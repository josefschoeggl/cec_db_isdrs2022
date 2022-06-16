# ALL ####
d <- dd  # dd = backup of the large dataframe, in case d is changed to a subset

## TYPE####
tab <- table(d$type, d$strategy) #all cases
tab_df <- as.data.frame.matrix(tab) # asdataframe
pt <- prop.table(table(d$type, d$strategy), 1) # 1 = or ow
rowSums(pt)
tab

### analysis ####
sum(is.na(d$strategy))
sum(is.na(d$type1))
sum(is.na(d$type))


rowSums(tab)
colSums(tab)
sum(tab)


####  heatmap ####
library("pheatmap")

# set color 
# color
library("viridis")
library("scales")
q_colors =  100
v_colors =  viridis(q_colors)
v_colors[q_colors] <- "#FFFFFF"

# plot
hm <- pheatmap::pheatmap(pt, clustering_method = "average",
         cutree_rows = 3, cutree_cols = 3, 
         color = (rev(v_colors)),
         main = "CE strategies per company/actor type",
         fontsize = 8, 
         angle_col = 90,
         breaks = NA)

# save plot
library("ggplot2")
ggsave(
  "plots/heatmaps/actors.pdf",
  device = NULL,
  plot = hm,
  path = NULL,
  scale = 0.9,
  width = 12,
  height = 12,  # 15 looks good
  units = "cm",
  dpi = 1000,
  limitsize = TRUE)

 ##### chi2 ####
library(DescTools)
library(gmodels)

CrossTable(table(d$type1, d$strategy), chisq = FALSE, 
           prop.r = FALSE, 
           prop.c = FALSE, 
           prop.chisq = TRUE, 
           prop.t = FALSE, 
           expected = TRUE)

chisq <- chisq.test(table(d$strategy, d$type1))
chisq # pvalue < 2.2e-16

ContCoef(table(d$strategy, d$type1), correct = TRUE)  # 0.27

#### table ####

# rank
t(apply(-pt, 1, rank))


## SECTOR #### 
tab <- table(d$sector, d$strategy) #all cases
tab_df <- as.data.frame.matrix(tab) # asdataframe
pt <- prop.table(tab, 1) # 1 = or ow
rowSums(pt)

###  heatmap ####
library("pheatmap")

# set color 
m_colors =  magma(q_colors)
m_colors[q_colors] <- "#FFFFFF"

p_colors =  plasma(q_colors)
p_colors[q_colors] <- "#FFFFFF"  # add white

# plot
hm <- pheatmap::pheatmap(pt, cutree_rows = 2, cutree_cols = 3,
         color = (rev(v_colors)),
         main = "Circular economy strategies per sector",
         fontsize = 8, 
         angle_col = 90,
         breaks = NA)

# save plot
library("ggplot2")
ggsave(
  "plots/heatmaps/sectors.pdf",
  device = NULL,
  plot = hm,
  path = NULL,
  scale = 0.9,
  width = 12,
  height = 12,  # 15 looks good
  units = "cm",
  dpi = 1000,
  limitsize = TRUE)


 #### chi2 ####
CrossTable(tab, chisq = FALSE, 
           prop.r = FALSE, 
           prop.c = FALSE, 
           prop.chisq = TRUE, 
           prop.t = FALSE, 
           expected = TRUE)

ContCoef(tab, correct = TRUE)  # 0.411
##### table ####

# rank
t <- t(apply(-pt, 1, rank))
colSums(t)
## REGION #### 
tab <- table(d$region, d$strategy) #all cases
tab_df <- as.data.frame.matrix(tab) # asdataframe
pt <- prop.table(tab, 1) # 1 = or ow
rowSums(pt)
sum(tab)
sum(is.na(d$region))
sum(is.na(d$strategy))

###  heatmap ####
library("pheatmap")

# set color 
# color
library("viridis")
library("scales")
q_colors =  100
v_colors =  viridis(q_colors)
v_colors[q_colors] <- "#FFFFFF"

# plot
hm <- pheatmap::pheatmap(pt, cutree_rows = 3, cutree_cols = 4,
         color = (rev(v_colors)),
         main = "CE strategies per region",
         fontsize = 8, 
         angle_col = 90,
         breaks = NA)

# save plot
library("ggplot2")
ggsave(
  "plots/heatmaps/region.pdf",
  device = NULL,
  plot = hm,
  path = NULL,
  scale = 0.9,
  width = 12,
  height = 12,  # 15 looks good
  units = "cm",
  dpi = 1000,
  limitsize = TRUE)


