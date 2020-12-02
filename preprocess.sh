#!/bin/bash

# untar your R installation
tar -xzf R402.tar.gz
tar -xzf packages_FITSio_tidyverse.tar.gz
tar -xzf packages_lubridate.tar.gz

#Unzip the necessary csv file from the zip file
#unzip bitcoin-transaction-data-from-2009-to-2018.zip $1
cp /staging/groups/stat605_hsbfs/$1 ./

cat *-*.csv | sed 's/, /; /g' > all.csv


export PATH=$PWD/R/bin:$PATH
export RHOME=$PWD/R
export R_LIBS=$PWD/packages
export R_OUTPUT=$PWD/r_output


#echo "job succesfule" > job$1.txt

Rscript summarise.R $1

rm *-*.csv
#rm *.zip
rm all.csv

