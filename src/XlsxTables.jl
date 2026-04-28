module XlsxTables

################################################################################
##
## Dependencies
##
################################################################################

using DataFrames, CategoricalArrays, Distributions, GLM, StatsAPI, Survival, StatsBase, DataStructures,
    HypothesisTests, NamedArrays, FreqTables, Stella, TableMetadataTools, ROCAnalysis,
    Dates, OrderedCollections, AnalysisOfVariance, LibXLSXWriter, Printf, Reexport
    
@reexport using LibXLSXWriter: workbook_new, workbook_close, workbook_add_worksheet, workbook_add_format, format_set_bold, worksheet_set_column, worksheet_write_string, worksheet_write_number, worksheet_insert_image, worksheet_merge_range

##############################################################################
##
## Exported methods and types (in addition to everything reexported above)
##
##############################################################################

export  univariatexls,   # output univariate statistics in an excel worksheet
        dfxls,
        anovaxls,
        create_formats
        # bivariatexls,  # output bivariate statistics in an excel worksheet
        # glmxls,        # output GLM models to an excel worksheet
        # mglmxls,       # output multiple GLM regression models to an excel spreadsheet
        # dfxls,         # output dataframe in an excel file
        # hltest
       
##############################################################################
##
## Load files
##
##############################################################################
include("xlsout.jl")
include("glmxls.jl")
include("format_defs.jl")
include("formats.jl")
include("anovaxls.jl")
include("helpers.jl")


end # module