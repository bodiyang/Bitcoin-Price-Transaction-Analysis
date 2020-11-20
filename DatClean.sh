#!/bin/bash

head 0-68732.csv | tr -d '[]' | sed 's/['\'']/''/g' | sed 's/\([^\"]*\)\([^,]*\),\([^,]*\)/\1\2;\3/g' > cleandat1.csv

