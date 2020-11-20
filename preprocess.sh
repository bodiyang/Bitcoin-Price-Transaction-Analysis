#!/bin/bash

# untar your R installation
tar -xzf R402.tar.gz
tar -xzf packages_FITSio_tidyverse.tar.gz


cat 0*.csv | sed 's/, /; /g' > all.csv


export PATH=$PWD/R/bin:$PATH
export RHOME=$PWD/R
export R_LIBS=$PWD/packages
export R_OUTPUT=$PWD/r_output





Rscript summarise.R


