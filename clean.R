
## C. McClintock 
## Data for Democracy - RunForOffice
## Summer 2018 
## Cleaning Script

# ..................................................................................................

# set up: wd, retrieve data
rm(list=ls())
getwd()
# if need be 
setwd("Louisiana/data")

# set up: libraries
library(dplyr)
library(forcats)
library(tidyverse)
library(readxl)
library(tidyr)
library(scales)
library(RColorBrewer)

# ..................................................................................................

# 1. LOUISIANA DEMOGRAPHICS
# 2. ALL ELECTED OFFICES 
# 3. LAW ENFORCEMENT
# 4. LOCAL GOVERNMENT
# 5. ELECTION RESULTS

# ..................................................................................................

# 1. LOUISIANA DEMOGRAPHICS

pop <- read_csv("acs16.csv")
pop$race <- as.factor(pop$race)

pop <- mutate(pop, 
                race=fct_recode(race, 
                                Other="American Indian", 
                                Other="Asian", 
                                Other = "Hawaiian Pacific Islander", 
                                Other = "Two or More Races"))
pop <- aggregate(pop$percent, by=list(race=pop$race), FUN="sum")
pop <- rename(pop, "percent"="x")

pop$level <- "2016 Louisiana Population"
pop$type <- "2016 Louisiana Population"
pop$genoffice <- "2016 Louisiana Population"
pop <- select(pop, race, level, type, genoffice, percent)

pop$percent <- pop$percent*100
pop <- pop[rep(1:nrow(pop), pop$percent),] %>% select(race, level, type, genoffice)

# ..................................................................................................

# 2. ALL ELECTED OFFICES 

# read in the data
louisiana <- read_excel("elected_officials.xlsx", sheet = 1)
la <- louisiana

# make the names easier to use
names(la) <- str_to_lower(names(la))
la <- rename(la, "office"="office title", "description"="office description",
                "zip"="zip code", "candidate"="candidate name", "party"="party code")
la <- select(la, office, description, city, zip, state, 
                parish, candidate, ethnicity, sex, party)

# coerce to factor class
la <- mutate(la, 
                office = as.factor(office), 
                city = as.factor(city),
                parish = as.factor(parish), 
                ethnicity = as.factor(ethnicity), 
                sex = as.factor(sex), 
                party = as.factor(party))

levels(la$office)

# add some potentially interesting useful categories

# level of government
la <- mutate(la, 
                level=fct_recode(office, 
                                  Federal = "U. S. Senator",
                                  Federal = "U. S. Representative", 
                                  State = "Governor", 
                                  State = "Lieutenant Governor", 
                                  State = "Secretary of State",
                                  State = "Attorney General",
                                  State = "Commissioner", 
                                  State = "State Treasurer", 
                                  State = "Associate Justice", 
                                  State = "Judge, Court of Appeal", 
                                  State = "Public Service Commission", 
                                  State = "Member, BESE", 
                                  State = "State Senator", 
                                  State = "State Representative", 
                                  Local = "District Judge", 
                                  Local = "Judge", 
                                  Local = "Magistrate", 
                                  Local = "District Attorney", 
                                  Local = "Judge, Family Court", 
                                  Local = "Sheriff", 
                                  Local = "Clerk of Court", 
                                  Local = "Clerk", 
                                  Local = "Assessor", 
                                  Local = "Coroner" , 
                                  Local = "Parish President" , 
                                  Local = "Mayor" , 
                                  Local = "Mayor-President" , 
                                  Local = "Councilman at Large" , 
                                  Local = "Councilmember at Large" , 
                                  Local = "Police Juror" , 
                                  Local = "Council Member", 
                                  Local = "Parish Commission Member", 
                                  Local = "Councilman", 
                                  Local = "Member", 
                                  Local = "Councilmember", 
                                  Local = "Member of Parish Council", 
                                  Local = "Council Member at Large", 
                                  Local = "City Judge", 
                                  Local = "City Judge, City Court", 
                                  Local = "City Marshal", 
                                  Local = "City Constable", 
                                  Local = "Constable", 
                                  Local = "Member of School Board", 
                                  Local = "Mbr. of School Bd.", 
                                  Local = "Justice of the Peace", 
                                  Local = "Justice of the Peace(s)", 
                                  Local = "Constable(s)", 
                                  Local = "Chief of Police", 
                                  Local = "Marshal", 
                                  Local = "City Prosecutor", 
                                  Local = "Alderman at Large", 
                                  Local = "Councilmen at Large", 
                                  Local = "Council Member(s) at Large", 
                                  Local = "Alderman", 
                                  Local = "Aldermen", 
                                  Local = "Selectman", 
                                  Local = "Council Member(s)", 
                                  Local = "Member, Board of Trustees", 
                                  Local = "Council Members", 
                                  Local = "Councilmen", 
                                  Local = "Council Member I", 
                                  Local = "Council Member II", 
                                  Local = "Council Member III" ))

