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
