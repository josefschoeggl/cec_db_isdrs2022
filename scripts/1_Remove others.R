# REMOVE OTHERS ####
# run code above and below again to revert it (i.e. for the analysis of descriptions)
# just remove other sector to keep other strategies in the analysis -> this changes
# screeplot to TWO Dimensions that explain more than the average eigenvalue
# with other STRATEGIES also removed it is ONE Dimension

# d <- subset(d, sector != "Other")
# d <- subset(d, type != "Other")

# # only remove if needed
d <- subset(d, strategy != "Other")
# summary(d)

# SUBSETS ####
# per sector
food <- subset(d, sec == "FOOD & BEVERAGES including agriculture and restaurants")
fashion <- subset(d, sec == "FASHION and other textiles")
manufacturing <- subset(d, sec == "MANUFACTURING: Equipment, furniture, paper, plastics, chemicals, metal, mining, etc.")
cities <- subset(d, sec == "CITIES: buildings, infrastructure, mobility, logistics, energy, water, waste management")
electronics <- subset(d, sec == "CONSUMER PRODUCTS & ELECTRONICS: mobile phones, computers, hygiene products, toys, etc")
othersec <- subset(d, sec == "OTHER: Financial services, professional services, healthcare, education, tourism, etc.")


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
dd <- d
