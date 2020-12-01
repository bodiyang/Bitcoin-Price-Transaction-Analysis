#!/bin/bash

# untar your R installation
tar -xzf R402.tar.gz
tar -xzf packages_FITSio_tidyverse.tar.gz
tar -xzf packages_lubridate.tar.gz



export PATH=$PWD/R/bin:$PATH
export RHOME=$PWD/R
export R_LIBS=$PWD/packages
export R_OUTPUT=$PWD/r_output


Rscript postprocess.R

