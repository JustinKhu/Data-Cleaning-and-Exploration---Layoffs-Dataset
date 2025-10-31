# Layoffs Data Cleaning & Exploratory Analysis Project

## Project Context
This project analyzes a global dataset of company layoffs from 2020 to 2024.  
The dataset includes information such as company name, location, industry, funding stage, total layoffs, and percentage of workforce affected.

The objective was to clean and standardize the dataset using MySQL, identify major layoff trends, and visualize my findings in Excel.  
This analysis helps uncover how different industries, companies, and countries reacted to changes in the economy both before and after the pandemic. 

## Data Cleaning Summary
The raw dataset contained some blank values, duplicates, and inconsistent formatting in certain areas. I used SQL to clean, standardize, and format the data so that it would be cleaner and therefore easier to extract useful insights from. 

In MySQL, I: 

**Created a staging table** in order to preserve the integrity of the original dataset. 
**Removed duplicates** by using the ROW_NUM function. 
**Cleaned up data** by removing any leading/trailing spaces using TRIM function. 
**Replaced empty cells** with NULL values. 

## Exploratory Data Analysis 
Finally, after cleaning the data I used aggregations and CTE's in order to extract valuable information. 


1. **Layoffs surged in mid-to-late 2022**  
   - The total number of layoffs rose sharply during this period, suggesting a major event (potentially COVID) following rapid hiring in 2021.

2. **Technology related industries were the most affected**  
   - Tech and consumer services (e.g Meta) sectors showed the highest number of layoffs, indicating potential overexpansion.

3. **The United States accounted for a large majority of the overall layoffs**  
   - This was followed by Europe and Asia, showcasing the large presence of U.S based companies in the dataset.
  
4. **Top companies by layoffs per year**  
   - Amazon, Meta, and Intel appeared multiple times, showcasing the massive amount of layoffs in the tech/consumer industry.
  
## Excel Visualizations
Visualizations were created in Excel to communicate key findings clearly:

| Insight | Visualization Type | File |
|----------|--------------------|------|
| Top companies by layoffs | Clustered Column Chart | `visualizations/top_companies.png` |

  
## Reflection & Learnings
Throughout this project, I strengthened my ability to clean and analyze real-world datasets using SQL.  
Key technical learnings included:

- Using **CTEs** and **window functions** for complex queries to find valuable information.  
- The nuances regarding inputting data on different operating systems. 
- Leveraging Excel to visualize and communicate findings and trends effectively.

Beyond these technical skills, I also improved on how to **structure a data analytics project** for professional presentation on GitHub.  
In future iterations, I plan to automate this workflow using **Python (Pandas)** and develop **interactive dashboards in Power BI** or **Tableau**.
