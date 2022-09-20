--- Store Procedure
USE 中文北風

CREATE PROC 產品查詢
AS
	SELECT A.產品編號, A.產品, C.供應商, B.類別名稱, A.單價, A.單位數量, A.庫存量
	FROM 產品資料 AS A JOIN 產品類別 AS B ON A.類別編號=B.類別編號
		JOIN 供應商 AS C ON A.供應商編號=C.供應商編號
	ORDER BY 單價 DESC
GO
EXEC 產品查詢;

-----------------------------------
ALTER PROC 產品查詢 @price1 MONEY, @price2 MONEY
AS 
	SELECT A.產品編號,A.產品,C.供應商,B.類別名稱,A.單價,A.單位數量,A.庫存量
	FROM 產品資料 AS A JOIN 產品類別 AS B ON A.類別編號=B.類別編號
		JOIN 供應商 AS C ON A.供應商編號=C.供應商編號
	WHERE 單價>=@price1 AND 單價<=@price2
	ORDER BY 單價 DESC
GO

EXEC 產品查詢 30,50;
EXEC 產品查詢 50,100;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

ALTER PROC 產品查詢 @price1 MONEY=0,@price2 MONEY=100000
AS
	SELECT A.產品編號,A.產品,C.供應商,B.類別名稱,A.單價,A.單位數量,A.庫存量
	FROM 產品資料 AS A JOIN 產品類別 AS B ON A.類別編號=B.類別編號
		JOIN 供應商 AS C ON A.供應商編號=C.供應商編號
	WHERE 單價>=@price1 AND 單價<=@price2
	ORDER BY 單價 DESC
GO

EXEC 產品查詢;
EXEC 產品查詢 50;
EXEC 產品查詢 30,40;

EXEC 產品查詢 DEFAULT,30;
EXEC 產品查詢 @price2=10;
EXEC 產品查詢 @price2=10,@price1=5;

EXEC sp_helptext '產品查詢';
EXEC sp_helptext '詳細訂單檢視';

/* 預存程序 VS. 函數

	1. 皆為編譯過的，相較之下，預存程序較有效率。
	2. 預存程序只能獨立執行，無法搭配其他的SQL語法執行;
		函數適用上較為靈活，可任意搭配其他SQL語法配合執行。
	3. 預存程序 能夠有多個 帶入、帶出行參數，並且可以擁有一個整數型態的傳回值。
	4. 預存程序原則上可執行任何SQL命令

*/
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

ALTER PROC 產品查詢 @price1 MONEY=0,@price2 MONEY=100000
	,@sum MONEY OUTPUT,@avg MONEY OUTPUT
AS
	SELECT @sum=SUM(A.單價),@avg=AVG(A.單價) 
	FROM 產品資料 AS A		
	WHERE 單價>=@price1 AND 單價<=@price2;
	
	SELECT A.產品編號,A.產品,C.供應商,B.類別名稱,A.單價,A.單位數量,A.庫存量
	FROM 產品資料 AS A JOIN 產品類別 AS B ON A.類別編號=B.類別編號
		JOIN 供應商 AS C ON A.供應商編號=C.供應商編號
	WHERE 單價>=@price1 AND 單價<=@price2
	ORDER BY 單價 DESC;
GO


DECLARE @ss MONEY;
DECLARE @aa MONEY;
EXEC 產品查詢 30,40,@ss OUTPUT,@aa OUTPUT;
PRINT @ss;
PRINT @aa;

-----------------------------------------------------------------------------------

ALTER PROC 產品查詢 @price1 MONEY=0,@price2 MONEY=100000
	,@sum MONEY OUTPUT,@avg MONEY OUTPUT
AS
	SELECT @sum=SUM(A.單價),@avg=AVG(A.單價)
	FROM 產品資料 AS A		
	WHERE 單價>=@price1 AND 單價<=@price2;
	
	DECLARE @count INT;

	SELECT A.產品編號,A.產品,C.供應商,B.類別名稱,A.單價,A.單位數量,A.庫存量
	FROM 產品資料 AS A JOIN 產品類別 AS B ON A.類別編號=B.類別編號
		JOIN 供應商 AS C ON A.供應商編號=C.供應商編號
	WHERE 單價>=@price1 AND 單價<=@price2
	ORDER BY 單價 DESC;

	SET @count=@@ROWCOUNT;
	RETURN @count;
GO

DECLARE @ss MONEY;
DECLARE @aa MONEY;
DECLARE @cc INT;
EXEC @cc=產品查詢 30,40,@ss OUTPUT,@aa OUTPUT;
PRINT @ss;
PRINT @aa;
PRINT @cc;

----------------------------------------------------------------------------------


CREATE PROC 建一堆表
AS
    CREATE TABLE T1(C1 INT,C2 NVARCHAR(10));
	CREATE TABLE T2(C1 INT,C2 NVARCHAR(10));
	CREATE TABLE T3(C1 INT,C2 NVARCHAR(10));
	CREATE TABLE T4(C1 INT,C2 NVARCHAR(10));
	CREATE TABLE T5(C1 INT,C2 NVARCHAR(10));
	CREATE TABLE T6(C1 INT,C2 NVARCHAR(10));
GO

CREATE PROC 刪一堆表
AS
  DROP TABLE T1,T2,T3,T4,T5,T6;
GO  


EXEC 建一堆表;
EXEC 刪一堆表;

-------------------------------------------------------------

