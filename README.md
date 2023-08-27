# How can a Wellness Technology Company play it smart?
## Capstone Project from Google Data Analytics Professional Certificate course

## Introduction:
Bellabeat is a high-tech manufacturer of health-focused products for women. It is a successful small company, but has the potential to become a larger player in the global smart device market. Urška Sršen, cofounder and Chief Creative Officer of Bellabeat, believes that analyzing smart fitness device data could help unlock new growth opportunities for the company. In this project I'll analyze smart device usage data from non-Bellabeat products to gain insights on how people are using these smart devices and then selecting a Bellabeat product to apply these insights to create high level recommendations for Bellabeat marketing strategy.

## Methodologies used:
1. Exploratory Data Analysis
2. Descriptive Statistics
3. Data Visualization

# Phase-1 ASK

## Key stakeholders:

* *Urška Sršen:* Bellabeat’s cofounder and Chief Creative Officer
* *Sando Mur:* Mathematician and Bellabeat’s cofounder; key member of the Bellabeat executive team
* *Bellabeat marketing analytics team:* A team of data analysts responsible for collecting, analyzing, and reporting data that helps guide Bellabeat’s marketing strategy. You joined this team six months ago and have been busy learning about Bellabeat’’s mission and business goals — as well as how you, as a junior data analyst, can help Bellabeat achieve them.

## Products: 

* *Bellabeat app:* The Bellabeat app provides users with health data related to their activity, sleep, stress, menstrual cycle, and mindfulness habits. This data can help users better understand their current habits and make healthy decisions. The Bellabeat app connects to their line of smart wellness products.
  
* *Leaf:* Bellabeat’s classic wellness tracker can be worn as a bracelet, necklace, or clip. The Leaf tracker connects to the Bellabeat app to track activity, sleep, and stress.
  
* *Time:* This wellness watch combines the timeless look of a classic timepiece with smart technology to track user activity, sleep, and stress. The Time watch connects to the Bellabeat app to provide you with insights into your daily wellness.
  
* *Spring:* This is a water bottle that tracks daily water intake using smart technology to ensure that you are appropriately hydrated throughout the day. The Spring bottle connects to the Bellabeat app to track your hydration levels.
  
* *Bellabeat membership:* Bellabeat also offers a subscription-based membership program for users. Membership gives users 24/7 access to fully personalized guidance on nutrition, activity, sleep, health and
beauty, and mindfulness based on their lifestyle and goals.

## Statement of the Business task:
Analyze smart device usage data from non-Bellabeat products to gain insights on how people are using these smart devices and then selecting a Bellabeat product to apply these insights to create high level recommendations for Bellabeat marketing strategy.

## Deliverables:
Produce a report with the following deliverables:
1. A clear summary of the business task
2. A description of all data sources used
3. Documentation of any cleaning or manipulation of data
4. A summary of the analysis
5. Supporting visualizations and key findings
6. High-level content recommendations based on the analysis

For this project I'll focus on the Bellabeat app. We want to know how FitBit users use FitBit to keep a track of their health. The data provided here may help us find the answer to the following questions:
1. What are some trends in smart device usage?
2. How could these trends apply to Bellabeat customers?
3. How could these trends help influence Bellabeat marketing strategy?

