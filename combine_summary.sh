#!/bin/bash

awk '(NR == 1) || (FNR > 1)' summarised_data_*.csv > all_summarised_data.csv


