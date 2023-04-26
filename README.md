# Overview

The Council of State Governments (CSG) Justice Center intends to illuminate parole release policies and practices in the United States and how they impact prison population sizes and lengths of stay, using data from the National Corrections Reporting Program (NCRP) from up to 45 states to:  

(1) examine trends in their parole-eligible populations;   
(2) conduct original empirical research on racial, ethnic, and gender disparities on the portion of sentences that are served in carceral settings past parole eligibility; and   
(3) conduct deep dives into selected states to shed light on parole board decision-making. For these states, we will seek to identify any disparate decision-making and associated outcomes and recommend changes to policy and practice to prevent unnecessarily long prison stays while maintaining public safety.   

While prison admissions declined dramatically in the first year of the pandemic, many parole-eligible people remained in confinement, and there are limited data on how parole boards made release decisions before or during the pandemic. Parole has an immense impact on prison populations, but no single data point exists to summarize that impact.  

The Robina Institute’s report on “degrees of indeterminacy” (Reitz et al., 2022) provides an essential framework through which we will investigate how parole boards influence the size of the prison population. Using this framework and rankings of indeterminacy, along with NCRP data, we will provide a state-by-state data visualization that allows state policymakers to understand the size and the makeup of the parole-eligible population within their states and how it is driven by their sentencing structure. The online tool will aggregate data on the characteristics of the parole-eligible population in prison (e.g., demographics, including race, ethnicity, and gender), their sentences (e.g., most serious charge type, sentence type and length, year of prison admission), and how this profile has changed over time, along with information about the state’s sentencing structure, highlighting the relationship between the two. We will also translate all of the population numbers into monetary figures to help policymakers understand the fiscal implications associated with keeping parole-eligible individuals behind bars.  

<br><br>

# Data

Data will be provided by NCRP. NCRP collects case-level administrative data annually on prison admissions and releases, year-end custody populations, and parole entries and discharges in participating jurisdictions. Demographic information, conviction offenses, sentence length, minimum time to be served, credited jail time, type of admission, type of release, and time served are collected from individual incarcerated people’s records. 

**Data Structure**
The NCRP data is reported on an individual level. So that means that each row in the data set is an individual term (term records data) or an individual person (admissions, releases, and year-end population data). This makes the data sets very long (multi-millions of observations), but relatively narrow (14-18 variables). Person-level data allows for a lot of flexibility in creating aggregate counts on specific cross-sections.  

The recent releases of the NCRP multi-year data series have 4 data sets:  

- Term Records - each row contains one record for each separate term in prison  
- Prison Admissions - each row contains one record for each admission to prison  
- Prison Releases - each row contains one record for each release from prison   
- Year-end Population - each row contains one record for each prisoner in custody on Dec 31 of each year  

An individual person may have more than one record in each of the data sets.

<br><br>

# Final Products

To create a one-of-a-kind data tool (Shiny vs Netlify) and to conduct original research that helps states understand the power of parole boards and the potential lack of equity in the parole-granting process.   

Will include state by state trends on the number of people who are incarcerated and parole eligible, by the following:  
- Admission type and top charge  
- Sentence and length of stay  
- Race and gender   
- Sentencing structures identified in the Robina report  

<br><br>

# Background

Parole boards play a critical role in determining the number of people on parole supervision nationally as well as the length of time served in prison for the 34 states with discretionary parole. While much attention is focused on the role of prosecutors and sentencing policies in driving incarceration trends, in many states, it is the parole board’s discretion that determines how long most people will remain in prison and how much the state will spend on incarceration.  

Understanding how and why individuals who are parole eligible remain incarcerated is a complex undertaking because parole decisions are influenced by a combination of factors including sentencing structure, parole board norms, and an individual’s behavior during incarceration, among other things.   

The Robina Institute (with support from Arnold Ventures) has just completed a seminal review of the degrees of indeterminacy in state systems, i.e., the “unpredictability of time served” (Reitz et al., 2022). They found that the predictability of individual prison sentences varied greatly by state and that back-end (e.g., corrections and parole) release decisions are more influential in some states than others. Higher degrees of “indeterminancy” raise questions about the quality and fairness of prison release decisions and whether states have adequate procedural safeguards in place to examine whether decisions are fair in practice.  

However, the Robina study did not explicitly explore how sentencing structures influence prison popuation sizes. In fact, one of their recommendations was to conduct research on the relationship between varying degrees of indetermiancy and prison size. And the report does not tell us how much variation there is in time served behind bars for people who received the same sentence. To understand the actual impact (beyond the “potential impact”), we must examine three things: (1) who is going in front of the parole board and at what time intervals, (2) the outcomes of parole board hearings, and (3) the size of the parole-eligible population that remains behind bars.    
