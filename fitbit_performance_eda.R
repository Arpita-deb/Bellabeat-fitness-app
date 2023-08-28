# Loading the libraries
library(tidyverse)
library(lubridate)
library(janitor)
library(corrplot)
library(ggcorrplot)

# Importing the data sets
activity <- read_csv("dailyActivity_merged.csv")
hourly_sleep <- read_csv("sleepDay_merged.csv")

View(activity)
View(hourly_sleep)

# Checking the datatypes
spec(activity)
spec(hourly_sleep)

# Looking for null values
sum(is.na(activity))
sum(is.na(hourly_sleep))

# Checking column wise for null values
colSums(is.na(activity))
colSums(is.na(hourly_sleep))

# Looking for Duplicates
sum(duplicated(activity))                     # Checking for duplicates

sum(duplicated(hourly_sleep))                 # There are 3 duplicates

hourly_sleep <- hourly_sleep %>% distinct()   # Selecting only the distinct value 

sum(duplicated(hourly_sleep))                 # Checking again for duplicates, there's none

# Clean and Consistent names
activity <- activity %>% clean_names()        # clean_names() from Janitor package changes the column names into lower snake case
head(activity)
hourly_sleep <- hourly_sleep %>% clean_names()
head(hourly_sleep)

# making a copy of the data sets
activity_df <- data.frame(activity)
sleep_df <- data.frame(hourly_sleep)

# Merging Data sets

daily_activity_sleep <- merge(activity, hourly_sleep, by=c("id")) 
head(daily_activity_sleep)

# Selecting the required columns only

daily_activity_sleep <- daily_activity_sleep %>%  
                        select(id,
                               activity_date,
                               total_steps,
                               total_distance,
                               very_active_minutes,
                               fairly_active_minutes,
                               lightly_active_minutes,
                               sedentary_minutes,
                               calories,
                               sleep_day,
                               total_sleep_records,
                               total_minutes_asleep, 
                               total_time_in_bed 
                        )

# Exploratory Data Analysis

# Number of distinct users for each data set 
n_distinct(activity$id)                     # There are 33 unique users in activity data set
n_distinct(hourly_sleep$id)                 # There are 24 unique users in activity data set

# Statistical summary
daily_activity_sleep %>% summary()          # Gives the general statistics such as mean, median, max, min values

# Histograms
# Gives idea about the distribution of the values for different attributes

hist(daily_activity_sleep$calories,
     breaks=10,
     main='Histogram of Calories',
     xlab='Calories',
     col='orange'
     )

hist(daily_activity_sleep$total_steps,
     breaks=20,
     main='Histogram of daily total steps ',
     xlab='Total Steps',
     col='coral')

hist(daily_activity_sleep$very_active_minutes,
     breaks=20,
     main='Histogram of very active minutes ',
     xlab='Very Active Minutes',
     col='orange')

hist(daily_activity_sleep$sedentary_minutes,breaks=20,
     main='Histogram of sedentary minutes',
     xlab='Sedentary Minutes',
     col='coral')

hist(daily_activity_sleep$total_minutes_asleep,
     breaks=20,
     main='Histogram of total minutes asleep ',
     xlab='Total minutes asleep',
     col='orange')

hist(daily_activity_sleep$total_time_in_bed,
     breaks=15,
     main='Histogram of total minutes in bed',
     xlab='Total minutes in bed',
     col='coral')


# Correlation matrix
# Helps us understand the strength of relation between various variables

df <- daily_activity_sleep %>% select(total_steps,                 # Selecting only the numerical columns we are interested in
                                      total_distance,
                                      very_active_minutes,
                                      fairly_active_minutes,
                                      lightly_active_minutes,
                                      sedentary_minutes,
                                      calories,
                                      total_sleep_records,
                                      total_minutes_asleep, 
                                      total_time_in_bed)

# cor() function returns a correlation data frame rather than a matrix

r <- cor(df,use="complete.obs")            # complete.obs means taking account of all observations                             

round(r,2)                                 # rounding off the correlation strength upto 2 decimal points

ggcorrplot(r, title='Correlation Matrix')  # plotting the correlation matrix


# The correlation matrix gives us many information about the relations between the variables. 
# It's clear from the correlation matrix, calories burned is positively correlated with-
# 1. total steps taken 2. total distance traveled  and 3.active minutes 

# Finding out correlation strengths between calories burned and total steps taken
cor(daily_activity_sleep$total_steps, daily_activity_sleep$calories)            # 0.4462722

# Finding out correlation strengths between calories burned and total distance traveled
cor(daily_activity_sleep$total_distance, daily_activity_sleep$calories)         # 0.5506964

# Finding out correlation strengths between calories burned and active minutes 
cor(daily_activity_sleep$very_active_minutes, daily_activity_sleep$calories)    # 0.6218306


# Scatter plot for Calories burned Vs daily total steps taken 

ggplot(daily_activity_sleep, aes(x=total_steps, y=calories)) +
  geom_jitter(alpha=0.3, size=2.3) + 
  geom_smooth(color='orange') +
  labs(title='Calories burned Vs Daily Total steps',
       subtitle = 'Relation between daily total steps taken and calories burned',
       caption='Source: FitBit Fitness Tracker Data') +
  xlab('Daily Total steps') +
  ylab('Calories') +
  theme(panel.background = element_blank(), plot.title = element_text( size=16))


# Scatter plot for Calories burned Vs very active minutes 

