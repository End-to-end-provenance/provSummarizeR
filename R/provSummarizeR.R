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
#' @param save if true saves the summary to the file prov-summary.txt on the 
#' provenance directory
#' @param create.zip if true all of the provenance data will be packaged up
#'   into a zip file stored in the current working directory
#' @export
prov.summarize.file <- function (prov.file, save=FALSE, create.zip=FALSE) {
  if (!file.exists(prov.file)) {
     cat("Provenance file not found.\n")
  } else {
    prov <- provParseR::prov.parse(prov.file)
    environment <- provParseR::get.environment(prov)
    if (save) save.to.text.file(environment)
    generate.summaries(prov, environment)
    if (save) sink()
    
    if (create.zip) {
      save.to.zip.file (environment)
    }
  }
}

#' prov.summarize
#' 
#' prov.summarize reads a JSON string that contains provenance and outputs
#' a text summary to the R console
#' 
#' @param save if true saves the summary to the file prov-summary.txt on the 
#' provenance directory
#' @param create.zip if true all of the provenance data will be packaged up
#'   into a zip file stored in the current working directory
#' @export
prov.summarize <- function (save=FALSE, create.zip=FALSE) {
  prov.json <- rdtLite::prov.json()
  if (!is.null(prov.json)) {
    prov <- provParseR::prov.parse(prov.json, isFile=F)
    environment <- provParseR::get.environment(prov)
    if (save) save.to.text.file(environment)
    generate.summaries(prov, environment)
    if (save) sink()
  }

  if (create.zip) {
    save.to.zip.file (environment)
  }
}

save.to.text.file <- function(environment) {
  prov.path <- environment[environment$label == "provDirectory", ]$value
  prov.file <- paste(prov.path, "/prov-summary.txt", sep="")
  sink(prov.file)
}

generate.summaries <- function(prov, environment) {
  generate.environment.summary (environment, provParseR::get.tool.info(prov))
  generate.library.summary (provParseR::get.libs(prov))
  generate.script.summary (provParseR::get.scripts(prov))
  generate.file.summary ("INPUTS:", provParseR::get.input.files(prov))
  generate.file.summary ("OUTPUTS:", provParseR::get.output.files(prov))
}

generate.environment.summary <- function (environment, tool.info) {
  script.path <- environment[environment$label == "script", ]$value
  script.file <- sub(".*/", "", script.path)
  
  if (script.file != "") {
    cat (paste ("PROVENANCE SUMMARY for", script.file, "\n\n"))
  } else {
    cat (paste ("PROVENANCE SUMMARY for Console Session\n\n"))
  }
  
  cat (paste ("ENVIRONMENT:\n"))
  cat (paste ("Executed at", environment[environment$label == "provTimestamp", ]$value, "\n"))
  
  if (script.file != "") {
    cat (paste ("Script last modified at", environment[environment$label == "scriptTimeStamp", ]$value, "\n"))
  }
  
  cat (paste ("Executed with", environment[environment$label == "langVersion", ]$value, "\n"))
  cat (paste ("Executed on", environment[environment$label == "architecture", ]$value,
      "running", environment[environment$label == "operatingSystem", ]$value, "\n"))
  cat (paste ("Provenance was collected with", tool.info$tool.name, tool.info$tool.version, "\n"))
  cat (paste ("Provenance is stored in", environment[environment$label == "provDirectory", ]$value, "\n"))
  cat (paste ("Hash algorithm is", environment[environment$label == "hashAlgorithm", ]$value, "\n" ))
  cat ("\n")
}

generate.library.summary <- function (libs) {
  cat ("LIBRARIES:\n")
  cat (paste (libs$name, libs$version, collapse="\n"))
  cat ("\n\n")
}

generate.script.summary <- function (scripts) {
  cat (paste ("SOURCED SCRIPTS:\n"))
  if (nrow(scripts) > 1) {
    script.info <- dplyr::select(scripts[2:nrow(scripts), ], "script", "timestamp")
    for (i in 1:nrow(script.info)) {
      cat(script.info[i, "script"], "\n")
      cat("  ", script.info[i, "timestamp"], "\n")
    }
  } else {
    cat("None\n")
  }
  cat ("\n")
}

generate.file.summary <- function (direction, files) {
  cat(direction, "\n")
  if (nrow(files) == 0) {
    cat ("None\n")
  }
  else {
    file.info <- dplyr::select(files, "type", "name", "timestamp", "hash")
    for (i in 1:nrow(file.info)) {
      cat(file.info[i, "type"], ": ")
      cat(file.info[i, "name"], "\n")
      if (file.info[i, "timestamp"] != "") cat("  ", file.info[i, "timestamp"], "\n")
      if (file.info[i, "hash"] != "") cat("  ", file.info[i, "hash"], "\n")
    }
  }
  cat("\n")
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
