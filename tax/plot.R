
rm(list = ls())
library(dplyr)
library(tidyr)


genus_data <- read.csv("Class_count_RA_top10.csv", row.names = 1)
group_data <- read.table("group.txt", header = TRUE, sep = "\t")
head(genus_data)
head(group_data)

genus_data_t <- as.data.frame(t(genus_data))

merged_data <- merge(genus_data_t, group_data, by.x = "row.names", by.y = "Sample")
colnames(merged_data)[1] <- "Sample"

mean_abundance <- merged_data %>%
  group_by(group) %>%
  summarise(across(where(is.numeric), mean))
head(mean_abundance)

mean_abundance_long <- mean_abundance %>%
  pivot_longer(-group, names_to = "Species", values_to = "Abundance")

write.csv(mean_abundance_long, "GZ_ZJ_HEB_mean_abundance.csv", quote = F, row.names = F)

print(mean_abundance_long)



rm(list = ls())
LA_data <- read.table("GZ_mean_abundance.txt", sep = '\t', header = T, check.names = F, stringsAsFactors = F)
head(LA_data)


LA_data <- LA_data[order(LA_data$Abundance, decreasing = TRUE), ]
LA_data, aes(x = 2, y = Abundance,  fill = reorder(Species_label, -Abundance))) +
  geom_bar(stat = "identity", color = "white", width = 1) +
  coord_polar("y", start = 0) +
  facet_wrap(~ group) +
  xlim(0.5, 2.5) + 
  theme_void() +
  theme(legend.position = "right") +
  scale_fill_manual(values = c("Alphaproteobacteria" = "#458A74", "Gammaproteobacteria" = "#CC5B45", "Bacteroidia" = "#D9A421",
                               "Actinobacteria" = "#F5A216", "Gemmatimonadetes" = "#57AF37", "Bdellovibrionia" = "#41B9C1", 
                               "Bacilli" =  "#008B8B", "Acidimicrobiia" = "#F59B7B", "Verrucomicrobiae" =   "#6A8EC9",
                               "Vicinamibacteria" = "#652884")) +
  guides(fill = guide_legend(override.aes = list(size = 5))) 

  
p1

ggsave("GZ_tiantian_class.pdf", p1, width = 8, height = 10)



rm(list = ls())
MM_data <- read.table("ZJ_mean_abundance.txt", sep = '\t', header = T, check.names = F, stringsAsFactors = F)
head(MM_data)


MM_data <- MM_data[order(MM_data$Abundance, decreasing = TRUE), ]

p2 <- ggplot(MM_data, aes(x = 2, y = Abundance,  fill = reorder(Species_label, -Abundance))) +

  geom_bar(stat = "identity", color = "white", width = 1) +
  coord_polar("y", start = 0) +
  facet_wrap(~ group) +
  xlim(0.5, 2.5) +  
  theme_void() +
  theme(legend.position = "right") +
  scale_fill_manual(values = c("Alphaproteobacteria" = "#458A74", "Gammaproteobacteria" = "#CC5B45", "Bacteroidia" = "#D9A421",
                               "Actinobacteria" = "#F5A216", "Gemmatimonadetes" = "#57AF37", "Bdellovibrionia" = "#41B9C1", 
                               "Bacilli" =  "#008B8B", "Acidimicrobiia" = "#F59B7B", "Verrucomicrobiae" =   "#6A8EC9",
                               "Vicinamibacteria" = "#652884")) +
  guides(fill = guide_legend(override.aes = list(size = 5))) 


p2

ggsave("ZJ_tiantian_class.pdf", p2, width = 8, height = 10)




rm(list = ls())
MM_data <- read.table("HEB_mean_abundance.txt", sep = '\t', header = T, check.names = F, stringsAsFactors = F)
head(MM_data)

MM_data <- MM_data[order(MM_data$Abundance, decreasing = TRUE), ]

p3 <- ggplot(MM_data, aes(x = 2, y = Abundance,  fill = reorder(Species_label, -Abundance))) +

  geom_bar(stat = "identity", color = "white", width = 1) +
  coord_polar("y", start = 0) +
  facet_wrap(~ group) +
  xlim(0.5, 2.5) + 
  theme_void() +
  theme(legend.position = "right") +
  scale_fill_manual(values = c("Alphaproteobacteria" = "#458A74", "Gammaproteobacteria" = "#CC5B45", "Bacteroidia" = "#D9A421",
                               "Actinobacteria" = "#F5A216", "Gemmatimonadetes" = "#57AF37", "Bdellovibrionia" = "#41B9C1", 
                               "Bacilli" =  "#008B8B", "Acidimicrobiia" = "#F59B7B", "Verrucomicrobiae" =   "#6A8EC9",
                               "Vicinamibacteria" = "#652884")) +
  guides(fill = guide_legend(override.aes = list(size = 5))) 


p3

ggsave("HEB_tiantian_class.pdf", p3, width = 8, height = 10)














