--Creating stored procedure EXEC all
CREATE OR ALTER PROCEDURE dwh.exec_all AS
	BEGIN
		EXEC stg.load_stg;
		
		EXEC dwh.load_dwh;
		
		EXEC dwh.load_mart_total_amount_by_city;
		
		EXEC dwh.load_mart_transactions_by_city;
		
		EXEC dwh.load_mart_card_usage_by_city;
		
		EXEC dwh.load_mart_expenditure_by_city;
		
		EXEC dwh.load_mart_distribution_by_city;
	END