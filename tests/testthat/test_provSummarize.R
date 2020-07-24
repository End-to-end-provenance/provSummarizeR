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

# Test prov.summarize.run
test_that("invoking rdtLite", {
  skip_if_not_installed("rdtLite")
  test.script <- system.file("testscripts", "warnings.r", package = "provSummarizeR", mustWork=TRUE)
  test.expected <- system.file("testsummaries", "warnings.expected", package = "provSummarizeR", mustWork=TRUE)
  summary <- capture.output (prov.summarize.run(test.script), type = "output")
  expected.summary <- readLines (test.expected)
  # Compare header, then skip lines dealing with when and where the script was executed and the 
  # libraries loaded
  expect_equal(summary[2:4], expected.summary[1:3])
  start.line <- match ("SOURCED SCRIPTS:", summary)
  expected.start.line <- match ("SOURCED SCRIPTS:", expected.summary)
  expect_equal(summary[start.line:(start.line+20)], 
               expected.summary[expected.start.line:(expected.start.line+20)])
})

