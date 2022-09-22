
USE 中文北風;
SELECT STRING_AGG([產品], ',') FROM 產品資料;

--- CURSOR 

DECLARE @nameList NVARCHAR(1024) = ''; -- '' => 空字串
SET @nameList = @nameList + '巨匠';
SELECT @nameList;

DECLARE @nameList NVARCHAR(1024) = ''; -- '' => 空字串
SELECT @nameList = @nameList + [產品] + ', '
FROM 產品資料;
SET @nameList = SUBSTRING(@nameList, 1, LEN(@nameList)-1); -- 去尾逗號
SELECT @nameList;


CREATE FUNCTION 分類產品清單(@typeId INT) RETURNS NVARCHAR(1024)
AS 
	BEGIN 
		DECLARE @nameList NVARCHAR(1024) = ''; -- '' => 空字串
		SELECT @nameList = @nameList + [產品] + ', ' FROM 產品資料 WHERE 類別編號 = @typeId;
		SET @nameList = SUBSTRING(@nameList, 1, LEN(@nameList)-1); -- 去尾逗號
		RETURN @nameList;
	END
GO

DECLARE @nn NVARCHAR(1024);
SET @nn=dbo.分類產品清單(1);
PRINT @nn;

----------------------------------------------------------------

/* HOMEWORK

1. 訂單出貨一覽

例：
訂單號  客戶號  送貨地址					訂購產品
10248	VINET	台北市北平東路24號3樓之一   42(10), 72(5)
10249	TOMSP	高雄市中正路一段12號        14(9), 51(40)
10250	HANAR	高雄市中正路一段12號        41(10), 51(35), 65(15)
*/

--2. 產線良率

CREATE TABLE 良率表
(
  線別 CHAR(2),
  站別 INT,
  良率 MONEY
)
GO
INSERT INTO 良率表 VALUES('L1',1,0.8),('L1',2,0.9),('L1',3,0.7)
INSERT INTO 良率表 VALUES('L2',1,0.9),('L2',2,0.9),('L2',3,0.8),('L2',4,0.9)

SELECT * FROM 良率表

--------------------------------------------------------------
CREATE TABLE 練習訂單
(
    訂單編號 CHAR(14) DEFAULT dbo.自訂單號(),
	金額 INT,
	訂單時間 DATETIME2(2) DEFAULT SYSDATETIME()
)
GO

CREATE FUNCTION 自訂單號() RETURNS VARCHAR(14)
AS 
	BEGIN 
		DECLARE @prefixOrderId VARCHAR(14);
		DECLARE @searchOrderId VARCHAR(14);
		DECLARE @lastOrderId VARCHAR(14);
		DECLARE @finalOrderId VARCHAR(14);

		DECLARE @num INT;
		DECLARE @numS VARCHAR(6);

		SET @prefixOrderId = FORMAT(GETDATE(), 'yyyyMMdd');
		SET @searchOrderId = @prefixOrderId + '%';

		SELECT TOP(1) @lastOrderId = 訂單編號 FROM 練習訂單
		WHERE 訂單編號 LIKE @searchOrderId
		ORDER BY 訂單編號 DESC;

		IF @@ROWCOUNT=0
		SET @finalOrderId=@prefixOrderId+'000001';
		ELSE
		  BEGIN
			SET @numS=SUBSTRING(@lastOrderId,9,6);
			SET @num=CONVERT(INT,@numS)+1;
			SET @numS=FORMAT(@num,'000000');
			SET @finalOrderId=@prefixOrderId+@numS;
		  END
		RETURN @finalOrderId
	 END
GO


-----------------------------------------------------------------

SELECT TOP(3) C.產品,SUM(B.數量) AS 購買數量
FROM 訂貨主檔 AS A JOIN 訂貨明細 AS B ON A.訂單號碼=B.訂單號碼
	JOIN 產品資料 AS C ON B.產品編號=C.產品編號
WHERE A.客戶編號='ANATR'
GROUP BY C.產品
ORDER BY 購買數量 DESC


CREATE FUNCTION 客戶購買前三(@customerId VARCHAR(5)) RETURNS TABLE
AS
	RETURN (
		SELECT TOP(3) C.產品,SUM(B.數量) AS 購買數量
		FROM 訂貨主檔 AS A JOIN 訂貨明細 AS B ON A.訂單號碼=B.訂單號碼
			JOIN 產品資料 AS C ON B.產品編號=C.產品編號
		WHERE A.客戶編號=@customerId
		GROUP BY C.產品
		ORDER BY 購買數量 DESC
	)
GO
	
SELECT * FROM 客戶
SELECT * FROM dbo.客戶購買前三('BLAUS')

SELECT A.客戶編號,A.公司名稱,B.產品,B.購買數量
FROM 客戶 AS A CROSS APPLY dbo.客戶購買前三(A.客戶編號) AS B;


-----------------------------------------------------------------



EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'clr strict security', 0;
RECONFIGURE;


CREATE ASSEMBLY [NET組件]
FROM 'C:\SQLData\SQLNET.dll'
WITH PERMISSION_SET=SAFE;		-- SAFE | EXTERNAL | UNSAFE
GO

CREATE FUNCTION 自訂NET分組(@value BIGINT,@start BIGINT,@end BIGINT,@range BIGINT) RETURNS NVARCHAR(1024)
AS
EXTERNAL NAME [NET組件].[SQLNET.MyNET].[MyPartition];
GO


EXEC sp_configure 'clr enable', 1;
RECONFIGURE;

SELECT dbo.自訂NET分組(薪資,0,100000000,10000) AS 薪資等級,COUNT(*) AS 人數
FROM 員工
GROUP BY dbo.自訂NET分組(薪資,0,100000000,10000);



---------------------------------------------------------------------------------

CREATE FUNCTION 繁轉簡(@value NVARCHAR(1024)) RETURNS NVARCHAR(1024)
AS
EXTERNAL NAME [NET組件].[SQLNET.MyNET].[T2S];
GO
CREATE FUNCTION 簡轉繁(@value NVARCHAR(1024)) RETURNS NVARCHAR(1024)
AS
EXTERNAL NAME [NET組件].[SQLNET.MyNET].[S2T];
GO


SELECT 客戶編號
	,dbo.繁轉簡(公司名稱) AS 公司名稱
	,dbo.繁轉簡(連絡人) AS 連絡人
	,dbo.繁轉簡(連絡人職稱) AS 連絡人職稱
	,dbo.繁轉簡(地址) AS 地址
INTO 簡體版客戶
FROM 客戶

SELECT * FROM 簡體版客戶;

SELECT 客戶編號
	,dbo.簡轉繁(公司名稱) AS 公司名稱
	,dbo.簡轉繁(連絡人) AS 連絡人
	,dbo.簡轉繁(連絡人職稱) AS 連絡人職稱
	,dbo.簡轉繁(地址) AS 地址
FROM 簡體版客戶;

