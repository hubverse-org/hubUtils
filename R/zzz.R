.onLoad <- function(libname, pkgname) {
  read_config.default <<- memoise::memoise(read_config.default)
  read_config.SubTreeFileSystem <<- memoise::memoise(read_config.SubTreeFileSystem)
  get_schema <<- memoise::memoise(get_schema)
  get_schema_valid_versions <<- memoise::memoise(get_schema_valid_versions)
}

ignore_unused_imports <- function() {
  # getting a note that R CMD check cannot detect unused imports
  # Zhian suspects this is due to the memoi[sz]ation above and is using
  # the Hadley hack: 
  #  <https://github.com/hadley/r-pkgs/issues/828#issuecomment-1210558705>
  fs::path
  gh::gh
  curl::curl_echo
}
