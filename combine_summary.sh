#!/bin/bash

awk '(NR == 1) || (FNR > 1)' summarised_data_*.csv > all_summarised_data.csv

awk '(NR == 1) || (FNR > 1)' regressions_*.csv > all_regressions_data.csv


