rm(list = ls())
library(vegan)
#library(picante)
otu <- read.delim('zotutab.txt', row.names = 1, sep = '\t', stringsAsFactors = FALSE,check.names = FALSE)
head(otu)
otu <- t(otu)
head(otu)

col <- c(rep('#FDDED7', length = 9), rep('#F5BE8F', length = 9), rep('#C1E0DB', length = 9), 
         rep('#CCD376', length=9), rep('#A28CC2', length=9), rep('#F59B7B', length=9), 
         rep('#ED8828', length=9), rep('#A4DDD3', length=9), rep('#81B21F', length=9),
         rep('#9FDAF7', length=9), rep('#33ABCC', length=9), rep('#D9DEE7', length=9))

raremax <- min(rowSums(otu))   #最大抽平数
raremax
rarecurve(otu, step = 200, sample = 20000, ylab = 'Observed OTU richness', xlab = 'Number of sequences',
          label = F, col = col, lwd = 1.5)







