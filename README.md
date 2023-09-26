## course-materials

### This repo contains the workshop materials for the Continuing Education Course, CEC01 [EUROTOX 2023, 10 September 2013, in Ljubljana, Slovenia](https://www.eurotox2023.com/programme/).

### Get the materials:

In a terminal run

```
git clone https://github.com/eurotox-2023-aitox-cec/course-materials
```

or from RStudio, iniate a new RStudio project, using New Project --> Version Control 

### Posit Cloud
For all R-related demos in the course, we are hosting a pre-configured RStudio Work Space on https://posit.cloud. The link to join this workspace will be shared at the start of the course. The workspace and associated RStudio projects will be pre-configured and have all packages installed and files ready for you to use during and 2 months after the course. 

### Tracks

There is a plenary track and a track A and B.
Track A is focused on R, track B on Python

### Plenary; Keynote
The plenary key note will be delivered by Prof. dr. Thomas Hartung. Please find the abstract of his talk [here:](https://www.eurotox2023.com/programme/) 

### Plenary; Good coding practices, publishing your work and code-collaboration 
The course will be closed by a hands-on demo and instruction delivered by Dr. Alyanne De Haan. 

### Track-a; Machine Learning with R
When working from a local machine or a virgin RStudio Server: 
 - Clone the repo, activate the RStudio project inside the folder `/track-a/machine-learning-with-r`.
 - Run the following R code in this project to get started. This will install the R-package `{caait}` and will get you all the dependencies you need to run the materials for this workshop.

```
devtool::install(".") 
```
On Posit Cloud, enter into the Workspace called "CEC01-Track-A" and click on the RStudio Porject "mteunis"
This demo will illustrate how to build, run and evaluate Machine Learning models in R, using the `{tidymdodels}` suite of R packages.
To run the workshop code open **`001_tidymodels.Rmd`** file in this project.

### Track-a; Probabilistic Hazard Models Trained On Harmonized Chemical Relationship Data 
Run the files in folder ./track-a/prob-hazard-models:

 1. 1_build_data.R
 2. 2_build_model.R
 3. 3_finished_product.R

### Track-a; Toxicogenomics data and analysis workflows 
In this demo, we will illustrate how R can be used to analyse Transcriptomics data. Run these files:

1. xxx
2. xxx




### Track-b; An Introduction to Machine Learning in Python 

### Track-b; A hands-on introduction to applied artificial intelligence in toxicology: Advanced Deep Learning for Toxicology






