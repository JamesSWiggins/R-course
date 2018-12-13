

library(reshape2)
library(tidyverse)

setwd('NTUST-Dec26-2018')
load('data/IHME_GBD_2017_PreProcessed_DataSets.Rdata')

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

# define clusters
clust_groups=cutree(hctree, k=5)
table(clust_groups)
clust_groups[cluster_groups==5]


# linear regression for location_name with death perc
cause_death_model=glm(perc~cause_name, data=perc_dt)
coeff_table=summary(cause_death_model)$coeff[-1,]
rownames(coeff_table)=gsub("cause_name", '', rownames(coeff_table))
sig_cause=coeff_table[coeff_table[,4]<0.05,]
sig_cause=sig_cause[order(sig_cause[,4]),]
top10_causes=sig_cause[1:10,]   # Most common top 10 causes in each country, not top10 for the world

# select out significant cause of death
top10_causes_dt=subset(perc_dt, cause_name %in% rownames(top10_causes))

# 
# a=aggregate(top10_causes_dt, 
#             by=list(regions, perc), FUN=mean)
# ggplot(top10_causes_dt, aes(cause_name, country)) +
#   geom_tile(aes(fill = perc), colour = "white") +
#   scale_fill_gradient(low = "white", high="steelblue")
# 
# 
# p <- ggplot(nba.m, aes(variable, Name)) + 
#   geom_tile(aes(fill = perc),
#             +     colour = "white") + 
#   scale_fill_gradient(low = "white",
#                       +     high = "steelblue"))                                                                           +     high = "steelblue"))
# 
# # select Far East Asian Country
# 
# # plot heatmap
# 

save(cause_death_model, 
     sig_cause, 'significant_cause_of_death.Rdata')
