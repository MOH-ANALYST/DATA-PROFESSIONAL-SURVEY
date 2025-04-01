#data gotten from data professional survey carried out by alex the analyst team containing about 630 respondant 
select count(*) as row_total
from data_professional_survey ;


select  *
from data_professional_survey;

# CREATE A NEW TABLE SO I CAN ALWAYS HAVE MY ORIGINAL TO LOOK AT  
create table DSP
select  *
from data_professional_survey;

# JUST CHECKING ALL OF THE COLUMN TO SEE IF ITS ALL STANDARIZE AND CAN BE USED FOR QUERY

 select *
 from dsp;

select distinct `Current Role`
from dsp;

select distinct Industry
from dsp; 

select distinct country
from dsp;


# lets query the data set before visulizing
/*count of some of our column (current role,country,educaion level) */
select `current role`, count(*) as respondant_count
from dsp
group by `Current Role`
order by 2 desc;
 
 
select country, count(*) as respondant_count
from dsp
group by country
order by 2 desc;
 
select `Education level` ,count(*) as respondant_count
from dsp
group by `Education level`
order by 2 desc;


# average happiness rating for(Learning New Things,Upward Mobility,Management, Coworkers)
select avg(`Happiness Rating (Work/Life Balance)`) 
from dsp;


select avg(`Happiness Rating (Coworkers)`) 
from dsp;


select avg(`Happiness Rating (Management)`) 
from dsp;


select avg(`Happiness Rating(salary)`)
from dsp;

select avg(`Happiness Rating (Upward Mobility)`) 
from dsp;
 
 # avg age in industries 
select industry ,avg(age)
from dsp
group by industry
order by 2;



# just checking how many people like a specific type of programming language then later i wanted to see which role selected it (more like a drop dow in powerBI)
select `Favorite Programming Language`,`Current Role`,count(*)
from dsp
group by `Favorite Programming Language`,`Current Role`
order by 3 desc
limit 5 ;

/* i want to replacethe column as im finding it very difficult to query with
i'll return it back after for visualization or if its feels good and looks beter ill just leave it 
come with me as i RENAME MY COLUMN  */

#CHECKING IF ITS ON AUTO SAVE
 SELECT @@AUTOCOMMIT ;
 
 
 
 ALTER TABLE dsp RENAME column `Date Taken (America/New_York)` to date_taken ;
  ALTER TABLE dsp RENAME column `Time Taken (America/New_York)` to time_taken ;
   ALTER TABLE dsp RENAME column `Current Role` to current_role ;
    ALTER TABLE dsp RENAME column `Did you switch careers into Data?` to switch_careers ;
     ALTER TABLE dsp RENAME column `Current Salary / YEAR(USD)`to salary ;
      ALTER TABLE dsp RENAME column `Favorite Programming Language` to programming_langugage ;
       ALTER TABLE dsp RENAME column `Happiness Rating(salary)` to salary_rating ;
        ALTER TABLE dsp RENAME column `Happiness Rating (Work/Life Balance)` to work_life_balance ;
         ALTER TABLE dsp RENAME column `Happiness Rating (Coworkers)`to co_workers;
          ALTER TABLE dsp RENAME column `Happiness Rating (Management)` to management;
           ALTER TABLE dsp RENAME column `Happiness Rating (Upward Mobility)` to upward_mobility;
            ALTER TABLE dsp RENAME column `Happiness Rating (Learning New Things)` to learning_new_things;
             ALTER TABLE dsp RENAME column `most important thing when taking a new job` to job_deal_breaker;
              ALTER TABLE dsp RENAME column `AVG(salary in USD)K` to avg_salary;
              alter table dsp RENAME column `Unique ID` to unique_Id;
              
              # checking the happiness rating in the management
              select industry,avg(management) 
              from dsp
              group by industry 
              order by 2  desc;
 # seems like the healthcare industry management system is all good , followed by real estate .
 
 
 # how many people changed career to data
 select switch_careers,count(*)
 from dsp
 group by switch_careers;
  # so a lot of people switched careers from our survey 
  
  #how many people switched careers to data per industry
 select distinct industry, switch_careers,count(*) as respondant
 from dsp
 group by switch_careers,Industry
 order by 1 ;
 


alter table dsp rename column `Time Spent`to time_spent;

#okay i need to change the time to sec first before i can get the avg of total spent on each survey

select time_spent,
time_to_sec(time_spent)
from dsp;

select avg(time_to_sec(time_spent))  as avg_time_spent
 , avg(time_to_sec(time_taken)) as avg_time_taken,
 (avg(time_to_sec(time_spent)))/60 - ( avg(time_to_sec(time_taken))) /60
 as time_spent_on_avg
from dsp ;
# i dont understand why on aveerage they spend 4hours by thats what the data is 
  
  
  select job_deal_breaker, count(*)
  from dsp
  group by job_deal_breaker;
  
  # need to clean this job_deal_breaker
  
  update dsp 
  set job_deal_breaker = "other"
  where job_deal_breaker like "Other (Please Specify)%";
  
  
  #cleaned data(a better data)
    select job_deal_breaker, count(*) as respondant
  from dsp
  group by job_deal_breaker
  order by 2 desc;
  #according to the data a lot of peoplein the survey want a better salary for a new job 
  