context("Testing cleansing corpus function")

test_that("Is cleansing_corpus Ok", {

  txt <- "It has roots in a piece of classical Latin literature from 45 BC"

  y <- cleansing_corpus(txt)
  expect_equal(class(y), "character")

  expect_error(cleansing_corpus(100))

})
