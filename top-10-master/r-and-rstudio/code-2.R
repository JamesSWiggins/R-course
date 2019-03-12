#
# How to read in a bunch of csv files with some defined
# filename
#

for(i in 1:25){
  dat <- read.csv(paste0("data/data-",i,".csv"))
  print(i)
  print(t.test(measurement ~ type, data = dat))
}

# cannot scroll through the console for all results if 
# printed out

# use sapply and save the results in a vector
#
# sapply apply a function overa list and return a vector 
#

# t.test returns a object that contain a variable called
# p.value.  value can be extracted from object by
# object$p.value
dat <- read.csv("data/example-data.csv")
t.rlt=t.test(measurement ~ type, data = dat)


results <- sapply(1:25, function(i){
  dat <- read.csv(paste0("data/data-",i,".csv"))
  t.test(measurement ~ type, data = dat)$p.value 
})




print(results)
# save into an R data file
save(results, t.rlt, "demo-result.Rdata")

# let's close the session and load the data again...
# load('demo-result.Rdata')
