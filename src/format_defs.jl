# -----------------------------------------------
# format definitions
#------------------------------------------------
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
