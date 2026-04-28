# -----------------------------------------------
# format definitions
#------------------------------------------------
format_defs = Dict(

    # format commands listed in the :global dictionary
    # will be added to all the other dictionaries below
    :global => Dict(
        "font_name" => "Arial",
        "font_size" => 9
    ),

    # header cells
    :heading => Dict(
        "bold" => true,
        "valign" => "vcenter", 
        "align" => "center", 
        "border" => "thin"
    ),

    :heading_right => Dict(
        "bold" => true,
        "valign" => "vcenter",
        "align" => "right",
        "left" => "thin",
        "bottom" => "thin",
        "top" => "thin"
    ), 
    
    :heading_left => Dict(
        "bold" => true,
        "valign" => "vcenter",
        "align" => "left",
        "right" => "thin",
        "bottom" => "thin",
        "top" => "thin"
    ),

    # string values
    :text => Dict(
        "valign" => "vcenter",
        "align" => "left",
        "border" => "thin"
    ),

    :str_r_b => Dict(
        "align" => "right",
        "valign" => "vcenter",
        "top" => "thin",
        "left" => "thin",
        "bottom" => "thin"
    ),

    :str_c_b => Dict(
        "align" => "center",
        "valign" => "vcenter",
        "top" => "thin",
        "left" => "thin",
        "bottom" => "thin"
    ),

    :model_name => Dict(
        "valign" => "vcenter",
        "align" => "left",
        "border" => "thin"
    ),

    :varname_1indent => Dict(
        "valign" => "vcenter",
        "align" => "left",
        "border" => "thin",
        "indent" => 1
    ),

    :varname_2indent => Dict(
        "valign" => "vcenter",
        "align" => "left",
        "border" => "thin",
        "indent" => 2
    ),

    # numeric values
    :n_fmt_right => Dict(
        "num_format" => "#,##0",
        "valign" => "vcenter",
        "align" => "right",
        "left" => "thin",
        "bottom" => "thin",
        "top" => "thin"
    ),

    :n_fmt_right_noborder => Dict(
        "num_format" => "#,##0",
        "valign" => "vcenter",
        "align" => "right",
        "border" => "none"
    ),

    :n_fmt_left_parens => Dict(
        "num_format" => "(#,##0)",
        "valign" => "vcenter",
        "align" => "right",
        "right" => "thin",
        "bottom" => "thin",
        "top" => "thin"
    ),

    :f_date => Dict(
        "num_format" => "mm/dd/yyyy",
        "valign" => "vcenter",
        "align" => "right",
        "border" => "thin"
    ),

    :f_datetime => Dict(
        "num_format" => "mm/dd/yyyy hh:mm:ss",
        "valign" => "vcenter",
        "align" => "right",
        "border" => "thin"
    ),

    :f_fmt_right => Dict(
        "num_format" => "#,##0.00",
        "valign" => "vcenter",
        "align" => "right",
        "left" => "thin",
        "bottom" => "thin",
        "top" => "thin"
    ),

    :f_fmt_center => Dict(
        "num_format" => "#,##0.0000",
        "valign" => "vcenter",
        "align" => "center",
        "border" => "thin"
    ),

    :f_fmt => Dict(
        "num_format" => "#,##0.00",
        "valign" => "vcenter",
        "align" => "right",
        "border" => "thin"
    ),

    :n_fmt => Dict(
        "num_format" => "#,##0",
        "valign" => "vcenter",
        "align" => "right",
        "border" => "thin"
    ),

    :n_fmt_center => Dict(
        "num_format" => "#,##0",
        "valign" => "vcenter",
        "align" => "center",
        "border" => "thin"
    ),

    :f_fmt_left_parens => Dict(
        "num_format" => "(#,##0.00)",
        "valign" => "vcenter",
        "align" => "left",
        "right" => "thin",
        "bottom" => "thin",
        "top" => "thin"
    ),

    :pct_fmt_parens => Dict(
        "num_format" => "(0.00%)",
        "valign" => "vcenter",
        "align" => "left",
        "right" => "thin",
        "bottom" => "thin",
        "top" => "thin"
    ),

    :pct_fmt => Dict(
        "num_format" => "0.00%",
        "valign" => "vcenter",
        "align" => "right",
        "border" => "thin"
    ),

    # numeric values for odds ratios and their confidence intervals
    :or_fmt => Dict(
        "num_format" => "0.000",
        "valign" => "vcenter",
        "align" => "right",
        "left" => "thin",
        "bottom" => "thin",
        "top" => "thin"
    ),

    :cilb_fmt => Dict(
        "num_format" => "(0.000\\,;(-0.000\\,",
        "valign" => "vcenter",
        "align" => "right",
        "bottom" => "thin",
        "top" => "thin"
    ),

    :ciub_fmt => Dict(
        "num_format" => "0.000)",
        "valign" => "vcenter",
        "align" => "left",
        "right" => "thin",
        "bottom" => "thin",
        "top" => "thin"
    ),

    :or_fmt_red => Dict(
        "num_format" => "0.000",
        "font_color" => "red",
        "valign" => "vcenter",
        "align" => "right",
        "left" => "thin",
        "bottom" => "thin",
        "top" => "thin"
    ),

    :cilb_fmt_red => Dict(
        "num_format" => "(0.000\\,;(-0.000\\,)",
        "font_color" => "red",
        "valign" => "vcenter",
        "align" => "right",
        "bottom" => "thin",
        "top" => "thin"
    ),

    :ciub_fmt_red => Dict(
        "num_format" => "0.000)",
        "font_color" => "red",
        "valign" => "vcenter",
        "align" => "left",
        "right" => "thin",
        "bottom" => "thin",
        "top" => "thin"
    ),

    :or_fmt_bold => Dict(
        "num_format" => "0.000",
        "bold" => true,
        "valign" => "vcenter",
        "align" => "right",
        "left" => "thin",
        "bottom" => "thin",
        "top" => "thin"
    ),

    :cilb_fmt_bold => Dict(
        "num_format" => "(0.000 -",
        "bold" => true,
        "valign" => "vcenter",
        "align" => "right",
        "bottom" => "thin",
        "top" => "thin"
    ),

    :ciub_fmt_bold => Dict(
        "num_format" => "0.000)",
        "bold" => true,
        "valign" => "vcenter",
        "align" => "left",
        "right" => "thin",
        "bottom" => "thin",
        "top" => "thin"
    ),

    # p-values
    :p_fmt => Dict(
        "num_format" => "0.000",
        "valign" => "vcenter",
        "align" => "right",
        "border" => "thin"
    ),

    :p_fmt_center => Dict(
        "num_format" => "0.000",
        "valign" => "vcenter",
        "align" => "center",
        "border" => "thin"
    ),

    :p_fmt2 => Dict(
        "valign" => "vcenter",
        "align" => "right",
        "border" => "thin"
    ),

    :p_fmt_red => Dict(
        "num_format" => "0.000",
        "font_color" => "red",
        "valign" => "vcenter",
        "align" => "right",
        "border" => "thin"
    ),

    :p_fmt2_red => Dict(
        "font_color" => "red",
        "valign" => "vcenter",
        "align" => "right",
        "border" => "thin"
    ),

    :p_fmt_bold => Dict(
        "num_format" => "0.000",
        "font_name" => "Arial",
        "font_size" => 9,
        "bold" => true,
        "valign" => "vcenter",
        "align" => "right",
        "border" => "thin"
    ),

    :p_fmt2_bold => Dict(
        "bold" => "thin",
        "valign" => "vcenter",
        "align" => "right",
        "border" => "thin"
    ),

    # empty cells to take care of borders
    :empty_border => Dict(
        "valign" => "vcenter",
        "border" => "thin"
    ),

    :empty_left => Dict(
        "valign" => "vcenter",
        "right" => "thin",
        "bottom" => "thin",
        "top" => "thin"
    ),

    :empty_right => Dict(
        "valign" => "vcenter",
        "left" => "thin",
        "bottom" => "thin",
        "top" => "thin"
    ),

    :empty_both => Dict(
        "valign" => "vcenter",
        "bottom" => "thin",
        "top" => "thin"
    )
)