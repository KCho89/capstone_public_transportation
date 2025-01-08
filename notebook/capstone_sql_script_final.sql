--  Create new table.

-- create table raw (
-- 		uza_name text,
-- 		population int,
-- 		density numeric, 	 
-- 		square_miles numeric,
-- 		agency_name text,
-- 		mode text,
--     	revenue_hours numeric,
--      	trips numeric,
-- 	 	revenue_miles numeric,
--      	operating_expenses numeric);


-- What is the population per square mile for each state?

-- SELECT
-- uza_name,ROUND(population_per_square_mile,1) AS pop_square_mile
-- FROM raw
-- GROUP BY uza_name,population_per_square_mile
-- ORDER BY uza_name;
 

-- What is the population per square mile for nyc, san francisco, denver, nashville?
 
-- SELECT
-- uza_name,ROUND(population_per_square_mile,1) AS pop_square_mile
-- FROM raw
-- WHERE uza_name = 'Nashville-Davidson, TN' 
-- OR (uza_name = 'New York--Jersey City--Newark, NY--NJ')
-- OR (uza_name = 'San Francisco--Oakland, CA')
-- OR (uza_name = 'Denver--Aurora, CO')
-- GROUP BY uza_name,population_per_square_mile
-- ORDER BY pop_square_mile DESC;

-- How many trips per capita per square mile did each city have?

-- WITH trips_density AS (SELECT
-- uza_name AS city,
-- ROUND(AVG(population_per_square_mile),1) AS pop_square_mile,
-- SUM(trips) AS trips
-- FROM raw
-- WHERE uza_name = 'Nashville-Davidson, TN' 
-- OR (uza_name = 'New York--Jersey City--Newark, NY--NJ')
-- OR (uza_name = 'San Francisco--Oakland, CA')
-- OR (uza_name = 'Denver--Aurora, CO')
-- GROUP BY uza_name
-- ORDER BY pop_square_mile DESC)
-- SELECT
-- city,
-- pop_square_mile,
-- trips,
-- ROUND((trips/pop_square_mile),2) AS trips_per_cap_psm
-- FROM trips_density
-- ORDER BY trips_per_cap_psm DESC;

-- How many total revenue hours does each city have and what is its revenue miles per capita per square mile?

-- WITH miles_density AS (SELECT
-- uza_name AS city,
-- ROUND(AVG(population_per_square_mile),1) as pop_square_mile,
-- SUM(revenue_miles) as revenue_miles
-- FROM raw
-- WHERE uza_name = 'Nashville-Davidson, TN' 
-- OR (uza_name = 'New York--Jersey City--Newark, NY--NJ')
-- OR (uza_name = 'San Francisco--Oakland, CA')
-- OR (uza_name = 'Denver--Aurora, CO')
-- GROUP BY uza_name
-- ORDER BY revenue_miles DESC)
-- SELECT
-- city,pop_square_mile,revenue_miles,
-- ROUND(revenue_miles/pop_square_mile,1) as revenue_miles_per_cap_psm
-- FROM miles_density
-- ORDER BY revenue_miles_per_cap_psm DESC;


-- How many square miles is each city?

-- SELECT
-- uza_name, 
-- ROUND(AVG(square_miles),2) AS square_miles
-- FROM raw
-- WHERE uza_name = 'Nashville-Davidson, TN'
-- OR (uza_name = 'New York--Jersey City--Newark, NY--NJ')
-- OR (uza_name = 'San Francisco--Oakland, CA')
-- OR (uza_name = 'Denver--Aurora, CO')
-- GROUP BY uza_name
-- ORDER BY square_miles DESC;

-- What is the total population served for each city?

-- SELECT
-- uza_name as city,
-- ROUND(AVG(population_served),0) as population_served
-- FROM
-- raw
-- WHERE uza_name = 'Nashville-Davidson, TN'
-- OR (uza_name = 'New York--Jersey City--Newark, NY--NJ')
-- OR (uza_name = 'San Francisco--Oakland, CA')
-- OR (uza_name = 'Denver--Aurora, CO')
-- GROUP BY uza_name
-- ORDER BY population_served DESC;

-- How many trips per capita does each city have?

-- WITH trips_per_capita as (SELECT
-- uza_name as city,
-- ROUND(AVG(population_served),0) as population_served,
-- SUM(trips) AS trips
-- FROM
-- raw
-- WHERE uza_name = 'Nashville-Davidson, TN'
-- OR (uza_name = 'New York--Jersey City--Newark, NY--NJ')
-- OR (uza_name = 'San Francisco--Oakland, CA')
-- OR (uza_name = 'Denver--Aurora, CO')
-- GROUP BY uza_name
-- ORDER BY population_served DESC)
-- SELECT
-- city, population_served,trips,
-- ROUND(trips/population_served,0) as trips_per_cap
-- FROM trips_per_capita
-- ORDER BY trips_per_cap DESC;


