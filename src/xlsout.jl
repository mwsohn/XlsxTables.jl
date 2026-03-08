###########################################################################
#
# This file contains following functions
#   glmxls - GLM regression models
#   bivariatexls - for two-way tables for discrete or continuous variables
#   univariatexls - for continuous variables
#   dfxls - for exporting a dataframe
#
###########################################################################
"""
    bivariatexls(df::AbstractDataFrame,,workbook,worksheet::AbstractString,
        colvar::Symbol,rowvars::Vector{Symbol}; row=0,col=0,column_percent = true)

 Creates bivariate statistics and appends it in a nice tabular format to an existing workbook.
 To use this function, `PyCall` is required with a working version python and
 a python package called `xlsxwriter` installed.  If a label is found for a variable
 or a value of a variable in a `Label`, the label will be output. Options are:

- `df`: an AbstractDataFrame
- `workbook`: a returned value from LibXLSXWriter.workbook_new() function (see an example below)
- `worksheet`: a string for the worksheet name
- `colvar`: a categorical variable whose values will be displayed on the columns
- `rowvars`: a Vector of Symbols for variables to be displayed on the rows. Both continuous and categorical variables are allowed.
    For continuous variables, mean and standard deviations will be output and a p-value will be based on an ANOVA test. For categorical variables,
    a r x c table with cell counts and row percentages will be output with a p-value based on a chi-square test.
- `row`: specify the row of the workbook to start the output table (default = 0 (for row 1))
- `col`: specify the column of the workbook to start the output table (default = 0 (for column A))
- `column_percent`: set this to `false` if you want row percentages in the output table (default = true)

### Example 1
This example is useful when one wants to append a worksheet to an existing workbook.
It is responsibility of the user to open a workbook before the function call and close it
to actually create the physical file by close the workbook.

```
julia> using LibXLSXWriter: workbook_new, workbook_close

julia> wb = workbook_new("test_workbook.xlsx")

julia> bivairatexls(df,wb,"Bivariate",:incomecat,[:age,:race,:male,:bmicat])

Julia> workbook_close(wb)
```

### Example 2
Alternatively, one can create a spreadsheet file directly. 

```
julia> bivariatexls(df,"test_workbook.xlsx","Bivariate",:incomecat,[:age,:race,:male,:bmicat])
```
"""
function bivariatexls(df::AbstractDataFrame,
    wbook,
    wsheet::AbstractString,
    colvar::Symbol,
    rowvars::Vector{Symbol};
    column_percent = false
    )

    row = 0
    col = 0

    # colvar has to be a CategoricalArray and must have 2 or more categories
    if isa(df[!, colvar], CategoricalArray) == false || length(levels(df[!, colvar])) < 2
        error("`", colvar, "` is not a CategoricalArray or does not have two or more levels")
    end

    # create a worksheet
    t = LibXLSXWriter.workbook_add_worksheet(wbook,wsheet)

    # attach formats to the workbook
    formats = create_formats(wbook)

    # starting row and column
    r = row
    c = col

    # drop NAs in colvar
    df2 = df[completecases(df[!, [colvar]]), :]

    # number of columns
    # column values
    # if wts == nothing
    collev = freqtable(df2, colvar, skipmissing=true)
    # else
    #     collev = freqtable(df2, colvar, skipmissing=true, weights=df2[!, wts])
    # end

    # drop empty rows
    # z = findall(x -> x != 0, collev.array)
    nlev = length(collev.array)
    tmpnms = names(collev, 1)
    colnms = Vector{CategoricalArrays.leveltype(tmpnms)}(tmpnms)
    coltot = sum(collev.array, dims=1)

    # set column widths
    LibXLSXWriter.worksheet_set_column(t, c, c, 40)
    LibXLSXWriter.worksheet_set_column(t, c + 1, c + (nlev + 1) * 2 + 1, 9)

    # create header
    # column variable name
    # It uses three rows
    LibXLSXWriter.worksheet_merge_range(t, r, c, r + 2, c, "Variable", formats[:heading])

    # header 1st row = variable name
    LibXLSXWriter.worksheet_merge_range(t, r, c + 1, r, c + (nlev + 1) * 2 + 1, TableMetadataTools.label(df, colvar), formats[:heading])

    # header 2nd and 3rd rows
    r += 1

    LibXLSXWriter.worksheet_merge_range(t, r, 1, r, 2, "All", formats[:heading])
    LibXLSXWriter.worksheet_write_string(t, r + 1, 1, "N", formats[:n_fmt_right])
    LibXLSXWriter.worksheet_write_string(t, r + 1, 2, "(%)", formats[:pct_fmt_parens])

    # 
    c += 3
    for i = 1:nlev
        LibXLSXWriter.worksheet_merge_range(t, r, c + (i - 1) * 2, r, c + (i - 1) * 2 + 1, string(colnms[i]), formats[:heading])
        LibXLSXWriter.worksheet_write_string(t, r + 1, c + (i - 1) * 2, "N", formats[:n_fmt_right])
        LibXLSXWriter.worksheet_write_string(t, r + 1, c + (i - 1) * 2 + 1, "(%)", formats[:pct_fmt_parens])
    end

    # P-value
    LibXLSXWriter.worksheet_merge_range(t, r, c + nlev * 2, r + 1, c + nlev * 2, "P-Value", formats[:heading])

    # total
    c = col
    r += 2
    LibXLSXWriter.worksheet_write_string(t, r, c, "All, n (Row %)", formats[:model_name])
    # if wts == nothing
    x = freqtable(df2, colvar, skipmissing=true)
    # else
    #     x = freqtable(df2, colvar, skipmissing=true, weights=df2[!, wts])
    # end
    tot = sum(x)
    LibXLSXWriter.worksheet_write_number(t,r, c + 1, tot, formats[:n_fmt_right])
    LibXLSXWriter.worksheet_write_number(t,r, c + 2, 1.0, formats[:pct_fmt_parens])
    for i = 1:nlev
        LibXLSXWriter.worksheet_write_number(t,r, c + i * 2 + 1, x.array[i], formats[:n_fmt_right])
        LibXLSXWriter.worksheet_write_number(t,r, c + i * 2 + 2, x.array[i] / tot, formats[:pct_fmt_parens])
    end
    LibXLSXWriter.worksheet_write_string(t,r, c + (nlev + 1) * 2 + 1, "", formats[:empty_border])

    # covariates
    c = col
    r += 1
    for varname in rowvars

        # variable name
        vars = label(df, varname) # a function in TableMetadataTools

        # determine if varname is categorical or continuous
        if isa(df2[!, varname], CategoricalArray) || eltype(df2[!, varname]) == String

            # categorial
            df3 = df2[completecases(df2[:, [varname]]), [varname, colvar]]
            # if wts == nothing
            x = freqtable(df3, varname, colvar, skipmissing=true)
            # else
            #     x = freqtable(df3, varname, colvar, skipmissing=true, weights=df3[!, wts])
            # end
            rtmpnms = names(x, 1)
            rowval = Vector{CategoricalArrays.leveltype(rtmpnms)}(rtmpnms)
            rowtot = sum(x.array, dims=2)
            coltot = sum(x.array, dims=1)

            # variable name
            # if there only two levels and one of the values is 1 or true
            # and the other values is 0 or false,
            # just output the frequency and percentage of the 1/true row

            # variable name
            LibXLSXWriter.worksheet_write_string(t, r, c, vars, formats[:model_name])

            # two levels with [0,1] or [false,true]
            if length(rowval) <= 2 && rowval in ([1], [true], ["Yes"], [0, 1], [false, true], ["No", "Yes"])

                nr = length(rowval)
                # row total
                LibXLSXWriter.worksheet_write_number(t,r, c + 1, rowtot[nr], formats[:n_fmt_right])
                LibXLSXWriter.worksheet_write_number(t,r, c + 2, rowtot[nr] / tot, formats[:pct_fmt_parens])

                for j = 1:nlev
                    LibXLSXWriter.worksheet_write_number(t,r, c + j * 2 + 1, x.array[nr, j], formats[:n_fmt_right])
                    if column_percent
                        LibXLSXWriter.worksheet_write_number(t,r, c + j * 2 + 2, coltot[j] > 0 ? x.array[nr, j] / coltot[j] : "", formats[:pct_fmt_parens])
                    else # elseif rowtot[2] > 0
                        LibXLSXWriter.worksheet_write_number(t,r, c + j * 2 + 2, rowtot[nr] > 0 ? x.array[nr, j] / rowtot[nr] : "", formats[:pct_fmt_parens])
                    end
                end
                pval = pvalue(ChisqTest(x.array))
                if isnan(pval) || isinf(pval)
                    pval = ""
                elseif pval < 0.001
                    pval = "< 0.001"
                end
                LibXLSXWriter.worksheet_write_number(t,r, c + (nlev + 1) * 2 + 1, pval, formats[:p_fmt])
                r += 1
            else
                for i = 1:nlev+1
                    LibXLSXWriter.worksheet_write_string(r, c + (i - 1) * 2 + 1, "", formats[:empty_right])
                    LibXLSXWriter.worksheet_write_string(r, c + (i - 1) * 2 + 2, "", formats[:empty_left])
                end
                LibXLSXWriter.worksheet_write_string(t, r, c + (nlev + 1) * 2 + 1, "", formats[:empty_border])

                r += 1
                for i = 1:length(rowval)
                    # row value
                    LibXLSXWriter.worksheet_write_string(t, r, c, string(rowval[i]), formats[:varname_1indent])

                    # row total
                    LibXLSXWriter.worksheet_write_number(t,r, c + 1, rowtot[i], formats[:n_fmt_right])
                    LibXLSXWriter.worksheet_write_number(t,r, c + 2, rowtot[i] / tot, formats[:pct_fmt_parens])

                    for j = 1:nlev
                        LibXLSXWriter.worksheet_write_number(t,r, c + j * 2 + 1, x.array[i, j], formats[:n_fmt_right])
                        if column_percent
                            LibXLSXWriter.worksheet_write_number(t,r, c + j * 2 + 2, coltot[j] > 0 ? x.array[i, j] / coltot[j] : nothing, formats[:pct_fmt_parens])
                        else
                            LibXLSXWriter.worksheet_write_number(t,r, c + j * 2 + 2, rowtot[i] > 0 ? x.array[i, j] / rowtot[i] : nothing, formats[:pct_fmt_parens])
                        end
                    end
                    # p-value - output only once
                    pval = pvalue(ChisqTest(x.array))

                    if isnan(pval) || isinf(pval)
                        pval = ""
                    elseif pval < 0.001
                        pval = "< 0.001"
                    end
                    if length(rowval) == 1
                        LibXLSXWriter.worksheet_write_number(t,r, c + (nlev + 1) * 2, pval, formats[:p_fmt])
                    elseif i == 1
                        LibXLSXWriter.worksheet_merge_range(t, r, c + (nlev + 1) * 2 + 1, r + length(rowval) - 1, c + (nlev + 1) * 2 + 1, pval, formats[:p_fmt])
                    end
                    r += 1
                end
            end
        else
            # continuous variable
            df3 = df2[completecases(df2[!, [varname]]), [varname, colvar]]
            y = combine(groupby(df3, colvar, sort=true), nrow => :n, varname => mean => :mean, varname => std => :sd) #tabstat(df3, varname, colvar)

            # variable name
            LibXLSXWriter.worksheet_write_string(t, r, c, string(vars, ", mean (SD)"), formats[:model_name])

            # All
            tmpvec = collect(skipmissing(df3[!, varname]))
            if length(tmpvec) == 0
                amean = ""
                astd = ""
            else
                amean = mean(tmpvec)
                if isnan(amean)
                    amean = ""
                end
                astd = std(tmpvec)
                if isnan(astd)
                    astd = ""
                end
            end
            LibXLSXWriter.worksheet_write_number(t,r, c + 1, amean, formats[:f_fmt_right])
            LibXLSXWriter.worksheet_write_number(t,r, c + 2, astd, formats[:f_fmt_left_parens])

            # colvar levels
            for i = 1:nlev
                if i <= size(y, 1) && y[i, :n] > 1
                    LibXLSXWriter.worksheet_write_number(t,r, c + i * 2 + 1, y[i, :mean], formats[:f_fmt_right])
                    LibXLSXWriter.worksheet_write_number(t,r, c + i * 2 + 2, y[i, :sd], formats[:f_fmt_left_parens])
                else
                    LibXLSXWriter.worksheet_write_number(t,r, c + i * 2 + 1, nothing, formats[:f_fmt_right])
                    LibXLSXWriter.worksheet_write_number(t,r, c + i * 2 + 2, nothing, formats[:f_fmt_left_parens])
                end
            end
            if size(y, 1) > 1
                pval = AnalysisOfVariance.anova(df3, varname, colvar).pvalue[2]
                if ismissing(pval) || isnan(pval) || isinf(pval)
                    pvalue = ""
                elseif pval < 0.001
                    pvalue = "< 0.001"
                else
                    pvalue = @sprintf("%.3f",pval)
                end
                LibXLSXWriter.worksheet_write_string(t,r, c + (nlev + 1) * 2 + 1, pvalue, formats[:p_fmt])
            end

            r += 1
        end
    end
