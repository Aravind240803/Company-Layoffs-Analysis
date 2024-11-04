## Project Overview
This project focuses on cleaning and preparing a dataset of company layoffs for insightful analysis. Using SQL, I applied four key data cleaning steps to ensure the dataset is consistent, complete, and ready for further analysis.

## Steps Undertaken
1) Removing Duplicates
Created a staging table and used a CTE to identify and remove duplicates, retaining only unique records based on key columns like company, location, and industry.

2) Standardizing the Data
Standardized text fields for uniformity, removed extra whitespace, and ensured consistent case formatting for columns such as company and location.

3) Handling Null and Blank Values
Addressed missing values by using placeholders (like “Unknown”) for categorical data and selectively imputing or retaining nulls in numerical fields for accuracy.

4) Removing Unnecessary Rows and Columns
Removed any temporary columns and rows created during the cleaning process, keeping only the finalized data for analysis.

## How to Use
- Import the layoffs.csv dataset as the layoffs table in MySQL.
- Run the Data cleaning Project.sql script to apply all cleaning steps.
- Analyze the cleaned data to explore patterns and trends in layoffs across industries and regions.
  
## Conclusion
By executing these essential cleaning steps, this project delivers a high-quality dataset for analyzing company layoff trends, offering a solid foundation for further data exploration and insights.
