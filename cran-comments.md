## Resubmission

This is a resubmission to resolve `Error: Vignette re-building failed`. In this version I have:

* Added rmarkdown package in the Suggests section of Description.

## Test environments

* Ubuntu 18.04.4 LTS (local), R 3.4.4
* Ubuntu 16.04.6 LTS (on travis-ci), R 3.6.1, 3.6.3, 4.0.0, R-devel
* macOS High Sierra 10.13.6 (on travis-ci), R 3.6.1, 3.6.3, 4.0.2
* win-builder (devel and release)
* Windows Server x64 (on AppVeyor) R 4.0.2

## R CMD check results

```
checking CRAN incoming feasibility ... NOTE
Maintainer: ‘Alexandros Kouretsis <ako@eworx.gr>’
  
New submission
```

0 errors | 0 warnings | 1 note

* This is a new release.

## Alert: isolate r-hub error

- data.table is not available for windows-x86_64-devel. Compilation is needed: 

rhub::check(
  platform="windows-x86_64-devel",
  env_vars=c(R_COMPILE_AND_INSTALL_PACKAGES = "always")
)

- Error for lack of system dependencies on r-hub only for

Ubuntu Linux 16.04 LTS, R 3.6.1, GCC


