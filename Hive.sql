SHOW DATABASES;
CREATE DATABASE <database_name>;
DROP DATABASE <database_name>;

SHOW DATABASES LIKE '*DWH*';
SHOW TABLES IN <database_name> LIKE '*ABT*';
DESCRIBE <table_name>;

DROP TABLE IF EXISTS <table_name>;

ALTER TABLE <current_table_name> RENAME TO <new_table_name>;

CREATE EXTERNAL TABLE IF NOT EXISTS <table_name>
STORED AS ORC
AS SELECT * FROM <table_name2>;

CREATE EXTERNAL TABLE IF NOT EXISTS <table_name>
STORED AS PARQUET
AS SELECT * FROM <table_name2>;

CREATE EXTERNAL TABLE IF NOT EXISTS <table_name>
PARTITIONED BY (column_name)
STORED AS PARQUET
AS SELECT * FROM <table_name2>;

CREATE EXTERNAL TABLE IF NOT EXISTS <database_name>.<table_name>(txn_id BIGINT, cust_id INT, amount DECIMAL(20,2),txn_type STRING, created_date DATE)
COMMENT 'A table to store transactions'
PARTITIONED BY (txn_date DATE)
STORED AS PARQUET;

CREATE EXTERNAL TABLE IF NOT EXISTS <database_name>.<table_name>(txn_id BIGINT, cust_id INT, amount DECIMAL(20,2), created_date DATE)
COMMENT 'A table to store transactions'
PARTITIONED BY (txn_date DATE, txn_type STRING)
STORED AS PARQUET;

DROP TABLE IF EXISTS <view_name>;

CREATE OR REPLACE VIEW <view_name_new> 
AS SELECT * FROM <view_name>;

CREATE VIEW IF NOT EXISTS <view_name_new> 
AS SELECT * FROM <view_name>;

SELECT
header_timestamp,  
to_date(from_unixtime(CAST(header_timestamp / 1000 AS BIGINT))) AS converted_date, 
from_unixtime(CAST(header_timestamp / 1000 AS BIGINT)) AS converted_timestamp
FROM <table_name>

SELECT CAST(report_date AS STRING FORMAT 'YYYY-MM') AS report_date FROM

SELECT date_format(report_date, 'yyyy-MM') AS report_date FROM
