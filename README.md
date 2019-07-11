# Introduction to RStudio on AWS

This repository provides simple introdcution to R

[![cloudformation-launch-stack](images/launchstack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=RStudio&templateURL=https://s3.amazonaws.com/ohdsi-rstudio/others/rstudio-sslv4.yaml)

### Instructions
1. Launch the AWS CloudFormation in your AWS account using the **Launch Stack** button above.  
    a. For the VPCId parameter, use your Default VPC (172.31.0.0/16)
    b. For the VPCSubnet parameter, choose a subnet within the Default VPC (172.31.0.0/20)
2. Once the stack says **CREATE_COMPLETE**, it takes about 5 additional minutes for the RStudio Server to become availabile.
3. After 5 minutes, follow the link in the **Outputs** tab of your AWS CloudForamtion Stack to access RStudio.
4. Accept the warning from your browser about the certificate being self-signed.  This gives us encrypted, HTTPS access to RStudio without purchasing a domain name or SSL certificate.
5. Login to RStudio using the credentials you provided to the AWS CloudFormation template, and **click the Terminal tab**.
6. Run the command **git clone https://github.com/JamesSWiggins/R-course**
7. Open the file **R-course/Basic Data Analysis/cluster_code.R**
8. Run each line of the R program
9. Open the **results** directory and view the images output by the analysis we just ran.  A description of the analysis and dataset is below.

## Basic Data Analysis

This section performs clustering analysis on a simple cause of death data set to identify top10 cause of death by country and summarize by region.  

1. Data Set: IHME_GBD_2017_PreProcessed_DataSets.Rdata
    - Downloaded from global data exchange (<http://ghdx.healthdata.org/>)
    - Contain all cause of death from 195 countries for 2017
    - Data is represented by the percentage of cause of death by country
    - Raw data is stored in data/IHME-GBD/
    - Raw data was processed by data_preprocessing.R 
    - Processed data was stored as IHME_GBD_2017_PreProcessed_DataSets.Rdata object

2. Script: cluster_code.R
    - The script loads reshape2, tidyverse libraries and Data Set .Rdata object
    - Create a 'results' subdirectory if it does exists
    - Performs PCA, store image in results
    - Perform Hierarchical Clustering, store image in results
    - Perform simple general linear model to select top 10 death causes
    - Summarize the top10 causes by geographical regions and generate a heatmap
    - Save the heatmap






Downloaded from GHDx
2017 all cause of death data from all countries
195 countries and 133 causes of death
Percentage of Cause of Death by country
