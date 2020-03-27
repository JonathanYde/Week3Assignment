rm(list=ls()) #clears the Environment in R

##### redefines the 'require' function to either install a new package OR load an already installed package from the library #####
require <- function(x) {if (!base::require(x, character.only = TRUE)) {install.packages(x, dep = TRUE) ; base::require(x, character.only = TRUE)}}#overwrites 'require' function to install missing packages

