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

Here is an example of what the summary looks like. The first line contains the name of 
the main R script. The ENVIRONMENT section includes details describing how and when the 
script was executed and how the provenance was collected. The LIBRARIES section lists all
libraries that were loaded along with their version numbers. The SOURCED SCRIPTS section 
lists any scripts that were sourced. The INPUTS section lists any input files or URLs. 
The OUTPUTS section lists any output files. The CONSOLE section lists any output to the 
screen. Finally the ERRORS section lists any error or warning messages that were generated 
when the script was executed.

```
PROVENANCE SUMMARY for basicTest.R 

ENVIRONMENT:
Executed at 2019-08-26T10.08.19EDT 
Total execution time is 6.3 seconds
Script last modified at 2019-01-02T12.43.34EST 
Executed with R version 3.6.1 (2019-07-05) 
Executed on x86_64 running mingw32 
Provenance was collected with rdtLite 1.1.1 
Provenance is stored in C:/Prov/prov_basicTest 
Hash algorithm is md5 

LIBRARIES:
base 3.6.1
datasets 3.6.1
ggplot2 3.2.1
graphics 3.6.1
grDevices 3.6.1
methods 3.6.1
rdtLite 1.1.1
stats 3.6.1
utils 3.6.1

SOURCED SCRIPTS:
None

INPUTS: 
URL : http://harvardforest.fas.harvard.edu/data/p00/hf000/hf000-01-daily-m.csv 
   2019-08-26 10:08:26 
   76551e9b09d96eb70bba9ae7a16aab9a 

OUTPUTS: 
File : shortdata.csv 
   2019-08-26 10:08:27 
   58725476ca78c8feb08ad15602d8a006 
File : airt-vs-prec.pdf 
   2019-08-26 10:08:27 
   ea5167eff2c4e26d0525a8cb50ad8bb9 

CONSOLE:
None

ERRORS:
In basicTest.R on line  66 :
   Error in file(file, "rt"): cannot open the connection
```

