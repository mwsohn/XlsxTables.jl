
format_defs = Dict()

format_defs[:heading] = Dict(
    "bold" => true,
    "font_name" => "Arial",
    "font_size" => 9,
    "valign" => "vcenter",
    "align" => "center",
    "border" => "thin"
)

format_defs[:text] = Dict(
    "font_name" => "Arial",
    "font_size" => 9,
    "valign" => "vcenter",
    "align" => "left",
    "border" => "thin"
)

format_defs[:heading_right] = Dict(
    "bold" => true,
    "font_name" => "Arial",
    "font_size" => 10,
    "valign" => "vcenter",
    "align" => "right",
    "left" => "thin",
    "bottom" => "thin",
    "top" => "thin"
)

format_defs[:heading_left] = Dict(
    "bold" => true,
    "font_name" => "Arial",
    "font_size" => 10,
    "valign" => "vcenter",
    "align" => "left",
    "right" => "thin",
    "bottom" => "thin",
    "top" => "thin"
)

format_defs[:model_name] = Dict(
    "font_name" => "Arial",
    "font_size" => 9,
    "valign" => "vcenter",
    "align" => "left",
    "border" => "thin"
)

format_defs[:varname_1indent] = Dict(
    "font_name" => "Arial",
    "font_size" => 9,
    "valign" => "vcenter",
    "align" => "left",
    "border" => "thin",
    "indent" => 1
)


format_defs[:varname_2indent] = Dict(
    "font_name" => "Arial",
    "font_size" => 9,
    "valign" => "vcenter",
    "align" => "left",
    "border" => "thin",
    "indent" => 2
)


format_defs[:n_fmt_right] = Dict(
    "num_format" => "#,##0",
    "font_name" => "Arial",
    "font_size" => 9,
    "valign" => "vcenter",
    "align" => "right",
    "left" => "thin",
    "bottom" => "thin",
    "top" => "thin"
)


format_defs[:n_fmt_left_parens] = Dict(
    "num_format" => "(#,##0)",
    "font_name" => "Arial",
    "font_size" => 9,
    "valign" => "vcenter",
    "align" => "right",
    "right" => "thin",
    "bottom" => "thin",
    "top" => "thin"
)

format_defs[:f_date] = Dict(
    "num_format" => "mm/dd/yyyy",
    "font_name" => "Arial",
    "font_size" => 9,
    "valign" => "vcenter",
    "align" => "right",
    "border" => "thin"
)

format_defs[:f_datetime] = Dict(
    "num_format" => "mm/dd/yyyy hh:mm:ss",
    "font_name" => "Arial",
    "font_size" => 9,
    "valign" => "vcenter",
    "align" => "right",
    "border" => "thin"
)

format_defs[:f_fmt_right] = Dict(
    "num_format" => "#,##0.00",
    "font_name" => "Arial",
    "font_size" => 9,
    "valign" => "vcenter",
    "align" => "right",
    "left" => "thin",
    "bottom" => "thin",
    "top" => "thin"
)

format_defs[:f_fmt_center] = Dict(
    "num_format" => "#,##0.0000",
    "font_name" => "Arial",
    "font_size" => 9,
    "valign" => "vcenter",
    "align" => "center",
    "border" => "thin"
)

format_defs[:f_fmt] = Dict(
    "num_format" => "#,##0.00",
    "font_name" => "Arial",
    "font_size" => 9,
    "valign" => "vcenter",
    "align" => "right",
    "border" => "thin"
)


format_defs[:n_fmt] = Dict(
    "num_format" => "#,##0",
    "font_name" => "Arial",
    "font_size" => 9,
    "valign" => "vcenter",
    "align" => "right",
    "border" => "thin"
)

format_defs[:n_fmt_center] = Dict(
    "num_format" => "#,##0",
    "font_name" => "Arial",
    "font_size" => 9,
    "valign" => "vcenter",
    "align" => "center",
    "border" => "thin"
)