#### chi2 ####
CrossTable(tab, chisq = FALSE, 
           prop.r = FALSE, 
           prop.c = FALSE, 
           prop.chisq = TRUE, 
           prop.t = FALSE, 
           expected = TRUE)

chisq.test(tab, simulate.p.value = TRUE)

ContCoef(tab, correct = TRUE)  # 0.34

##### table ####

# rank
t(apply(-pt, 1, rank))

# strongest depenendency between sector and strategy, it is the largest determant


# DIVIDED ####
# select type or shorter type 1
## manu ####
d <- manufacturing

tab <- table(d$type, d$strategy) #all cases
tab_df <- as.data.frame.matrix(tab) # asdataframe
pt <- prop.table(table(d$type, d$strategy), 1) # 1 = or ow
rowSums(pt)
manu <- pt

###  heatmap ####
library("pheatmap")

# plot
pheatmap::pheatmap(pt, cutree_rows = 5, cutree_cols = 4,
         color = (rev(v_colors)),
         main = "CE Strategy per company type - Manufacturing sector",
         fontsize = 8, 
         angle_col = 90,
         breaks = NA)

### chi2 ####
CrossTable(table(d$type, d$strategy), chisq = FALSE, 
           prop.r = FALSE, 
           prop.c = FALSE, 
           prop.chisq = FALSE, 
           prop.t = FALSE, 
           expected = TRUE)

chisq <- chisq.test(tab, simulate.p.value = TRUE)
chisq # 0.09

ContCoef(table(d$strategy, d$type), correct = TRUE)  # 0.39

## food ####
d <- food

tab <- table(d$type, d$strategy) #all cases
tab_df <- as.data.frame.matrix(tab) # asdataframe
pt <- prop.table(table(d$type, d$strategy), 1) # 1 = or ow
rowSums(pt)
foo <- pt
###  heatmap ####
library("pheatmap")

# plot
pheatmap::pheatmap(pt, cutree_rows = 5, cutree_cols = 4,
                   color = (rev(v_colors)),
                   main = "CE Strategy per company type - Food sector",
                   fontsize = 8, 
                   angle_col = 90,
                   breaks = NA)

### chi2 ####
CrossTable(table(d$type, d$strategy), chisq = FALSE, 
           prop.r = FALSE, 
           prop.c = FALSE, 
           prop.chisq = FALSE, 
           prop.t = FALSE, 
           expected = TRUE)
sum(tab) # 528

chisq <- chisq.test(tab, simulate.p.value = TRUE)
chisq # pvalue < 2.2e-16

ContCoef(table(d$strategy, d$type), correct = TRUE)  # 0.42
## electronics ####
d <- electronics

tab <- table(d$type, d$strategy) #all cases
tab_df <- as.data.frame.matrix(tab) # asdataframe
pt <- prop.table(table(d$type, d$strategy), 1) # 1 = or ow
rowSums(pt)
el <- pt

###  heatmap ####
pheatmap::pheatmap(pt, cutree_rows = 5, cutree_cols = 4,
                   color = (rev(v_colors)),
                   main = "CE Strategy per company type - Manufacturing sector",
                   fontsize = 8, 
                   angle_col = 90,
                   breaks = NA)

### chi2 ####
CrossTable(table(d$type, d$strategy), chisq = FALSE, 
           prop.r = FALSE, 
           prop.c = FALSE, 
           prop.chisq = FALSE, 
           prop.t = FALSE, 
           expected = TRUE)

chisq <- chisq.test(tab, simulate.p.value = TRUE)
chisq # pvalue < 2.2e-16

ContCoef(table(d$strategy, d$type), correct = TRUE)  # 0.42

## fashion ####
d <- fashion

tab <- table(d$type, d$strategy) #all cases
tab_df <- as.data.frame.matrix(tab) # asdataframe
pt <- prop.table(table(d$type, d$strategy), 1) # 1 = or ow
rowSums(pt)
tex <- pt
sum(tab)
sum(is.na(d$type))

###  heatmap ####

# plot
pheatmap::pheatmap(pt, cutree_rows = 5, cutree_cols = 4,
                   color = (rev(v_colors)),
                   main = "CE Strategy per company type - Manufacturing sector",
                   fontsize = 8, 
                   angle_col = 90,
                   breaks = NA)