end
function bivariatexls(_df::AbstractDataFrame,
    colvar::Symbol,
    rowvars::Vector{Symbol},
    wbook::AbstractString,
    wsheet::AbstractString;
    column_percent=false)

    wb = LibXLSXWriter.workbook_new(wbook)

    bivariatexls(_df,wb, wsheet,colvar,rowvars; column_percent=column_percent)

    LibXLSXWriter.workbook_close(wb)
end


"""
    univariatexls(df::DataFrame,workbook,worksheet::AbstractString,contvars::Vector{Symbol}; row=0,col=0)

Creates univariate statistics for a vector of continuous variable and
appends it to an existing workbook.
To use this function, `PyCall` is required with a working version python and
a python package called `xlsxwriter` installed.  If a label is found for a variable
in a `Label` object, the label will be output. Options are:

- `df`: a DataFrame
- `workbook`: a returned value from xlsxwriter.Workbook() function (see an example below)
- `worksheet`: a string for the worksheet name
- `contvars`: a vector of continuous variables
- `row`: specify the row of the workbook to start the output table (default = 0 (for row 1))
- `col`: specify the column of the workbook to start the output table (default = 0 (for column A))

# Example 1
This example is useful when one wants to append a worksheet to an existing workbook.
It is responsibility of the user to open a workbook before the function call and close it
to actually create the physical file by close the workbook.

```
julia> wb = workbook_new("test_workbook.xlsx")
Ptr{LibXLSXWriter.lxw_workbook}(0x0000018dfdb527f0)

julia> univariatexls(df,[:age,:income_amt,:bmi],wb,"Univariate")

Julia> workbook_close(wb)
```

# Example 2
Alternatively, one can create a spreadsheet file directly. `PyCall` or `@pyimport`
does not need to be called before the function.

```jldoctest
julia> univariatexls(df,"test_workbook.xlsx","Bivariate",[:age,:income_amt,:bmi])
```

"""
function univariatexls(df::DataFrame, wbook, wsheet::AbstractString,
    contvars::Vector{Symbol};
    wt::Union{Nothing,Symbol}=nothing,
    row=0,
    col=0)

    # create a worksheet
    t = LibXLSXWriter.workbook_add_worksheet(wbook, wsheet)

    # attach formats to the workbook
    formats = create_formats(wbook)

    # starting row and column
    r = row
    c = col

    # column width
    LibXLSXWriter.worksheet_set_column(t, 0, 0, 20)
    LibXLSXWriter.worksheet_set_column(t, 1, length(contvars), 12)

    # output the row names
    rownms = ["N Total", "N Miss", "N Used", "Sum", "Mean",
        "SD", "Variance", "Minimum", "P25", "Median", "P75", "Maximum",
        "Skewness", "Kurtosis", "Smalles", "", "", "", "", "Largest", "", "", "", ""]

    worksheet_write_string(t, r, c, "Statistic", formats[:heading])
    for i in 1:24
        worksheet_write_string(t, r + i, c, rownms[i], formats[:heading_left])
    end

    col = 1
    for vsym in contvars

        # if symbol is not found in the DataFrame
        if !in(vsym, propertynames(df))
            continue
        end

        # vsym is not a real number
        if (nonmissingtype(eltype(df[!, vsym])) <: Real) == false
            continue
        end

        # non-missing values
        len = size(df, 1) - count(ismissing, df[!, vsym])  # sum(ismissing.(df[!,vsym]) .== false)

        # pick up the variable label
        varstr = label(df, vsym)
        worksheet_write_string(t, 0, col, varstr, formats[:heading])
        u = Stella.univariate(df[!, vsym]) #,wt=df[wt])
        for j = 1:14
            if j < 4
                fmttype = :n_fmt
            else
                fmttype = :p_fmt
            end
            if isnan(u[j, :Value]) || isinf(u[j, :Value])
                worksheet_write_string(t, j, col, "", formats[fmttype])
            else
                worksheet_write_number(t, j, col, u[j, :Value], formats[fmttype])
            end
        end

        len = len < 5 ? len : 5
        smallest = Stella.smallest(df[!, vsym], n=len)
        if nonmissingtype(eltype(df)) <: Integer
            fmttype = :n_fmt
        else
            fmttype = :p_fmt
        end
        for j = 1:5
            if j <= len
                worksheet_write_number(t,j + 14, col, smallest[j], formats[fmttype])
            else
                worksheet_write_string(t,j + 14, col, "", formats[fmttype])
            end
        end
        largest = Stella.largest(df[!, vsym], n=len)
        for j = 1:5
            if j <= len
                worksheet_write_number(t,j + 19, col, largest[j], formats[fmttype])
            else
                worksheet_write_string(t,j + 19, col, "", formats[fmttype])
            end
        end
        col += 1
    end
