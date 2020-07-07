context("Testing identify language function")

test_that("Is language identify Ok", {

  txt <- "what lexical scoping really means"

  y <- identify_language(txt, "cld2")
  expect_type(y, "character")

  y <- identify_language(txt, "cld3")
  expect_type(y, "character")

  y <- identify_language(txt, "both")
  expect_type(y, "character")

  expect_error(identify_language(txt, "foo"))

})
