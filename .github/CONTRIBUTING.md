# Contributing to hubUtils

This outlines how to propose a change to `hubUtils`.
For more general info about contributing to this, and other hubverse packages, please see the
[**hubverse contributing guide**](https://hubverse.io/en/latest/overview/contribute.html).

You can fix typos, spelling mistakes, or grammatical errors in the documentation directly using the GitHub web interface, as long as the changes are made in the *source* file.
This generally means you'll need to edit [roxygen2 comments](https://roxygen2.r-lib.org/articles/roxygen2.html) in an `.R`, not a `.Rd` file.
You can find the `.R` file that generates the `.Rd` by reading the comment in the first line.

## Bigger changes

If you want to make a bigger change, it's a good idea to first file an issue and make sure someone from the team agrees that it's needed.
If you've found a bug, please file an issue that illustrates the bug with a minimal
[reprex](https://www.tidyverse.org/help/#reprex) (this will also help you write a unit test, if needed).

Our procedures for contributing bigger changes, code in particular, generally follow those advised by the tidyverse dev team, including following the tidyverse style guide for code and recording user facing changes in `NEWS.md`.

### Pull request process

- Fork the package and clone onto your computer. If you haven't done this before, we recommend using `usethis::create_from_github("hubverse-org/hubUtils", fork = TRUE)`.

- Install all development dependencies with `devtools::install_dev_deps()`, and then make sure the package passes R CMD check by running `devtools::check()`.
  If R CMD check doesn't pass cleanly, it's a good idea to ask for help before continuing.

- Follow [the pull request checklist](https://hubverse-org.github.io/hubDevs/articles/release-checklists.html#subsequent-pr-checklist) to create a Git branch for your pull request (PR). We recommend using `usethis::pr_init("name/brief-description/issue")`.

- Make your changes, commit to git, and then create a PR by running `usethis::pr_push()`, and following the prompts in your browser.
  The title of your PR should briefly describe the change.
  The body of your PR should contain `Fixes #issue-number`.

- For user-facing changes, add a bullet to the top of `NEWS.md` (i.e. just below the first heading---usually labelled "development version"). Follow the style described in <https://style.tidyverse.org/news.html>.

### Code style

- New code should follow the tidyverse [style guide](https://style.tidyverse.org).
  You can use the [styler](https://CRAN.R-project.org/package=styler) package to apply these styles, but please don't restyle code that has nothing to do with your PR.

- We use [roxygen2](https://cran.r-project.org/package=roxygen2), with [Markdown syntax](https://cran.r-project.org/web/packages/roxygen2/vignettes/rd-formatting.html), for documentation.

- We use [testthat](https://cran.r-project.org/package=testthat) for unit tests.
  Contributions with test cases included are easier to accept.

## Working with a development version of `hubverse-org/schemas`

The canonical home for the hubverse schemas are at
https://github.com/hubverse-org/schemas. These schemas are copied over here
under the `inst/schemas` folder, which allows offline validation for hubs.

**If you are developing against an in-development version of the hubverse
schemas, you must ensure that the schemas in this repository are synchronized**

### Synchronization script

The script that synchronizes the schemas is in
[data-raw/schemas.R](https://github.com/hubverse-org/hubUtils/blob/main/data-raw/schemas.R)
and it can be run from within R, as a standalone script, or as a git hook. It
takes one environment variable `HUBUTILS_DEV_BRANCH`. If the environment
variable is unset, the branch information from the `inst/schemas/update.json`
is used.

#### Usage: within R

```r
source("data-raw/schemas.R")
```

#### Usage: from BASH

```bash
Rscript data-raw/schemas.R
```

#### Usage: commit hook

See [Installing the Git Hook](#installing-the-git-hook). A Git hook is a way to
run a local script before or after you do something in Git. For example, a
pre-push hook (the one we use here) will run every time before you make a
commit. Likewise, a pre-push hook will run every time before you push to a
repository.

#### Details

By default, this script will make a single call to the GitHub API to determine
the status of the most recent commit on the branch listed in
`inst/schemas/update.json`. If the sha and branch match and the timestamp is
ahead of the the most recent commit, then you are good to go!

If an update is needed, then your system git is used to clone the branch and
copy it over to `inst/schemas`.

When running this as a script (not interactive), then when a schema update
happens, the tests are re-run.




### Synchronizing a development branch

In order to synchronize a development branch, you should set a temporary
environment variable called `HUBUTILS_DEV_BRANCH` to the name of the branch.
This can only be done interactively in R or as a BASH script.

#### Via R

```r
Sys.setenv("HUBUTILS_DEV_BRANCH" = "br-v4.0.1")
source("data-raw/schemas.R")
#> ✔ removing /path/to/hubUtils/inst/schemas
#> ✔ Creating inst/schemas/.
#> ℹ Fetching the latest version of the schemas from GitHub
#> Cloning into '/path/to/temp/folder'...
#> ✔ Copying v4.0.1, v4.0.0, v3.0.1, v3.0.0, v2.0.1, v2.0.0, v1.0.0, v0.0.1, v0.0.0.9,
#>  and NEWS.md to inst/schemas
#> [ ... snip ... ]
#> ✔ Done
#> ✔ Schemas up-to-date!
#> ℹ branch: "br-v4.0.1"
#> ℹ sha: "43b2c8aceb3a316b7a1929dbe8d8ead2711d4e84"
#> ℹ timestamp: "2024-12-19T16:40:16Z"
Sys.unsetenv("HUBUTILS_DEV_BRANCH")
```

#### Via BASH

When run via script (both manually and via git hook), if any synchronization
happens, tests are automatically run:

```bash
HUBUTILS_DEV_BRANCH=br-v4.0.1 Rscript data-raw/schemas.R \
&& unsetenv HUBUTILS_DEV_BRANCH
#> ✔ removing /path/to/hubUtils/inst/schemas
#> ✔ Creating inst/schemas/.
#> ℹ Fetching the latest version of the schemas from GitHub
#> Cloning into '/path/to/temp/folder'...
#> ✔ Copying v4.0.1, v4.0.0, v3.0.1, v3.0.0, v2.0.1, v2.0.0, v1.0.0, v0.0.1, v0.0.0.9,
#>  and NEWS.md to inst/schemas
#> [ ... snip ... ]
#> ✔ Done
#> ✔ Schemas up-to-date!
#> ℹ branch: "br-v4.0.1"
#> ℹ sha: "43b2c8aceb3a316b7a1929dbe8d8ead2711d4e84"
#> ℹ timestamp: "2024-12-19T16:40:16Z"
#>
#> ── ⚠ schema updated ──
#>
#> ! Re-running tests.
#> ℹ Testing hubUtils
#> ✔ | F W  S  OK | Context
#> ✔ |          7 | as_config
#> ✔ |          9 | as_model_out_tbl
#> ✔ |          5 | check_deprecated_schema
#> ✔ |         17 | model_id_merge
#> ✔ |          7 | read_config [6.4s]
#> ✔ |          7 | utils-get_hub
#> ✔ |         16 | utils-model_out_tbl
#> ✔ |         14 | utils-round_ids
#> ✔ |          8 | utils-round-config
#> ✔ |         39 | utils-schema-versions
#> ✔ |         14 | utils-schema [1.2s]
#> ✔ |          3 | utils-task_ids
#> ✔ |          7 | v3-schema-utils
#>
#> ══ Results ════════════════════════════
#> Duration: 9.0 s
#>
#> [ FAIL 0 | WARN 0 | SKIP 0 | PASS 153 ]
#> ✔ OK
```

### Installing the Git Hook

It is optional, but recommended to use this script as a pre-push hook so that
the schemas are checked for updates before each commit.

```r
usethis::use_git_hook("pre-push", readLines(usethis::proj_path("data-raw/schemas.R")))
```

This will create or overwrite `.git/hooks/pre-push`.

**If you want to uninstall the git hook, remove the `.git/hooks/pre-push`
file**

In addition to checking that the schemas in `inst/schemas` are synchronized, [as
demonstrated above](#via-bash), this hook will also check:

 1. the local hook is up-to-date
 2. the `inst/schemas` folder contents are all committed


When you install this as a git hook, you will get a message before every
successful push:

```
$ git push
#> ✔ Setting active project to "/path/to/hubUtils".
#> ✔ Schemas up-to-date!
#> ℹ branch: "main"
#> ℹ sha: "0163a89cc38ba3846cd829545f6d65c1e40501a6"
#> ℹ timestamp: "2024-12-19T16:56:13Z"
#> 
#> ── pre-push: checking for changes in inst/schemas ──
#> 
#> ✔ OK
```

#### When the schema updates

If the schemas are updated but not committed, this hook will prevent you from
pushing the changes until they are updated:

```
$ git push 
#> [ ... snip ... ]
#>
#> ── ⚠ schema updated ──
#>
#> [ ... snip ... ]
#> ✔ OK
#>
#> ── pre-push: checking for changes in inst/schemas ──
#> 
#> Error in `check_status()`:
#> ! New schemas must be committed before pushing.
#> Backtrace:
#>     ▆
#>  1. └─global check_status(usethis::proj_path())
#>  2.   └─cli::cli_abort(c("New schemas must be committed before pushing."))
#>  3.     └─rlang::abort(...)
#> Execution halted
#> error: failed to push some refs to 'https://github.com/hubverse-org/hubUtils.git'
```

#### When the script changes

If the git hook script changes, you will be given instructions to update:

```
$ git push
#> ✔ Setting active project to "/path/to/hubUtils".
Error in `check_hook()`:
! git hook outdated
ℹ Use `usethis::use_git_hook("pre-push", readLines(usethis::proj_path("data-raw/schemas.R")))`
  to update your hook.
Backtrace:
    ▆
 1. └─global check_hook(usethis::proj_path())
 2.   └─cli::cli_abort(c("git hook outdated", i = "Use {.code {cmd}} to update your hook."))
 3.     └─rlang::abort(...)
Execution halted
error: failed to push some refs to 'https://github.com/hubverse-org/hubUtils.git'
```

## Code of Conduct

Please note that the hubUtils project is released with a
[Contributor Code of Conduct](https://hubverse-org.github.io/hubUtils/CODE_OF_CONDUCT.html).
By contributing to this project you agree to abide by its terms.


