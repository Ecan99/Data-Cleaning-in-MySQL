SELECT *
FROM layoffs; 

-- CREATE ANOTHER TABLE TO WORK ON 

CREATE TABLE layoffs1
SELECT *
FROM layoffs;

SELECT *
FROM layoffs1; 

-- Steps That I Take When Cleaning Data
-- 1. Check duplicates and remove them 
-- 2. Standardize data and fix errors 
-- 3. Look for null values and blank values
-- 4. Remove columns or rows that are not necessary 


-- 1. Check duplicates and remove them 

SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs1;  

WITH duplicate_cte As ( 
SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs1 )
SELECT *
FROM duplicate_cte 
WHERE row_num > 1 ;

-- I create 3rd table to add another column into 'row_num' 

CREATE TABLE `layoffs2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO layoffs2 
SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs1;

SELECT *
FROM layoffs2
where row_num > 1;

DELETE
FROM layoffs2
where row_num > 1;

-- Step 2 : Standardize data and fix errors 
-- Starting by trimming the company column 

SELECT company, trim(company) 
FROM layoffs2; 

UPDATE layoffs2 
SET company = trim(company);

-- Updated company column now Indusry column

SELECT distinct industry
FROM layoffs2; 

## Found an issue of 'crypto' and 'crypto currency', going to label them as one thing

SELECT*
FROM layoffs2
where industry LIKE "crypto%"
;

UPDATE layoffs2
SET industry = 'crypto' 
where industry LIKE "crypto%"
;

SELECT distinct country 
FROM layoffs2;

## Found another issue in country column, theres a dot at the end of united states

SELECT distinct country, trim(trailing '.' from country) 
FROM layoffs2
order by 1;

UPDATE layoffs2 
SET country = trim(trailing '.' from country) 
where country like 'United States%' ;

## Changing date to date format since it is in text form

SELECT `date` ,
STR_TO_DATE(`DATE`, '%m/%d/%Y')
FROM layoffs2;

Update layoffs2
SET `date` = STR_TO_DATE(`DATE`, '%m/%d/%Y');

ALTER TABLE layoffs2
MODIFY COLUMN `date` DATE;

-- Null values and empty spaces

SELECT *
FROM layoffs2
WHERE industry IS NULL
OR industry = '';

SELECT *
FROM layoffs2
WHERE company = 'Airbnb' ;

-- I'm going to try to populate the one with missing values with the one matches with them 

SELECT t1.industry, t2.industry 
from layoffs2 t1 
join layoffs2 t2 
	on t1.company = t2.company 
    where(t1.industry is null or t1.industry = '')
    and t2.industry is not null;

UPDATE layoffs2
set industry = null 
where industry = '';

update layoffs2 t1 
join layoffs2 t2
on t1.company = t2.company
set t1.industry = t2.industry 
  where t1.industry is null 
    and t2.industry is not null;



-- Last step is to remove the columns and rows that are not applicable

SELECT *
FROM layoffs2
WHERE total_laid_off is null 
and percentage_laid_off is null;


DELETE 
FROM layoffs2
WHERE total_laid_off is null 
and percentage_laid_off is null;

SELECT *
FROM layoffs2;

ALTER TABLE layoffs2
DROP COLUMN row_num;


























