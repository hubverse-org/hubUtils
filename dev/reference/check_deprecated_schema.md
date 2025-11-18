# Check whether a config file is using a deprecated schema

Function compares the current schema version in a config file to a valid
version, If config file version deprecated compared to valid version,
the function issues a lifecycle warning to prompt user to upgrade.

## Usage

``` r
check_deprecated_schema(
  config_version,
  config,
  valid_version = "v2.0.0",
  hubutils_version = "0.0.0.9010"
)
```

## Arguments

- config_version:

  Character string of the schema version.

- config:

  List representation of config file.

- valid_version:

  Character string of minimum valid schema version.

- hubutils_version:

  The version of the hubUtils package in which deprecation of the schema
  version below `valid_version` is introduced.

## Value

Invisibly, `TRUE` if the schema version is deprecated, `FALSE`
otherwise. Primarily used for the side effect of issuing a lifecycle
warning.
