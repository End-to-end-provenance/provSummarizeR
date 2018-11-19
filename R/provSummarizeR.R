# Copyright (C) President and Fellows of Harvard College and 
# Trustees of Mount Holyoke College, 2014, 2015, 2016, 2017, 2018.

# This program is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public
#   License along with this program.  If not, see
#   <http://www.gnu.org/licenses/>.

###############################################################################

#' prov.summarize.file
#' 
#' prov.summarize.file reads a JSON file that contains provenance and outputs
#' a text summary to the R console
#' 
#' @param prov.file the path to the file containing provenance
#' @param create.zip if true all of the provenance data will be packaged up
#'   into a zip file stored in the current working directory
#' @export
prov.summarize.file <- function (prov.file, create.zip=FALSE) {
  prov <- provParseR::prov.parse(prov.file)
  environment <- provParseR::get.environment(prov)
  generate.environment.summary (environment, provParseR::get.tool.info(prov))
  generate.library.summary (provParseR::get.libs(prov))
  generate.file.summary ("Input", provParseR::get.input.files(prov))
  generate.file.summary ("Output", provParseR::get.output.files(prov))
  generate.script.summary (provParseR::get.scripts(prov))
  
  if (create.zip) {
    save.to.zip.file (environment)
  }
}

generate.environment.summary <- function (environment, tool.info) {
  script.path <- environment[environment$label == "script", ]$value
  script.file <- sub(".*/", "", script.path)
  cat (paste ("Provenance summary for", script.file, "\n\n"))
  cat (paste ("Executed at", environment[environment$label == "provTimestamp", ]$value, "\n"))
  cat (paste ("Script last modified at", environment[environment$label == "scriptTimeStamp", ]$value, "\n"))
  cat (paste ("Executed with", environment[environment$label == "langVersion", ]$value, "\n"))
  cat (paste ("Executed on", environment[environment$label == "architecture", ]$value,
      "running", environment[environment$label == "operatingSystem", ]$value, "\n"))
  cat (paste ("Provenance was collected with", tool.info$tool.name, tool.info$tool.version, "\n"))
  cat (paste ("Provenance is stored in", environment[environment$label == "provDirectory", ]$value, "\n"))
}

generate.library.summary <- function (libs) {
  cat ("\nLibraries:\n")
  cat (paste (libs$name, libs$version, collapse="\n"))
  cat ("\n")
}

generate.file.summary <- function (direction, files) {
  if (nrow(files) == 0) {
    cat (paste ("\n", direction, "files: None\n"))
  }
  else {
    cat (paste ("\n", direction, "files:\n"))
    file.info <- dplyr::select(files, "name", "timestamp")
    print (file.info, row.names=FALSE, right=FALSE)
  }
}

generate.script.summary <- function (scripts) {
  if (nrow(scripts) > 1) {
    cat (paste ("\nScripts sourced:\n"))
    script.info <- dplyr::select(scripts[2:nrow(scripts), ], "script", "timestamp")
    print (script.info, row.names=FALSE, right=FALSE)
  }
}

save.to.zip.file <- function (environment) {
  cur.dir <- getwd()
  prov.path <- environment[environment$label == "provDirectory", ]$value
  setwd(prov.path)
  prov.dir <- sub (".*/", "", prov.path)
  zipfile <- paste0 (prov.dir, "_", 
      environment[environment$label == "provTimestamp", ]$value, ".zip")
  zippath <- paste0 (cur.dir, "/", zipfile)
  if (file.exists (zippath)) {
    setwd(cur.dir)
    stop (zippath, " already exists.")
  }
  utils::zip (zippath, ".", extras="-x debug/")
  setwd(cur.dir)
  cat (paste ("Provenance saved in", zipfile))
}
