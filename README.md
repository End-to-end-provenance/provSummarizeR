[![Travis-CI Build Status](https://travis-ci.org/End-to-end-provenance/provSummarizeR.svg?branch=master)](https://travis-ci.org/End-to-end-provenance/provSummarizeR)

# provSummarizeR
Given prov JSON files, returns a report identifying the user's computing environment, a 
list of all the input and output files and URLs.  It also packages the files and the
scripts into a timestamped zip file.


# Installation
Install from GitHub:
```{r}
# install.packages("devtools")
devtools::install_github("End-to-end-provenance/provSummarizeR")
```
Once installed, load the package:
```{r}
library("provSummarizeR")
```


# Usage

