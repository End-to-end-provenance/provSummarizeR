# provSummarizeR 1.4.1

* Updated tests to reflect a change in rdtLite that affects the list of libraries.
  Specifically, ggplot2 will not be listed unless the script being summarized
  uses ggplot2.

# provSummarizeR 1.4

* The summary now reports pre-exiting variables.  These are variables that
  are assigned before the script begins execution and are used within the script.
  
# provSummarizeR 1.3

* Added file & url information for console sessions

# provSummarizeR 1.2

* Messages to the console are included in the summary

# provSummarizeR 1.1

* Added total execution time to the summary
* Updated for provParseR 0.1.2
* Enhanced testing
