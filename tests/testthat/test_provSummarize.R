library(provSummarizeR)
library(testthat)

# Test prov.summarize.file
test.data <- system.file("testdata", "prov.json", package = "provSummarizeR", mustWork=TRUE)
test.expected <- system.file("testsummaries", "prov.expected", package = "provSummarizeR", mustWork=TRUE)
expect_known_output(prov.summarize.file(test.data, save = FALSE, create.zip = FALSE), test.expected, update = FALSE)

# Test summaries that include error messages
test.data <- system.file("testdata", "warnings.json", package = "provSummarizeR", mustWork=TRUE)
test.expected <- system.file("testsummaries", "warnings.expected", package = "provSummarizeR", mustWork=TRUE)
expect_known_output(prov.summarize.file(test.data, save = FALSE, create.zip = FALSE), test.expected, update = FALSE)

# Test console session
test.data <- system.file("testdata", "console.json", package = "provSummarizeR", mustWork=TRUE)
test.expected <- system.file("testsummaries", "console.expected", package = "provSummarizeR", mustWork=TRUE)
expect_known_output(prov.summarize.file(test.data, save = FALSE, create.zip = FALSE), test.expected, update = FALSE)

# Test files & urls
test.data2 <- system.file("testdata", "files.json", package = "provSummarizeR", mustWork=TRUE)
test.expected <- system.file("testsummaries", "files.expected", package = "provSummarizeR", mustWork=TRUE)
expect_known_output(prov.summarize.file(test.data2), test.expected, update = FALSE)


