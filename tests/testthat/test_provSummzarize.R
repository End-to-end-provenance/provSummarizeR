library(provSummarizeR)
library(testthat)

## Loading test data
test.data <- system.file("testdata", "prov.json", package = "provSummarizeR", mustWork=TRUE)

# Test prov.summarize.file
summary <- capture.output (prov.summarize.file(test.data, save = FALSE, create.zip = FALSE))
expect_equal(length(summary), 39)

