context("LP1 function")

L<- LP1(100,150,14,0.0126)

test_that("LP1 produces a numeric output", {

  expect_is(L, "numeric")

})
