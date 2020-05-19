library(provSummarizeR)
library(testthat)

# Test prov.summarize.file
test.data <- system.file("testdata", "prov.json", package = "provSummarizeR", mustWork=TRUE)
test.expected <- system.file("testsummaries", "prov.expected", package = "provSummarizeR", mustWork=TRUE)
expect_known_output(prov.summarize.file(test.data, save = FALSE, create.zip = FALSE), test.expected, update = FALSE)

# Test prov.summarize.run
test.script <- system.file("testscripts", "warnings.r", package = "provSummarizeR", mustWork=TRUE)
test.expected <- system.file("testsummaries", "warnings.expected", package = "provSummarizeR", mustWork=TRUE)
summary <- capture.output (prov.summarize.run(test.script))
expected.summary <- readLines (test.expected)
expect_equal(length(summary), length(expected.summary))
expect_equal(summary[1:4], expected.summary[1:4])
expect_equal(summary[12:14], expected.summary[12:14])
expect_equal(summary[26:46], expected.summary[26:46])
# Can't test this like the others because some of the fields will change when it is run,
# like execution time.
# expect_known_output(prov.summarize.run(test.script), test.expected, update = FALSE)

# Test console session
test.data <- system.file("testdata", "console.json", package = "provSummarizeR", mustWork=TRUE)
test.expected <- system.file("testsummaries", "console.expected", package = "provSummarizeR", mustWork=TRUE)
expect_known_output(prov.summarize.file(test.data, save = FALSE, create.zip = FALSE), test.expected, update = FALSE)

# Test files & urls
test.data2 <- system.file("testdata", "files.json", package = "provSummarizeR", mustWork=TRUE)
test.expected <- system.file("testsummaries", "files.expected", package = "provSummarizeR", mustWork=TRUE)
expect_known_output(prov.summarize.file(test.data2), test.expected, update = FALSE)


