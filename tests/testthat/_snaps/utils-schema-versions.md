# version comparison utilities fail correctly

    Code
      version_lt("v2.0.0")
    Condition
      Error in `version_lt()`:
      x Exactly one of `config`, `config_path`, `hub_path` or `schema_version` must be provided.
      i None provided.

---

    Code
      version_lt("v2.0.0", config = NULL)
    Condition
      Error in `version_lt()`:
      x Exactly one of `config`, `config_path`, `hub_path` or `schema_version` must be provided.
      i None provided.

---

    Code
      version_lt("v2.0.0", hub_path = hub_path, config_path = config_path)
    Condition
      Error in `version_lt()`:
      x Exactly one of `config`, `config_path`, `hub_path` or `schema_version` must be provided.
      i Provided arguments: `config_path` and `hub_path`.

---

    Code
      version_lt("x2.0.0", config = config)
    Condition
      Error in `version_lt()`:
      x Invalid version number format. Must be in the format "v#.#.#."