format_defs[:f_fmt_left_parens] = Dict(
    "num_format" => "(#,##0.00)",
    "font_name" => "Arial",
    "font_size" => 9,
    "valign" => "vcenter",
    "align" => "left",
    "right" => "thin",
    "bottom" => "thin",
    "top" => "thin"
)


format_defs[:pct_fmt_parens] = Dict(
    "num_format" => "(0.00%)",
    "font_name" => "Arial",
    "font_size" => 9,
    "valign" => "vcenter",
    "align" => "left",
    "right" => "thin",
    "bottom" => "thin",
    "top" => "thin"
)


format_defs[:pct_fmt] = Dict(
    "num_format" => "0.00%",
    "font_name" => "Arial",
    "font_size" => 9,
    "valign" => "vcenter",
    "align" => "right",
    "border" => "thin"
)

format_defs[:or_fmt] = Dict(
    "num_format" => "0.000",
    "font_name" => "Arial",
    "font_size" => 9,
    "valign" => "vcenter",
    "align" => "right",
    "left" => "thin",
    "bottom" => "thin",
    "top" => "thin"
)

format_defs[:cilb_fmt] = Dict(
    "num_format" => "(0.000\\,;(-0.000\\,",
    "font_name" => "Arial",
    "font_size" => 9,
    "valign" => "vcenter",
    "align" => "right",
    "bottom" => "thin",
    "top" => "thin"
)

format_defs[:ciub_fmt] = Dict(
    "num_format" => "0.000)",
    "font_name" => "Arial",
    "font_size" => 9,
    "valign" => "vcenter",
    "align" => "left",
    "right" => "thin",
    "bottom" => "thin",
    "top" => "thin"
)


format_defs[:or_fmt_red] = Dict(
    "num_format" => "0.000",
    "font_name" => "Arial",
    "font_size" => 9,
    "font_color" => "red",
    "valign" => "vcenter",
    "align" => "right",
    "left" => "thin",
    "bottom" => "thin",
    "top" => "thin"
)

format_defs[:cilb_fmt_red] = Dict(
    "num_format" => "(0.000\\,;(-0.000\\,)",
    "font_name" => "Arial",
    "font_size" => 9,
    "font_color" => "red",
    "valign" => "vcenter",
    "align" => "right",
    "bottom" => "thin",
    "top" => "thin"
)

format_defs[:ciub_fmt_red] = Dict(
    "num_format" => "0.000)",
    "font_name" => "Arial",
    "font_size" => 9,
    "font_color" => "red",
    "valign" => "vcenter",
    "align" => "left",
    "right" => "thin",
    "bottom" => "thin",
    "top" => "thin"
)


format_defs[:or_fmt_bold] = Dict(
    "num_format" => "0.000",
    "font_name" => "Arial",
    "font_size" => 9,
    "bold" => true,
    "valign" => "vcenter",
    "align" => "right",
    "left" => "thin",
    "bottom" => "thin",
    "top" => "thin"
)

format_defs[:cilb_fmt_bold] = Dict(
    "num_format" => "(0.000 -",
    "font_name" => "Arial",
    "font_size" => 9,
    "bold" => true,
    "valign" => "vcenter",
    "align" => "right",
    "bottom" => "thin",
    "top" => "thin"
)

format_defs[:ciub_fmt_bold] = Dict(
    "num_format" => "0.000)",
    "font_name" => "Arial",
    "font_size" => 9,
    "bold" => true,
    "valign" => "vcenter",
    "align" => "left",
    "right" => "thin",
    "bottom" => "thin",
    "top" => "thin"
)

format_defs[:p_fmt] = Dict(
    "num_format" => "0.000",
    "font_name" => "Arial",
    "font_size" => 9,
    "valign" => "vcenter",
    "align" => "right",
    "border" => "thin"
)

