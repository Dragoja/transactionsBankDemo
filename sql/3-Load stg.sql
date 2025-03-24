USE Bank;
GO

CREATE OR ALTER PROCEDURE stg.load_stg AS
BEGIN
	PRINT '>> Truncating Table: stg.mplus_transactions';
	TRUNCATE TABLE stg.mplus_transactions;
	PRINT '>> Inserting Data Into: stg.mplus_transactions';
	WITH cte1 as (	
		SELECT
			TRIM(city) AS source_city,
			TRIM(SUBSTRING(city, 1, CHARINDEX(',', city) - 1)) AS city,
			TRIM(SUBSTRING(city, CHARINDEX(',', city) + 1, LEN(city))) AS country,
			transaction_date,
			TRIM(card_type) AS card_type,
			TRIM(exp_type) AS exp_type,
			TRIM(gender) AS source_gender,
			CASE WHEN UPPER(TRIM(gender)) = 'F' THEN 'Female'
					WHEN UPPER(TRIM(gender)) = 'M' THEN 'Male'
			END AS gender,
			amount
		FROM [src].[mplus_transactions]
		)



	INSERT INTO stg.mplus_transactions(
		source_city,
		city,
		country,
		transaction_date,
		card_type,
		exp_type,
		source_gender,
		gender,
		amount
		)
	SELECT
		source_city,
		city,
		country,
		transaction_date,
		card_type,
		exp_type,
		source_gender,
		gender,
		amount
	FROM cte1
END