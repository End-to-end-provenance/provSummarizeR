library(provSummarizeR)
library(testthat)

## Loading test data
test.data <- system.file("testdata", "prov.json", package = "provSummarizeR", mustWork=TRUE)

# Test prov.summarize.file
summary <- capture.output (prov.summarize.file(test.data, save = FALSE, create.zip = FALSE))
expect_equal(length(summary), 39)

# Test prov.summarize
#summary.file <- system.file("testdata", "prov-summary.txt", package = "provSummarizeR")
#if (summary.file != "") file.remove (summary.file)
#expect_false(file.exists(summary.file))
#summary <- capture.output (prov.summarize.file(test.data, save = TRUE, create.zip = FALSE))
#expect_true(file.exists(summary.file))