format_defs[:p_fmt_center] = Dict(
    "num_format" => "0.000",
    "font_name" => "Arial",
    "font_size" => 9,
    "valign" => "vcenter",
    "align" => "center",
    "border" => "thin"
)

format_defs[:p_fmt2] = Dict(
    #"num_format" => "0.000",
    "font_name" => "Arial",
    "font_size" => 9,
    "valign" => "vcenter",
    "align" => "right",
    "border" => "thin"
)


format_defs[:p_fmt_red] = Dict(
    "num_format" => "0.000",
    "font_name" => "Arial",
    "font_size" => 9,
    "font_color" => "red",
    "valign" => "vcenter",
    "align" => "right",
    "border" => "thin"
)

format_defs[:p_fmt2_red] = Dict(
    #"num_format" => "0.000",
    "font_name" => "Arial",
    "font_size" => 9,
    "font_color" => "red",
    "valign" => "vcenter",
    "align" => "right",
    "border" => "thin"
)


format_defs[:p_fmt_bold] = Dict(
    "num_format" => "0.000",
    "font_name" => "Arial",
    "font_size" => 9,
    "bold" => true,
    "valign" => "vcenter",
    "align" => "right",
    "border" => "thin"
)

format_defs[:p_fmt2_bold] = Dict(
    #"num_format" => "0.000",
    "font_name" => "Arial",
    "font_size" => 9,
    "bold" => "thin",
    "valign" => "vcenter",
    "align" => "right",
    "border" => "thin"
)

format_defs[:empty_border] = Dict(
    #"num_format" => "0.000",
    "valign" => "vcenter",
    "border" => "thin"
)

format_defs[:empty_left] = Dict(
    #"num_format" => "0.000",
    "valign" => "vcenter",
    "right" => "thin",
    "bottom" => "thin",
    "top" => "thin"
)

format_defs[:empty_right] = Dict(
    #"num_format" => "0.000",
    "valign" => "vcenter",
    "left" => "thin",
    "bottom" => "thin",
    "top" => "thin"
)


format_defs[:empty_both] = Dict(
    #"num_format" => "0.000",
    "valign" => "vcenter",
    "bottom" => "thin",
    "top" => "thin"
)



fmt_no_opt = ("bold", "italic", "font_strikeout", "unlocked", "hidden", "text_wrap",
    "shrink", "quote_prefix")

fmt_align = Dict(
    "none" => 0,
    "left" => 1,
    "center" => 2,
    "right" => 3,
    "fill" => 4,
    "justify" => 5,
    "center_across" => 6,
    "distributed" => 7
)

fmt_valign = Dict(
    "top" => 8,
    "bottom" => 9,
    "vcenter" => 10,
    "justify" => 11,
    "vdistributed" => 12
)

# options mapping
fmt_diag = Dict("up" => 1, "down" => 2, "up_down" => 3)

fmt_underline = Dict("none" => 0, "single" => 1, "double" => 2, "single_accounting" => 3, "double_accounting" => 4)

fmt_script = Dict("superscript" => 1, "subscript" => 2)

fmt_color = Dict(
    "black" => 16777216,
    "blue" => 255,
    "brown" => 8388608,
    "cyan" => 65535,
    "gray" => 8421504,
    "green" => 32768,
    "lime" => 65280,
    "magenta" => 16711935,
    "navy" => 128,
    "orange" => 16737792,
    "pink" => 16711935,
    "purple" => 8388736,
    "red" => 16711680,
    "silver" => 12632256,
    "white" => 16777215,
    "yellow" => 16776960
)

fmt_border = Dict(
    "none" => 0,
    "thin" => 1,
    "thin" => 2,
    "dashed" => 3,
    "dotted" => 4,
    "thick" => 5,
    "double" => 6,
    "hair" => 7,
    "thin_dashed" => 8,
    "dash_dot" => 9,
    "thin_dash_dot" => 10,
    "dash_dot_dot" => 11,
    "thin_dash_dot_dot" => 12,
    "slant_dash_dot" => 13
)

