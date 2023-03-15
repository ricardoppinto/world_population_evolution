/*World Population Data Exploration*/


-- World population change through time, with percentage

WITH population_change AS (

SELECT
	year,
	total_population,
	total_population - LAG(total_population) OVER (ORDER BY year) AS change

FROM 
	demographic_data_final
WHERE
	location = 'World'
GROUP BY 
	year,
	location,
	total_population
)

SELECT
	year,
	total_population,
	change/ LAG(total_population) OVER (ORDER BY year) * 100 AS percentage_change
FROM 
	population_change



-- Average percentage change in total population per year

WITH population_change AS (

SELECT
	year,
	total_population,
	total_population - LAG(total_population) OVER (ORDER BY year) AS change
FROM 
	demographic_data_final
WHERE 
	location = 'World'
GROUP BY 
	year,
	total_population
)

SELECT 
	AVG(percentage_change) AS avg_percentage_change
FROM (
	SELECT
		year,
        	total_population,
        	change/ LAG(total_population) OVER (ORDER BY year) * 100 AS percentage_change
	FROM 
  		population_change
) sbq



-- Fertility rate and population growth rate through time

WITH changes_table AS (
	
SELECT
	year,
	total_population,
	fertility_rate,
	fertility_rate - LAG(fertility_rate) OVER (ORDER BY year) AS fertility_change,
	total_population - LAG(total_population) OVER (ORDER BY year) AS change
FROM 
	demographic_data_final
WHERE 
	location = 'World'
GROUP BY 
	year,
	total_population,
	fertility_rate
)

SELECT
	year,
	fertility_rate,
	fertility_change/ LAG(fertility_rate) OVER (ORDER BY year) * 100 AS fertility_change_pct,
	change/ LAG(total_population) OVER (ORDER BY year) * 100 AS population_change_pct
  
FROM
	changes_table



-- World average fertility rate per year

SELECT
	AVG(fertility_rate) AS fertility_rate_avg
FROM 
	demographic_data_final
WHERE 
	location = 'World'



-- World population median age through time

SELECT
	year,
	median_age
FROM 
	demographic_data_final
WHERE 
	location = 'World'
GROUP BY
	year,
	location,
	median_age



-- World childbearing mean age through time

SELECT
	year,
	childbearing_mean_age
FROM
	demographic_data_final
WHERE
	location = 'World'
GROUP BY 
	year,
	childbearing_mean_age



-- Average adolescent birth rate, crude birth rate and fertility rate per year

SELECT 
	year,
	AVG(adolescent_births) AS adolescent_births_avg, 
	AVG(fertility_rate) AS fertility_rate_avg,
	AVG(crude_birth_rate) AS birth_rate_avg
FROM 
	demographic_data_final
GROUP BY
	year



-- Demographic indicators and births through time

SELECT
	year,
	AVG(human_development_idx) AS avg_hdi,
	AVG(gender_inequality_idx) AS avg_gii,
	AVG(fertility_rate) AS fertility_rate_avg,
	AVG(crude_birth_rate) AS birth_rate_avg
FROM 
	demographic_data_final
WHERE
	iso3 IS NOT null
GROUP BY 
	year

	
	
	
-- Average percentage change in human development index per year, men vs women

WITH hdi_averages AS ( 
	
SELECT
	year,
	AVG(male_hdi) AS avg_male,
	AVG(female_hdi) AS avg_female
FROM 
	demographic_data_final
WHERE 
	iso3 IS NOT null
	AND male_hdi IS NOT null
GROUP BY 
	year
),

	
hdi_differences AS (
			
SELECT 
	year,
	hdi_averages.avg_male,
	hdi_averages.avg_female,
	(avg_male - LAG(avg_male) OVER (ORDER BY year)) / LAG(avg_male) OVER (ORDER BY year) * 100 AS male_difference,
	(avg_female - LAG(avg_female) OVER (ORDER BY year)) / LAG(avg_female) OVER (ORDER BY year) * 100 AS female_difference
FROM 
	hdi_averages
)
	

SELECT 
	AVG(male_difference) AS avg_male_change,
	AVG(female_difference) AS avg_female_change
FROM
	hdi_differences
	
	
	
-- World population age distribution in a given year

WITH year_total AS (

SELECT
	year,
	location,
	age_range,
	total_men,
	total_female,
	SUM(total_men + total_female) OVER() AS pop_total
FROM
	demographic_data_final
WHERE
	location = 'World'
	AND year = '1950' 
)

SELECT
	year,
	location,
	age_range,
	(total_men + total_female)/ (pop_total*1.0)*100 AS percent_of_total
FROM
	year_total
GROUP BY
	year,
	location,
	age_range,
	total_men,
	total_female,
	pop_total
	
	
	
-- World death rate through time

SELECT
	year,
	crude_death_rate
FROM
	demographic_data_final
WHERE
	location = 'World'
GROUP BY
	year,
	crude_death_rate
	
	
	
-- World life expectancy through time

SELECT
	year,
	life_expectancy
FROM
	demographic_data_final
WHERE
	location = 'World'
GROUP BY
	year,
	life_expectancy
