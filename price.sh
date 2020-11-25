#!/bin/bash


#This file downloads the csv of bitcoin daily price data from: https://www.kaggle.com/fengxiad/bitcoin-historical-data

# The file assumes that you have the kaggle API setup and stored in ~/.local/bin/kaggle and the API credentials saved in ~/.kaggle/kaggle.json


# The file also assumes you have a directory ./data/ where the csv will be saved to



~/.local/bin/kaggle datasets download -f  Bitcoin_Historical_Data.csv -d fengxiad/bitcoin-historical-data --unzip

unzip Bit*.zip -d data/






