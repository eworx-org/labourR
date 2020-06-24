context("Testing utilities functions")

test_that("Is get_language_code Ok", {

  txt <- "occupations_en.csv"

  y <- get_language_code(txt)
  expect_equal(class(y), "character")

})

