context("Testing occupations classify function")

test_that("Is occupations classification Ok", {

  corpus <- letters
  expect_error(
    classify_occupation(
      corpus = corpus
    )
  )

  corpus <- data.table(
    id = 1:4,
    text = c("Data Scientist", "Junior Architect Engineer", "Cashier at McDonald's", "Priest at St. Martin Catholic Church")
  )
  y <- classify_occupation(
    corpus = corpus,
    isco_level = NULL,
    lang = "en",
    num_leaves = 5
  )

  expect_named(y, expected = c("id", "conceptUri", "preferredLabel"))

  y <- classify_occupation(
    corpus = corpus,
    isco_level = 3,
    lang = "en",
    num_leaves = 5
  )

  expect_named(y, expected = c("id", "iscoGroup", "preferredLabel"))

  y <- classify_occupation(
    corpus = corpus,
    string_dist = "osa"
  )

  expect_s3_class(y, "data.frame")

  expect_error(
    classify_occupation(
      corpus = corpus,
      id_col = "ID"
    )
  )

  expect_error(
    classify_occupation(
      corpus = corpus,
      isco_level = 6
    )
  )

  expect_error(
    classify_occupation(
      corpus = corpus,
      lang = "jp"
    )
  )

})
