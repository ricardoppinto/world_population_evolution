/*Importing and preparing the data*/


-- Creating table and importing the main dataset to PostgreSQL

CREATE TABLE demographic_Indicators (
	ISO3 VARCHAR(3),
	location VARCHAR(100),
	year VARCHAR(4),
	total_population DECIMAL,
	sex_ratio DECIMAL,
	median_age DECIMAL,
	natural_change_rate DECIMAL,
	crude_birth_rate DECIMAL,
	fertility_rate DECIMAL,
	childbearing_median_age DECIMAL,
	crude_death_rate DECIMAL,
	life_expectancy DECIMAL,
	infant_mortality_rate DECIMAL

)

COPY demographic_Indicators(
	ISO3,
	location,
	year,
	total_population,
	sex_ratio,
	median_age,
	natural_change_rate,
	crude_birth_rate,
	fertility_rate,
	childbearing_median_age,
	crude_death_rate,
	life_expectancy,
	infant_mortality_rate
)

FROM 
	'C:\Users\35192\Desktop\Project World Population Evolution\Clean Data\clean_Demographic_Indicators_Data.csv'
DELIMITER ','
CSV HEADER;
	
	
	
-- Creating table and importing data on human development index
	
CREATE TABLE world_HDI (
	ISO3 VARCHAR(5),
	country VARCHAR(100),
	year VARCHAR(4),
	HDI DECIMAL
)

COPY world_HDI (
	ISO3,
	country,
	year,
	HDI
)
	
FROM 
	'C:\Users\35192\Desktop\Project World Population Evolution\Clean Data\clean_HDI_data.csv'
DELIMITER ','
CSV HEADER;



-- Creating table and importing data on adolescent birth rates

CREATE TABLE world_ABR (
	ISO3 VARCHAR(3),
	country VARCHAR(100),
	year VARCHAR(4),
	ABR DECIMAL
)

COPY world_ABR (
	ISO3,
	country,
	year,
	ABR
)
	
FROM
	'C:\Users\35192\Desktop\Project World Population Evolution\Clean Data\clean_ABR_data.csv'
DELIMITER ','
CSV HEADER;



-- Creating table and importing data on female human development index

CREATE TABLE world_female_HDI (
	ISO3 VARCHAR(3),
	country VARCHAR(100),
	year VARCHAR(4),
	female_HDI DECIMAL
)

COPY world_female_HDI (
	ISO3,
	country,
	year,
	female_HDI
)
	
FROM
	'C:\Users\35192\Desktop\Project World Population Evolution\Clean Data\clean_female_HDI_data.csv'
DELIMITER ','
CSV HEADER;



-- Creating table and importing data on male human development index

CREATE TABLE world_male_HDI (
	ISO3 VARCHAR(3),
	country VARCHAR(100),
	year VARCHAR(4),
	male_HDI DECIMAL
)

COPY world_male_HDI (
	ISO3,
	country,
	year,
	male_HDI
)
	
FROM 
	'C:\Users\35192\Desktop\Project World Population Evolution\Clean Data\clean_male_HDI_data.csv'
DELIMITER ','
CSV HEADER;



-- Creating table and importing data on gender inequality index

CREATE TABLE world_GII (
	ISO3 VARCHAR(50),
	country VARCHAR(60),
	year VARCHAR(50),
	GII DECIMAL
	)

COPY world_GII (
	ISO3,
	country,
	year,
	GII
	)
	
FROM 
	'C:\Users\35192\Desktop\Project World Population Evolution\Clean Data\clean_GII_data.csv'
DELIMITER ','
CSV HEADER;



-- Joining all the the previous tables together

SELECT 
	demographic_indicators.iso3,
	location,
	demographic_indicators.year,
	total_population,
	sex_ratio,
	median_age,
	natural_change_rate,
	crude_birth_rate,
	fertility_rate,
	childbearing_median_age,
	crude_death_rate,
	life_expectancy,
	infant_mortality_rate,
	adolescent_birth_rate,
	gender_inequality_idx,
	human_development_idx,
	male_hdi,
	female_hdi
FROM 
	demographic_indicators
	
LEFT JOIN world_hdi
	ON demographic_indicators.iso3 = world_hdi.iso3
	AND demographic_indicators.year = world_hdi.year
LEFT JOIN world_abr
	ON world_hdi.iso3 = world_abr.iso3
	AND world_hdi.year = world_abr.year
LEFT JOIN world_female_hdi
	ON world_abr.iso3 = world_female_hdi.iso3
	AND world_abr.year = world_female_hdi.year
LEFT JOIN world_male_hdi
	ON world_female_hdi.iso3 = world_male_hdi.iso3
	AND world_female_hdi.year = world_male_hdi.year
LEFT JOIN world_gii
	ON world_male_hdi.iso3 = world_gii.iso3
	AND world_male_hdi.year = world_gii.year
)



-- Creating table and importing data on men age groups

CREATE TABLE men_age_groups (
	location VARCHAR(100),
	iso3 VARCHAR(3),
	year VARCHAR(4),
	age_range VARCHAR(10),
	number_male INT
)

COPY men_age_groups (
	location,
	iso3,
	year,
	age_range,
	number_male
)

FROM
	'C:\Users\35192\Desktop\Project World Population Evolution\male_age_groups_DATA_222.csv'
DELIMITER ','
CSV HEADER;



-- Creating table and importing data on women age groups

CREATE TABLE women_age_groups (
	location VARCHAR(100),
	iso3 VARCHAR(3),
	year VARCHAR(4),
	age_range VARCHAR(10),
	number_female INT
)

COPY women_age_groups (
	location,
	iso3,
	year,
	age_range,
	number_female
)
FROM
	'C:\Users\35192\Desktop\Project World Population Evolution\women_age_groups_data.csv'
DELIMITER ','
CSV HEADER;



-- Joining the last 2 tables to the main one in order to create a final, organized dataset

SELECT 
	complete_data_table.iso3,
	complete_data_table.location,
	complete_data_table.year,
	total_population,
	sex_ratio,
	median_age,
	natural_change_rate,
	crude_birth_rate,
	fertility_rate,
	childbearing_median_age,
	crude_death_rate,
	life_expectancy,
	infant_mortality_rate,
	net_migration_rate,
	adolescent_birth_rate,
	gender_inequality_idx,
	human_development_idx,
	male_hdi,
	female_hdi,
	men_age_groups.age_range,
	number_men,
	number_women
	
FROM
	complete_data_table	
	
LEFT JOIN women_age_groups
	ON complete_data_table.iso3 = women_age_groups.iso3
	AND complete_data_table.year = women_age_groups.year
LEFT JOIN men_age_groups
	ON women_age_groups.iso3 = men_age_groups.iso3
	AND women_age_groups.year = men_age_groups.year
	AND women_age_groups.age_range = men_age_groups.age_range
)
