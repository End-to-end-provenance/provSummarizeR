# Test file for summarizing files and urls

text <- readLines("warnings.R")
webpage <- readLines ("https://harvardforest.fas.harvard.edu/")

writeLines (text, tempfile())

