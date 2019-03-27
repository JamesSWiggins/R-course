#
# This script reads the data 
# This assumes that the current working directory
# has all of the necessary files
#

# First, load all the data:
print('Loading data...')
dge_results <- read.table('differential_results.csv', 
                          sep=',', 
                          header=T, 
                          stringsAsFactors=F)

expressions = read.table('gene_expression.tsv', 
                         sep='\t',
                         header=T, 
                         stringsAsFactors=F)

annotations = read.table('gene_annotations.tsv', 
                         sep='\t', 
                         header=T,
                         stringsAsFactors=F)

column_names = c('gene_name','p_way')
pathways = read.table('my_pathway_genes.txt', 
                      sep='\t', 
                      col.names=column_names,
                      stringsAsFactors=F)

mutations = read.table('mutations.tsv',
                       sep='\t',
                       header=T,
                       stringsAsFactors=F)

print('Done loading data.')
