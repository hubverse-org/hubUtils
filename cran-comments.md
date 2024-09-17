## R CMD check results

0 errors | 0 warnings | 3 notes

*   New Submission

    This is a new release.

*   Possibly misspelled words in DESCRIPTION:
    al (16:37)
    et (16:34)
    
    False positive

*   Suggests or Enhances not in mainstream repositories:
    hubData
  Availability using Additional_repositories specification:
    hubData   yes   https://hubverse-org.r-universe.dev/
    
    This is a core 'hubverse' package and an Import to 'hubData'. Once 'hubUtils' is 
    on CRAN, 'hubData' will be submitted to CRAN also and the use if Remotes removed.

Additional actions in response to manual review

*   More details and DOI to relevant publication added to Description field.

*   Installation instructions updated in README.md.

*   Comments added to `zzz.R` to clarify use of `<<-` 
