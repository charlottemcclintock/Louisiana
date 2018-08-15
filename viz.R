
## C. McClintock 
## Data for Democracy - RunForOffice
## Summer 2018 
## Visualizations

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

load("LA.Rdata")

# ..................................................................................................

# GENDER AND ELECTED OFFICE

# GENDER BY LEVEL OF GOVERNMENT
la.b1 <- ggplot(data = la, aes(x = level)) + 
  geom_bar(aes(fill = gender), position = "fill") +
  scale_fill_manual(values = c("#ff3399", "#a6a6a6", "#0070c0")) +
  labs(title = "Elected Offices by Gender of Elected Official", 
       subtitle = "Data from the State of Louisiana, as of July 2018",
       fill = "Gender", x = "Level of Government", y = "Percent of Elected Officials") +
  scale_y_continuous(labels = percent) + 
  geom_hline(yintercept = .5, col="black", linetype=2) +
  annotate("text", x = c(1,2,3), y = c(1.04, 1.04, 1.04), 
           label = c("n = 4348","n = 224", "n = 8")) 

xtabs(~la$level + la$gender)

# GENDER BY TYPE OF POSITION
la.b1a <- ggplot(data = la, aes(x = type)) + 
  geom_bar(aes(fill = gender), position = "fill") +
  scale_fill_manual(values = c("#ff3399", "#a6a6a6", "#0070c0")) +
  labs(title = "Elected Offices by Gender of Elected Officiaal", 
       subtitle = "Data from the State of Louisiana, as of July 2018",
       fill = "Gender", x = "Type of Position", y = "Percent of Elected Officials") +
  scale_y_continuous(labels = percent) + 
  geom_hline(yintercept = .5, col="black", linetype=2) +
  annotate("text", x = c(1,2,3,4,5,6), y = c(1.04, 1.04, 1.04, 1.04, 1.04, 1.04), 
           label = c("n = 651","n = 751", "n = 1848","n = 311","n = 152", "n = 867")) 

xtabs(~la$type + la$gender)

# ..................................................................................................

# RACE AND ELECTED OFFICE

# add population measures for comparison

df <- full_join(la, pop, by = c("race", "level", "type"))
df <- mutate(df,
             level = as.factor(level),
             level = fct_relevel(level,
                              "2016 Louisiana Population", 
                              "Local", 
                              "State", 
                              "Federal"))

df <- mutate(df,
             type = as.factor(type),
             type = fct_relevel(type,
                                 "2016 Louisiana Population", 
                                 "Education",
                                 "Law Enforcement",
                                 "Local Government",
                                 "Executive", 
                                 "Legislative", 
                                 "Judicial"))

# RACE BY LEVEL OF GOVERNMENT
la.b2 <- ggplot(data = df, aes(x = level)) + 
  geom_bar(aes(fill = race), position = "fill") +
  scale_fill_manual(values = c("#09529c", "#4292c6", "#a6a6a6","#9ecae1")) +
  scale_y_continuous(labels = percent) +
  labs(title = "Elected Offices by Race of Elected Official", 
       subtitle = "Data from the State of Louisiana, as of July 2018",
       fill = "Race", x = "Level of Government", y = "Percent of Elected Officials")  + 
  geom_hline(yintercept = .626, col="black", linetype=2) + 
  geom_hline(yintercept = .678, col="black", linetype=2) +
  annotate("text", x = c(1,2,3), y = c(1.04, 1.04, 1.04), 
           label = c("n = 4348","n = 224", "n = 8")) 

xtabs(~la$race + la$level)

# RACE BY TYPE OF POSITION
la.b2a <- ggplot(data = df, aes(x = type)) + 
  geom_bar(aes(fill = race), position = "fill") +
  scale_y_continuous(labels = percent) +
  scale_fill_manual(values = c("#09529c", "#4292c6", "#a6a6a6","#9ecae1")) +
  labs(title = "Elected Offices by Race of Elected Official", 
       subtitle = "Data from the State of Louisiana, as of July 2018",
       fill = "Race", x = "Type of Position", y = "Percent of Elected Officials") + 
  geom_hline(yintercept = .626, col="black", linetype=2) + 
  geom_hline(yintercept = .678, col="black", linetype=2) +
  annotate("text", x = c(1,2,3,4,5,6), y = c(1.04, 1.04, 1.04, 1.04, 1.04, 1.04), 
           label = c("n = 651","n = 751", "n = 1848","n = 311","n = 152", "n = 867")) 

xtabs(~la$type + la$race)

# ..................................................................................................

