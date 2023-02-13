/*Importing and preparing the data*/


-- Creating the table and importing the main dataset to PostgreSQL

CREATE TABLE demographic_Indicators (
	ISO3 VARCHAR(50),
	location VARCHAR(60),
	year VARCHAR(50),
	total_population DECIMAL,
	male_population DECIMAL,
	female_population DECIMAL,
	population_density DECIMAL,
	sex_ratio DECIMAL,
	median_age DECIMAL,
	natural_change_rate DECIMAL,
	crude_birth_rate DECIMAL,
	fertility_rate DECIMAL,
	childbearing_median_age DECIMAL,
	crude_death_rate DECIMAL,
	life_expectancy DECIMAL,
	male_life_expectancy DECIMAL,
	female_life_expectancy DECIMAL,
	infant_mortality_rate DECIMAL,
	net_migration_rate DECIMAL

)


COPY demographic_Indicators(
	ISO3,
	location,
	year,
	total_population,
	male_population,
	female_population,
	population_density,
	sex_ratio,
	median_age,
	natural_change_rate,
	crude_birth_rate,
	fertility_rate,
	childbearing_median_age,
	crude_death_rate,
	life_expectancy,
	male_life_expectancy,
	female_life_expectancy,
	infant_mortality_rate,
	net_migration_rate)

FROM 'C:\Users\35192\Desktop\Project World Population Evolution\Clean Data\clean_Demographic_Indicators_Data.csv'
DELIMITER ','
CSV HEADER;