-- How many revenue miles per capita did each city have?

-- WITH revenue_miles_per_capita as (SELECT
-- uza_name as city,
-- ROUND(AVG(population_served),0) as population_served,
-- SUM(revenue_miles) AS revenue_miles
-- FROM
-- raw
-- WHERE uza_name = 'Nashville-Davidson, TN'
-- OR (uza_name = 'New York--Jersey City--Newark, NY--NJ')
-- OR (uza_name = 'San Francisco--Oakland, CA')
-- OR (uza_name = 'Denver--Aurora, CO')
-- GROUP BY uza_name
-- ORDER BY population_served DESC)
-- SELECT
-- city, population_served,revenue_miles,
-- ROUND(revenue_miles/population_served,0) as revenue_miles_per_cap
-- FROM revenue_miles_per_capita
-- ORDER BY revenue_miles_per_cap DESC;

-- How many revenue miles does each city have?

-- SELECT
-- uza_name as city,
-- SUM(revenue_miles) as revenue_miles
-- FROM raw
-- WHERE uza_name = 'Nashville-Davidson, TN'
-- OR (uza_name = 'New York--Jersey City--Newark, NY--NJ')
-- OR (uza_name = 'San Francisco--Oakland, CA')
-- OR (uza_name = 'Denver--Aurora, CO')
-- GROUP BY uza_name
-- ORDER BY revenue_miles DESC;

-- What is the cost per mile for each city?

-- with cost_per_mile as (SELECT
-- uza_name as city,
-- SUM(revenue_miles) as revenue_miles,
-- SUM(operating_expenses) as operating_expenses
-- FROM raw
-- WHERE uza_name = 'Nashville-Davidson, TN'
-- OR (uza_name = 'New York--Jersey City--Newark, NY--NJ')
-- OR (uza_name = 'San Francisco--Oakland, CA')
-- OR (uza_name = 'Denver--Aurora, CO')
-- GROUP BY uza_name
-- ORDER BY operating_expenses ASC)
-- SELECT
-- city,revenue_miles, operating_expenses,
-- ROUND(operating_expenses/revenue_miles,2) AS cost_per_mile
-- FROM cost_per_mile;

-- How many total trips did each city have?

-- SELECT
-- uza_name as city,
-- SUM(trips) as trips
-- FROM raw
-- WHERE uza_name = 'Nashville-Davidson, TN'
-- OR (uza_name = 'New York--Jersey City--Newark, NY--NJ')
-- OR (uza_name = 'San Francisco--Oakland, CA')
-- OR (uza_name = 'Denver--Aurora, CO')
-- GROUP BY uza_name
-- ORDER BY trips DESC;

-- What was the cost per trip for each city?

-- with cost_per_trip as (SELECT
-- uza_name as city,
-- SUM(trips) as trips,
-- SUM(operating_expenses) as operating_expenses
-- FROM raw
-- WHERE uza_name = 'Nashville-Davidson, TN'
-- OR (uza_name = 'New York--Jersey City--Newark, NY--NJ')
-- OR (uza_name = 'San Francisco--Oakland, CA')
-- OR (uza_name = 'Denver--Aurora, CO')
-- GROUP BY uza_name
-- ORDER BY trips DESC)
-- SELECT
-- city, trips,operating_expenses,
-- ROUND(operating_expenses/trips,2) as cost_per_trip
-- FROM cost_per_trip
-- ORDER BY cost_per_trip ASC;

-- What was the trips per capita for each city?

-- with trips_per_capita as (SELECT
-- uza_name as city,
-- SUM(trips) as trips,
-- ROUND(AVG(population_served),0) as population_served
-- FROM raw
-- WHERE uza_name = 'Nashville-Davidson, TN'
-- OR (uza_name = 'New York--Jersey City--Newark, NY--NJ')
-- OR (uza_name = 'San Francisco--Oakland, CA')
-- OR (uza_name = 'Denver--Aurora, CO')
-- GROUP BY uza_name
-- ORDER BY trips DESC)
-- SELECT
-- city, trips,population_served,
-- ROUND(trips/population_served,0) as trips_per_cap
-- FROM trips_per_capita
-- ORDER BY trips_per_cap ASC;

