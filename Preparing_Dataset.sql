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
	
	
	
-- Creating table and importing HDI data
	
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
