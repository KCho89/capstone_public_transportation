-- imported excel sheet

-- create table cost_data (
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
-- FROM cost_data


-- *** table with only agency_name and sum of all fixed_guideway expenses.
-- WITH name_expenses AS (SELECT 
-- agency_name, sum(fixed_guideway_operating_expenses::MONEY) AS fixed_expenses
-- FROM cost_data
-- GROUP BY agency_name)
-- SELECT*
-- FROM name_expenses
-- ORDER BY fixed_expenses DESC NULLS LAST;


-- *** table with only agency_name and fixed,non_fixed, and total_expenses.
WITH name_expenses AS (SELECT 
agency_name, 
sum(fixed_guideway_operating_expenses::MONEY) AS fixed_expenses,
sum(non_fixed_guideway_operating_expenses::MONEY) AS non_fixed_expenses,
sum(total_operating_expenses::MONEY) AS total_expenses
FROM cost_data
GROUP BY agency_name)
SELECT*
FROM name_expenses
ORDER BY total_expenses DESC NULLS LAST;


-- The infor above with density attached.
WITH name_expenses AS (SELECT 
agency_name,uza_name,
sum(fixed_guideway_operating_expenses::MONEY) AS fixed_expenses,
sum(non_fixed_guideway_operating_expenses::MONEY) AS non_fixed_expenses,
sum(total_operating_expenses::MONEY) AS total_expenses,
density
FROM cost_data
GROUP BY agency_name, density,uza_name)
SELECT*
FROM name_expenses
ORDER BY total_expenses DESC NULLS LAST;



-- Add state column based on uza_name.
WITH name_expenses AS (SELECT 
agency_name,uza_name,
sum(fixed_guideway_operating_expenses::MONEY) AS fixed_expenses,
sum(non_fixed_guideway_operating_expenses::MONEY) AS non_fixed_expenses,
sum(total_operating_expenses::MONEY) AS total_expenses,
density
FROM cost_data
GROUP BY agency_name, density,uza_name)
SELECT*
FROM name_expenses
ORDER BY total_expenses DESC NULLS LAST;
