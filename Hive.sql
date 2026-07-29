-- Show a list of all databases
SHOW DATABASES;

-- Create a new database
CREATE DATABASE <database_name>;

-- Delete a database
DROP DATABASE <database_name>;

-- Show all databases that have 'DWH' in their name
SHOW DATABASES LIKE '*DWH*';

-- Show all tables in a database that have 'ABT' in their name
SHOW TABLES IN <database_name> LIKE '*ABT*';

-- Show the structure of a table (column names and data types)
DESCRIBE <table_name>;

-- Show detailed information about a table (columns, partitions, storage, stats, etc.)
DESCRIBE FORMATTED <table_name>;

-- Delete a table, but only if it exists (no error if it doesn't)
DROP TABLE IF EXISTS <table_name>;
DROP VIEW IF EXISTS <view_name>;

-- Change the name of a table
ALTER TABLE <current_table_name> RENAME TO <new_table_name>;

-- Create a new external table in ORC format,
-- filled with data copied from another table
CREATE EXTERNAL TABLE IF NOT EXISTS <table_name>
STORED AS ORC
AS SELECT * FROM <table_name2>;

-- Create a new external table in PARQUET format,
-- filled with data copied from another table
CREATE EXTERNAL TABLE IF NOT EXISTS <table_name>
STORED AS PARQUET
AS SELECT * FROM <table_name2>;

-- Create a new external table in PARQUET format,
-- split into partitions by one column,
-- filled with data copied from another table
CREATE EXTERNAL TABLE IF NOT EXISTS <table_name>
PARTITIONED BY (column_name)
STORED AS PARQUET
AS SELECT * FROM <table_name2>;

-- Create an empty external table with defined columns,
-- partitioned by date, stored in PARQUET format
CREATE EXTERNAL TABLE IF NOT EXISTS <database_name>.<table_name>(txn_id BIGINT, cust_id INT, amount DECIMAL(20,2), txn_type STRING, created_date DATE)
COMMENT 'A table to store transactions'
PARTITIONED BY (txn_date DATE)
STORED AS PARQUET;

-- Create an empty external table with defined columns,
-- partitioned by two columns (date and type), stored in PARQUET format
CREATE EXTERNAL TABLE IF NOT EXISTS <database_name>.<table_name>(txn_id BIGINT, cust_id INT, amount DECIMAL(20,2), created_date DATE)
COMMENT 'A table to store transactions'
PARTITIONED BY (txn_date DATE, txn_type STRING)
STORED AS PARQUET;

-- Create a new view, or replace it if it already exists
CREATE OR REPLACE VIEW <view_name_new> 
AS SELECT * FROM <view_name>;

-- Create a new view, but only if it doesn't exist yet
CREATE VIEW IF NOT EXISTS <view_name_new> 
AS SELECT * FROM <view_name>;

-- Use a temporary named result (CTE) to make the query easier to read
WITH temp_table AS (
  SELECT txn_id, amount 
  FROM <table_name> 
  WHERE amount > 0
)
SELECT * FROM temp_table
ORDER BY amount DESC
LIMIT 10;  

-- Convert a Unix timestamp (in milliseconds) to a date and a timestamp
SELECT
header_timestamp,  
to_date(from_unixtime(CAST(header_timestamp / 1000 AS BIGINT))) AS converted_date, 
from_unixtime(CAST(header_timestamp / 1000 AS BIGINT)) AS converted_timestamp
FROM <table_name>

-- Convert a date to text in 'YYYY-MM' format (year and month only)
SELECT CAST(report_date AS STRING FORMAT 'YYYY-MM') AS report_date FROM

-- Format a date as 'yyyy-MM' (year and month only)
SELECT date_format(report_date, 'yyyy-MM') AS report_date FROM
