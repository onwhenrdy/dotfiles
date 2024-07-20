options("width" = 800)
Sys.setenv(LANG = "en_US.UTF-8")

# Set CRAN mirror
local({
  r <- getOption("repos")
  r["CRAN"] <- "https://cloud.r-project.org"
  options(repos = r)
})

# styler settings
options(languageserver.formatting_style = function(options) {
  style <- styler::tidyverse_style(
    indent_by = 2L,
    strict = TRUE,
    start_comments_with_one_space = TRUE
  )
  style
})
options(styler.cache_root = "styler-perm")

# usethis settings
options(
  usethis.description = list(
    "Authors@R" = utils::person(
      "Dominik", "Selzer",
      email = "dominik.selzer@uni-saarland.de",
      role = c("aut", "cre"),
      comment = c(ORCID = "0000-0002-4126-0816")
    ),
    License = "MIT + file LICENSE"
  ),
  usethis.overwrite = TRUE
)

# do not ask for saving workspace
formals(q)$save <- formals(q)$save <- "no"

# promt
if (interactive()) {
  local({
    .p <- function(expr, value, ok, visible) {
      path <- getwd() |> basename()
      p <- paste0("../", path, " ") |> cli::col_grey()

      if (ok) {
        p |> paste0(cli::col_green(cli::symbol$pointer, " "))
      } else {
        p |> paste0(cli::col_red(cli::symbol$pointer, " "))
      }
    }

    prompt::set_prompt(.p)
  })
}
