library(reshape2)
library(tidyverse)
library(readxl)
#
# read in raw data table in 'melt' form and 
# convert the table into a matrix of percentage
# 

setwd('NTUST-Dec26-2018')
raw_dt=read.csv('data/IHME-GBD_2017_DATA/IHME_GBD_2017_DATA.csv')
location_code=read_xlsx('data/IHME-GBD_2017_DATA/IHME_GBD_2017_GBD_LOCATIONS_HIERARCHY.XLSX')
raw_location=merge(raw_dt, location_code, by='location_id')
raw_location=merge(raw_location, location_code,
                   by.x='parent_id',
                   by.y='location_id')


perc_dt=subset(raw_location, metric_id==2, select=c('measure_name', 
                                              'location_name.x',
                                              'location_name',
                                              'sex_name',
                                              'cause_name',
                                              'metric_name',
                                              'year',
                                              'val'))
colnames(perc_dt)[2]='country'
colnames(perc_dt)[3]='region'
colnames(perc_dt)[8]='perc'

matrix_dt=dcast(perc_dt, cause_name~country, value.var="perc")
rownames(matrix_dt)=matrix_dt[,1]
matrix_dt=t(matrix_dt[,-1])
regions=lapply(unique(perc_dt$region), function(X, region_data){
  unique(subset(region_data, region==X, country))
  }, region_data=perc_dt)
names(regions)=unique(perc_dt$region)
  

save(matrix_dt, perc_dt, raw_dt, location_code, regions, 
     file='data/IHME_GBD_2017_PreProcessed_DataSets.Rdata')

# load data

# load('data/data_set')
# head and tail

# perform PCA
pca=princomp(matrix_dt)  # compute PCA
png('results/pca.png', res=150)
plot(pca$scores[,1], pca$scores[,2],
     xlab='pc1', ylab='pc2')
points(pca$scores[regions$`South Asia`$country,1], 
     pca$score[regions$`South Asia`$country,2], 
     col="red", pch=18)
points(pca$scores[regions$`Western Europe`$country,1], 
       pca$score[regions$`Western Europe`$country,2], 
       col="green", pch=18)
points(pca$scores[regions$`Central Sub-Saharan Africa`$country,1], 
       pca$score[regions$`Central Sub-Saharan Africa`$country,2], 
       col="blue", pch=18)
dev.off()

png('results/hctree.png', width=1200, height=2400)
hctree=hclust(dist(matrix_dt, method='euclidean'))
par(mar=c(3,1,1,15)) 
plot(as.dendrogram(hctree), horiz=T)
dev.off()

# linear regression for location_name with death perc
cause_death_model=glm(perc~cause_name, data=perc_dt)
coeff_table=summary(cause_death_model)$coeff[-1,]
rownames(coeff_table)=gsub("cause_name", '', rownames(coeff_table))
sig_cause=coeff_table[coeff_table[,4]<0.05,]
sig_cause=sig_cause[order(sig_cause[,4]),]
top10_causes=sig_cause[1:10,]   # Most common top 10 causes in each country, not top10 for the world

# select out significant cause of death
top10_causes_dt=subset(perc_dt, cause_name %in% rownames(top10_causes), )

