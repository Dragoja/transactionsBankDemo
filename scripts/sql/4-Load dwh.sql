USE Bank;
GO

CREATE OR ALTER PROCEDURE dwh.load_dwh AS
BEGIN
	PRINT '>> Inserting Data Into: dwh.dim_city';
	INSERT INTO dwh.dim_city(city)
	SELECT 
	DISTINCT(city)
	FROM stg.mplus_transactions
	WHERE NOT EXISTS (SELECT city FROM dwh.dim_city WHERE dwh.dim_city.city = stg.mplus_transactions.city)

	PRINT '>> Inserting Data Into: dwh.dim_country';
	INSERT INTO dwh.dim_country(country)
	SELECT 
	DISTINCT(country)
	FROM stg.mplus_transactions
	WHERE NOT EXISTS (SELECT country FROM dwh.dim_country WHERE dwh.dim_country.country = stg.mplus_transactions.country)

	PRINT '>> Inserting Data Into: dwh.dim_card_type';
	INSERT INTO dwh.dim_card_type(card_type)
	SELECT 
	DISTINCT(card_type)
	FROM stg.mplus_transactions
	WHERE NOT EXISTS (SELECT card_type FROM dwh.dim_card_type WHERE dwh.dim_card_type.card_type = stg.mplus_transactions.card_type)

	PRINT '>> Inserting Data Into: dwh.dim_exp_type';
	INSERT INTO dwh.dim_exp_type(exp_type)
	SELECT 
	DISTINCT(exp_type)
	FROM stg.mplus_transactions
	WHERE NOT EXISTS (SELECT exp_type FROM dwh.dim_exp_type WHERE dwh.dim_exp_type.exp_type = stg.mplus_transactions.exp_type)

	PRINT '>> Inserting Data Into: dwh.dim_gender';
	INSERT INTO dwh.dim_gender(gender)
	SELECT 
	DISTINCT(gender)
	FROM stg.mplus_transactions
	WHERE NOT EXISTS (SELECT gender FROM dwh.dim_gender WHERE dwh.dim_gender.gender = stg.mplus_transactions.gender)

	--------------------------------------------------------------------------------------------------------

	PRINT '>> Inserting Data Into: dwh.fact_transactions';
	with cte as(SELECT 
		c.pk_id AS city,
		co.pk_id AS country,
		t.transaction_date,
		ca.pk_id AS card_type,
		e.pk_id AS exp_type,
		g.pk_id AS gender,
		t.amount
		FROM stg.mplus_transactions AS t
		LEFT JOIN dwh.dim_city AS c
		ON t.city = c.city
		LEFT JOIN dwh.dim_country AS co
		ON t.country = co.country
		LEFT JOIN dwh.dim_card_type AS ca
		ON t.card_type = ca.card_type
		LEFT JOIN dwh.dim_exp_type AS e
		ON t.exp_type = e.exp_type
		LEFT JOIN dwh.dim_gender AS g
		ON t.gender = g.gender)
	
	
	INSERT INTO dwh.fact_transactions( 
		city, 
		country, 
		transaction_date, 
		card_type, 
		exp_type, 
		gender, 
		amount)
	SELECT 
		city, 
		country, 
		transaction_date, 
		card_type, 
		exp_type, 
		gender, 
		amount
		FROM cte
	WHERE NOT EXISTS (SELECT city, country 
					  FROM dwh.fact_transactions 
					  WHERE dwh.fact_transactions.city = cte.city 
					  AND dwh.fact_transactions.country = cte.country
					  AND dwh.fact_transactions.transaction_date = cte.transaction_date
					  AND dwh.fact_transactions.card_type = cte.card_type
					  AND dwh.fact_transactions.exp_type = cte.exp_type
					  AND dwh.fact_transactions.gender = cte.gender
					  AND dwh.fact_transactions.amount = cte.amount
					  )



------------------------------------------------------------------
	PRINT '>> Truncating Table: src.transactions';
	TRUNCATE TABLE src.mplus_transactions;
	PRINT '>> Truncating Table: stg.transactions';
	TRUNCATE TABLE stg.mplus_transactions;
END

