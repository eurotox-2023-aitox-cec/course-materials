---
title: "CEC01 - A hands-on introduction to applied artificial intelligence in toxicology (CAAIT)"
subtitle: "Machine Learning With R"
author: "Marc A.T. Teunis, PhD"
site: bookdown::bookdown_site
output: 
    bookdown::gitbook:
        css: style.css
        number_sections: false
        anchor_sections: false
        split_by: chapter
        config:
            sharing:
                 github: no
                 facebook: no
                 twitter: no
                 all: no
            toc:
                collapse: section
                scroll_highlight: yes
                before: <li class="toc-logo"><a href="./"></a> <h4 class=".paddingtitel ">CAAIT</h2></li>
header-includes:
  - \usepackage{fontawesome5}
---






# Introduction {-}

Download the source code [<svg viewBox="0 0 496 512" style="height:1em;position:relative;display:inline-block;top:.1em;" xmlns="http://www.w3.org/2000/svg">  <path d="M165.9 397.4c0 2-2.3 3.6-5.2 3.6-3.3.3-5.6-1.3-5.6-3.6 0-2 2.3-3.6 5.2-3.6 3-.3 5.6 1.3 5.6 3.6zm-31.1-4.5c-.7 2 1.3 4.3 4.3 4.9 2.6 1 5.6 0 6.2-2s-1.3-4.3-4.3-5.2c-2.6-.7-5.5.3-6.2 2.3zm44.2-1.7c-2.9.7-4.9 2.6-4.6 4.9.3 2 2.9 3.3 5.9 2.6 2.9-.7 4.9-2.6 4.6-4.6-.3-1.9-3-3.2-5.9-2.9zM244.8 8C106.1 8 0 113.3 0 252c0 110.9 69.8 205.8 169.5 239.2 12.8 2.3 17.3-5.6 17.3-12.1 0-6.2-.3-40.4-.3-61.4 0 0-70 15-84.7-29.8 0 0-11.4-29.1-27.8-36.6 0 0-22.9-15.7 1.6-15.4 0 0 24.9 2 38.6 25.8 21.9 38.6 58.6 27.5 72.9 20.9 2.3-16 8.8-27.1 16-33.7-55.9-6.2-112.3-14.3-112.3-110.5 0-27.5 7.6-41.3 23.6-58.9-2.6-6.5-11.1-33.3 2.6-67.9 20.9-6.5 69 27 69 27 20-5.6 41.5-8.5 62.8-8.5s42.8 2.9 62.8 8.5c0 0 48.1-33.6 69-27 13.7 34.7 5.2 61.4 2.6 67.9 16 17.7 25.8 31.5 25.8 58.9 0 96.5-58.9 104.2-114.8 110.5 9.2 7.9 17 22.9 17 46.4 0 33.7-.3 75.4-.3 83.6 0 6.5 4.6 14.4 17.3 12.1C428.2 457.8 496 362.9 496 252 496 113.3 383.5 8 244.8 8zM97.2 352.9c-1.3 1-1 3.3.7 5.2 1.6 1.6 3.9 2.3 5.2 1 1.3-1 1-3.3-.7-5.2-1.6-1.6-3.9-2.3-5.2-1zm-10.8-8.1c-.7 1.3.3 2.9 2.3 3.9 1.6 1 3.6.7 4.3-.7.7-1.3-.3-2.9-2.3-3.9-2-.6-3.6-.3-4.3.7zm32.4 35.6c-1.6 1.3-1 4.3 1.3 6.2 2.3 2.3 5.2 2.6 6.5 1 1.3-1.3.7-4.3-1.3-6.2-2.2-2.3-5.2-2.6-6.5-1zm-11.4-14.7c-1.6 1-1.6 3.6 0 5.9 1.6 2.3 4.3 3.3 5.6 2.3 1.6-1.3 1.6-3.9 0-6.2-1.4-2.3-4-3.3-5.6-2z"></path></svg>](https://github.com/ontox-hu/aira)

[These workshop materials were produced for the EOROTOX 2023 Conference, Continued Education Course (CEC01), 2023, held on 10 September, Ljubljana, Slovenia](https://www.eurotox2023.com/programme/)

<img src="images/eurotox-banner.png" width="375" />

## Disclaimer on this work
We would like to stress that the code and work included in this repo and workshop is experimental. It was not reviewed by a peer assessment process. The code, examples and work should be considered accordingly. The work is meant for illustrative and educational purposes. The authors do not take any responsibly for the use, re-use, application or derivates from the work included in this repository. We appreciate attribution of the original work and adapted work by the authors of this repo.

## CAAIT
Welcome to the ...

## Programme of this workshop
 1. An introduction to R and the tidyverse
 1. An introduction to Tidymodels in R (adapted from the Tidymodels documentation)
 1. An introduction to Read Accross, based on Compound similarity
 1. An introduction to Machine Learning approaches for classification of chemicals

If you are already acquainted with R and a practiced user of the `{tidyverse}` suit of R packages, you can skip activity 1. 
If you already are familiar with the `{tidymodels}` workflow, you might want to skip or only glimpse over activity 2.


You can find these lessons in the menu on the left. Each lesson starts with a short introduction by the teachers. After that, you are supposed to study the lessons yourself and make the exercises. During the lessons, you can ask questions to the teachers and the teachers will provide feedback. 

Please note: this is a crash course. We scheduled this course to allow you to throw yourself into R and be able to see yourself making progress very quickly. 

We wish you good luck and we hope you will have a lot of fun with R!

## Course material

The course material consists of the following:

- Instruction pages (menu to the left). 
- Exercises.

To navigate through the different materials, you can use the menu on the left. Part 1 of this workshop is based on the online book [R for Data Science](https://r4ds.had.co.nz/index.html). Part 2is based on the [Tidymodels documentation](https://www.tidymodels.org/). Part 3 was adapted from [TAME](https://uncsrp.github.io/Data-Analysis-Training-Modules/machine-learning-and-predictive-modeling.html#machine-learning-and-predictive-modeling). Part 4 was created from scratch, but information and code examples were derived from [tensorflow for R documentation](https://tensorflow.rstudio.com/tutorials/quickstart/beginner)

## R and RStudio

During the course, we will use R in the Integrated Development Environment  **RStudio**, which you can download and install for your system using the links below:

Download R [here](https://cran.r-project.org/)
Download RStudio [here](https://posit.co/download/rstudio-desktop/)

## Resources and Bookdown
This website has been created using the `{bookdown}` R package

```{.r .Rchunk}
citation(package = "bookdown")
```

```{.Rout}
## 
## To cite package 'bookdown' in publications use:
## 
##   Xie Y (2023). _bookdown: Authoring Books and Technical Documents with
##   R Markdown_. R package version 0.33,
##   <https://github.com/rstudio/bookdown>.
## 
##   Xie Y (2016). _bookdown: Authoring Books and Technical Documents with
##   R Markdown_. Chapman and Hall/CRC, Boca Raton, Florida. ISBN
##   978-1138700109, <https://bookdown.org/yihui/bookdown>.
## 
## To see these entries in BibTeX format, use 'print(<citation>,
## bibtex=TRUE)', 'toBibtex(.)', or set
## 'options(citation.bibtex.max=999)'.
```
I you want to learn more on bookdown, see [this link](https://bookdown.org/)

## Learning objectives

After this course, you will be able to 

- use R to perform a structure-based Generalised Read Across
- explain the basics of machine learning and Deep learning in toxicology.
- Build a Neural Network and monitor its performance in R
- Build a classical Machine Learning model and evaluate its performance
- Run model-tuning to find optimal hyperparameters 

## Attribution

This work is distributed under a CC BY-NC 4.0 licence. Please cite this work as:

Corradi, M.; De Haan, A. & Teunis, M.A.T., 2022, "Workshop on 'Applications for artificial intelligence (AI) in risk assessment' (AiRA)", ASPIS Cluster Meeting, Sitges, Barcelona, https://github.com/ontox-hu/aira 

This reference can be viewed in R, when you have build the aira package or installed it from Github, by running:

```{.r .Rchunk}
citation(package = "aira")
```

```{.Rout}
## 
## To cite package 'aira' in publications use:
## 
##   Corradi M, De Haan A, Teunis M (0025). _aira: This R package, and
##   bookdown project, contains the materials for the training course
##   "Applications for artificial intelligence (AI) in risk assessment",
##   held at the ASPIS Cluster Meeting on Friday 25 November 2022 in
##   Sitges - Barcelona in Spain._. R package version 0.1.0.
## 
## A BibTeX entry for LaTeX users is
## 
##   @Manual{,
##     title = {aira: This R package, and bookdown project, contains the materials for the
## training course "Applications for artificial intelligence (AI) in risk
## assessment", held at the ASPIS Cluster Meeting on Friday 25 November 2022
## in Sitges - Barcelona in Spain.},
##     author = {Marie Corradi and Alyanne {De Haan} and Marc Teunis},
##     year = {0025},
##     note = {R package version 0.1.0},
##   }
```

and include the original source as:

Roell K, Koval LE, Boyles R, Patlewicz G, Ring C, Rider CV, Ward-Caviness C, Reif DM, Jaspers I, Fry RC, Rager JE. Development of the InTelligence And Machine LEarning (TAME) Toolkit for Introductory Data Science, Chemical-Biological Analyses, Predictive Modeling, and Database Mining for Environmental Health Research. Front Toxicol. 2022 Jun 22;4:893924. doi: 10.3389/ftox.2022.893924. PMID: 35812168; PMCID: PMC9257219.
https://doi.org/10.3389/ftox.2022.893924

Some materials were adapted from: [TAME](https://uncsrp.github.io/Data-Analysis-Training-Modules/machine-learning-and-predictive-modeling.html#machine-learning-and-predictive-modeling), and was reproduced and adapted with permission of the authors. See for the publications and [the complete Toolbox:](https://github.com/UNCSRP/Data-Analysis-Training-Modules). This toolbox is a good place to start for Introductory Data Science, Chemical-Biological Analyses, Predictive Modeling, and Database Mining for Environmental Health Research. 

Please also provide attribution to R itself

```{.r .Rchunk}
citation()
```

```{.Rout}
## 
## To cite R in publications use:
## 
##   R Core Team (2022). R: A language and environment for statistical
##   computing. R Foundation for Statistical Computing, Vienna, Austria.
##   URL https://www.R-project.org/.
## 
## A BibTeX entry for LaTeX users is
## 
##   @Manual{,
##     title = {R: A Language and Environment for Statistical Computing},
##     author = {{R Core Team}},
##     organization = {R Foundation for Statistical Computing},
##     address = {Vienna, Austria},
##     year = {2022},
##     url = {https://www.R-project.org/},
##   }
## 
## We have invested a lot of time and effort in creating R, please cite it
## when using it for data analysis. See also 'citation("pkgname")' for
## citing R packages.
```

The `{tidyvese}`

```{.r .Rchunk}
citation(package = "tidyverse")
```

```{.Rout}
## 
## To cite package 'tidyverse' in publications use:
## 
##   Wickham H, Averick M, Bryan J, Chang W, McGowan LD, François R,
##   Grolemund G, Hayes A, Henry L, Hester J, Kuhn M, Pedersen TL, Miller
##   E, Bache SM, Müller K, Ooms J, Robinson D, Seidel DP, Spinu V,
##   Takahashi K, Vaughan D, Wilke C, Woo K, Yutani H (2019). "Welcome to
##   the tidyverse." _Journal of Open Source Software_, *4*(43), 1686.
##   doi:10.21105/joss.01686 <https://doi.org/10.21105/joss.01686>.
## 
## A BibTeX entry for LaTeX users is
## 
##   @Article{,
##     title = {Welcome to the {tidyverse}},
##     author = {Hadley Wickham and Mara Averick and Jennifer Bryan and Winston Chang and Lucy D'Agostino McGowan and Romain François and Garrett Grolemund and Alex Hayes and Lionel Henry and Jim Hester and Max Kuhn and Thomas Lin Pedersen and Evan Miller and Stephan Milton Bache and Kirill Müller and Jeroen Ooms and David Robinson and Dana Paige Seidel and Vitalie Spinu and Kohske Takahashi and Davis Vaughan and Claus Wilke and Kara Woo and Hiroaki Yutani},
##     year = {2019},
##     journal = {Journal of Open Source Software},
##     volume = {4},
##     number = {43},
##     pages = {1686},
##     doi = {10.21105/joss.01686},
##   }
```

`{tidymodels}`

```{.r .Rchunk}
citation(package = "tidymodels")
```

```{.Rout}
## 
## To cite package 'tidymodels' in publications use:
## 
##   Kuhn et al., (2020). Tidymodels: a collection of packages for
##   modeling and machine learning using tidyverse principles.
##   https://www.tidymodels.org
## 
## A BibTeX entry for LaTeX users is
## 
##   @Manual{,
##     title = {Tidymodels: a collection of packages for modeling and machine learning using tidyverse principles.},
##     author = {Max Kuhn and Hadley Wickham},
##     url = {https://www.tidymodels.org},
##     year = {2020},
##   }
```

And `{rcdk}`

```{.r .Rchunk}
citation(package = "rcdk")
```

```{.Rout}
## 
## To cite rcdk in publications use:
## 
##   Guha, R. (2007). 'Chemical Informatics Functionality in R'. Journal
##   of Statistical Software 6(18)
## 
## A BibTeX entry for LaTeX users is
## 
##   @Article{,
##     author = {Rajarshi Guha},
##     journal = {Journal of Statistical Software},
##     number = {6},
##     title = {Chemical Informatics Functionality in R},
##     volume = {18},
##     year = {2007},
##   }
```
