--Creating stored procedure for Total Amount Spent by City
CREATE OR ALTER PROCEDURE dwh.load_mart_total_amount_by_city AS
BEGIN
	PRINT '>> Truncating Table: dwh.mart_total_amount_by_city';
	TRUNCATE TABLE dwh.mart_total_amount_by_city;
	PRINT '>> Insert into tabel dwh.mart_total_amount_by_city';
	WITH cte1 AS (
		 SELECT 
			city,
			SUM(amount) AS total_amount
		FROM 
			[dwh].[fact_transactions]
		GROUP BY 
			city
		),
	cte2 AS (
		SELECT 
			d.city AS city,
			t.total_amount AS total_amount
		FROM cte1 as t
		INNER JOIN [dwh].[dim_city] as d
		ON t.city = d.pk_id)
	

	INSERT INTO dwh.mart_total_amount_by_city(
		city,
		total_amount)
	SELECT
		city,
		total_amount
		FROM cte2
END
GO

--Creating stored procedure for Count of Transactions by City
CREATE OR ALTER PROCEDURE dwh.load_mart_transactions_by_city AS
BEGIN
	PRINT '>> Truncating Table: dwh.mart_transactions_by_city';
		TRUNCATE TABLE dwh.mart_transactions_by_city;
		PRINT '>> Insert into tabel dwh.mart_transactions_by_city';
		WITH cte1 AS (
			SELECT 
				city,
				COUNT(*) AS transaction_count
			FROM 
				[dwh].[fact_transactions]
			GROUP BY 
				city
			),
		cte2 AS (
			SELECT 
				d.city AS city,
				t.transaction_count AS transaction_count
			FROM cte1 as t
			INNER JOIN [dwh].[dim_city] as d
			ON t.city = d.pk_id
			)
	

		INSERT INTO dwh.mart_transactions_by_city(
			city,
			transaction_count)
		SELECT
			city,
			transaction_count
			FROM cte2
END
GO

--Creating stored procedure for Card Usage by City
CREATE OR ALTER PROCEDURE dwh.load_mart_card_usage_by_city AS
BEGIN
	PRINT '>> Truncating Table: dwh.mart_card_usage_by_city';
		TRUNCATE TABLE dwh.mart_card_usage_by_city;
		PRINT '>> Insert into tabel dwh.mart_card_usage_by_city';
		WITH cte1 AS (
			SELECT 
				city,
				card_type,
				COUNT(*) AS transaction_count,
				SUM(amount) AS total_amount
			FROM 
				[dwh].[fact_transactions]
			GROUP BY 
				city, card_type
			),
		cte2 AS (
			SELECT 
				d1.city AS city,
				d2.card_type AS card_type,
				t.transaction_count AS transaction_count,
				t.total_amount AS total_amount
			FROM cte1 as t
			INNER JOIN [dwh].[dim_city] as d1
			ON t.city = d1.pk_id
			INNER JOIN [dwh].[dim_card_type] as d2
			ON t.card_type = d2.pk_id
			)
	

		INSERT INTO dwh.mart_card_usage_by_city(
			city,
			card_type,
			transaction_count,
			total_amount)
		SELECT
			city,
			card_type,
			transaction_count,
			total_amount
			FROM cte2
END
GO


--Creating stored procedure for Expenditure Type by City
CREATE OR ALTER PROCEDURE dwh.load_mart_expenditure_by_city AS
BEGIN
	PRINT '>> Truncating Table: dwh.mart_expenditure_by_city';
		TRUNCATE TABLE dwh.mart_Expenditure_by_city;
		PRINT '>> Insert into tabel dwh.mart_expenditure_by_city';
		WITH cte1 AS (
			SELECT 
				city,
				exp_type,
				COUNT(*) AS transaction_count,
				SUM(amount) AS total_amount
			FROM 
				[dwh].[fact_transactions]
			GROUP BY 
				city, exp_type
			),
		cte2 AS (
			SELECT 
				d1.city AS city,
				d2.exp_type AS exp_type,
				t.transaction_count AS transaction_count,
				t.total_amount AS total_amount
			FROM cte1 as t
			INNER JOIN [dwh].[dim_city] as d1
			ON t.city = d1.pk_id
			INNER JOIN [dwh].[dim_exp_type] as d2
			ON t.exp_type = d2.pk_id
			)
	

		INSERT INTO dwh.mart_expenditure_by_city(
			city,
			exp_type,
			transaction_count,
			total_amount)
		SELECT
			city,
			exp_type,
			transaction_count,
			total_amount
			FROM cte2
END
GO

--Creating stored procedure for Gender Distribution by City
CREATE OR ALTER PROCEDURE dwh.load_mart_distribution_by_city AS
BEGIN
	PRINT '>> Truncating Table: dwh.mart_distribution_by_city';
		TRUNCATE TABLE dwh.mart_distribution_by_city;
		PRINT '>> Insert into tabel dwh.mart_distribution_by_city';
		WITH cte1 AS (
			SELECT 
				city,
				gender,
				COUNT(*) AS transaction_count,
				SUM(amount) AS total_amount
			FROM 
				[dwh].[fact_transactions]
			GROUP BY 
				city, gender
			),
		cte2 AS (
			SELECT 
				d1.city AS city,
				d2.gender AS gender,
				t.transaction_count AS transaction_count,
				t.total_amount AS total_amount
			FROM cte1 as t
			INNER JOIN [dwh].[dim_city] as d1
			ON t.city = d1.pk_id
			INNER JOIN [dwh].[dim_gender] as d2
			ON t.gender = d2.pk_id
			)
	

		INSERT INTO dwh.mart_distribution_by_city(
			city,
			gender,
			transaction_count,
			total_amount)
		SELECT
			city,
			gender,
			transaction_count,
			total_amount
			FROM cte2
END