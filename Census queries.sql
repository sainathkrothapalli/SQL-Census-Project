# COLUMNS MEANING
# SEX RATION: NUMBER OF FEMALES PER 1000 MALES
# GROWTH RATE: RATE OF CHANGE OF POPULATION OVER A PERIOD (DECADE)  

# Overview of data
Select *from project.census;

# Records count
select count(*) as "Number of records" from project.census;

#Telugu states data
select * from project.census where upper(state) in ('ANDHRA PRADESH');

# Telugu states no of districts
select count(*) as "Number of districts" from project.census where upper(state) in ('ANDHRA PRADESH');

# Telugu states lowest and highest literacy rates
select district,literacy as "Max literacy district" from project.census where upper(state) in ('ANDHRA PRADESH') and literacy in (
select max(literacy) from project.census where upper(state) in ('ANDHRA PRADESH'));
select district,literacy as "Min literacy district" from project.census where upper(state) in ('ANDHRA PRADESH') and literacy in (
select min(literacy) from project.census where upper(state) in ('ANDHRA PRADESH'));

# Indias total population based on 2011 census
SET SQL_SAFE_UPDATES = 0;
update  population set population=REPLACE(population, ',', '');
commit;
alter table population modify COLUMN population INT ;
Select sum(population) as "India's Population"  from population;

# Indias Most populated states
Select state,sum(population) as "Population"  from population
group by 1 
order  by 2 desc;

# Indians top 3 most populated districts
Select district,sum(population) as "Population"  from population
group by 1 
order  by 2 desc
limit 3;

# Indians states having highest area
Select state,sum(Area_km2) as "Area"  from population
where state!='#N/A'
group by 1 
order  by 2 desc;

# Top 5 Indians districts having highest area
Select district,sum(Area_km2) as "Area"  from population
group by 1 
order  by 2 desc limit 5;

# States avg growth
update  census set growth=REPLACE(growth, '%', '');
commit;
alter table census modify COLUMN growth double ;
select state,round(avg(growth),2) as "States average growth"  from project.census
group by 1;

#State with lowest and highest Average growth
select state as "Highest growth state",round(avg(growth),2) as "States average growth"  from project.census
group by 1
order by 2 desc limit 1;
select state as "Lowest growth state",round(avg(growth),2) as "States average growth"  from project.census
group by 1
order by 2  limit 1;

# Average literacy rate by state
select state,round(avg(literacy),3) as "Average literacy"  from project.census
group by 1 ;
select state as " Highest literacy state",round(avg(literacy),3) as "Average literacy"  from project.census
group by 1 order by 2 desc limit 1;
select state as " Lowest literacy state",round(avg(literacy),3) as "Average literacy"  from project.census
group by 1 order by 2 limit 1;

# Top 5 highest Average literacy states
select z.* from (
select state as " Highest literacy state",round(avg(literacy),3) as "Average literacy" ,
dense_rank() over( order by round(avg(literacy),3) desc) rk
 from project.census
group by 1 ) z where z.rk<6;

# Top 5 highest Average literacy states
select z.* from (
select state as " Lowest literacy state",round(avg(literacy),3) as "Average literacy" ,
dense_rank() over( order by round(avg(literacy),3) ) rk
 from project.census
group by 1 ) z where z.rk<6;

# South indian states
select *from project.census where upper(state) in ('ANDHRA PRADESH','KERALA','TAMIL NADU','KARNATAKA');

# South india states Average literacy rate
select state as " SOUTH INDIAN state",round(avg(literacy),3) as "Average literacy"  from project.census
where upper(state) in ('ANDHRA PRADESH','KERALA','TAMIL NADU','KARNATAKA')
group by 1 order by 2 ;

# South india highest literacy state
select state as " Highest literacy sOUTH INDIAN state",round(avg(literacy),3) as "Average literacy"  from project.census
where upper(state) in ('ANDHRA PRADESH','KERALA','TAMIL NADU','KARNATAKA')
group by 1 order by 2 desc limit 1;

# South india lowest literacy state
select state as " Lowest literacy sOUTH INDIAN state",round(avg(literacy),3) as "Average literacy"  from project.census
where upper(state) in ('ANDHRA PRADESH','KERALA','TAMIL NADU','KARNATAKA')
group by 1 order by 2  limit 1;

# Sounth indian states highest population
select state, sum(population) as "population" from project.population
where upper(state) in ('ANDHRA PRADESH','KERALA','TAMIL NADU','KARNATAKA')
group by 1 order by 2 desc limit 1 ;

# Top 5 Sounth indian district highest population
select district, sum(population) as "population" from project.population
where upper(state) in ('ANDHRA PRADESH','KERALA','TAMIL NADU','KARNATAKA')
group by 1 order by 2 desc limit 5 ;

# Sounth indian states highest area
select state, sum(Area_km2) as "Area" from project.population
where upper(state) in ('ANDHRA PRADESH','KERALA','TAMIL NADU','KARNATAKA')
group by 1 order by 2 desc limit 1 ;

# Sounth indian districts highest area
select district, sum(Area_km2) as "Area" from project.population
where upper(state) in ('ANDHRA PRADESH','KERALA','TAMIL NADU','KARNATAKA')
group by 1 order by 2 desc limit 5 ;

# Indias average sex ration
select avg(sex_ratio) as "India's average sex ration"  from census;

# top 10 Indian states average sex ration
select state,avg(sex_ratio) as "Average sex ration"  from census
group by 1
order by 2 desc limit 10;

# Least 10 Indian states average sex ration
select state,avg(sex_ratio) as "Average sex ration"  from census
group by 1
order by 2 asc limit 10;

#Top indian state with Average sex ration
select district,avg(sex_ratio) as "Average sex ration"  from census
group by 1
order by 2 desc limit 10;

# South indian states average sex ration
select avg(sex_ratio) as "Average sex ration"  from census
where upper(state) in ('ANDHRA PRADESH','KERALA','TAMIL NADU','KARNATAKA');

# Top south indian with avg sex ration
select state,avg(sex_ratio) as "Average sex ration"  from census
where upper(state) in ('ANDHRA PRADESH','KERALA','TAMIL NADU','KARNATAKA')
group by 1 order by 2 desc limit 1;

# Top 10 south indian districts with avg sex ration
select District,avg(sex_ratio) as "Average sex ration"  from census
where upper(state) in ('ANDHRA PRADESH','KERALA','TAMIL NADU','KARNATAKA')
group by 1 order by 2 desc limit 10;

# Sounth indias highest average growth rate state
select state,round(avg(growth),2) as "Average growth"  from census
where upper(state) in ('ANDHRA PRADESH','KERALA','TAMIL NADU','KARNATAKA')
group by 1 order by 2 desc ;

# Sounth indias highest average growth rate districts
select District,avg(growth) as "Average growth"  from census
where upper(state) in ('ANDHRA PRADESH','KERALA','TAMIL NADU','KARNATAKA')
group by 1 order by 2 desc limit 10;