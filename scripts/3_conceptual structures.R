
# install and load package
library("bibliometrix")

# /SECTOR ####

## Manufacturing ####

# 6 * 4 pdf export for all

# MCA 
# conceptualStructure(manufacturing_e, field = "AB", method = "MCA", minDegree = 15, k.max = 8, clust = 6) # best

# stemming
conceptualStructure(manufacturing_e, field = "AB", method = "MCA", minDegree = 15, k.max = 8, clust = 6, stemming = TRUE) # used 5.15 x 3.61

# Electronics ####

# MCA
# CSelectronics <- conceptualStructure(electronics_e, field = "AB", method = "MCA", minDegree = 16, k.max = 8, clust = 5) 
# broad engagement differen R strategies visible

# stemming 
conceptualStructure(electronics_e, field = "AB", method = "MCA", minDegree = 30, k.max = 8, stemming = TRUE)

conceptualStructure(electronics_e, field = "AB", method = "MCA", minDegree = 25, k.max = 8, clust = 3, stemming = TRUE) # used

# Fashion ####

# MCA 
# CSfashion <- conceptualStructure(fashion_e, field = "AB", method = "MCA", minDegree = 10, k.max = 8, clust = 5)
# CSfashion <- conceptualStructure(fashion_e, field = "AB", method = "MCA", minDegree = 20, k.max = 8, clust = 5)

# stemming
conceptualStructure(fashion_e, field = "AB", method = "MCA", minDegree = 10, k.max = 8, clust = 5, stemming = TRUE)


# Food ####

# MCA 
# CSfood <- conceptualStructure(food_e, field = "AB", method = "MCA", minDegree = 20, k.max = 8, clust = 5) # best

# stemming
CSfood <- conceptualStructure(food, field = "AB", method = "MCA", minDegree = 15, k.max = 20, clust = 6, stemming = TRUE)

# Cities ####
# MCA 
# CScities <- conceptualStructure(cities_e, field = "AB", method = "MCA", minDegree = 23, k.max = 8, clust = 5) # best

# stemming
CScities <- conceptualStructure(cities_e, field = "AB", method = "MCA", minDegree = 25, k.max = 8, clust = 6, stemming = TRUE)