# Phase-2 PREPARE
## Dataset used:
[FitBit Fitness Tracker Data](https://www.kaggle.com/datasets/arashnic/fitbit) from Kaggle is the primary source for this project. It consists of 18 files that contain various information metrics based on which we can provide recommendation to the BellaBeat stakeholders.

For this project I'll be using only 2 files and later merge them to create one file to work upon-
* dailyActivity_merged.csv
* sleepDay_merged.csv

I use the R0CCC method to check the integrity and reliability of the data.

1. **Reliability**:  
   The data set used for this project is provided in Kaggle. It contains personal fitness tracker data from 30 fitbit users. There is no information about the age, gender, profession, accuracy or bias during collection.

2. **Originality**:
   This data was collected by Amazon Turk between 12/03/2016 - 12/05/2016 and has been preprocessed and uploaded by Kaggle User Mobius. The data set is licensed under Creative Commons which claims no copyright of the data and allows copy, modification and performing work,even for commercial purposes, all without asking permission. Since the data was collected from third party, the originality cannot be vented.

3. **Comprehensiveness**:
   30 eligible FitBit users consented in submission of their health tracker data, that includes minute-level output for physical activity, heart rate, sleep monitoring. However, the dataset contains many limitations:
   * There's no information about the person's age, gender, height, weight, profession etc, that helps us identify patterns of activity of individual users. We are not sure if the sample is representative of the population as a whole.
   * There is no information about the unit of distance.
   * There are no information about intensity, its unit and how it is measured.
   * There are inconsistencies in logged data, not all 30 users have data for full 30 days.
   * The data contains 1440 minutes of sedentary minutes which is equivalent to a day, indicating that they were not wearing the tracker throughout the day.
   * The data contains informations from March to May. Since the data spreads for both April and May, there are participants with 31 days of data, making the time-frame for data analysis inconsistent.

4. **Citation**:
   Furberg, R., Brinton, J., Keating, M., & Ortiz, A. (2016). Crowd-sourced Fitbit datasets 03.12.2016-05.12.2016 [Data set]. Zenodo. https://doi.org/10.5281/zenodo.53894

5. **Current**:
   This data was collected from 12/03/2016 to 12/05/2016, which indicates that the data is quite outdated. It decreases the data's usability. 

# Phase-3 PROCESS
1. Choosing the tools:
   For data processing and cleaning I'm using R programming language and RStudio as IDE. 

2. Checking the data for errors:
   1. After importing the files, saved them in different dataframes namely activity and hourly_sleep
   2. Checked their datatypes using spec() function.
   3. Checked for null values. There was none.
   4. checked for duplicates, and removed 3 duplicate entries from hourly_sleep dataset. 

3. Transforming the data to work with it effectively:
   1. Changed the column names for more consistent and cleaner names usinf clean_names() function from janitor package. It changed the CamelCase names to lower_snake_case names.
   2. Changed the Date
   3. Merged the two datasets into one daily_activity_sleep 
   
4. Document the cleaning process.





# Phase-4 ANALYSIS
In this phase of data analysis process we're going to-

* Aggregate the data so it’s useful and accessible.
* Organize and format the data.
* Perform calculations.
* Identify trends and relationships.

# Phase 5 SHARE

## Summary of the analysis:

Since the dataset of FitBit Fitness Tracker users is rather small, I would recommend the keystakeholders to do further analysis with a bigger dataset to clearly find the patterns and user trends and take data driven decision.

But from this small sample size dataset we can still get some insights.The Bellabeat app can consider the following matrices to provide accurate informations about the daily activities of the users:

* Daily total steps
* Daily calories burned
* Daily active minutes
* Daily sedentary minutes
* Duration of sleeping (light, normal or over sleep)

As these variables are closely related to each other, one factor affects the others. Using the informations from those matrices the Bellabeat app can further give information about user's weight, heartrate, cholesterol level, and suggest healthy eating habits, recommed physical practices and back up their claims by providing scientific facts.


# Phase 6 : ACT

Some recommendation for the Bellabeat app:

* According to the CDC research taking 8,000 steps per day was associated with a 51% lower risk for all-cause mortality (or death from all causes). Taking 12,000 steps per day was associated with a 65% lower risk compared with taking 4,000 steps. But in our analysis, in case of lightly active and sedentary users it is very low(~6800 & ~2800 respectively). The Bellabeat app can remind the users to take at least 8000 steps explaining the benefits for their health.

* As users do more physical activity, they burn more calories, which in turn helps them lose more weight. In addition to giving daily updates on calorie burning, Bellabeat can suggest some ideas for low-calorie intakes.

* If users want to improve their sleep, Bellabeat should consider using app notifications to go to bed and notify them if they've had enough sleep or if they overslept.

* The Bellabeat app can notify the users when they're sitting(sedentary time) for more than that is healthy, and remind them to do some light activity like, taking a stroll outside, or stretching up a bit etc.

* When a user does the recommended activities, the Bellabeat app can show motivational messages and reward them. That way the users will then be encouraged and they'll continue to do the hard work.
