# RunForOffice: Louisiana
#### A Project of RunforOffice & DataforDemocracy 

We want to do basic analysis and visualization work using open public data including state lists of elected officials, census data from the American Community Survey, and state voter files so that we can see where the imbalances are for representation across dimensions including gender, race, age, economic status, educational background, so that our government can better reflect and represent our citizens. To view the code for this project, click [here](https://github.com/RunForOffice/Louisiana).

#### Thanks to: 
##### Jake Johnson *for wrangling the election results data to a usable format*
##### Stephen Gardner *for the parish breakdowns*

## Next Steps

1. Join the elections results with the elected officials data to explore margin of victory and number of candidates across different dimensions of government.
2. Match state house districts with census data to compare representation to the local population.

## Want to help? 

Check out `la-officials-clean.csv` and `la-results-clean.csv` in the data folder and see if you can find any interesting insights into representation in Louisiana! The work so far is available [here](https://runforoffice.github.io/doc.html). 
  
## Code & Scripts 

   * `clean.R` cleans the data and produces useful objects that are used in the visualizations
      + `la-officials-clean.csv` is a complete list of elected officials
      + `la-results-clean.csv` is a list of candidates and vote totals for all Louisiana races in 2014 and 2016
   * `clean-elections.R` cleans the election results data 
   * `doc.Rmd` produces an HTML file of the visualizations and current analysis
   

# Data Sources

* Population parameters *from the Census Bureau*
    +  Racial demographics of the state of Louisiana from the 2016 5-Year American Community Survey, retrieved through [SocialExplorer](https://www.socialexplorer.com/tables/ACS2016_5yr/R11751646).
    +  Population of cities and towns retrieved from [American FactFinder](https://factfinder.census.gov/faces/tableservices/jsf/pages/productview.xhtml)
* Race, party, gender, and position of elected officials *from Louisiana Secretary of State*
    + Retrieved from [the Louisiana Secretary of State](https://www.sos.la.gov/ElectionsAndVoting/BecomeACandidate/PurchaseVoterLists/Pages/default.aspx)
  
# Decision Points

#### Race Categorizations

The `ethnicity` factor was recoded to "White", "Black or African-American", and "Other". This decision was made taking into consideration two points:

  1) Races other than Black or White make up 5.2% of the Louisiana population, and consistently less than 5% of the data. Taking all of those groups together makes it easier to discern their collective status, relative to small individual populations.
  
  2) There was some uncertainty surrounding the ethnicity classifications other than "W" and "B", and there was not adequate time to investigate the issue. 

