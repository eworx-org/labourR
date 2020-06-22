context("Testing identify language function")

test_that("Is language identify Ok", {

  txt <- "what lexical scoping really means?"

  y <- identify_language(txt, "cld2")
  expect_equal(class(y), "character")

  y <- identify_language(txt, "cld3")
  expect_equal(class(y), "character")

  y <- identify_language(txt, "both")
  expect_equal(class(y), "character")

  y <- identify_language(txt, "foo")
  expect_equal(class(y)[1], "error")

})

