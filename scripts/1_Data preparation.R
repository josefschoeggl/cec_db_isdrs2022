# data preparation

# importing the full table 
d <- read.csv("data/cecdb201811.csv", header = TRUE, sep = ",") # only works on MAC!

# Rename the Abstract column so that it will be recognized
# by the conceptualStructure of the bibliometrix package
colnames(d)[colnames(d)=="ab"] <- "AB"
colnames(d)[colnames(d)=="sector"] <- "sec"
colnames(d)[colnames(d)=="type"] <- "companytype"

#change factors to characters #
d$name <- as.character(d$name)
d$AB <- as.character(d$AB)
d$strat <- as.character(d$strat)
d$org <- as.character(d$org)
d$sec <- as.character(d$sec)
d$companytype <- as.character(d$companytype)
d$SR <- 1:3017

#CLEANING THE DATA####
#columns cleaned -> strategy, type, sector

#STRATEGIES
#strategies abbreviations
#show unique values
unique(d$strat)
names(table(d$strat))
levels(factor(d$strat))

#renaming them
stratrename <- c("DESIGN: e.g.: design for disassembly, redesign of supply chains, c2c, …" = "Design",
              "PRODUCT LIFE EXTENSION: e.g.: reuse, share, redistribute, donate, repair, remanufacture, …" = "Product life extension",
              "WASTE AS A RESOURCE: e.g.: recycling, compost, energy from waste, …" = "Waste as a resource",
              "RESOURCES: e.g.: biodegradable materials, renewable energy, clean processes, no hazardous chemicals, clean packaging, …" = "Resources",
              "BUSINESS MODELS: e.g.: product as a service, rent, re-sell, lease, ..." = "Business model",
              "OTHER" = "Other",
              "BUSINESS MODELS: e.g.: product as a service, rent, re-sell, lease, …" = "Business model",
              "wASTE AS A RESOURCE: e.g.: recycling, compost, energy from waste, …" = "Waste as a resource",
              "buSINESS MODELS: e.g.: product as a service, rent, re-sell, lease, ..." = "Business model",
              "bUSINESS MODELS: e.g.: product as a service, rent, re-sell, lease, ..." = "Business model",
              "waSTE AS A RESOURCE: e.g.: recycling, compost, energy from waste, …" = "Waste as a resource",
              "prODUCT LIFE EXTENSION: e.g.: reuse, share, redistribute, donate, repair, remanufacture, …" = "Product life extension",
              "pRODUCT LIFE EXTENSION: e.g.: reuse, share, redistribute, donate, repair, remanufacture, …" = "Product life extension",
              "rESOURCES: e.g.: biodegradable materials, renewable energy, clean processes, no hazardous chemicals, clean packaging, …" = "Resources")

#appending new column
d$strategy <- as.character(stratrename[d$strat])
class(d$strategy)
summary(d$strategy)
is.na(d$strategy)
table(is.na(d$strategy)) #1 NA


#SECTORS
#show unique values
levels(factor(d$sec))

#renaming them
# other may be omitted as it can not be interpreted!
sectorrename <- c("FOOD & BEVERAGES including agriculture and restaurants" = "Food",
                  "FASHION and other textiles" = "Fashion",
                  "fASHION and other textiles" = "Fashion",
                  "MANUFACTURING: Equipment, furniture, paper, plastics, chemicals, metal, mining, etc." = "Manufacturing",
                  "maNUFACTURING: Equipment, furniture, paper, plastics, chemicals, metal, mining, etc." = "Manufacturing",
                  "CITIES: buildings, infrastructure, mobility, logistics, energy, water, waste management" = "Cities",
                  "CONSUMER PRODUCTS & ELECTRONICS: mobile phones, computers, hygiene products, toys, etc" = "Consumer Products",
                  "OTHER: Financial services, professional services, healthcare, education, tourism, etc." = "Other",
                  "oTHER: Financial services, professional services, healthcare, education, tourism, etc." = "Other",
                  "OthER: Financial services, professional services, healthcare, education, tourism, etc." = "Other")

#appending new column
d$sector <- as.character(sectorrename[d$sec])
class(d$sector)
summary(d$sector)
is.na(d$sector)
table(is.na(d$sector)) #2 NAs

#COMPANY TYPES
#show unique values
levels(factor(d$companytype))
unique(d$companytype)
names(table(d$companytype))

