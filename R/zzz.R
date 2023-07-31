.onLoad <- function(libname, pkgname) {
  get_schema <<- memoise::memoise(get_schema)
  get_schema_valid_versions <<- memoise::memoise(get_schema_valid_versions)
  read_config.default <<- memoise::memoise(read_config.default)
  read_config.SubTreeFileSystem <<- memoise::memoise(read_config.SubTreeFileSystem)
}
