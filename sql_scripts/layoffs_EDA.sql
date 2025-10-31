USE world_layoff;

-- Layoffs by month 

SELECT SUBSTRING(`date`, 1,7) AS `Month`, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY `Month`
ORDER BY 1 ;

-- Creating a rolling total for people laid off

WITH RollingTotal AS (
	SELECT SUBSTRING(`date`, 1,7) AS `Month`, SUM(total_laid_off) AS TotalLaid
	FROM layoffs_staging2
	GROUP BY `Month`
) 
SELECT 
	`Month`, TotalLaid, 
	SUM(TotalLaid) OVER (ORDER BY `Month`) AS rolling_total
FROM RollingTotal ; 

-- Top 5 companies by layoff for each year

WITH Ranked_Layoffs (company, years, total_laid_off) AS 
(
	SELECT company, YEAR(`date`), SUM(total_laid_off) 
	FROM layoffs_staging2 
	GROUP BY company, YEAR(`date`)
)
, Company_year_rank AS 
(
SELECT *, DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS Ranked_Layoffs_by_year
FROM Ranked_layoffs 
)
SELECT * 
FROM Company_year_rank 
WHERE Ranked_Layoffs_by_year <= 5 ;
