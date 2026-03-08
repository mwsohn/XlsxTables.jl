module XlsxTables

################################################################################
##
## Dependencies
##
################################################################################

using DataFrames, CategoricalArrays, Distributions, GLM, Survival, StatsBase, DataStructures,
    HypothesisTests, NamedArrays, FreqTables, Stella, TableMetadataTools, LogisticROC, 
    Dates, OrderedCollections, AnalysisOfVariance, LibXLSXWriter
    
import LibXLSXWriter: workbook_new, workbook_add_worksheet, workbook_add_format, format_set_bold, worksheet_set_column, worksheet_write_string, worksheet_write_number, worksheet_insert_image, workbook_close

##############################################################################
##
## Exported methods and types (in addition to everything reexported above)
##
##############################################################################

export  univariatexls,   # output univariate statistics in an excel worksheet
        dfxls,
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
# include("mglmxls.jl")
include("formats.jl")

end # module