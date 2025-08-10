
library(randomForest)
library(vegan)     
library(ggplot2)
library(dplyr)
library(caret)
library(reshape2)
set.seed(123)
alpha <- read.csv("alpha.csv", header = T)
head(alpha)
alpha_shannon <- subset(alpha, select = c("sample", "Shannon"))
head(alpha_shannon)
env_data <- read.csv("env_data.csv", header = T)
head(env_data)
df <- merge(env_data, alpha_shannon, by = "sample")
head(df)
row.names(df) <- df$sample
df <- subset(df, select = -sample)


df$soil <- as.factor(df$soil)
df$genotype <- as.factor(df$genotype)
df$Fol <- as.factor(df$Fol)

rf_model <- randomForest(Shannon ~ ., data = df, importance = TRUE, ntree = 500)

print(rf_model)

# 提取变量重要性
imp <- as.data.frame(importance(rf_model))
head(imp)
imp$Variable <- rownames(imp)
head(imp)
write.csv(imp, "rf_model.csv", row.names = T)


colnames(imp) <- c("%IncMSE", "IncNodePurity", "Variable")
head(imp)
# 将数据转换为长格式以便 ggplot 使用
imp_long <- melt(imp, id.vars = "Variable", variable.name = "Metric", value.name = "Importance")
head(imp_long)
# 绘图
p <- ggplot(imp_long, aes(x = reorder(Variable, Importance), y = Importance, fill = Metric)) +
  geom_bar(stat = "identity", position = "dodge", color = "black", ) +
  coord_flip() +
  theme_minimal(base_size = 14) +
  labs(title = "Variable Importance from Random Forest",
       x = "Variable", y = "Importance") +
  scale_fill_manual(values = c("#1b9e77", "#d95f02")) +
  theme(legend.title = element_blank())
p
ggsave("random_forest.pdf", p, width = 8, height = 8)