## provSummarizeR
Reads the provenance collected by rdtLite or rdt from execution of a script or commands
in the console. Creates a human-readable summary of the provenance, including details 
on the computing environment, loaded libraries, scripts used (if any), input and output
files, console output, and error and warning messages. The summary is optionally saved 
to a text file and all related provenance files are optionally packaged in a zip file.


## Installation
Install from GitHub:

```r
# install.packages("devtools")
devtools::install_github("End-to-end-provenance/provSummarizeR")
```
Once installed, load the package:

```{r}
library("provSummarizeR")
```


## Usage
The summarize functions can be used in one of three ways.

1. To sumarize the last provenance collected in the current R session:

```{r}
prov.summarize ()
```

2. To run the script <i>script.R</i>, collect provenance, and summarize 
the provenance all in one step:

```
prov.summarize.run ("script.R")
```

3. To summarize provenance that was collected in the past and stored in the file
<i>prov.json</i> on the directory <i>prov_script</i>:

```{r}
prov.summarize.file ("prov_script/prov.json")
```

All three functions have two optional parameters, <i>save</i> and <i>create.zip</i>.  

If <i>save</i> is true, the summary is saved to a text file, in addition to being displayed
in the console.  The file is named <i>prov-summary.txt</i> and is stored in the current
provenance directory.  The default value of <i>save</i> is false.

If <i>create.zip</i> is true, the provenance directory is packaged into a timestamped zip file
and placed in the current working directory.  This file will contain a copy of all input and
output files and scripts used, as well as the <i>prov-summary.txt</i> if <i>save</i> is true.
It also includes the <i>prov.json</i> file containing the detailed execution trace.  The default
value of <i>create.zip</i> is false.

Creating the zip file depends on use of an external zip program.  It has been
tested with zip for Unix/Mac OS and with 7z on Windows.  It may or may not work with
other zip programs.  To use a program other than zip, set the R_ZIPCMD environment variable.

## Example

Here is an example of what the summary looks like.  It first identifies the script executed.
Next it describes details of how and when the script was executed.  It then lists the libraries
that were used during execution, any additional scripts sourced, and the input and
output files.

```
PROVENANCE SUMMARY for script.R 

ENVIRONMENT:
Executed at 2018-11-29T16.52.34EST 
Script last modified at 2018-11-29T16.34.54EST 
Executed with R version 3.5.1 (2018-07-02) 
Executed on x86_64 running darwin15.6.0 
Provenance was collected with rdtLite 1.0.2 
Provenance is stored in /Users/blerner/Documents/scripts/prov_script 
Hash algorithm is md5 

LIBRARIES:
base 3.5.1
datasets 3.5.1
ggplot2 3.0.0
graphics 3.5.1
grDevices 3.5.1
methods 3.5.1
provSummarizeR 1.0
rdtLite 1.0.2
stats 3.5.1
utils 3.5.1

SOURCED SCRIPTS:
None

INPUTS: 
File : in.txt 
   2018-11-29T16.52.35EST 
   52dbff5d488efed73caf540c9476aa01 
File : script2.R 
   2018-11-29T16.52.35EST 
   422b85c26655e3192dece05303b58c11 

OUTPUTS: 
File : out.txt 
   2018-11-29T16.52.35EST 
   a4a33d050511356b2108669380684498 
```