#renaming them
typerename <- c("- Startup" = "Startups",
                "- Multinational Corporate" = "Multinational corporate",
                "- SME" = "SME",
                "Support (investment, consulting, media, etc)" = "Support",
                "Education" = "Education",
                "Government" = "Government",
                "- Private sector (undefined)" = "Other corporate",
                "- National Corporate" = "National corporate",
                "Non-profit" = "NPO",
                "Other" = "Other",
                "other" = "Other")

#appending new column
d$type <- as.character(typerename[d$companytype])
class(d$type)
summary(d$type)
is.na(d$type)
table(is.na(d$type)) #0 NAs
table(is.na(d$sector)) #2 NAs

# Remove missing values
d <- d[!is.na(d$sector),]
dd <- d

# group type ####
dput(levels(as.factor(d$type)))
library(dplyr)
d <- d %>% 
  mutate(type1 = case_when(type == "Education" ~ "Education",
                           type == "Government" ~ "Government",
                           type == "NPO" ~ "Other",
                           type == "National corporate" ~ "National corporate",
                           type == "Multinational corporate" ~ "Multinational corporate",
                           type == "SME" ~ "SME",
                           type == "Other corporate" ~ "Other",
                           type == "Support" ~ "Other",
                           type == "Other" ~ "Other",
                           type == "Startups" ~ "Startups",
                           TRUE ~ NA_character_))

dd <- d
sum(is.na(d$type1)) # 0
sum(is.na(d$type)) # 0

# SUBSETS ####
# per sector
food <- subset(d, sec == "FOOD & BEVERAGES including agriculture and restaurants")
fashion <- subset(d, sec == "FASHION and other textiles")
manufacturing <- subset(d, sec == "MANUFACTURING: Equipment, furniture, paper, plastics, chemicals, metal, mining, etc.")
cities <- subset(d, sec == "CITIES: buildings, infrastructure, mobility, logistics, energy, water, waste management")
electronics <- subset(d, sec == "CONSUMER PRODUCTS & ELECTRONICS: mobile phones, computers, hygiene products, toys, etc")
othersec <- subset(d, sec == "OTHER: Financial services, professional services, healthcare, education, tourism, etc.")

# per sector english only
d <- dd # load original df
library("textcat")
d$lang <- textcat(d$AB, p = ECIMCI_profiles)
dd <- d

d_e <- d %>% 
  filter(lang == "en")

food_e <- subset(d_e, sec == "FOOD & BEVERAGES including agriculture and restaurants")
fashion_e <- subset(d_e, sec == "FASHION and other textiles")
manufacturing_e <- subset(d_e, sec == "MANUFACTURING: Equipment, furniture, paper, plastics, chemicals, metal, mining, etc.")
cities_e <- subset(d_e, sec == "CITIES: buildings, infrastructure, mobility, logistics, energy, water, waste management")
electronics_e <- subset(d_e, sec == "CONSUMER PRODUCTS & ELECTRONICS: mobile phones, computers, hygiene products, toys, etc")
othersec_e <- subset(d_e, sec == "OTHER: Financial services, professional services, healthcare, education, tourism, etc.")

#per strategy 
design <- subset(d, strat == "DESIGN: e.g.: design for disassembly, redesign of supply chains, c2c, …")
lifeextension <- subset(d, strat == "PRODUCT LIFE EXTENSION: e.g.: reuse, share, redistribute, donate, repair, remanufacture, …")
waste <- subset(d, strat == "WASTE AS A RESOURCE: e.g.: recycling, compost, energy from waste, …")
resources <- subset(d, strat =="RESOURCES: e.g.: biodegradable materials, renewable energy, clean processes, no hazardous chemicals, clean packaging, …")
business <- subset(d, strat == "BUSINESS MODELS: e.g.: product as a service, rent, re-sell, lease, ...")
otherstrategy <- subset(d, strat == "OTHER")

# SECTORS/STRATGIES ####
# as basis input for the Correspondence analysis of the text descriptions 

#design
fooddesign <- subset(design, sec == "FOOD & BEVERAGES including agriculture and restaurants")
fashiondesign <- subset(design, sec == "FASHION and other textiles")
manufacturingdesign <- subset(design, sec == "MANUFACTURING: Equipment, furniture, paper, plastics, chemicals, metal, mining, etc.")
citiesdesign <- subset(design, sec == "CITIES: buildings, infrastructure, mobility, logistics, energy, water, waste management")
electronicsdesign <- subset(design, sec == "CONSUMER PRODUCTS & ELECTRONICS: mobile phones, computers, hygiene products, toys, etc")
othersecdesign <- subset(design, sec == "OTHER: Financial services, professional services, healthcare, education, tourism, etc.")