# PARTY BY LEVEL OF GOVERNMENT
la.b3 <- ggplot(data = subset(la, !is.na(party)), aes(x = level)) + 
  geom_bar(aes(fill = party), position = "fill") +
  scale_fill_manual(values = c("#e22f2b", "#a6a6a6", "#00437a")) +
  labs(title = "Elected Offices by Party of Elected Official", 
       subtitle = "Data from the State of Louisiana, as of July 2018",
       fill = "Party", x = "Level of Government", y = "Percent of Elected Officials") +
  annotate("text", x = c(1,2,3), y = c(1.04, 1.04, 1.04), 
           label = c("n = 4348","n = 224", "n = 8"))  
  

# PARTY BY TYPE OF POSITION
la.b3a <- ggplot(data = subset(la, !is.na(party)), aes(x = type)) + 
  geom_bar(aes(fill = party), position = "fill") +
  scale_fill_manual(values = c("#e22f2b", "#a6a6a6", "#00437a")) +
  labs(title = "Elected Offices by Party of Elected Official, as of July 2018", 
       subtitle = "Data from the State of Louisiana",
       fill = "Party", x = "Type of Position", y = "Percent of Elected Officials") +
  annotate("text", x = c(1,2,3,4,5,6), y = c(1.04, 1.04, 1.04, 1.04, 1.04, 1.04), 
           label = c("n = 651","n = 751", "n = 1848","n = 311","n = 152", "n = 867")) 

# ..................................................................................................

# LAW ENFORCEMENT

# BY GENDER OF ELECTED OFFICIAL
la.b1b <- ggplot(data = enforce, aes(x = genoffice)) + 
  geom_bar(aes(fill = gender), position = "fill") +
  scale_fill_manual(values = c("#ff3399", "#a6a6a6", "#0070c0")) +
  labs(title = "Law Enforcement Offices by Gender of Elected Official", 
       subtitle = "Data from the State of Louisiana, as of July 2018",
       fill = "Gender", x = "Position", y = "Percent of Elected Officials") +
  scale_y_continuous(labels = percent) + 
  geom_hline(yintercept = .5, col="black", linetype=2) +
  annotate("text", x = c(1,2,3,4,5,6), y = c(1.04, 1.04, 1.04, 1.04, 1.04, 1.04), 
           label = c("n = 185","n = 387", "n = 362","n = 47","n = 42", "n = 64"))  

prop.table(table(enforce$gender, enforce$genoffice), margin = 2)

# BY RACE OF ELECTED OFFICIAL
la.b2b <- ggplot(data = subset(df2, !is.na(race)), aes(x = genoffice)) + 
  geom_bar(aes(fill = race), position = "fill") +
  scale_fill_manual(values = c("#09529c", "#4292c6", "#a6a6a6","#9ecae1")) +
  scale_y_continuous(labels = percent) +
  labs(title = "Law Enforcement Offices by Race of Elected Official", 
       subtitle = "Data from the State of Louisiana, as of July 2018",
       fill = "Race", x = "Position", y = "Percent of Elected Officials")  + 
  geom_hline(yintercept = .626, col="black", linetype=2) + 
  geom_hline(yintercept = .678, col="black", linetype=2) +
  annotate("text", x = c(2,3,4,5,6,7), y = c(1.04, 1.04, 1.04, 1.04, 1.04, 1.04), 
           label = c("n = 185","n = 387", "n = 362","n = 47","n = 42", "n = 64")) 

prop.table(table(enforce$race, enforce$genoffice), margin = 2)

# BY PARTY OF ELECTED OFFICIAL
la.b3b <- ggplot(data = subset(enforce, !is.na(party)), aes(x = genoffice)) + 
  geom_bar(aes(fill = party), position = "fill") +
  scale_fill_manual(values = c("#e22f2b", "#a6a6a6", "#00437a")) +
  labs(title = "Law Enforcement Offices by Party of Elected Official", 
       subtitle = "Data from the State of Louisiana, as of July 2018",
       fill = "Party", x = "Position", y = "Percent of Elected Officials")+
  annotate("text", x = c(1,2,3,4,5,6), y = c(1.04, 1.04, 1.04, 1.04, 1.04, 1.04), 
           label = c("n = 185","n = 387", "n = 362","n = 47","n = 42", "n = 64")) 

prop.table(table(enforce$party, enforce$genoffice), margin = 2)

# ..................................................................................................

# LOCAL GOVERNMENT

# BY GENDER OF ELECTED OFFICIAL
la.b1c <- ggplot(data = local, aes(x = genoffice)) + 
  geom_bar(aes(fill = gender), position = "fill") +
  scale_fill_manual(values = c("#ff3399", "#a6a6a6", "#0070c0")) +
  labs(title = "Local Government Offices by Gender of Elected Official", 
       subtitle = "Data from the State of Louisiana, as of July 2018",
       fill = "Gender", x = "Position", y = "Percent of Elected Officials") +
  scale_y_continuous(labels = percent) + 
  geom_hline(yintercept = .5, col="black", linetype=2) +
  annotate("text", x = c(1,2,3,4), y = c(1.04, 1.04, 1.04, 1.04), 
           label = c("n = 278","n = 665", "n = 21","n = 346")) 

