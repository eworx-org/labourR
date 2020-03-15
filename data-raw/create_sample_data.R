library(tibble)
library(data.table)

set.seed(1000)
tib_iris <- as_tibble(iris)

ss <- data.table::fread(file = "inst/extdata/tib_iris.csv")
setnames(ss, names(tib_iris))

tib_iris <- rbind(data.table(tib_iris) ,ss)

usethis::use_data(tib_iris, compress = "xz")
