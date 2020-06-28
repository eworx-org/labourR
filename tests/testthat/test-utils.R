context("Testing utilities functions")

test_that("Is get_language_code Ok", {

  txt <- "occupations_en.csv"

  y <- get_language_code(txt)
  expect_type(y, "character")

})


test_that("Is stopwords Ok", {
  expect_type(get_stopwords("el"), "character")
  expect_type(get_stopwords("en"), "character")
  expect_type(get_stopwords("ir"), "character")
  expect_warning(get_stopwords("xxx"), regexp = "no stopwords retrieved")
})