prop.table(table(local$gender, local$genoffice), margin = 2)

# BY RACE OF ELECTED OFFICIAL
la.b2c <- ggplot(data = subset(df3, !is.na(race)), aes(x = genoffice)) + 
  geom_bar(aes(fill = race), position = "fill") +
  scale_fill_manual(values = c("#09529c", "#4292c6", "#a6a6a6","#9ecae1")) +
  scale_y_continuous(labels = percent) +
  labs(title = "Local Government Offices by Race of Elected Official", 
       subtitle = "Data from the State of Louisiana, as of July 2018",
       fill = "Race", x = "Position", y = "Percent of Elected Officials")  + 
  geom_hline(yintercept = .626, col="black", linetype=2) + 
  geom_hline(yintercept = .678, col="black", linetype=2) +
  annotate("text", x = c(2,3,4,5), y = c(1.04, 1.04, 1.04, 1.04), 
           label = c("n = 278","n = 665", "n = 21","n = 346")) 

prop.table(table(enforce$race, enforce$genoffice), margin = 2)

# BY PARTY OF ELECTED OFFICIAL
la.b3c <- ggplot(data = subset(local, !is.na(party)), aes(x = genoffice)) + 
  geom_bar(aes(fill = party), position = "fill") +
  scale_fill_manual(values = c("#e22f2b", "#a6a6a6", "#00437a")) +
  labs(title = "Local Government Offices by Party of Elected Official", 
       subtitle = "Data from the State of Louisiana, as of July 2018",
       fill = "Party", x = "Position", y = "Percent of Elected Officials") +
  annotate("text", x = c(1,2,3,4), y = c(1.04, 1.04, 1.04, 1.04), 
           label = c("n = 278","n = 665", "n = 21","n = 346")) 

prop.table(table(enforce$party, enforce$genoffice), margin = 2)

# ..................................................................................................

# URBAN RURAL DIVIDE IN MUNICIPAL GOVERNMENT

# BY GENDER
muni.b1 <- ggplot(data = subset(muni, !is.na(density)), aes(x = genoffice)) + 
  geom_bar(aes(fill = gender), position = "fill") + facet_wrap(~density) +
  scale_fill_manual(values = c("#ff3399", "#a6a6a6", "#0070c0")) +
  labs(title = "Differences in Urban & Rural Gender Representation in Local Government", 
       subtitle = "Data from the State of Louisiana, as of July 2018",
       fill = "Gender", x = "Position", y = "Percent of Elected Officials") +
  scale_y_continuous(labels = percent) + 
  geom_hline(yintercept = .5, col="black", linetype=2)

# BY RACE OF ELECTED OFFICIAL
muni.b2 <- ggplot(data = subset(df4, !is.na(race)&!is.na(density)), aes(x = genoffice)) + 
  geom_bar(aes(fill = race), position = "fill") + facet_wrap(~density) +
  scale_fill_manual(values = c("#09529c", "#4292c6", "#a6a6a6","#9ecae1")) +
  scale_y_continuous(labels = percent) +
  labs(title = "Differences in Urban & Rural Racial Representation in Local Government", 
       subtitle = "Data from the State of Louisiana, as of July 2018",
       fill = "Race", x = "Position", y = "Percent of Elected Officials") + 
  geom_hline(yintercept = .626, col="black", linetype=2) + 
  geom_hline(yintercept = .678, col="black", linetype=2)


# BY PARTY OF ELECTED OFFICIAL
muni.b3 <- ggplot(data = subset(muni, !is.na(party)&!is.na(density)), aes(x = genoffice)) + 
  geom_bar(aes(fill = party), position = "fill") + facet_wrap(~density) +
  scale_fill_manual(values = c("#e22f2b", "#a6a6a6", "#00437a")) +
  labs(title = "Local Government Offices by Party of Elected Official", 
       subtitle = "Data from the State of Louisiana, as of July 2018",
       fill = "Party", x = "Position", y = "Percent of Elected Officials") 

# ..................................................................................................

# JUDGES

j.b1 <- ggplot(data = subset(judges, !is.na(gender)), aes(x=office)) + 
  geom_bar(aes(fill = gender), position = "fill")

j.b2 <- ggplot(data = subset(judges, !is.na(race)), aes(x=office)) + 
  geom_bar(aes(fill = race), position = "fill")

j.b3 <- ggplot(data = subset(judges, !is.na(party)), aes(x=office)) + 
  geom_bar(aes(fill = party), position = "fill")

# ..................................................................................................

save.image("viz.Rdata")



