### chi2 ####
CrossTable(table(d$type, d$strategy), chisq = FALSE, 
           prop.r = FALSE, 
           prop.c = FALSE, 
           prop.chisq = FALSE, 
           prop.t = FALSE, 
           expected = TRUE)
sum(tab)

chisq <- chisq.test(table(d$strategy, d$type, simulate.p.value = TRUE))
chisq # pvalue < 2.2e-16

ContCoef(table(d$strategy, d$type), correct = TRUE)  # 0.42

## cities ####
d <- cities

tab <- table(d$type, d$strategy) #all cases
tab_df <- as.data.frame.matrix(tab) # asdataframe
pt <- prop.table(table(d$type, d$strategy), 1) # 1 = or ow
rowSums(pt)
ci <- pt

###  heatmap ####
library("pheatmap")

# set color 
# color
library("viridis")
library("scales")
q_colors =  100
v_colors =  viridis(q_colors)
v_colors[q_colors] <- "#FFFFFF"

# plot
pheatmap::pheatmap(pt, cutree_rows = 5, cutree_cols = 4,
                   color = (rev(v_colors)),
                   main = "CE Strategy per company type - Manufacturing sector",
                   fontsize = 8, 
                   angle_col = 90,
                   breaks = NA)

### chi2 ####
CrossTable(table(d$type, d$strategy), chisq = FALSE, 
           prop.r = FALSE, 
           prop.c = FALSE, 
           prop.chisq = FALSE, 
           prop.t = FALSE, 
           expected = TRUE)
sum(tab)

chisq <- chisq.test(table(d$strategy, d$type, simulate.p.value = TRUE))
chisq # pvalue < 2.2e-16

ContCoef(table(d$strategy, d$type), correct = TRUE)  # 0.42


# comparison ####
library(devtools)
# install_github("jokergoo/ComplexHeatmap")
library(ComplexHeatmap)
library(circlize)

# color mapping function 
common_min = min(c(manu, tex, el, foo, ci))  # define common minimums and max to have the same color range
common_max = max(c(manu, tex, el, foo, ci))   # https://jokergoo.github.io/ComplexHeatmap-reference/book/a-single-heatmap.html
col_fun = circlize::colorRamp2(breaks = seq(common_min, common_max, length = 100),colors = rev(v_colors)) 

# define splits
rkm = 0
ckm = 3

## plot ####
cm <- "average"
cc <- TRUE

ComplexHeatmap::Heatmap(manu, cluster_rows = FALSE,
                        cluster_columns = cc, col = col_fun,
                        rect_gp = gpar(col = "lightgray", lwd = 2), 
                        column_km = ckm,
                        column_title = "Manufacturing", 
                        show_heatmap_legend = TRUE,
                        heatmap_legend_param = list(title = "%"),
                        clustering_method_rows = cm,
                        clustering_method_columns = cm) + 
  
  Heatmap(el, cluster_rows = FALSE, cluster_columns = cc, col = col_fun,
          rect_gp = gpar(col = "lightgray", lwd = 2),
          row_km = rkm, column_km = ckm,
          column_title = "Consumer products", 
          show_heatmap_legend = FALSE,
          # clustering_distance_rows = "euclidean",
          clustering_method_rows = cm,
          clustering_method_columns = cm) +
  
  
  Heatmap(tex, cluster_rows = FALSE, cluster_columns = cc, col = col_fun,
          rect_gp = gpar(col = "lightgray", lwd = 2),
          row_km = rkm, column_km = ckm,
          column_title = "Fashion", 
          show_heatmap_legend = FALSE,
          # clustering_distance_rows = "euclidean",
          clustering_method_rows = cm,
          clustering_method_columns = cm) + 
  
  Heatmap(foo, cluster_rows = FALSE, cluster_columns = cc, col = col_fun,
          rect_gp = gpar(col = "lightgray", lwd = 2),
          row_km = rkm, column_km = ckm, 
          column_title = "Food", 
          show_heatmap_legend = FALSE,
          # clustering_distance_rows = "euclidean",
          clustering_method_rows = cm,
          clustering_method_columns = cm) +
  
  Heatmap(ci, cluster_rows = FALSE, cluster_columns = cc, col = col_fun,
          rect_gp = gpar(col = "lightgray", lwd = 2),
          row_km = rkm, column_km = ckm,
          column_title = "Cities", 
          show_heatmap_legend = FALSE,
          # clustering_distance_rows = "euclidean",
          clustering_method_rows = cm,
          clustering_method_columns = cm) # cluster_columns = FALSE

