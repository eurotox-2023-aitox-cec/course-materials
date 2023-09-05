## install script - installs all R packages needed for the Track A demos.

install.packages("pak")
library(pak)
pkg_install(c(
  "tidyverse",
  "tidymodels",
  "broom.mixed",
  "dotwhisker",
  "QSARdata",
  "bundle",
  "doMC",
  "finetune",
  "tune",
  "BiocManager", # toxicogenomics
  "DESeq2", # toxicogenomics
  "ggpubr", # toxicogenomics
  "corrr", # toxicogenomics
  "ggfortify", # toxicogenomics
  "ggcorrplot", # toxicogenomics
  "ggdendro", # toxicogenomics
  "data.table", # toxicogenomics
  "GGally", # toxicogenomics
  "enrichR"# toxicogenomics
))

# Track A / Prob-Hazard-Models ==========================================================

# Install reticulate first to manage Python dependencies
install.packages("reticulate") 

# needs a python environment, two ways to do this:
# Virtualenv:
#    > `python -m venv reticulate` # in bash shell
#    > `source venv/bin/activate` 
#    > `pip install rdkit pillow biobricks`
# reticulate: # this method won't work on all systems
#    > reticulate::virtualenv_create('reticulate')
#    > reticulate::use_virtualenv('reticulate',required=TRUE)
#    > reticulate::py_install(c('rdkit','biobricks','pillow'), method='pip')

# Install R packages needed for prob-hazard-models
pkg_install(c(
  "pacman",  # For package management
  "httr",    # For HTTP requests
  "jsonlite", # For JSON parsing
  "arrow",   # For data interchange
  "glue",    # For string manipulation
  "torch",   # For deep learning
  "zeallot", # For unpacking
  "github::biobricks-ai/biobricks-r"  # For biobricks R package from GitHub
))
