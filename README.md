# Isotopes-MammalLab

Mammal Lab collaboration to write an R package for isotope analysis

Collaborators: Gary and Ben

Some useful links
https://hilaryparker.com/2014/04/29/writing-an-r-package-from-scratch/

http://r-pkgs.had.co.nz/  # This is Hadley Wickham's guide for writing packages

Useful functions from devtools

devtools::create() # create a new package with the required folders

devtools::document() # generate documentation for the individual functions in the package

devtools::use_vignette() # create a vignette for the package if devtools < 2.1.0

usethat::use_vignette("introduction") # use "usethat" if devtools > 2.1.0





Use this to install the package once it has been committed to github

devtools::install_github("yourusername/myfirstpackage")


Other packages using Isotopes:

https://cran.r-project.org/web/packages/IsotopeR/index.html

Function names:
LP0 -> total length of the thing
LP1() -> length of the thing after you cut it (should include -1)
CheckNLoad() -> checking for a package and loading it
() -> time segment for whisker (i.e. seciton 3 will be winter)
() -> choosing this whisker length and this segment days to tell me which whiskers have this season (winter, for e.g.) in them
