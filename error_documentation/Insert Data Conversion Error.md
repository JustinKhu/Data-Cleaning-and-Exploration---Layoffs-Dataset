# 📋 Error Overview

# Issue
Encountered issues attempting to bulk insert data into table. 
- Error Message:
   
          Bulk load data conversion error (type mismatch or invalid character for the specified codepage) for row 5, column 2 (bdate).

# Attempted Solutions

* Changed data type from 'DateTime' to 'Date'
* Used dataset without NULL values
* Added ROWTERMINATOR = '\n', to account for potential inconsistent CSV line endings. 

# Resolution
 Altered the CSV table and changed the affected column to 'YYYY/MM/DD'. 
