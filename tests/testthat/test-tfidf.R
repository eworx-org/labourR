context("Testing tf_idf function")

test_that("Is tf_idf Ok", {

  library(data.table)
  corpus <- occupations_bundle[language == "en"][ , .(conceptUri, text)]
  setnames(corpus, c("id", "text"))

  y <- tf_idf(corpus, tf_weight = "raw_count")
  expect_equal(class(y), c("data.table", "data.frame"))

  y <- tf_idf(corpus, tf_weight = "double_norm")
  expect_equal(class(y), c("data.table", "data.frame"))

  y <- tf_idf(corpus, tf_weight = "log_norm")
  expect_equal(class(y), c("data.table", "data.frame"))

  y <- tf_idf(corpus, idf_weight = "idf")
  expect_equal(class(y), c("data.table", "data.frame"))

  y <- tf_idf(corpus, idf_weight = "idf_smooth")
  expect_equal(class(y), c("data.table", "data.frame"))

})

