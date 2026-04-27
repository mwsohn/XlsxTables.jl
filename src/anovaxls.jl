"""
    anovaxls(a::ANOVA)


"""
function anovaxls(anov::ANOVA, wbook::Ptr, wsheet::String; row=0, col=0)

    # create a worksheet
    t = LibXLSXWriter.workbook_add_worksheet(wbook, wsheet)

    # formats for the table
    fmts = Dict(
        :global => Dict("font_name" => "Arial", "font_size" => 9),
        :heading => Dict("align" => "center", "top" => "thin", "bottom" => "thin"),
        :heading_right => Dict("align" => "right","top" => "thin", "bottom" => "thin","right" => "thin"),
        :source_name => Dict("align" => "right", "right" => "thin"),
        :int_right => Dict("num_format" => "#,##0","align" => "right"),
        :pvalue => Dict("align" => "right"),
        :str_right => Dict("align" => "right"),
        :f_fmt => Dict("num_format" => "#,##0.000", "align" => "right"),
        :source_name_b => Dict("right" => "thin", "top" => "thin", "bottom" => "thin"),
        :int_right_b => Dict("num_format" => "#,##0", "align" => "right", "top" => "thin", "bottom" => "thin"),
        :str_right_b => Dict("align" => "right", "top" => "thin", "bottom" => "thin"),
        :f_fmt_b => Dict("num_format" => "#,##0.000", "align" => "right", "top" => "thin", "bottom" => "thin")
    )

    # attach formats to the workbook
    formats = create_formats(wbook,fmt=fmts)

    # starting row and column
    r = row
    c = col

    # set column widths
    LibXLSXWriter.worksheet_set_column(t, c, c, 30)
    LibXLSXWriter.worksheet_set_column(t, c + 1, c + 5, 10)

    # header
    header = ["Source", "SS", "df", "MS", "F", "P"]
    for v in header
        if c == col # Source will have right border
            LibXLSXWriter.worksheet_write_string(t,c,r,v,formats[:heading_right])    
        else
            LibXLSXWriter.worksheet_write_string(t,c,r,v,formats[:heading])
        end
        c += 1
    end

    # rows first and then columns
    c = col
    r += 1
    mm = hcat(anov.title, anov.ss, anov.df, anov.ms, anov.F, anov.pvalue)
    dims = size(mm)
    for i in 1:dims[1] # rows
        for j in 1:dims[2] # columns
            v = mm[i, j]

            if i == dims[1] # last row ofo "Total" - output with top and bottom borders
                if j == 1 # source
                    LibXLSXWriter.worksheet_write_string(t,c,r,v,formats[:source_name_b])
                elseif j == 3 # DF
                    LibXLSXWriter.worksheet_write_number(t, c, r, v, formats[:int_right_b])
                elseif ismissing(v)
                    LibXLSXWriter.worksheet_write_string(t, c, r, "", formats[:str_right_b])
                else
                    LibXLSXWriter.worksheet_write_number(t, c, r, v, formats[:f_fmt_b])
                end
            else
                if j == 1 # source
                    LibXLSXWriter.worksheet_write_string(t, c, r, string(v), formats[:source_name])
                elseif j == 3 # DF
                    LibXLSXWriter.worksheet_write_number(t, c, r, v, formats[:int_right])
                elseif j in (5,6) # F and p-values
                    if v < 0.001
                        LibXLSXWriter.worksheet_write_string(t, c, r, "< 0.001", formats[:str_right])
                    elseif !ismissing(v)
                        LibXLSXWriter.worksheet_write_string(t, c, r, @sprintf("%.3f", v), formats[:str_right_b])
                    else
                        LibXLSXWriter.worksheet_write_string(t, c, r, "", formats[:str_right_b])
                    end
                # elseif ismissing(v)
                #     LibXLSXWriter.worksheet_write_string(t, c, r, "", formats[:str_right])
                # else
                #     LibXLSXWriter.worksheet_write_number(t, c, r, v, formats[:f_fmt])
                end
            end
            r += 1
        end
        c += 1
    end
end
function anovaxls(anov::ANOVA, wb::String, wsheet::String; row=0, col=0)
    wbook = LibXLSXWriter.workbook_new(wb)
    anovaxls(anov, wbook, wsheet; row=row, col=col)
    LibXLSXWriter.workbook_close(wbook)
end



