context("Testing printer function")

test_that("I psrinetr Ok", {

  set.seed(1)
  x <- rnorm(10)[1]
  expect_equal(x, -0.6264538)

  y <- printer(x)
  expect_equal(class(y), "character")

  y <- hello(x)
  expect_equal(class(y), "character")

})

