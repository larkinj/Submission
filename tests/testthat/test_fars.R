context("Testing Make Filename Function")

filename <- make_filename(2013)
test_that("The function to create a filename works",{
  expect_that(filename, is_a("character"))
})

