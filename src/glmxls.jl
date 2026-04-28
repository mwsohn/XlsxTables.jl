"""
    glmxls(glmout::Vector{DataFrames.DataFrameRegressionModel}, workbook, worksheet::AbstractString; 
        mtitle::Union{Vector,Nothing}=nothing,
        eform=false,
        ci=true, 
        row = 0, 
        col =0,
        robust=nothing,
        labels=nothing,
        adjust=true)

Outputs multiple GLM regression tables side by side to an excel spreadsheeworksheet_
To use this function, `PyCall` is required with a working version python and
a python package called `xlsxwriter` installed. If a label is found for a variable
or a value of a variable in a `labels`, the label will be outpuworksheet_ Options are:

- `glmout`: a vector of GLM regression models
- `workbook`: a returned value from xlsxwriter.Workbook() function (see an example below)
- `worksheet`: a string for the worksheet name
- `mtitle`: header label for GLM models. If not specified, the dependent variable name will be used.
- `labels`: variable labels can be specified here as a dictionary.
- `eform`: use `eform = true` to get exponentiated estimates, standard errors, or 95% confidence intervals
- `ci`: use `ci = true` (default) to get 95% confidence intervals. `ci = false` will output standard errors and Z values instead.
- `row`: specify the row of the workbook to start the output table (default = 0 (for row 1))
- `col`: specify the column of the workbook to start the output table (default = 0 (for column A))
- `robust`: set to a HC standard error functions (e.g., `:hc1`) to obtain robust standard errors (default: `nothing`)
- `adjust`: set to `true` to obtain confidence intervals consistent with Stata or R values (default: `true`)

# Example 1
This example is useful when one wants to append a worksheet to an existing workbook.
It is responsibility of the user to open a workbook before the function call and close it
to actually create the physical file by close the workbook.

```
julia> using XlsxTables

julia> wb = workbook_new("test_workbook.xlsx")

julia> glmxls(olsmodels,wb,"OLS1")

Julia> workbook_close(wb)
```

# Example 2
Alternatively, one can create a spreadsheet file directly. 

```
julia> glmxls(olsmodels,"test_workbook.xlsx","OLS1")
```

"""
function glmxls(glmout,
    wbook,
    wsheet::AbstractString;
    mtitle::Union{Vector,Nothing}=nothing,
    eform::Bool=false,
    ci=true,
    row=0,
    col=0,
    robust=nothing,
    labels=nothing,
    adjust=true)

    num_models = length(glmout)
    otype = Vector(undef, num_models)
    if isa(glmout[1].model, GeneralizedLinearModel)
        linkfun = Vector{Link}(undef, num_models)
        distrib = Vector{UnivariateDistribution}(undef, num_models)
    end

    for i = 1:num_models

        # assuming that all models have the same family and link function
        otype[i] = "Estimate"
        if isa(glmout[i].model, GeneralizedLinearModel)
            distrib[i] = glmout[i].model.rr.d
            linkfun[i] = Link(glmout[i].model.rr)
            if eform == true
                otype[i] = Stella.coeflab(distrib[i], linkfun[i])
            end
        elseif isa(glmout[i].model, CoxModel)
            if eform == true
                otype[i] = "HR"
            end
        end

    end

    if mtitle == nothing
        mtitle = String[]

        # assign dependent variables
        for i = 1:num_models
            ysim = glmout[i].mf.f.lhs.sym #terms.eterms[1]
            push!(mtitle, string(ysim))
        end
    end

    # create a worksheet
    t = LibXLSXWriter.workbook_add_worksheet(wbook, wsheet)

    # attach formats to the workbook
    formats = create_formats(wbook)

    # starting location in the worksheet
    r = row
    c = col

    # set column widths
    worksheet_set_column(t, c, c, 40)
    worksheet_set_column(t, c + 1, c + 4 * num_models, 7)

    worksheet_merge_range(t, r, c, r + 1, c, "Variable", formats[:heading])
    for i = 1:num_models
        if ci == true
            worksheet_merge_range(t, r, c + 1, r, c + 4, mtitle[i], formats[:heading])
            worksheet_merge_range(t, r + 1, c + 1, r + 1, c + 3, string(otype[i], " (95% CI)"), formats[:heading])
            worksheet_write_string(t, r + 1, c + 4, "P-Value", formats[:heading])
        else
            worksheet_write_string(t, r, c + 1, otype[i], formats[:heading])
            worksheet_write_string(t, r, c + 2, robust != nothing ? "Robsut SE" : "SE", formats[:heading])
            worksheet_write_string(t, r, c + 3, "Z Value", formats[:heading])
            worksheet_write_string(t, r, c + 4, "P-Value", formats[:heading])
        end
        c += 4
    end

    #------------------------------------------------------------------
    r += 2
    c = col

    # collate variables from multiple regressions
    covariates = Vector{String}()
    vvalues = Dict()
    tdata = Vector(undef, num_models)
    tconfint = Vector(undef, num_models)
    loc = Dict()

    for i = 1:num_models
        if isa(glmout[i].model, CoxModel)
            tdata[i] = Survival.coeftable(glmout[i])
        else
            if robust == nothing
                tdata[i] = coeftable(glmout[i])
            else
                tdata[i] = rcoeftable(glmout[i], robust=robust, adjust=adjust)
            end
        end
        if robust == nothing
            tconfint[i] = confint(glmout[i])
        else
            tconfint[i] = rconfint(glmout[i], robust=robust, adjust=adjust)
        end

        # build a vector of covariate names
        for (k, nm) in enumerate(tdata[i].rownms)

            # save the location of the variable in loc dictionary
            if haskey(loc, i) == false
                loc[i] = Dict()
            end

            if occursin(":", nm)
                (vn, val) = split(nm, ": ")
            else
                vn = nm
                val = ""
            end
            loc[i][(vn, val)] = k # location of the variable in the tdata.cols[1]

            if in(vn, covariates) == false
                push!(covariates, vn)
            end

            if val != ""
                if haskey(vvalues, vn)
                    vvalues[vn] = OrderedSet(vcat(collect(vvalues[vn]), val))
                else
                    vvalues[vn] = OrderedSet([val])
                end
            end
        end
    end

    # expand covariates and vvalues
    covars = Vector{String}()
    valvec = Vector{String}()
    for vn in covariates
        ncat = 1
        vval = [""]
        if haskey(vvalues, vn)
            ncat = length(vvalues[vn])
            vval = collect(vvalues[vn])
        end
        for i = 1:ncat
            push!(covars, vn)
            push!(valvec, vval[i])
        end
    end

    # go through each variable and construct variable name and value label arrays
    # vals = Vector{String}(undef,nrows)
    nrows = length(covars)
    nlev = zeros(Int, nrows)
    npred = [dof(m) for m in glmout]
    varname = deepcopy(covars)

    for i = 1:length(covars)

        vn = covars[i]

        # count the number of levels in a categorical variable
        # use TableMetadataTools to get variable labels
        if labels != nothing && haskey(labels, Symbol(vn))
            varname[i] = labels[Symbol(vn)]
        else
            varname[i] = vn
        end

    end
    for i in 1:length(varname)
        nlev[i] = length(findall(x -> x == varname[i], varname))
    end

    # write table
    lastvarname = ""

    for i = 1:length(covars)
        if covars[i] != lastvarname
            # output cell boundaries only and go to the next line

            # variable name - expanded if `labels` is provided
            worksheet_write_string(t, r, c, varname[i], formats[:model_name])

            if nlev[i] > 1

                for k = 1:num_models
                    if ci == true
                        worksheet_write_string(t, r, c + 1, "", formats[:empty_right])
                        worksheet_write_string(t, r, c + 2, "", formats[:empty_both])
                        worksheet_write_string(t, r, c + 3, "", formats[:empty_left])
                        worksheet_write_string(t, r, c + 4, "", formats[:p_fmt])
                    else
                        worksheet_write_string(t, r, c + 1, "", formats[:empty_border])
                        worksheet_write_string(t, r, c + 2, "", formats[:empty_border])
                        worksheet_write_string(t, r, c + 3, "", formats[:empty_border])
                        worksheet_write_string(t, r, c + 4, "", formats[:p_fmt])
                    end
                    c += 4
                end
                c = col
                r += 1

                worksheet_write_string(t, r, c, valvec[i], formats[:varname_1indent])

            else
                if valvec[i] != "" && in(valvec[i], ["Yes", "1"]) == false
                    worksheet_write_string(t, r, c, string(varname[i], ": ", valvec[i]), formats[:model_name])
                else
                    worksheet_write_string(t, r, c, varname[i], formats[:model_name])
                end
            end
        else
            worksheet_write_string(t, r, c, valvec[i], formats[:varname_1indent])
        end

        for j = 1:num_models

            # find the index number for each coeftable row
            if haskey(loc[j], (covars[i], valvec[i]))
                ri = loc[j][(covars[i], valvec[i])] # findfirst(x->x == covariates[i],tdata[j].rownms)
            else
                ri = 0
            end

            if ri == 0
                # this variable is not in the model
                # print empty cells and then move onto the next model

                worksheet_write_string(t, r, c + 1, "", formats[:or_fmt])
                worksheet_write_string(t, r, c + 2, "", formats[:cilb_fmt])
                worksheet_write_string(t, r, c + 3, "", formats[:ciub_fmt])
                worksheet_write_string(t, r, c + 4, "", formats[:p_fmt])

                c += 4
                continue
            end


            # estimates
            ret = ri <= npred[j] ? tdata[j].cols[1][ri] : NaN
            if eform == true
                worksheet_write_number(t, r, c + 1, exp(ret), formats[:or_fmt])
            else
                worksheet_write_number(t, r, c + 1, ret, formats[:or_fmt])
            end

            if ci == true

                retlo = ri <= npred[j] ? tconfint[j][ri, 1] : NaN
                rethi = ri <= npred[j] ? tconfint[j][ri, 2] : NaN
                if eform == true

                    # 95% CI Lower
                    worksheet_write_number(t, r, c + 2, exp(retlo), formats[:cilb_fmt])

                    # 95% CI Upper
                    worksheet_write_number(t, r, c + 3, exp(rethi), formats[:ciub_fmt])
                else
                    # 95% CI Lower
                    worksheet_write_number(t, r, c + 2, retlo, formats[:cilb_fmt])

                    # 95% CI Upper
                    worksheet_write_number(t, r, c + 3, rethi, formats[:ciub_fmt])
                end
            else
                # SE
                if eform == true
                    worksheet_write_number(t, r, c + 2, ri <= npred[j] ? exp(tdata[j].cols[1][ri]) * tdata[j].cols[2][ri] : nothing, formats[:or_fmt])
                else
                    worksheet_write_number(t, r, c + 2, ri <= npred[j] ? tdata[j].cols[1][ri] : nothing, formats[:or_fmt])
                end

                # Z value
                worksheet_write_number(t, r, c + 3, ri <= npred[j] ? tdata[j].cols[3][ri] : nothing, formats[:or_fmt])

            end

            # P-Value
            worksheet_write_string(t, r, c + 4, ri <= npred[j] ? (tdata[j].cols[4][ri] < 0.001 ? "< 0.001" : @sprintf("%.3f",tdata[j].cols[4][ri])) : "", formats[:p_fmt])

            c += 4

        end

        lastvarname = covars[i]

        # update row
        r += 1
        c = col
    end

    # Write model characteristics and goodness of fit statistics
    c = col
    row2 = r
    for i = 1:num_models

        # N
        worksheet_write_string(t, r, c, "N", formats[:model_name])
        worksheet_merge_range(t, r, c + 1, r, c + 4, string(nobs(glmout[i])), formats[:str_c_b])

        # degress of freedom
        r += 1
        worksheet_write_string(t, r, c, "DF", formats[:model_name])
        worksheet_merge_range(t, r, c + 1, r, c + 4, string(dof(glmout[i])), formats[:str_c_b])

        # R² or pseudo R²
        r += 1
        if isa(glmout[i].model, LinearModel)
            worksheet_write_string(t, r, c, "R²", formats[:model_name])
            worksheet_merge_range(t, r, c + 1, r, c + 4, @sprintf("%.3f",r2(glmout[i])), formats[:str_c_b])
            worksheet_write_string(t, r + 1, c, "Adjusted R²", formats[:model_name])
            worksheet_merge_range(t, r + 1, c + 1, r + 1, c + 4, @sprintf("%.3f",adjr2(glmout[i])), formats[:str_c_b])

            # r += 2
            r = row2
            c += 4

        elseif !isa(glmout[i].model, CoxModel)

            # Logistic regression
            if isa(linkfun[i], LogitLink)
                worksheet_write_string(t, r, c, "Pseudo R² (MacFadden)", formats[:model_name])
                worksheet_merge_range(t, r, c + 1, r, c + 4, @sprintf("%.3f",r2(glmout[i], :McFadden)), formats[:str_c_b])
                worksheet_write_string(t, r + 1, c, "Pseudo R² (Nagelkerke)", formats[:model_name])
                worksheet_merge_range(t, r + 1, c + 1, r + 1, c + 4, @sprintf("%.3f",r2(glmout[i], :Nagelkerke)), formats[:str_c_b])

                # -2 log-likelihood
                worksheet_write_string(t, r + 2, c, "-2 Log-Likelihood", formats[:model_name])
                worksheet_merge_range(t, r + 2, c + 1, r + 2, c + 4, @sprintf("%.3f",deviance(glmout[i])), formats[:str_c_b])

                # Hosmer-Lemeshow GOF test
                worksheet_write_string(t, r + 3, c, "Hosmer-Lemeshow Chisq Test (df), p-value", formats[:model_name])
                hl = XlsxTables.hltest(glmout[i])
                worksheet_merge_range(t, r + 3, c + 1, r + 3, c + 4, @sprintf("%.4f (%d); p = %.4f",hl[1], hl[2], hl[3]), formats[:str_c_b])

                # ROC (c-statistic)
                rr = ROCAnalysis.roc(rocinput(glmout)...)
                worksheet_write_string(t, r + 4, c, "Area under the ROC Curve", formats[:model_name])
                worksheet_merge_range(t, r + 4, c + 1, r + 4, c + 4, @sprintf("%.4f",ROCAnalysis.AUC(rr)), formats[:str_c_b])

                r += 5
            end

            # AIC & BIC
            worksheet_write_string(t, r, c, "AIC", formats[:model_name])
            worksheet_merge_range(t, r, c + 1, r, c + 4, @sprintf("%.4f",aic(glmout[i])), formats[:str_c_b])

            r += 1
            worksheet_write_string(t, r, c, "BIC", formats[:model_name])
            worksheet_merge_range(t, r, c + 1, r, c + 4, @sprintf("%.4f",bic(glmout[i])), formats[:str_c_b])

            r = row2
            c += 4
        else

            # For coxModel
            # AIC & BIC
            worksheet_write_string(t, r, c, "AIC", formats[:model_name])
            worksheet_merge_range(t, r, c + 1, r, c + 4, @sprintf("%.4f",aic(glmout[i])), formats[:str_c_b])

            r += 1
            worksheet_write_string(t, r, c, "BIC", formats[:model_name])
            worksheet_merge_range(t, r, c + 1, r, c + 4, @sprintf("%.4f",bic(glmout[i])), formats[:str_c_b])

            r = row2
            c += 4
        end
    end
end
function glmxls(glmout,
    wbook::AbstractString,
    wsheet::AbstractString;
    mtitle::Union{String,Nothing}=nothing,
    labels::Dict=nothing,
    eform::Bool=false,
    ci=true,
    row=0,
    col=0)

    wb = LibXLSXWriter.workbook_new(wbook)

    glmxls(glmout, wb, wsheet, mtitle=mtitle, eform=eform, ci=ci, row=row, col=col)

    LibXLSXWriter.workbook_close(wb)
end