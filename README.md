
<!-- README.md is generated from README.Rmd. Please edit that file -->

# labourR

<!-- badges: start -->

[![Travis build
status](https://travis-ci.org/AleKoure/labourR.svg?branch=master)](https://travis-ci.org/AleKoure/labourR)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/AleKoure/labourR?branch=master&svg=true)](https://ci.appveyor.com/project/AleKoure/labourR)
[![Codecov test
coverage](https://codecov.io/gh/AleKoure/labourR/branch/master/graph/badge.svg)](https://codecov.io/gh/AleKoure/labourR?branch=master)
<!-- badges: end -->

The goal of the labourR package is to map multilingual free-text of
occupations, such as a job title in a Curriculum Vitae, to existing
hierarchical ontologies like [ESCO](https://ec.europa.eu/esco/portal),
the multilingual classification of European Skills, Competences,
Qualifications and Occupations, and
[ISCO](https://ec.europa.eu/esco/portal/escopedia/International_Standard_Classification_of_Occupations__40_ISCO_41_),
the International Standard Classification of Occupations, and showcase
the importance of those classifications in understanding and analysing
the labour market.

## Installation

You can install the released version of labourR from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("labourR")
```

## Examples

``` r
library(labourR)
corpus <- data.frame(
  id = 1:3,
  text = c("Data Scientist", "Junior Architect Engineer", "Cashier at McDonald's")
)
```

  - If the ISCO level is not specified, the top num\_leaves, in this
    case 5, suggested ESCO occupations are returned for each id:

<!-- end list -->

``` r
classify_occupation(corpus = corpus, isco_level = NULL, lang = "en", num_leaves = 5)
#>     id                           conceptUri
#>  1:  1 258e46f9-0075-4a2e-adae-1ff0477e0f30
#>  2:  1 1562c7a3-c7d9-419d-b9b6-db26610bcf84
#>  3:  1 f470b785-643c-46f9-8b31-6085427ab7b8
#>  4:  1 7086d0ca-1e77-4690-89c9-7ed1a0478fa3
#>  5:  1 d3edb8f8-3a06-47a0-8fb9-9b212c006aa2
#>  6:  2 76abbb82-c103-4d7a-a4c0-14dba4d6199a
#>  7:  2 c8fa93eb-7c2c-42c3-b135-c2e825a6615e
#>  8:  2 e12f08fb-4748-4388-9489-b647df60332a
#>  9:  2 9dbbeb2c-0d51-4c03-8ef6-8dfa7360db22
#> 10:  2 2f26a52b-cf45-4282-9138-478252161f00
#> 11:  3 3f32394b-f1b1-48ef-96ee-74405fb7c6b6
#> 12:  3 961cbd1f-2a9b-4756-b227-67a1c23c94b6
#> 13:  3 2ff9e53c-6e7f-42af-8d71-b5dd7f283089
#> 14:  3 b7fc1cd1-0d6d-4e9e-8a9f-c3270201be81
#> 15:  3 2b871272-bd61-4206-bd1a-0b96d7023098
#>                          preferredLabel
#>  1:                      data scientist
#>  2:             data warehouse designer
#>  3: aeronautical information specialist
#>  4:             data quality specialist
#>  5:                        data analyst
#>  6:              commissioning engineer
#>  7:                       test engineer
#>  8:                 hydropower engineer
#>  9:             ship assistant engineer
#> 10:            food production engineer
#> 11:                     lottery cashier
#> 12:                      casino cashier
#> 13:                         bank teller
#> 14:            foreign exchange cashier
#> 15:                             cashier
```

  - Otherwise, if the ISCO level is specified, the top one suggested
    ISCO group is returned for each id:

<!-- end list -->

``` r
classify_occupation(corpus = corpus, isco_level = 3, lang = "en", num_leaves = 5)
#>    id iscoGroup                                          preferredLabel
#> 1:  1       251       Software and applications developers and analysts
#> 2:  2       214 Engineering professionals (excluding electrotechnology)
#> 3:  3       523                              Cashiers and ticket clerks
```

## Contributors

  - Alexandros Kouretsis - [Github](https://github.com/AleKoure)
  - Andreas Bampouris - [Github](https://github.com/andbamp)
  - Petros Morfiris - [Github](https://github.com/peterthunder)
  - Konstantinos Papageorgiou