ggplot(daily_activity_sleep, aes(x=very_active_minutes, y=calories)) +
  geom_jitter(alpha=0.3, size=2.3) + 
  geom_smooth(color='orange') +
  labs(title='Calories burned Vs Very active minutes',
       subtitle = 'Relation between active minutes of physical exercise and calories burned',
       caption='Source: FitBit Fitness Tracker Data') +
  xlab('Very active minutes') +
  ylab('Calories') +
  theme(panel.background = element_blank(), plot.title = element_text( size=16))


# Scatter plot for Calories burned Vs daily total distance walked

ggplot(daily_activity_sleep, aes(x=total_distance, y=calories)) +
  geom_jitter(alpha=0.3, size=2.3) + 
  geom_smooth(color='orange') +
  labs(title='Calories burned Vs Total distance',
       subtitle = 'Relation between total distance walked and calories burned',
       caption='Source: FitBit Fitness Tracker Data') +
  xlab(' Daily Total Distance') +
  ylab('Calories') +
  theme(panel.background = element_blank(), plot.title = element_text( size=16))


# Statistical summary according to four user types

# Creating a data frame with mean values from daily_activity_sleep data set grouped by individual users (id)

daily_average <- daily_activity_sleep %>%
  group_by(id) %>%                                   # to get unique values for each fitbit user
  summarise (mean_daily_steps = mean(total_steps), 
             mean_daily_calories = mean(calories), 
             mean_daily_sleep = mean(total_minutes_asleep),
             mean_time_in_bed= mean(total_time_in_bed),
             mean_very_active_min=mean(very_active_minutes),
             mean_fairly_active_min=mean(fairly_active_minutes),
             mean_lightly_active_min=mean(lightly_active_minutes),
             mean_sedentary_min=mean(sedentary_minutes) 
             )

# Creating a new data frame that divides the above data frame into 4 groups based on their total daily steps taken 

user_type <- daily_average %>%
  mutate(user_type = case_when(                                              # adds a column user type in the daily_average data frame
    mean_daily_steps < 5000 ~ "sedentary",
    mean_daily_steps >= 5000 & mean_daily_steps < 7499 ~ "lightly active", 
    mean_daily_steps >= 7500 & mean_daily_steps < 9999 ~ "fairly active", 
    mean_daily_steps >= 10000 ~ "very active"))

# Grouping the user_type data frame by user_type and getting the statistics for each user type

average_stats <- user_type%>%
                  group_by(user_type)%>%                                      
                  summarise(count_of_users=n(),
                  average_total_steps=sum(mean_daily_steps)/count_of_users,
                  average_calories=sum(mean_daily_calories)/count_of_users,
                  average_sleep_minutes=sum(mean_daily_sleep)/count_of_users,
                  average_very_active_min=sum(mean_very_active_min)/count_of_users,
                  average_fairly_active_min=sum(mean_fairly_active_min)/count_of_users,
                  average_lightly_active_min=sum(mean_lightly_active_min)/count_of_users,
                  average_sedentary_min=sum(mean_sedentary_min)/count_of_users)

# Plotting a bar chart for Avearage daily steps by User type

ggplot(average_stats,aes(x=user_type, y=average_total_steps)) +
  geom_col(width=0.6, fill='gold1') +
  labs(title="Average daily steps Vs User type", 
       subtitle='Showing the average daily steps taken by each user type',
       caption='Source: FitBit Fitness Tracker Data') + 
  xlab("User type") + 
  ylab("Mean daily steps") +
  theme(panel.background = element_blank(),plot.title = element_text( size=16),text= element_text(size=12))

# Plotting a bar chart for Average calories burned by User type

ggplot(average_stats,aes(x=user_type, y=average_calories)) +
  geom_col(width=0.6, fill='orange') +
  labs(title="Average calories burned Vs User type",
       subtitle='Showing the average calories burned by each user type',
       caption='Source: FitBit Fitness Tracker Data') + 
  xlab("User type") + 
  ylab("Mean calories") +
  theme(panel.background = element_blank(),plot.title = element_text( size=16), text= element_text(size=12))

# Plotting a bar chart for Average sleeping time (in minutes) by User type

ggplot(average_stats,aes(x=user_type, y=average_sleep_minutes)) +
  geom_col(width=0.6, fill='coral') +
  labs(title="Average sleeping time (in minutes) Vs User type",
       subtitle='Showing the average sleeping time for each user type',
       caption='Source: FitBit Fitness Tracker Data') + 
  xlab("User type") + 
  ylab("Mean Sleep Time (in minutes)")+
  theme(panel.background = element_blank(),plot.title = element_text( size=16),text= element_text(size=12))


# Finding Sleeping pattern among the users
# Creating a new data frame that divides the users into 3 groups based on their sleeping time

sleep_type <- user_type %>%
  mutate(sleep_type=case_when(
    (mean_daily_sleep) <= 360.00 ~ "Bad Sleep",
    (mean_daily_sleep) > 360.00 & (mean_daily_sleep) <= 480.00 ~ "Normal Sleep",
    (mean_daily_sleep) > 480.00 ~ "Over Sleep"))


sleepers<- sleep_type %>%   
    group_by(user_type) %>%
    summarise(total=n(),
              bad_sleepers = sum(sleep_type == "Bad Sleep"), 
              normal_sleepers = sum(sleep_type == "Normal Sleep"),
              over_sleepers = sum(sleep_type == "Over Sleep"))

# Bar plot showing sleeper types

ggplot(sleep_type, aes(x=sleep_type))+
  geom_bar(fill='gold1') +
  labs(title='Sleeping Type', subtitle='Shows the number of users in each category', caption='Source: FitBit Fitness Tracker Data')+
  xlab('Sleep Type') +
  ylab('Number of Users')+
  theme(panel.background = element_blank(),plot.title = element_text( size=16),text= element_text(size=12))