# type of office
la <- mutate(la, 
             type=fct_recode(office, 
                              Legislative = "U. S. Senator",
                              Legislative = "U. S. Representative", 
                              Executive = "Governor", 
                              Executive = "Lieutenant Governor", 
                              Executive = "Secretary of State",
                              Executive = "Attorney General",
                              Executive = "Commissioner", 
                              Executive = "State Treasurer", 
                              Judicial = "Associate Justice", 
                              Judicial = "Judge, Court of Appeal", 
                              Executive = "Public Service Commission", 
                              Education = "Member, BESE", 
                              Legislative = "State Senator", 
                              Legislative = "State Representative", 
                              Judicial = "District Judge", 
                              Judicial = "Judge", 
                              Judicial = "Magistrate", 
                              Judicial = "District Attorney", 
                              Judicial = "Judge, Family Court", 
                              "Law Enforcement" = "Sheriff", 
                              Judicial = "Clerk of Court", 
                              Judicial = "Clerk", 
                              "Local Government" = "Assessor", 
                              "Law Enforcement" = "Coroner" , 
                              Executive = "Parish President" , 
                              Executive = "Mayor" , 
                              Executive = "Mayor-President" , 
                              "Local Government" = "Councilman at Large" , 
                              "Local Government" = "Councilmember at Large" , 
                              "Local Government" = "Police Juror" , 
                              "Local Government" = "Council Member", 
                              "Local Government" = "Parish Commission Member", 
                              "Local Government" = "Councilman", 
                              "Local Government" = "Member", 
                              "Local Government" = "Councilmember", 
                              "Local Government" = "Member of Parish Council", 
                              "Local Government" = "Council Member at Large", 
                              Judicial = "City Judge", 
                              Judicial = "City Judge, City Court", 
                              "Law Enforcement" = "City Marshal", 
                              "Law Enforcement" = "City Constable", 
                              "Law Enforcement" = "Constable", 
                              Education = "Member of School Board", 
                              Education = "Mbr. of School Bd.", 
                              Judicial = "Justice of the Peace", 
                              Judicial = "Justice of the Peace(s)", 
                             "Law Enforcement" = "Constable(s)", 
                             "Law Enforcement" = "Chief of Police", 
                             "Law Enforcement" = "Marshal", 
                              Judicial = "City Prosecutor", 
                              "Local Government" = "Alderman at Large", 
                              "Local Government" = "Councilmen at Large", 
                              "Local Government" = "Council Member(s) at Large", 
                              "Local Government" = "Alderman", 
                              "Local Government" = "Aldermen", 
                              "Local Government" = "Selectman", 
                              "Local Government" = "Council Member(s)", 
                              "Local Government" = "Member, Board of Trustees", 
                              "Local Government" = "Council Members", 
                              "Local Government" = "Councilmen", 
                              "Local Government" = "Council Member I", 
                              "Local Government" = "Council Member II", 
                              "Local Government" = "Council Member III"))

# level of government
la <- mutate(la, 
             genoffice = office,
             genoffice=fct_recode(genoffice, 
                              "Judge" = "Judge, Family Court", 
                              "Clerk" = "Clerk of Court",
                              "Mayor" = "Mayor-President" , 
                              "Council Member" = "Councilman at Large" , 
                              "Council Member" = "Councilmember at Large" , 
                              "Council Member" = "Council Member", 
                              "Council Member" = "Councilman", 
                              "Council Member" = "Councilmember", 
                              "Council Member" = "Member of Parish Council", 
                              "Council Member" = "Council Member at Large", 
                              "City Judge" = "City Judge, City Court", 
                              "Member of School Board" = "Mbr. of School Bd.", 
                              "Justice of the Peace" = "Justice of the Peace(s)", 
                              "Constable" = "Constable(s)", 
                              "Alderman" = "Alderman at Large", 
                              "Council Member" = "Councilmen at Large", 
                              "Council Member" = "Council Member(s) at Large", 
                              "Alderman" = "Aldermen", 
                              "Council Member" = "Council Member(s)", 
                              "Council Member" = "Council Members", 
                              "Council Member" = "Councilmen", 
                              "Council Member" = "Council Member I", 
                              "Council Member" = "Council Member II", 
                              "Council Member" = "Council Member III" ))


# create more readable factor categories

