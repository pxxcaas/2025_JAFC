library(dplyr)
library(tidyr)


Class_count <- read.delim("Class_counts.txt", header = TRUE)
head(Class_count)


Class_count <- Class_count %>%
  filter(!Class %in% c("Unassigned", "uncultured", "uncultured_bacterium"))
head(Class_count)
row.names(Class_count) <- Class_count$Class

Class_count <- subset(Class_count, select = -Class)

Class_count$sum <- rowSums(Class_count)
head(Class_count)

otu_table_sorted <- Class_count[order(-Class_count$sum), ]
head(otu_table_sorted)


otu_table_sorted_top20 <-  otu_table_sorted[1:10,] 
head(otu_table_sorted_top20)

otu_table_sorted_top20 <-  subset(otu_table_sorted_top20, select = -sum)


Class_count_RA_top20 <- apply(otu_table_sorted_top20, 2, function(x) x/sum(x)) 
head(Class_count_RA_top20)

sum <-  apply(Class_count_RA_top20, 2, sum)
head(sum)
Others <-  1-sum
head(Others)

Class_count_RA_top20 <-  rbind(Class_count_RA_top20, Others) #添加Others列
head(Class_count_RA_top20)

write.csv(Class_count_RA_top20, "Class_count_RA_top10.csv", quote = F)

rm(list = ls())
library("reshape2", quietly=T, warn.conflicts=F)
library(ggalluvial)
library(ggsci)
otu_table <- read.csv("Class_count_RA_top10.csv")  
group_info <- read.table("group.txt", header = TRUE, sep = "\t")

sample_to_group <- setNames(group_info$group, group_info$Sample)

otu_table_sample_data <- otu_table[, -1] 

colnames(otu_table_sample_data) <- sample_to_group[colnames(otu_table_sample_data)]

otu_table_with_group <- cbind(otu_table[, 1, drop = FALSE], otu_table_sample_data)

otu_table_long <- melt(otu_table_with_group, id.vars = "Class", variable.name = "Group", value.name = "Abundance")

taxcol <- c("#64A4CC", "#9CCEE3", "#C7E5DB", "#ECF6C8", "#FEEDAA", "#FDC980",
            "#F89D59", "#E75B3A", "#D7191C", "#FDDED7", "#F5BE8F", "#C1E0DB",
            "#CCD376", "#A28CC2", "#8498AB", "#5CB0C3", "#F59B7B", "#ED8828",
            "#A4DDD3", "#81B21F", "#8D73BA")

p1e <- ggplot(data = otu_table_long, aes(x = Group, y = Abundance, alluvium = Class)) +
  geom_alluvium(aes(fill = Class), alpha = 1) +
  scale_fill_manual(values = taxcol) +
  labs(x = "Group", y = "Relative Abundance") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

p1e

ggsave("Class_site.pdf", p1e, width = 8, height = 6)