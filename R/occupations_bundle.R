#' @title ESCO occupations bundle
#'
#' @description The occupations pillar is one of the three pillars of \href{https://ec.europa.eu/esco/portal/home}{ESCO}. It organises
#' the occupation concepts. It uses hierarchical relationships between them, metadata as well as mappings to the International Standard
#' Classification of Occupations \href{https://ec.europa.eu/esco/portal/escopedia/Occupation}{ISCO} in order to structure the occupations.
#' The descriptions of each concept is provided only in english. Since the purpose of this package is multilingual analysysis of free text
#' labour data it will be discarded for "symmetry" of information among the given languages.
#'
#' * The ESCO version used is ESCO v1 1.0.3 retrieved at 11/12/2019.
#'
#' @format A data.table with 4 elements, which are:
#' \describe{
#' \item{language}{Languages covered by the classification.}
#' \item{conceptUri}{Uniform Resource Identifier of occupations.}
#' \item{iscoGroup}{Four-level classification of occupation groups, see \href{https://ec.europa.eu/esco/portal/escopedia/International_Standard_Classification_of_Occupations__40_ISCO_41_}{ISCO}.}
#' \item{text}{Free text of preffered name and alternative names of ESCO occupation concepts.}
#' }
"occupations_bundle"
