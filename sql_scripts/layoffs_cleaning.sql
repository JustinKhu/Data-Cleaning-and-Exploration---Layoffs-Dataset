-- Data Cleaning 

-- 1. Remove Duplicates 
-- 2. Standardize the data 
-- 3. Null Values or Blank Values 
-- 4. Remove any columns 

-- Removing duplicates

CREATE DATABASE world_layoffs; 
USE world_layoffs;

-- Creating a staging table to work on, protecting the raw data. 

CREATE TABLE layoffs_staging
LIKE layoffs;

INSERT INTO layoffs_staging 
SELECT *
FROM layoffs;

-- Identifying any duplicate records using ROW_NUMBER and CTE's

SELECT *, 
	ROW_NUMBER() OVER (
    PARTITION BY company, location, total_laid_off, `date`, percentage_laid_off, industry, stage, funds_raised, country
    ) AS row_num
FROM layoffs_staging; 

WITH cte_duplicate AS (
SELECT *, 
	ROW_NUMBER() OVER (
	PARTITION BY company, location, total_laid_off, `date`, percentage_laid_off, industry, stage, funds_raised, country
	) AS row_num
FROM layoffs_staging
) 
SELECT * 
FROM cte_duplicate 
WHERE row_num > 1;

-- Inspecting columns with 'WHERE row_num > 1;' to verify if it is truly a duplicate.

SELECT * 
FROM layoffs_staging
WHERE company = 'cazoo';

-- Creating a second staging table to make the process of deleting duplicate data more simple.

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `total_laid_off` double DEFAULT NULL,
  `date` text,
  `percentage_laid_off` text,
  `industry` text,
  `stage` text,
  `funds_raised` text,
  `country` text,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO layoffs_staging2
SELECT *, 
ROW_NUMBER() OVER (
	PARTITION BY company, location, total_laid_off, `date`, percentage_laid_off, industry, stage, funds_raised, country
	) AS row_num
FROM layoffs_staging; 

DELETE 
FROM layoffs_staging2 
WHERE row_num > 1;

-- Standardizing Data to remove leading/trailing spaces.

SELECT company, TRIM(company) 
FROM layoffs_staging2;

UPDATE layoffs_staging2 
SET company = TRIM(company);

-- Changing 'date' column from text to DATE definition.  

SELECT `date`
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

-- Handling blank values.

UPDATE layoffs_staging2
SET industry = NULL 
WHERE industry = '';

UPDATE layoffs_staging2
SET country = 'Canada' 
WHERE country = '' AND 
company = 'Ludia' ;

-- Filling in missing values for 'industry' column where possible (reliant on t2 column having a value). 

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2 
	ON t1.company = t2.company 
SET t1.industry = t2.industry 
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL ;

