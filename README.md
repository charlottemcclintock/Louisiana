# RunForOffice: Louisiana
#### A Project of RunforOffice & DataforDemocracy 

The aim of this project is to explore diversity and inclusion at all levels of government, investigating representation across demographics including race, gender, and age, and the demographic impact on state and local politics across the United States. The initial focus is Louisiana, but the eventual goal is to expand the project to every state.

# Data Sources

* Population parameters *from the Census Bureau*
    +  Racial demographics of the state of Louisiana from the 2016 5-Year American Community Survey, retrieved through [SocialExplorer](https://www.socialexplorer.com/tables/ACS2016_5yr/R11751646).
    +  Population of cities and towns retrieved from [American FactFinder](https://factfinder.census.gov/faces/tableservices/jsf/pages/productview.xhtml)
* Race, party, gender, and position of elected officials *from WHERE?*
    + 
* Age and address of elected officials *from Louisiana Secretary of State Voter File*
    + Retrieved from [the Louisiana Secretary of State](https://www.sos.la.gov/ElectionsAndVoting/BecomeACandidate/PurchaseVoterLists/Pages/default.aspx).
  
# Code & Scripts 

To view the code for this project, click [here](https://www.github.com/charlottemcclintock/LouisianaGov).

# Decision Points

#### Race Categorizations

The `ethnicity` factor was recoded to "White", "Black or African-American", and "Other". This decision was made taking into consideration two points:

  1) Races other than Black or White make up 5.2% of the Louisiana population, and consistently less than 5% of the data. Taking all of those groups together makes it easier to discern their collective status, relative to miniscule individual populations.
  
  2) There was some uncertainty surrounding the ethnicity classifications other than "W" and "B", and there was not adequate time to investigate the issue. 
