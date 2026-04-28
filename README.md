#### Project Overview
This project focuses on analyzing the "Bright Car Sales" dataset, which captures daily transactional and pricing information for Bright Motors. 
As a Junior Data Analyst, my mission was to extract actionable insights for the newly appointed Head of Sales to help expand the dealership network,improve sales performance, and optimize inventory. 

#### Project Objectives
The primary goals of this analysis were to:
Identify which car makes and models generate the highest revenue .
Analyze the relationship between price, mileage, and year of manufacture. 
Determine which regions or locations exhibit the highest sales volumes.
Uncover emerging customer purchasing trends and preferences. 
Provide data-driven recommendations to increase dealership profitability

#### Data Architecture & Workflow
The project followed a structured data pipeline to ensure data integrity and insightful reporting:
Source: Raw daily transactional car sales data (CSV/Excel).

ETL Pipeline:
Cleaning: Removing duplicates and handling missing or inconsistent values.
Transformation: Converting text-based prices to numeric formats and formatting currency.
Storage (Databriks):
Calculation of Total Revenue and Profit Margins.
Categorization of vehicles into performance tiers (High, Medium, and Low Margin).
Time-period grouping (Month, Quarter, Year).
Analysis Layer: Connecting processed datasets to Power BI for interactive dashboarding using slicers for region, fuel type, and year.
