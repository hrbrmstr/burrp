context("basic functionality")
test_that("we can do something", {

  system.file("extdata", "hottest_year.xml", package="burrp") %>%
    read_burp() -> burp_df

  expect_that(burp_df, is_a("data.frame"))

})
