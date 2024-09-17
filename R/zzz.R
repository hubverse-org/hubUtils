# We use `<<-` below to modify the package's namespace.
# It doesn't modify the global environment.
# We do this to prevent build time dependencies on {memoise},
# as recommended in <http://memoise.r-lib.org/reference/memoise.html#details>.
# Cf. <https://github.com/r-lib/memoise/issues/76> for further details.
.onLoad <- function(libname, pkgname) {
  read_config.default <<- memoise::memoise(read_config.default)
  read_config.SubTreeFileSystem <<- memoise::memoise(read_config.SubTreeFileSystem)
  get_schema <<- memoise::memoise(get_schema)
  get_schema_valid_versions <<- memoise::memoise(get_schema_valid_versions)
}