# race # all other racial groups are very small, makes sense to combine
la$ethnicity <- as.character(la$ethnicity)
la$ethnicity <- ifelse(is.na(la$ethnicity), "U", la$ethnicity)
la <- mutate(la, 
                race=fct_recode(ethnicity, 
                                White="W",
                                "Black or African American"="B", 
                                Other="A", 
                                Other="O", 
                                Other = "I", 
                                Other = "H", 
                                Unknown = "U"))
la$race <- as.factor(la$race)


la <- mutate(la, 
                race=fct_relevel(race,"Black or African American", 
                                 "Other",
                                 "Unknown", 
                                 "White"))

la$sex <- as.character(la$sex)
la$sex <- ifelse(is.na(la$sex), "U", la$sex)

la <- mutate(la, 
                gender=fct_recode(sex, 
                                  Male="M",
                                  Female="F",
                                  Unknown="U"))

la$gender <- as.factor(la$gender)

la <- mutate(la, 
             gender=fct_relevel(gender, "Female", "Unknown", "Male"))

la <- mutate(la, 
             party=fct_recode(party, 
                               Democrat="D",
                               Republican="R",
                               Other="N", 
                               Other="G",
                               Other="I",
                               Other="L", 
                               Other="O"))

la <- mutate(la, 
             party=fct_relevel(party, 
                               "Democrat",
                               "Other", 
                               "Republican"))

la <- mutate(la,
             type = fct_relevel(type,
                                "Education",
                                "Law Enforcement",
                                "Local Government",
                                "Executive", 
                                "Legislative", 
                                "Judicial"))

la <- select(la, -c(ethnicity, sex))

# ..................................................................................................

# 3. LAW ENFORCEMENT

judges <- c("Judge, Court of Appeal", "Judge", "Judge, Family Court", "District Judge", 
            "City Judge", "City Judge, City Court")
judges <- filter(la, office %in% judges)

sheriffs <- "Sheriff"
sheriffs <- filter(la, office %in% sheriffs)

police <- "Chief of Police"
police <- filter(la, office %in% police)

DA <- "District Attorney"
DA <- filter(la, office %in% DA)

enforce <- c("Judge, Court of Appeal", "Judge", "Judge, Family Court", "District Judge", 
             "City Judge", "City Judge, City Court", "Sheriff", "Chief of Police", 
             "District Attorney", "Marshal", "City Marshal", "City Constable", "Constable")
enforce <- filter(la, office %in% enforce)

# coerce to factor again to drop ghost levels
enforce <- mutate(enforce, 
                  genoffice = enforce$office,
                  genoffice = fct_recode(office, 
                                         "Judge" = "Judge, Court of Appeal", 
                                         "Judge" = "Judge, Family Court", 
                                         "Judge" = "District Judge", 
                                         "Judge" =  "City Judge", 
                                         "Judge" = "City Judge, City Court",
                                         "Constable" = "City Constable",
                                         "Marshal" = "City Marshal"))

enforce$genoffice = factor(enforce$genoffice)

enforce <- mutate(enforce, 
                  race = fct_relevel(race, 
                                     "Black or African American",
                                     "Other", 
                                     "White"))

enforce <- mutate(enforce, 
                  party = fct_relevel(party, 
                                     "Democrat",
                                     "Other", 
                                     "Republican"))

df2 <- full_join(enforce, pop, by = c("race", "genoffice"))
df2 <- mutate(df2,
             genoffice = as.factor(genoffice),
             genoffice = fct_relevel(genoffice,
                                "2016 Louisiana Population", 
                                "Chief of Police",
                                "Constable",
                                "Judge",
                                "Marshal", 
                                "District Attorney", 
                                "Sheriff"))

# ..................................................................................................

# 4. LOCAL GOVERNMENT

local <- c("Mayor", "Mayor-President", "Council Member", "Parish President", "Police Juror")
local <- filter(la, genoffice %in% local)
local <- mutate(local, 
                genoffice = fct_relevel(genoffice, 
                                        "Mayor", 
                                        "Council Member", 
                                        "Parish President",
                                        "Police Juror"))
local$genoffice = factor(local$genoffice)

df3 <- full_join(local, pop, by = c("race", "genoffice"))
df3 <- mutate(df3,
              genoffice = as.factor(genoffice),
              genoffice = fct_relevel(genoffice,
                                      "2016 Louisiana Population", 
                                      "Mayor", 
                                      "Council Member", 
                                      "Parish President", 
                                      "Police Juror"))

mpop <- read.csv("municipal_populations.csv") 
mpop <- separate(data = mpop, col = city, into = c("city", "type"), 
                 sep = " city| town| village") %>% select(city, X2017)
mpop <- rename(mpop, "population"="X2017")
mpop <- mutate(mpop, 
               city = fct_recode(city, 
                                 "Amite" = "Amite City", 
                                 "Lafitte" = "Jean Lafitte"))

