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



-- Average percentage change per year

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
