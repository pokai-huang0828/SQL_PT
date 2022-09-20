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

EXEC 建一堆表 WITH RECOMPILE;
EXEC sp_recompile '建一堆表';

/* 預存程序的重新編譯

	1. 刪除，再重新撰寫建立
	2. 再次執行該預存程序，並指定重新編譯
		例如: EXEC 建一堆表 WITH RECOMPILE;
	3. 標定該預存程序需要重新編譯，由下一位呼叫執行者來進行步驟2
		例如: EXEC sp_recompile '建一堆表';例如: 
		
*/
USE 練練
--- 純質量函數 ( Scalar Function ) (指傳回單一值)
CREATE FUNCTION 匠匠平均價() RETURNS MONEY
AS 
	BEGIN 
		DECLARE @avgPrice MONEY;
		SELECT @avgPrice = AVG(價錢) FROM 匠匠;
		RETURN @avgPrice;
	END
GO

SELECT GETDATE();
SELECT dbo.匠匠平均價();

SELECT * FROM 巨巨 WHERE 價錢>=dbo.匠匠平均價();
SELECT *,dbo.匠匠平均價() AS 匠匠均價 FROM 巨巨;

-------------------------------------------------------

-- Table Value Function (TVF)
--- Inline Table Value Function 
CREATE FUNCTION 匠匠價格區間產品(@price1 MONEY=0,@price2 MONEY=100000) RETURNS TABLE
AS
  RETURN (
	SELECT 產品編號,品名,價錢
	FROM 匠匠 
	WHERE 價錢>=@price1 AND 價錢<=@price2
  )
GO

SELECT * FROM 匠匠價格區間產品(30,50);
SELECT * FROM 匠匠價格區間產品(DEFAULT,DEFAULT);

--- Muti-Statement Table Value Function

CREATE FUNCTION 書籍負責同仁(@bookId INT)
RETURNS @ee TABLE 
(
	員工編號 INT,
	姓名 NVARCHAR(10),
	職稱 NVARCHAR(10),
	負責區域 NVARCHAR(10)
)
AS 
	BEGIN 
		DECLARE @eid INT;
		SELECT @eid=負責人 FROM 書籍資料 WHERE 書籍編號=@bookId;

		INSERT INTO @ee(員工編號, 姓名, 職稱, 負責區域)
			SELECT 員工編號,姓名,職稱,負責區域 FROM 書籍員工資料 WHERE 員工編號=@eid;
	INSERT INTO @ee(員工編號,姓名,職稱,負責區域)
		SELECT 員工編號,姓名,職稱,負責區域 FROM 書籍員工資料 WHERE 主管編號=@eid;
	RETURN;
  END
GO

SELECT * FROM dbo.書籍負責同仁(6);
SELECT * FROM dbo.書籍負責同仁(5);
SELECT * FROM dbo.書籍負責同仁(4);