local$city[local$description == 'City of New Orleans'] <- 'New Orleans'
local$city[local$description == 'Metro Council, City of Baton Rouge'] <- 'Baton Rouge'

local <- left_join(local, mpop, by = "city")

muni <- c("Mayor", "Council Member")
muni <- filter(local, genoffice %in% muni)

muni$density <- ifelse(muni$population>47000, "Urban", "Rural")
muni$density <- factor(muni$density)

df4 <- full_join(muni, pop, by = c("race", "genoffice"))
df4 <- mutate(df4,
              genoffice = as.factor(genoffice),
              genoffice = fct_relevel(genoffice,
                                      "2016 Louisiana Population"))


# ..................................................................................................

# 5. ELECTION RESULTS

elect16 <- read_excel("la_elections_16_clean.xlsx")
elect16$year <- 2016
elect14 <- read_excel("la_elections_14_clean.xlsx")
elect14$year <- 2014

elect <- rbind(elect16, elect14)

# rename
elect <- rename(elect, "election"="Election", "candidate"="Option")

# gather parishes
elect <- gather(elect, "parish", "votes", Acadia:Winn)

# separate into positon and district
elect <- separate(elect, col = election, into = c("position", "district"), sep = " -- ")

# filter out ballot initiatives
elect <- filter(elect, !(elect$candidate=="YES" | elect$candidate=="NO"))

# separate out party column
elect <- separate(elect, col = candidate, into = c("candidate", "party"), sep = "[\\(\\)]" )

multi <- elect %>% 
  group_by(position, candidate, year) %>% 
  summarise(votes = sum(votes))

# get votes to a more useful format
elect <- filter(elect, !is.na(elect$votes))
elect$votes <- as.numeric(elect$votes)

votes <- elect %>% 
  group_by(position, district, candidate, party, year) %>% 
  summarise(votes = sum(votes))

multi.parish <- elect %>% 
  group_by(position, district, candidate, year) %>%
  count() %>% filter(n>1) %>% select(-n)
multi.parish$parish <- "Multi-Parish Race"
multi.parish <- left_join(multi.parish, votes, by=c("position", "district", "candidate", "year"))

single.parish <- elect %>% 
  group_by(position, district, candidate, party, year) %>%
  count() %>% filter(n==1) %>% select(-n)
single.parish <- left_join(single.parish, elect, 
                           by = c("position", "district", "candidate", 
                                  "party", "year"))

elect <- full_join(multi.parish, single.parish, 
                   by = c("position", "district", "candidate", "party", 
                          "year", "parish", "votes"))

elect <- arrange(elect, position, district)
elect <- mutate(elect, 
                pct = 100*votes/total)

# calculate margin of victory
margin <- elect %>% 
  group_by(position, district) %>%
  arrange(position, district, -desc(pct)) %>%
  mutate_if(is.numeric,funs(. - lag(., default=0))) %>%
  summarise_if(is.numeric, tail, 1) %>% select(position, district, votes, pct)
margin <- rename(margin, "votemargin"="votes", "pctmargin"="pct")

elect <- left_join(elect, margin, by = c("position", "district"))

# add number of candidates
ncan <- elect %>% 
  group_by(position, district, year) %>%
  count()
ncan <- rename(ncan, "n_can"="n")
elect <- left_join(elect, ncan, by = c("position", "district", "year"))

# add number of candidates by party
elect$party <- ifelse(elect$party=="GRN" | elect$party=="LBT", "OTHER", elect$party)
npty <- elect %>% 
  group_by(position, district, party, year) %>%
  count()
npty <- spread(npty, party, n)
names(npty) <- c("position", "district", "year","n_dem", "n_nopty", "n_other", "n_rep")
npty <- select(npty, position, district, year, n_dem, n_rep, n_nopty, n_other)
elect <- left_join(elect, npty, by =  c("position", "district", "year"))

# coerce NAs to 0s
elect$n_dem <- ifelse(is.na(elect$n_dem), 0, elect$n_dem)
elect$n_rep <- ifelse(is.na(elect$n_rep), 0, elect$n_rep)
elect$n_nopty <- ifelse(is.na(elect$n_nopty), 0, elect$n_nopty)
elect$n_other <- ifelse(is.na(elect$n_other), 0, elect$n_other)

gen <- select(la, office, genoffice)
gen <- rename(gen, "position"="office")
gen <- filter(gen, !duplicated(gen$position))

elect <- left_join(elect, gen , by = "position")

# ..................................................................................................

# USEFUL OBJECTS

# la - complete cleaned list of elected officials 
# elect -  election results

# ..................................................................................................

write.csv(la, "la-officials-clean.csv")
write.csv(elect, "la-results-clean.csv")

save.image("LA.Rdata")





           