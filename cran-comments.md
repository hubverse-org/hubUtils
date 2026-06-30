## R CMD check results

0 errors | 0 warnings | 0 notes

Tested on:
- Local: macOS Sequoia 15.7.2, R 4.5.1
- GitHub Actions: macOS, Windows, Ubuntu (R-devel, release, oldrel-1)
- win-builder: R-devel

## Release summary

This is a patch release that substantially improves the performance of
`convert_output_type()` by computing conversions per group of model/task ID
combinations without first materialising a large intermediate table, reducing
both runtime and memory allocation for large sample tables (#282).

## Reverse dependencies

We checked 1 reverse dependency (hubEnsembles), comparing R CMD check results
across CRAN and dev versions of this package.

- We saw 0 new problems
- We failed to check 0 packages