# all format functions
fmt_function = Dict{String,Function}(
    "font_name" => LibXLSXWriter.format_set_font_name,
    "font_size" => LibXLSXWriter.format_set_font_size,
    "font_color" => LibXLSXWriter.format_set_font_color,
    "bold" => LibXLSXWriter.format_set_bold,
    "italic" => LibXLSXWriter.format_set_italic,
    "underline" => LibXLSXWriter.format_set_underline,
    "font_strikeout" => LibXLSXWriter.format_set_font_strikeout,
    "font_script" => LibXLSXWriter.format_set_font_script,
    "font_family" => LibXLSXWriter.format_set_font_family,
    "font_charset" => LibXLSXWriter.format_set_font_charset,
    "num_format" => LibXLSXWriter.format_set_num_format,
    "num_format_index" => LibXLSXWriter.format_set_num_format_index,
    "unlocked" => LibXLSXWriter.format_set_unlocked,
    "hidden" => LibXLSXWriter.format_set_hidden,
    "align" => LibXLSXWriter.format_set_align,
    "valign" => LibXLSXWriter.format_set_align,
    "text_wrap" => LibXLSXWriter.format_set_text_wrap,
    "rotation" => LibXLSXWriter.format_set_rotation,
    "indent" => LibXLSXWriter.format_set_indent,
    "shrink" => LibXLSXWriter.format_set_shrink,
    "pattern" => LibXLSXWriter.format_set_pattern,
    "bg_color" => LibXLSXWriter.format_set_bg_color,
    "fg_color" => LibXLSXWriter.format_set_fg_color,
    "border" => LibXLSXWriter.format_set_border,
    "bottom" => LibXLSXWriter.format_set_bottom,
    "top" => LibXLSXWriter.format_set_top,
    "left" => LibXLSXWriter.format_set_left,
    "right" => LibXLSXWriter.format_set_right,
    "border_color" => LibXLSXWriter.format_set_border_color,
    "bottom_color" => LibXLSXWriter.format_set_bottom_color,
    "top_color" => LibXLSXWriter.format_set_top_color,
    "left_color" => LibXLSXWriter.format_set_left_color,
    "right_color" => LibXLSXWriter.format_set_right_color,
    "diag_type" => LibXLSXWriter.format_set_diag_type,
    "diag_border" => LibXLSXWriter.format_set_diag_border,
    "diag_color" => LibXLSXWriter.format_set_diag_color,
    "quote_prefix" => LibXLSXWriter.format_set_quote_prefix
)

# function to create format
function create_formats(wb; fmt::Dict=format_defs)
    newfmts = Dict()
    for key in keys(fmt)
        fdict = fmt[key]
        newfmts[key] = LibXLSXWriter.workbook_add_format(wb)
        for ff in keys(fdict)
            if ff in fmt_no_opt
                fmt_function[ff](newfmts[key])
            elseif ff == "align"
                fmt_function[ff](newfmts[key], fmt_align[fdict[ff]])
            elseif ff == "valign"
                fmt_function[ff](newfmts[key], fmt_valign[fdict[ff]])
            elseif ff == "diag"
                fmt_function[ff](newfmts[key], fmt_diag[fdict[ff]])
            elseif ff == "underline"
                fmt_function[ff](newfmts[key], fmt_underline[fdict[ff]])
            elseif ff == "script"
                fmt_function[ff](newfmts[key], fmt_script[fdict[ff]])
            elseif ff == "font_color"
                fmt_function[ff](newfmts[key], fmt_color[fdict[ff]])
            elseif ff in ("border", "left", "top", "right", "bottom")
                fmt_function[ff](newfmts[key], fmt_border[fdict[ff]])
            else
                fmt_function[ff](newfmts[key], fdict[ff])
            end
        end

    end
    return newfmts
end
