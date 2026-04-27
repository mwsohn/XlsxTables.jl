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
        :f_fmt => Dict("num_format" => "#,##0.000","align" => "right"),
        :source_name_b => Dict("right" => "thin", "top" => "thin", "bottom" => "thin"),
        :int_right_b => Dict("num_format" => "#,##0", "align" => "right", "top" => "thin", "bottom" => "thin"),
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
            LibXLSXWriter.worksheet_write_string(t,c,r,v,formats[:heading_r_border])    
        else
            LibXLSXWriter.worksheet_write_string(t,c,r,v,formats[:heading])
        end
        c += 1
    end

    # rows first and then columns
    c = col
    r += 1
    mm = [anov.title, anov.ss, anov.df, anov.ms, anov.F, anov.pvalue]
    for (i,m) in enumerate(mm)
        for (j,v) in enumerate(vv)
            if ismissing(v)
                continue # do not output data
            end

            if j == length(mm[i]) # last row fot "Total" - output with top and bottom borders
                if i == 1
                    LibXLSXWriter.worksheet_write_string(t,c,r,v,formats[:source_name_b])
                elseif i == 3 # integer
                    LibXLSXWriter.worksheet_write_number(t, c, r, v, formats[:int_right_b])
                else
                    LibXLSXWriter.worksheet_write_number(t, c, r, v, formats[:f_fmt_b])
                end
            else
                if i == 1
                    LibXLSXWriter.worksheet_write_string(t, c, r, v, formats[:source_name])
                elseif i == 3 # integer
                    LibXLSXWriter.worksheet_write_number(t, c, r, v, formats[:int_right])
                elseif i == 6 # p-values
                    if v < 0.001
                        LibXLSXWriter.worksheet_write_string(t, c, r, "< 0.001", formats[:pvalue])
                    else
                        LibXLSXWriter.worksheet_write_number(t, c, r, @sprintf("%.3f", v), formats[:f_fmt])
                    end
                else
                    LibXLSXWriter.worksheet_write_number(t, c, r, v, formats[:f_fmt])
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



