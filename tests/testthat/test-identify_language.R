context("Testing identify language function")

test_that("Is language identify Ok", {

  txt <- "what lexical scoping really means"

  y <- identify_language(txt)
  expect_type(y, "character")

})
