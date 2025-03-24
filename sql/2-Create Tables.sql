
--Create src Table
USE Bank;
GO

IF OBJECT_ID('src.mplus_transactions', 'U') IS NOT NULL
    DROP TABLE [src].[mplus_transactions];
GO

CREATE TABLE src.mplus_transactions (
	[index]				BIGINT,
	[city]				NVARCHAR(MAX),
	[transaction_date]	DATE,
	[card_type]			NVARCHAR(MAX),
	[exp_type]			NVARCHAR(MAX),
	[gender]			NVARCHAR(MAX),
	[amount]			BIGINT
	);
GO


--Create stg Table
IF OBJECT_ID('stg.mplus_transactions', 'U') IS NOT NULL
    DROP TABLE stg.mplus_transactions;
GO

CREATE TABLE stg.mplus_transactions (
	[source_city]		NVARCHAR(MAX),
	[city]				NVARCHAR(MAX),
	[country]			NVARCHAR(MAX),
	[transaction_date]	DATE,
	[card_type]			NVARCHAR(MAX),
	[exp_type]			NVARCHAR(MAX),
	[source_gender]		NVARCHAR(MAX),
	[gender]			NVARCHAR(MAX),
	[amount]			BIGINT
);
GO


--Create dwh Table
CREATE TABLE dwh.dim_city (
	[pk_id]				int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[city]				NVARCHAR(MAX),
);
GO

----------------


CREATE TABLE dwh.dim_country (
	[pk_id]				int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[country]			NVARCHAR(MAX),
);
GO

------------------



CREATE TABLE dwh.dim_card_type (
	[pk_id]				int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[card_type]			NVARCHAR(MAX),
);
GO

---------------


CREATE TABLE dwh.dim_exp_type (
	[pk_id]				int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[exp_type]			NVARCHAR(MAX),
);
GO

--------------------


CREATE TABLE dwh.dim_gender (
	[pk_id]				int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[gender]			NVARCHAR(MAX),
);
GO

CREATE TABLE dwh.fact_transactions (
	[city]				INT,
	[country]			INT,
	[transaction_date]	DATE,
	[card_type]			INT,
	[exp_type]			INT,
	[gender]			INT,
	[amount]			INT
);
GO



--Create dwh data marts Table
CREATE TABLE dwh.mart_total_amount_by_city (
	[city]				NVARCHAR(MAX),
	[total_amount]		BIGINT
	);
GO

CREATE TABLE dwh.mart_transactions_by_city (
	[city]				NVARCHAR(MAX),
	[transaction_count]	BIGINT
	);
GO	

CREATE TABLE dwh.mart_card_usage_by_city (
	city				NVARCHAR(MAX),
	card_type			NVARCHAR(MAX),
	transaction_count	BIGINT,
	total_amount		BIGINT
	);
GO


CREATE TABLE dwh.mart_expenditure_by_city (
	city				NVARCHAR(MAX),
	exp_type			NVARCHAR(MAX),
	transaction_count	BIGINT,
	total_amount		BIGINT
	);
GO


CREATE TABLE dwh.mart_distribution_by_city (
	city				NVARCHAR(MAX),
	gender			NVARCHAR(MAX),
	transaction_count	BIGINT,
	total_amount		BIGINT
	);
GO