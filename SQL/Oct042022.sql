--Output    搭配 DML 使用 inserted / deleted

SELECT * FROM [匠匠];
INSERT INTO [匠匠] VALUES(26,'御飯糰',30);
UPDATE [匠匠] SET 價錢=45 WHERE 產品編號=26;
DELETE FROM [匠匠] WHERE 產品編號=26;

--↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ 

INSERT INTO [匠匠]
	OUTPUT inserted.*
VALUES(26,'御飯糰',30);

DELETE FROM [匠匠]
	OUTPUT deleted.*
WHERE 產品編號=26;

UPDATE [匠匠] SET 價錢=45
	OUTPUT inserted.產品編號,inserted.品名,inserted.價錢,deleted.價錢
		,inserted.價錢-deleted.價錢 AS 價差
WHERE 產品編號=26;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT * FROM 練習訂單;

INSERT INTO 練習訂單(金額) VALUES(1111);
INSERT INTO 練習訂單(金額) OUTPUT inserted.訂單編號 VALUES(5678);

-----------------------------------------

CREATE TABLE 匠匠追蹤表
(
    產品編號 INT,
	舊產品 NVARCHAR(10),
	舊售價 MONEY,
	新產品 NVARCHAR(10),
	新售價 MONEY,
	異動狀態 NVARCHAR(10),
	帳號 NVARCHAR(100) DEFAULT SUSER_SNAME(),
	異動時間 DATETIME2(2) DEFAULT SYSDATETIME()
)
GO

SELECT * FROM 匠匠追蹤表;

SELECT * FROM 匠匠;



INSERT INTO [匠匠]
	OUTPUT inserted.*,'新增產品'
		INTO 匠匠追蹤表(產品編號,新產品,新售價,異動狀態)
VALUES(26,'御飯糰',30);


UPDATE [匠匠]
SET 品名='大顆御飯糰',價錢=45
	OUTPUT inserted.*,deleted.品名,deleted.價錢,'產品資料異動'
		INTO 匠匠追蹤表(產品編號,新產品,新售價,舊產品,舊售價,異動狀態)
WHERE 產品編號=26;


DELETE FROM [匠匠]
	OUTPUT deleted.*,'刪除產品'
		INTO 匠匠追蹤表(產品編號,舊產品,舊售價,異動狀態)
WHERE 產品編號=26;

---------------------------------------------------------------------------------------------------------------------------------

CREATE PROC 匠匠新增 @id INT,@name NVARCHAR(10),@price MONEY
AS
	INSERT INTO [匠匠]
		OUTPUT inserted.*,'新增產品'
			INTO 匠匠追蹤表(產品編號,新產品,新售價,異動狀態)
	VALUES(@id,@name,@price);
GO

CREATE PROC 匠匠修改 @id INT,@name NVARCHAR(10),@price MONEY
AS
	UPDATE [匠匠]
	SET 品名=@name,價錢=@price
		OUTPUT inserted.*,deleted.品名,deleted.價錢,'產品資料異動'
			INTO 匠匠追蹤表(產品編號,新產品,新售價,舊產品,舊售價,異動狀態)
	WHERE 產品編號=@id;
GO

CREATE PROC 匠匠刪除 @id INT
AS
	DELETE FROM [匠匠]
		OUTPUT deleted.*,'刪除產品'
			INTO 匠匠追蹤表(產品編號,舊產品,舊售價,異動狀態)
	WHERE 產品編號=@id;
GO


EXEC 匠匠新增 27,'金莎',80;
EXEC 匠匠修改 27,'大金莎',180;
EXEC 匠匠刪除 27;

SELECT * FROM 匠匠;
SELECT * FROM 匠匠追蹤表;

--------------------------------------------------------

--SQL2016 時態表

--DROP TABLE 新巨巨;
--SELECT * FROM sys.tables


