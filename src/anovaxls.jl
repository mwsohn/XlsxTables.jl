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
        :source_name_b => Dict("align" => "right", "right" => "thin", "top" => "thin", "bottom" => "thin"),
        :int_right => Dict("num_format" => "#,##0", "align" => "right"),
        :pvalue => Dict("align" => "right"),
        :str_right => Dict("align" => "right"),
        :f_fmt => Dict("num_format" => "#,##0.000", "align" => "right"),
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
    LibXLSXWriter.worksheet_set_column(t, c, c, 20)
    LibXLSXWriter.worksheet_set_column(t, c + 1, c + 1, 15)
    LibXLSXWriter.worksheet_set_column(t, c + 2, c + 2, 8)
    LibXLSXWriter.worksheet_set_column(t, c + 3, c + 3, 15)
    LibXLSXWriter.worksheet_set_column(t, c + 4, c + 5, 8)


    # header
    header = ["Source", "SS", "DF", "MS", "F", "P"]
    for v in header
        LibXLSXWriter.worksheet_write_string(t, r, c, v, formats[:heading])
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
                    LibXLSXWriter.worksheet_write_string(t, r, c,string(v," "),formats[:source_name_b])
                elseif j == 3 # DF
                    LibXLSXWriter.worksheet_write_number(t, r, c, v, formats[:int_right_b])
                elseif ismissing(v)
                    LibXLSXWriter.worksheet_write_string(t, r, c, "", formats[:str_right_b])
                else
                    LibXLSXWriter.worksheet_write_number(t, r, c, v, formats[:f_fmt_b])
                end
            else
                if j == 1 # source
                    LibXLSXWriter.worksheet_write_string(t, r, c, string(v," "), formats[:source_name])
                elseif j == 3 # DF
                    LibXLSXWriter.worksheet_write_number(t, r, c, v, formats[:int_right])
                elseif j in (5,6) # F and p-values
                    if ismissing(v)
                        LibXLSXWriter.worksheet_write_string(t, r, c, "", formats[:str_right])
                    elseif v < 0.001
                        LibXLSXWriter.worksheet_write_string(t, r, c, "< 0.001", formats[:str_right])
                    else
                        LibXLSXWriter.worksheet_write_string(t, r, c, @sprintf("%.3f", v), formats[:str_right])
                    end
                else
                    LibXLSXWriter.worksheet_write_number(t, r, c, v, formats[:f_fmt])
                end
            end
            c += 1
        end
        r += 1
        c = col
    end
end
function anovaxls(anov::ANOVA, wb::String, wsheet::String; row=0, col=0)
    wbook = LibXLSXWriter.workbook_new(wb)
    anovaxls(anov, wbook, wsheet; row=row, col=col)
    LibXLSXWriter.workbook_close(wbook)
end



