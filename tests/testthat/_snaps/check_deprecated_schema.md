# check check_deprecated_schema using config_version works

    Code
      check_deprecated_schema(config_version = "v1.0.0")
    Condition
      Warning:
      Hub configured using schema version v1.0.0. Support for schema earlier than v2.0.0 was deprecated in hubUtils 0.0.0.9010.
      i Please upgrade Hub config files to conform to, at minimum, version v2.0.0 as soon as possible.

# check check_deprecated_schema fails correctly

    Code
      check_deprecated_schema(config)
    Condition
      Error in `check_deprecated_schema()`:
      ! Assertion on 'config_version' failed: Must be of type 'string', not 'list'.

---

    Code
      check_deprecated_schema(c("v1.0.0", "v2.0.0"))
    Condition
      Error in `check_deprecated_schema()`:
      ! Assertion on 'config_version' failed: Must have length 1.

