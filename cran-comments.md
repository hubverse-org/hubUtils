## Resubmission

This is a resubmission. In this version I have set 17.0.0 as the minimum version of the 'arrow' dependency.

## R CMD check results

0 errors | 0 warnings | 1 notes


*   Possibly misspelled words in DESCRIPTION:
    al (16:37)
    et (16:34)
    
    False positive

Additional previous actions in response to automated and manual reviews

*   Removed the remote dependency on 'hubData'.

*   More details and DOI to relevant publication added to Description field.

*   Installation instructions updated in README.md.

*   Comments added to `zzz.R` to clarify use of `<<-` and `check_deprecated_schema.R` to clarify use of `.GlobalEnv` in `lifecycle::deprecate_warn()`.