#lifeextension
foodlifeextension <- subset(lifeextension, sec == "FOOD & BEVERAGES including agriculture and restaurants")
fashionlifeextension <- subset(lifeextension, sec == "FASHION and other textiles")
manufacturinglifeextension <- subset(lifeextension, sec == "MANUFACTURING: Equipment, furniture, paper, plastics, chemicals, metal, mining, etc.")
citieslifeextension <- subset(lifeextension, sec == "CITIES: buildings, infrastructure, mobility, logistics, energy, water, waste management")
electronicslifeextension <- subset(lifeextension, sec == "CONSUMER PRODUCTS & ELECTRONICS: mobile phones, computers, hygiene products, toys, etc")
otherseclifeextension <- subset(lifeextension, sec == "OTHER: Financial services, professional services, healthcare, education, tourism, etc.")

#waste
foodwaste <- subset(waste, sec == "FOOD & BEVERAGES including agriculture and restaurants")
fashionwaste <- subset(waste, sec == "FASHION and other textiles")
manufacturingwaste <- subset(waste, sec == "MANUFACTURING: Equipment, furniture, paper, plastics, chemicals, metal, mining, etc.")
citieswaste <- subset(waste, sec == "CITIES: buildings, infrastructure, mobility, logistics, energy, water, waste management")
electronicswaste <- subset(waste, sec == "CONSUMER PRODUCTS & ELECTRONICS: mobile phones, computers, hygiene products, toys, etc")
othersecwaste <- subset(waste, sec == "OTHER: Financial services, professional services, healthcare, education, tourism, etc.")

#resources
foodresources <- subset(resources, sec == "FOOD & BEVERAGES including agriculture and restaurants")
fashionresources <- subset(resources, sec == "FASHION and other textiles")
manufacturingresources <- subset(resources, sec == "MANUFACTURING: Equipment, furniture, paper, plastics, chemicals, metal, mining, etc.")
citiesresources <- subset(resources, sec == "CITIES: buildings, infrastructure, mobility, logistics, energy, water, waste management")
electronicsresources <- subset(resources, sec == "CONSUMER PRODUCTS & ELECTRONICS: mobile phones, computers, hygiene products, toys, etc")
othersecresources <- subset(resources, sec == "OTHER: Financial services, professional services, healthcare, education, tourism, etc.")

#business
foodbusiness <- subset(business, sec == "FOOD & BEVERAGES including agriculture and restaurants")
fashionbusiness <- subset(business, sec == "FASHION and other textiles")
manufacturingbusiness <- subset(business, sec == "MANUFACTURING: Equipment, furniture, paper, plastics, chemicals, metal, mining, etc.")
citiesbusiness <- subset(business, sec == "CITIES: buildings, infrastructure, mobility, logistics, energy, water, waste management")
electronicsbusiness <- subset(business, sec == "CONSUMER PRODUCTS & ELECTRONICS: mobile phones, computers, hygiene products, toys, etc")
othersecbusiness <- subset(business, sec == "OTHER: Financial services, professional services, healthcare, education, tourism, etc.")


#UNUSED ####
#Rename org to TC to try if this prevents the error in the conceptualStructure function
#colnames(d)[colnames(d)=="org"] <- "TC"
#indeed the output file is now written but we would need to change the organisation field
#to the same code as the author code in "M" in bibliometrix to show the orgnanisations in the factorial map

#STRATEGIES NUMBERED ####

# stratnumrename <- c("DESIGN: e.g.: design for disassembly, redesign of supply chains, c2c, …" = "1",
#                     "PRODUCT LIFE EXTENSION: e.g.: reuse, share, redistribute, donate, repair, remanufacture, …" = "2",
#                     "WASTE AS A RESOURCE: e.g.: recycling, compost, energy from waste, …" = "3",
#                     "RESOURCES: e.g.: biodegradable materials, renewable energy, clean processes, no hazardous chemicals, clean packaging, …" = "4",
#                     "BUSINESS MODELS: e.g.: product as a service, rent, re-sell, lease, ..." = "5",
#                     "OTHER" = "6")
# 
# #appending new column
# d$strat_num <- as.numeric(stratnumrename[d$strat])
# class(d$strat_num)
# summary(d$strat_num)
# is.na(d$strat_num)
# table(is.na(d$strat_num)) # 12 NAs


