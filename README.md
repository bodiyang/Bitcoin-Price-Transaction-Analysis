# Statistic605-Project

## data sourse (sample data from large bitcoin history transaction data sourse):
raw data of Bitcoin transaction: 0-68732.csv

Cleaned data of Bitcoin transation: dat1.csv

Bitcoin daily price: Bitcoin Historical Data - Investing.com.csv

## Main code:
data cleaning: Analysis.R, Summerise.R
Regression model: Regression. R

HTC cluster computing
 Run "condor_submit_dag process.dag" to cause all the code specified in
 the following Directed Acyclic Graph (DAG), below, to run:
              
 (job 1)  preprocess.sub
 
            / | \
            
   22 parallel runs of preprocess.sh
   
            \ | /
              V
              
 (post 1) combine_summary.sh
 
              |
              
              V
              
 (job 2)  postprocess.sub
 
            / | \
   
   1 run of postprocess.sh


 Note that "job 1" and "job 2" are each HTCondor job submission
 scripts that will create several distributed jobs that run in
 parallel.
 
Run "condor_submit_dag sd.dag" to cause all the code specified in the DAG to run in the correct order.



Please refer to this file as the final report: STAT 605 First Draft.pdf
