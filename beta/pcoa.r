#!/usr/bin/env Rscript



data = "c3bd4d2a-0c51-47fb-8741-672fa405c3e5.txt"
metadata = "ed5b275a-144a-40d2-b5e6-1dbde9d7b0af.txt"
shape_variable_order = "NULL"
input_type = "distance_matrix"
dissimilarity_index = "bray"
manual_color_vector = "#018b38FF,#652884FF"
binary_dissimilarity_index = FALSE
data_transform = "None"
group_variable = "NULL"
color_variable = "site"
color_variable_order = "NULL"
shape_variable = "NULL"
shape_variable_order = "NULL"
size_variable = "NULL"
size_variable_order = "NULL"
label_variable_order = "NULL"
label_variable = "NULL"
legend.position = "right"
draw_ellipse = "auto"
manual_color_vector = "#018b38FF,#652884FF"
title = ""
top_n = 1
statistical_value_type = "mad"
top_n = 1
label_font_size = "NULL"
type1 = "t"
level = 0.95
extra_ggplot2_cmd = "NULL"
check_significance = TRUE
check_paired_significance = TRUE
outputprefix = "703fde11-f2c9-4b15-a537-5b96516e0075"
outputpictype = "pdf"
facet_variable = "NULL"
coord_fixed = TRUE
width = 12
height = 8
saveppt = FALSE
k = 3

if (data == "") {
  script = sub(".*=", "", commandArgs()[4])
  #print(script)
  system(paste(script, "-h"))
  stop("At least -f is required!")
}

# For all users
# devtools::install_github("ImageGP")
# For chinese users
# devtools::install_git("ImageGP")

# If no ImagegP package, install it.
library(ImageGP)
library(RColorBrewer)
library(vegan)
library(dplyr)
library(htmlwidgets)
library(plotly)
library(ggplot2)
library(ggalt)
library(ggrepel)
library(pairwiseAdonis)


debug = FALSE

if (outputprefix == "") {
  outputprefix = data
}
filename = paste0(outputprefix,  '.pcoa.', outputpictype)

manual_color_vector = sp_string2vector(manual_color_vector)
color_variable_order = sp_string2vector(color_variable_order)
size_variable_order = sp_string2vector(size_variable_order)
label_variable_order = sp_string2vector(label_variable_order)
shape_variable_order = sp_string2vector(shape_variable_order)
# sp_string2vector

#sink("s.log", append=TRUE, split=TRUE)

cat(sp_current_time(), "Starting...\n")

sp_pcoa(
  data = data,
  metadata = metadata,
  input_type = input_type,
  dissimilarity_index = dissimilarity_index,
  k = k,
  binary_dissimilarity_index = binary_dissimilarity_index,
  data_transform = data_transform,
  group_variable = group_variable,
  color_variable = color_variable,
  color_variable_order = color_variable_order,
  shape_variable = shape_variable,
  shape_variable_order = shape_variable_order,
  size_variable = size_variable,
  size_variable_order = size_variable_order,
  label_variable = label_variable,
  legend.position = legend.position,
  draw_ellipse = draw_ellipse,
  manual_color_vector = manual_color_vector,
  title = title,
  label_font_size = label_font_size,
  debug = debug,
  type = type1,
  width = width,
  height = height,
  saveppt = saveppt,
  level = level,
  filename = filename,
  top_n = top_n,
  statistical_value_type = statistical_value_type,
  extra_ggplot2_cmd = extra_ggplot2_cmd,
  check_significance = check_significance,
  check_paired_significance = check_paired_significance,
  coord_fixed = coord_fixed
)

cat(sp_current_time(), "Success.\n")
#sink()
 
