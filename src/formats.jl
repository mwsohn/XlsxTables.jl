# these are the formats for which there are no options. Use `true` in the format_defs
fmt_no_opt = ("bold", "italic", "font_strikeout", "unlocked", "hidden", "text_wrap",
    "shrink", "quote_prefix")

fmtdict = Dict(
    # alignment mapping
    "align" => Dict(
        "none" => 0,
        "left" => 1,
        "center" => 2,
        "right" => 3,
        "fill" => 4,
        "justify" => 5,
        "center_across" => 6,
        "distributed" => 7
    ),

    # vertical alignment mapping
    "valign" => Dict(
        "top" => 8,
        "bottom" => 9,
        "vcenter" => 10,
        "justify" => 11,
        "vdistributed" => 12
    ),

    # diagonal line 
    "diag" => Dict("up" => 1, "down" => 2, "up_down" => 3),

    # underline type
    "underline" => Dict(
        "none" => 0,
        "single" => 1,
        "double" => 2,
        "single_accounting" => 3,
        "double_accounting" => 4
    ),

    # subscript/superscript type
    "script" => Dict(
        "superscript" => 1,
        "subscript" => 2
    ),

    # color mapping
    "color" => Dict(
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
    ),

    # border thickness
    "border" => Dict(
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
    ),

    # pattern
    "pattern" => Dict(
        "none" => 0,
        "solid" => 1,
        "medium_gray" => 2,
        "dark_gray" => 3,
        "light_gray" => 4,
        "dark_horizontal" => 5,
        "dark_vertical" => 6,
        "dark_down" => 7,
        "dark_up" => 8,
        "dark_grid" => 9,
        "dark_trellis" => 10,
        "light_horizontal" => 11,
        "light_vertical" => 12,
        "light_down" => 13,
        "light_up" => 14,
        "light_grid" => 15,
        "light_trellis" => 16,
        "gray_125" => 17,
        "gray_0625" => 18
    )
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
    if haskey(fmt,:global)
        fglobal = fmt[:global]
    end
    for key in keys(fmt)
        if key == :global
            continue
        end
        fdict = fmt[key]
        newfmts[key] = LibXLSXWriter.workbook_add_format(wb)
        for ff in keys(merge(fglobal,fdict))
            if ff in fmt_no_opt
                fmt_function[ff](newfmts[key])
            elseif haskey(fmtdict,ff)
                fmt_function[ff](newfmts[key], fmtdict[ff][fdict[ff]])
            # elseif ff == "align"
            #     fmt_function[ff](newfmts[key], fmt_align[fdict[ff]])
            # elseif ff == "valign"
            #     fmt_function[ff](newfmts[key], fmt_valign[fdict[ff]])
            # elseif ff == "diag"
            #     fmt_function[ff](newfmts[key], fmt_diag[fdict[ff]])
            # elseif ff == "underline"
            #     fmt_function[ff](newfmts[key], fmt_underline[fdict[ff]])
            # elseif ff == "script"
            #     fmt_function[ff](newfmts[key], fmt_script[fdict[ff]])
            # elseif ff == "font_color"
            #     fmt_function[ff](newfmts[key], fmt_color[fdict[ff]])
            # elseif ff in ("border", "left", "top", "right", "bottom")
            #     fmt_function[ff](newfmts[key], fmt_border[fdict[ff]])
            else
                fmt_function[ff](newfmts[key], fdict[ff])
            end
        end

    end
    return newfmts
end
