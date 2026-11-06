################################################################################
# R script for calculation of BIAS results either for single country data
# or multiple countries simultaneously
# Note that the country specific results may differ in single country vs all
# countries run since the age length key combines data on ICES SD basis  
#
# This script was made in 2026 in the Interreg project AUTOFISH
#
################################################################################

rm(list = ls())


suppressPackageStartupMessages({
  library(readxl)
  library(writexl)
  library(tidyverse)
  library(forcats)
  library(readr)
  library(stringr)
  library(dplyr)
  library(purrr)
  library(tidyr)
  library(tibble)
  library(mapplots)
  
})

# Define project paths
###############################
# Path for input data
# Inside the folder defined here should be country specific folders for BIAS data
# Supported country abbreviations are "EE", "FI","SE","DE","PL", "LV" and "LT
path_input <-"../../01-Projects/AUTOFISH/dat/BIAS/"

# Path for output files
path_output<-"../../01-Projects/AUTOFISH/out/BIAS/"  

##################################
############ WORKFLOW ############
##################################

# Define survey year
choose_year<-2025

# Define country or countries on which you wish to calculate results by 
# choosing one of the options below 
# (remember to comment out with "#" all other options)
# ====================================================================

# Option 1: Choose this if you wish to run only one country data
# ===============================================================
# Supported country abbreviations are "EE", "FI","SE","DE","PL", "LV" and "LT
# countries<-"EE"

# Option 2: Choose this if you wish to run multiple countries at once, but keeping
# age length keys separately calculated for each country
# ======================================================================
# countries<-c("EE", "FI","SE","DE","PL", "LV") # LT not yet supported as data is not available

# Option 3: Choose this if you wish to run the script by pooling data from all 
# countries. The age length keys are formulated on ICES SD basis
# ======================================================================
#countries<-"all"
countries<-"FI"

Ncountries<-length(countries)

for(i in 1:Ncountries){
  country<-countries[i]    
  # Read in data 
  source("current-calculus/read-in-data-BIAS-all-countries.R")
  
  # Run the script for calculating BIAS results
  source("current-calculus/current_BIAS_calculation.R")

  # Save the results
  write_xlsx(res,paste0(path_output, "BIAS_results_", choose_year,"_", country,".xlsx"))
  
}