end
function univariatexls(df::DataFrame, wbook::AbstractString, wsheet::AbstractString, contvars::Vector{Symbol};
    wt::Union{Nothing,Symbol}=nothing, row=0, col=0)

    wb = workbook_new(wbook)

    univariatexls(df, contvars, wb, wsheet, wt=wt, row=row, col=col)

    workbook_close(wb)
end


"""
    dfxls(df::DataFrame, workbook::PyObject, worksheet::AbstractString; row=0, col=0)

 To use this function, `PyCall` is required with a working version python and
 a python package called `xlsxwriter` installed. Options are:

- `df`: a DataFrame
- `workbook`: a returned value from xlsxwriter.Workbook() function (see an example below)
- `worksheet`: a string for the worksheet name (default: "Data1")
- `row`: specify the row of the workbook to start the output table (default = 0 (for row 1))
- `col`: specify the column of the workbook to start the output table (default = 0 (for column A))

# Example 1
This example is useful when one wants to append a worksheet to an existing workbook.
It is responsibility of the user to open a workbook before the function call and close it
to actually create the physical file by close the workbook.

```
julia> wb = workbook_new("test_workbook.xlsx")
Ptr{LibXLSXWriter.lxw_workbook}(0x0000018dfdb527f0)

julia> dfxls(df, wb, "DataFrame")

Julia> workbook_close(wb)
```

# Example 2
Alternatively, one can create a spreadsheet file directly. `PyCall` or `@pyimport`
does not need to be called before the function.

```
julia> dfxls(df,"test_workbook.xlsx","df",nrows = 0)
```

"""
function dfxls(df::AbstractDataFrame,
    wbook,
    worksheet::AbstractString;
    col::Int64=0, 
    row::Int64=0)

    # create a worksheet
    t = LibXLSXWriter.workbook_add_worksheet(wbook, worksheet)

    # attach formats to the workbook
    formats = create_formats(wbook)

    # starting row and column
    c = col

    # Eltype
    typ = Vector{DataType}(undef, size(df, 2))
    for i = 1:ncol(df)
        if typeof(df[!, i]) <: CategoricalArray
            typ[i] = String # eltype(df[!,i].pool.invindex.keys)
        else
            typ[i] = nonmissingtype(eltype(df[!, i]))
        end
    end
    varnames = propertynames(df)

    for i = 1:size(df, 2)

        r = row
        LibXLSXWriter.worksheet_set_column(t, c, c, 10)
        LibXLSXWriter.worksheet_write_string(t, r, c, string(varnames[i]), formats[:heading])
        r += 1

        for j in 1:nrow(df)
            

            if ismissing(df[j, i])
                worksheet_write_string(t, r, c, " ", formats[:n_fmt])
            elseif typ[i] <: AbstractString
                if df[j, i] == ""
                    worksheet_write_string(t, r, c, " ", formats[:text])
                else
                    worksheet_write_string(t, r, c, String(df[j, i]), formats[:text])
                end
            elseif typ[i] <: Number
                if isnan(df[j, i]) || isinf(df[j, i])
                    worksheet_write_string(t, r, c, " ", formats[:text])
                elseif typ[i] <: Integer
                    worksheet_write_number(t, r, c, df[j, i], formats[:n_fmt])
                elseif typ[i] <: AbstractFloat
                    worksheet_write_number(t, r, c, df[j, i], formats[:f_fmt])
                end
            elseif typ[i] <: Date
                worksheet_write_number(t, r, c, Dates.value(df[j, i] - Date(1899, 12, 30)), formats[:f_date])
            elseif typ[i] <: DateTime
                worksheet_write_number(t, r, c, (Dates.value(df[j, i] - DateTime(1899, 12, 30, 0, 0, 0))) / 86400000, formats[:f_datetime])
            elseif typ[i] == Symbol || typ[i] == DataType
                worksheet_write_number(t, r, c, string(df[j, i]), formats[:text])
            else
                # skip
            end

            r += 1
        end
        c += 1
    end

end
function dfxls(df::DataFrame,
    wbook::AbstractString,
    worksheet::AbstractString;
    col::Int64=0, 
    row::Int64=0)

    # create a workbook
    wb = LibXLSXWriter.workbook_new(wbook)

    dfxls(df, wb, worksheet, col=col, row=row)

    workbook_close(wb)
end

function newfilename(filen::AbstractString)
    while (isfile(filen))
        # separate the name into three parts, basename (number).extension
        (basename, ext) = splitext(filen)
        m = match(r"(.*)(\(.*\))$", basename)
        if m == nothing
            filen = string(filen, " (1)")
        else
            m2 = parse(Int, replace(m[2], r"\((.*)\)", s"\1"))
            filen = string(m[1], " (", m2 + 1, ")")
        end
    end
    return filen
end