# Data-Cleaning-in-MySQL
Skills used in real-world

SQL Data Cleaning Project
Project Overview

This project demonstrates practical SQL skills used in real-world data analyst roles, with a strong focus on data cleaning and preparation. The objective was to take raw, inconsistent layoff data and transform it into a clean, structured, and analysis-ready dataset using MySQL.

The project reflects common data challenges faced in business environments and showcases the ability to write efficient, readable, and well-structured SQL queries.

Tools and Technologies

MySQL

MySQL Workbench

SQL

Dataset Description

The dataset contains company layoff information with fields such as:

Company

Location

Industry

Total laid off

Percentage laid off

Date

Company stage

Country

The original data included multiple quality issues, including:

Duplicate records

Inconsistent text formatting

Leading and trailing spaces

Null and blank values

Incorrect date formats

Data Cleaning Process

The following steps were performed to clean and standardize the data:

1. Staging Tables

Created staging tables to preserve the original dataset.

Ensured all transformations were applied safely without altering raw data.

2. Duplicate Removal

Used ROW_NUMBER() with PARTITION BY to identify duplicate rows.

Removed duplicates while retaining a single valid record per group.

3. Text Standardization

Applied TRIM() to remove leading and trailing spaces.

Standardized inconsistent company, industry, and country names.

4. Handling Null and Blank Values

Converted blank values to NULL for consistency.

Filled missing values where logically possible using existing data.

5. Date Formatting

Converted date columns into proper DATE data types.

Ensured consistency across all records.

6. Final Validation

Verified data integrity after cleaning.

Ensured the dataset was ready for analysis and reporting.

SQL Concepts and Techniques Used

Data Definition Language (DDL)

Data Manipulation Language (DML)

Common Table Expressions (CTEs)

Window functions (ROW_NUMBER)

Conditional logic (CASE)

String functions (TRIM)

Filtering with WHERE

Null handling (IS NULL)

Outcome

Duplicate records successfully removed

Text fields standardized

Missing and invalid values handled appropriately

Clean, structured dataset suitable for analysis

Professional Relevance

Data cleaning is a core responsibility of data analysts and typically consumes the majority of analysis time. This project demonstrates:

Strong SQL fundamentals

Attention to data quality

Safe and structured query design

Readiness to work with real business datasets

How to Run the Project

Clone this repository.

Open the SQL file in MySQL Workbench.

Execute the queries sequentially.

Review the cleaned final table.

Author

Mpho Ecan
Aspiring Data Analyst
South Africa
