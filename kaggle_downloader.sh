#!/bin/bash


#This file downloads the first csv of bitcoint data from: https://www.kaggle.com/shiheyingzhe/bitcoin-transaction-data-from-2009-to-2018
# The file assumes that you have the kaggle API setup and stored in ~/.local/bin/kaggle and the API credentials saved in ~/.kaggle/kaggle.json
#    -Instructions on setting up the kaggle API are available here: https://github.com/Kaggle/kaggle-api


# The file also assumes you have a directory ./data/ where the csv will be unzipped to






~/.local/bin/kaggle datasets download -f 0-68732.csv -d shiheyingzhe/bitcoin-transaction-data-from-2009-to-2018 --unzip


unzip *.zip -d data/



rm *68732.csv*



