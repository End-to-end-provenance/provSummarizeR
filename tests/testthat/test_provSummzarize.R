library(provSummarizeR)
library(testthat)

## Loading test data
test.data <- system.file("testdata", "prov.json", package = "provSummarizeR")

summary <- capture.output (prov.summarize.file(test.data, save = FALSE, create.zip = FALSE))

