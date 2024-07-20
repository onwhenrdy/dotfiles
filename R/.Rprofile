options("width" = 800)
Sys.setenv(LANG = "en_US.UTF-8")

local({
  r <- getOption("repos")
  r["CRAN"] <- "https://cloud.r-project.org"
  options(repos = r)
})

# styiling
options(languageserver.formatting_style = function(options) {
  style <- styler::tidyverse_style(
    indent_by = 2L,
    strict = TRUE,
    start_comments_with_one_space = TRUE
  )
  style
})
options(styler.cache_root = "styler-perm")
