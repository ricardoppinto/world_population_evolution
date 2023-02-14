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
	year, location,
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



-- Comparing fertility rate and population growth through time

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
	chganges_table



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



-- World childbearing median age through time

SELECT
	year,
	childbearing_median_age
FROM
	demographic_data_final
WHERE
	location = 'World'
GROUP BY 
	year,
	childbearing_median_age



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



-- Gender differences and births through time

SELECT
	year,
	AVG(gender_development_idx) AS avg_gdi,
	AVG(gender_inequality_idx) AS avg_gii,
	AVG(fertility_rate) AS fertility_rate_avg,
	AVG(crude_birth_rate) AS birth_rate_avg
FROM 
	demographic_data_final
GROUP BY 
	year
	
	
	
--



















