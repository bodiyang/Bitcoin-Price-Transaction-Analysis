#!/bin/bash


#This file downloads the first csv of bitcoint data from: https://www.kaggle.com/shiheyingzhe/bitcoin-transaction-data-from-2009-to-2018
# The file assumes that you have the kaggle API setup and stored in ~/.local/bin/kaggle and the API credentials saved in ~/.kaggle/kaggle.json
#    -Instructions on setting up the kaggle API are available here: https://github.com/Kaggle/kaggle-api


# The file also assumes you have a directory ./data/ where the csv will be unzipped to


# If the code below is throwing an error, you might need to update the urllib3 package, which you can do with the following code: "pip install --user --upgrade urllib3"




#rm *.csv.zip

# Make Local directories for kaggle files
#mkdir ~/.local
#mkdir ~/.local/bin
#cp kaggle ~/.local/bin/
#mkdir ~/.kaggle
#cp kaggle.json ~/.kaggle/

#mkdir data

#~/.local/bin/kaggle datasets download -f $1 -d shiheyingzhe/bitcoin-transaction-data-from-2009-to-2018 --unzip
~/.local/bin/kaggle datasets download -d shiheyingzhe/bitcoin-transaction-data-from-2009-to-2018 



#unzip -n *.zip -d data/



#rm *68732.csv*