CREATE TABLE dbo.新巨巨
(    
	產品編號 INT NOT NULL PRIMARY KEY
	, 產品名稱 NVARCHAR(10) NOT NULL  
	, 售價 MONEY NOT NULL     
	, [開始時間] DATETIME2(2) GENERATED ALWAYS AS ROW START  
	, [結束時間] DATETIME2(2) GENERATED ALWAYS AS ROW END  
	, PERIOD FOR SYSTEM_TIME (開始時間, 結束時間)
)    
WITH (SYSTEM_VERSIONING = ON(HISTORY_TABLE = dbo.新巨巨追蹤));  


DROP TABLE 新巨巨;
ALTER TABLE 新巨巨 SET (SYSTEM_VERSIONING = OFF);
DROP TABLE 新巨巨;
DROP TABLE [dbo].[MSSQL_TemporalHistoryFor_1525580473];

INSERT INTO 新巨巨(產品編號, 產品名稱, 售價)
	SELECT 產品編號, 品名, 價錢 FROM 練練.dbo.巨巨;

SELECT * FROM 新巨巨;

INSERT INTO 新巨巨(產品編號,產品名稱,售價) VALUES(30,'波卡',35);
DELETE FROM 新巨巨 WHERE 產品編號=29;
UPDATE 新巨巨 SET 產品名稱='大金沙',售價=180 WHERE 產品編號=28;
INSERT INTO 新巨巨(產品編號,產品名稱,售價) VALUES(31,'芝多司',30);
UPDATE 新巨巨 SET 產品名稱='大波卡',售價=50 WHERE 產品編號=30;
UPDATE 新巨巨 SET 產品名稱='大盒金沙',售價=280 WHERE 產品編號=28;


SELECT * FROM 新巨巨;
SELECT * FROM 新巨巨 FOR SYSTEM_TIME ALL;
SELECT * FROM 新巨巨 FOR SYSTEM_TIME ALL WHERE 產品編號= 28 ORDER BY 結束時間;

ALTER TABLE 新巨巨 SET (SYSTEM_VERSIONING = OFF);
ALTER TABLE 新巨巨 SET (SYSTEM_VERSIONING = ON(HISTORY_TABLE = dbo.新巨巨追蹤));

-----------------------------------------------------

/*--- ACID 交易行為(NON-SQL 沒有)
ACID，是指資料庫管理系統（DBMS）在寫入或更新資料的過程中，
為保證事務（transaction）是正確可靠的，所必須具備的四個特性：
	1. 原子性（atomicity，或稱不可分割性）
	2. 一致性（consistency）
	3. 隔離性（isolation，又稱獨立性）
	4. 持久性（durability）

在資料庫系統中，一個事務是指：由一系列資料庫操作組成的一個完整的邏輯過程。
	例如銀行轉帳，從原帳戶扣除金額，以及向目標帳戶添加金額，這兩個資料庫操作的總和，構成一個完整的邏輯過程，不可拆分。
	這個過程被稱為一個事務，具有ACID特性。
*/


SELECT * INTO 新匠匠 FROM 練練.dbo.匠匠;


SELECT * FROM 新匠匠;

DELETE FROM 新匠匠 WHERE 產品編號>=26;

INSERT INTO 新匠匠 VALUES(26,'AAA',260);
INSERT INTO 新匠匠 VALUES(27,'BBB','BBB');
INSERT INTO 新匠匠 VALUES(28,'CCC',280);
---------------
INSERT INTO 新匠匠 VALUES(26,'AAA',260),(27,'BBB','BBB'),(28,'CCC',280);

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT * FROM 新匠匠;

--BEGIN TRANSACTION   搭配 COMMIT / ROLLBACK
BEGIN TRAN
	INSERT INTO 新匠匠 VALUES(26,'AAA',260);
	INSERT INTO 新匠匠 VALUES(27,'BBB','BBB');
	INSERT INTO 新匠匠 VALUES(28,'CCC',280);
COMMIT

BEGIN TRAN
	INSERT INTO 新匠匠 VALUES(26,'AAA',260);
	INSERT INTO 新匠匠 VALUES(27,'BBB',270);
	INSERT INTO 新匠匠 VALUES(28,'CCC',280);
ROLLBACK