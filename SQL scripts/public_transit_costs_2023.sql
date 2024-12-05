-- *** create table cost_data (
-- 		UACE_Code int,
-- 		UZA_Name text,
-- 		Primary_UZA text,
-- 		Population int,
-- 		Density numeric, 	 
-- 		Square_Miles numeric,
-- 		State_NTD_ID text,
-- 		NTD_ID int,
-- 		Agency_Name text,
-- 		Reporter_Type text,
-- 		Reporting_Module text,
-- 		Mode text,
-- 		TOS text,
-- 		UZA_Reporting_Method text,
-- 		FG_NFG_Reporting_Method text,
-- 		Other_FG_NFG_Reporting_Method_Description text,
-- 		Total_Actual_Vehicle_Revenue_Hours int,
-- 		Total_Unlinked_Passenger_Trips int,
-- 		Total_Actual_Vehicle_Revenue_Miles int,
-- 		Total_Passenger_Miles_Traveled numeric,
-- 		Total_Operating_Expenses numeric,
-- 		Non_Fixed_Guideway_Vehicle_Revenue_Miles numeric,
-- 		Non_Fixed_Guideway_Passenger_Miles numeric,
-- 		Non_Fixed_Guideway_Operating_Expenses numeric,
-- 		Directional_Route_Miles numeric,
-- 		Fixed_Guideway_Vehicle_Revenue_Miles numeric,
-- 		Fixed_Guideway_Passenger_Miles numeric,
-- 		Fixed_Guideway_Operating_Expenses numeric,
-- 		SGR_FG_Directional_Route_Miles numeric,
-- 		SGR_FG_Vehicle_Revenue_Miles numeric,
-- 		SGR_HIB_Directional_Route_Miles numeric,
-- 		SGR_HIB_Vehicle_Revenue_Miles numeric);


-- ** This is the dataframe that was made in pandas before switching to sql.

-- SELECT
-- uza_name,population,directional_route_miles,fixed_guideway_vehicle_revenue_miles,
-- fixed_guideway_passenger_miles,fixed_guideway_operating_expenses,density,square_miles,agency_name,non_fixed_guideway_passenger_miles,total_operating_expenses
-- FROM cost_data;


-- *** table with only agency_name and sum of all fixed_guideway expenses.
-- WITH name_expenses AS (SELECT 
-- agency_name, sum(fixed_guideway_operating_expenses::MONEY) AS fixed_expenses
-- FROM cost_data
-- GROUP BY agency_name)
-- SELECT*
-- FROM name_expenses
-- ORDER BY fixed_expenses DESC NULLS LAST;


-- *** table with only agency_name and fixed,non_fixed, and total_expenses.
-- WITH name_expenses AS (SELECT 
-- agency_name, 
-- sum(fixed_guideway_operating_expenses::MONEY) AS fixed_expenses,
-- sum(non_fixed_guideway_operating_expenses::MONEY) AS non_fixed_expenses,
-- sum(total_operating_expenses::MONEY) AS total_expenses
-- FROM cost_data
-- GROUP BY agency_name)
-- SELECT*
-- FROM name_expenses
-- ORDER BY total_expenses DESC NULLS LAST;


-- *** The infor above with density attached.
-- WITH name_expenses AS (SELECT 
-- agency_name,uza_name,
-- sum(fixed_guideway_operating_expenses::MONEY) AS fixed_expenses,
-- sum(non_fixed_guideway_operating_expenses::MONEY) AS non_fixed_expenses,
-- sum(total_operating_expenses::MONEY) AS total_expenses,
-- density
-- FROM cost_data
-- GROUP BY agency_name, density,uza_name)
-- SELECT*
-- FROM name_expenses
-- ORDER BY total_expenses DESC NULLS LAST;



-- *** Add state column based on uza_name.
-- WITH name_expenses AS (SELECT 
-- agency_name,uza_name,
-- sum(fixed_guideway_operating_expenses::MONEY) AS fixed_expenses,
-- sum(non_fixed_guideway_operating_expenses::MONEY) AS non_fixed_expenses,
-- sum(total_operating_expenses::MONEY) AS total_expenses,
-- density
-- FROM cost_data
-- GROUP BY agency_name, density,uza_name)
-- SELECT*
-- FROM name_expenses
-- ORDER BY total_expenses DESC NULLS LAST;


-- *** Created state_info table.

-- create table state_info (
-- 		Mode text,
-- 		UACE_Code int,
-- 		UZA_Name text,
-- 		State text,
-- 		Population int,
-- 		Density numeric, 	 
-- 		Square_Miles numeric,
-- 		State_NTD_ID text,
-- 		Agency_Name text,
-- 		Reporting_Module text)

-- *** created mode_info

-- create table mode_info (
-- 		mode text,
-- 		definition text,
-- 		rail text,
-- 		bus text,
-- 		cable text,
-- 		van text,
-- 		boat text)

-- *** rail only

-- SELECT mode, definition, rail
-- FROM mode
-- WHERE rail = 'TRUE'

------------------------------  ANALYSIS  ------------------------------------------



--  Top 20 total_operating_expenses.

-- SELECT
-- uza_name, agency_name, mode, total_operating_expenses
-- FROM cost
-- ORDER BY total_operating_expenses DESC
-- LIMIT 20;



-- Total Operating expenses for each mode for the entire data set.

-- SELECT
-- cost.mode,definition,
-- sum(total_operating_expenses) AS total_operating_expenses
-- FROM cost
-- LEFT JOIN mode ON cost.mode = mode.mode
-- GROUP BY cost.mode,definition
-- ORDER BY total_operating_expenses DESC


-- Total Operating Cost Per Capita for Each State.

WITH total_operating_cost_per_capita AS (SELECT*
FROM cost
LEFT JOIN state on cost.uace_code = state.uace_code)
SELECT
distinct state, 
ROUND(SUM(total_operating_expenses/population),2) AS total_operating_cost_per
FROM total_operating_cost_per_capita
GROUP BY state
ORDER BY state DESC;


WITH total_operating_cost_per_capita AS (SELECT*
FROM cost
LEFT JOIN state on cost.uace_code = state.uace_code)
SELECT
state, population, agency_name, total_operating_expenses
FROM total_operating_cost_per_capita


WITH total_operating_cost_per_capita AS (SELECT*
FROM cost
LEFT JOIN state on cost.uace_code = state.uace_code)
SELECT*
FROM total_operating_cost_per_capita


-- *** what is causing the repeat states in the per capita chart?

WITH total_operating_cost_per_capita AS (SELECT*
FROM cost
INNER JOIN state USING (uace_code))
SELECT*
FROM total_operating_cost_per_capita




