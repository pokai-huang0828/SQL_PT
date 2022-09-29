/*	Trigger

	1. SQL Server 中，有分為 DML Trigger | DDL Trigger 
	2. SQL Server 中，有分為 After | Instead of	
	3. 發生在特殊時間點，且不能由使用者自行呼叫，另類的預存程序
	4. 在同一資料庫中，不能有相同名字的 預存程序 / 觸發程序
	5. Trigger 是隱性效能殺手

*/
/*	SQL 語法分類

	DDL : CREATE、ALTER、DROP
	DML : INSERT、UPDATE、DELETE
	DCL : GRANT、REVOKE、DENY
	DQL : SELECT 
	DTL : TRANSACTION、COMMIT、ROLLBACK

*/

USE 練練;
ALTER TRIGGER 巨巨觸發 ON [巨巨]
AFTER INSERT, UPDATE, DELETE
AS 
	PRINT '巨巨表中有資料被異動喔!'
GO


SELECT * FROM [巨巨]
INSERT INTO [巨巨] VALUES(28, '茶理王', 25);
UPDATE [巨巨] SET 價錢 = 35 WHERE 產品編號 = 28;
DELETE FROM [巨巨] WHERE 產品編號 = 28;


CREATE TRIGGER 巨巨新增觸發 ON [巨巨]
AFTER INSERT
AS 
	PRINT '巨巨表中有資料被新增喔!'
GO

CREATE TRIGGER 巨巨更新觸發 ON [巨巨]
AFTER UPDATE
AS 
	PRINT '巨巨表中有資料被更新喔!'
GO

CREATE TRIGGER 巨巨刪除觸發 ON [巨巨]
AFTER DELETE
AS 
	PRINT '巨巨表中有資料被刪除喔!'
GO

EXEC sp_helptrigger '巨巨';
SELECT * FROM sys.triggers;
SELECT OBJECT_NAME(A.parent_id) AS 父物件, * FROM sys.triggers AS A;

DROP TRIGGER 巨巨觸發, 巨巨新增觸發, 巨巨更新觸發, 巨巨刪除觸發;


CREATE TRIGGER 巨巨新增觸發 ON 巨巨
AFTER INSERT
AS 
	DECLARE @price MONEY;
	SELECT @price = 價錢 FROM inserted;
	IF @price >= 1000
		RAISERROR('本公司不銷售超過1000元以上產品', 16, 10);
GO


ALTER TRIGGER 巨巨新增觸發 ON 巨巨
AFTER INSERT
AS
	DECLARE @price MONEY;
	SELECT @price=價錢 FROM inserted;
	IF @price>=1000	 
		THROW 50010,'本公司不銷售超過1000元以上的產品',10;		
GO

INSERT INTO [巨巨] VALUES(29, '超貴純契茶', 900);
INSERT INTO [巨巨] VALUES(30, '超貴可樂', 1200);
SELECT * FROM [巨巨];

--------------------------------------------------------------

SELECT * FROM sys.tables;
SELECT * FROM sys.views;
SELECT * FROM sys.triggers;

SELECT * FROM sys.objects;
SELECT * FROM sys.objects WHERE [type]='u';
SELECT * FROM sys.objects WHERE [type]='v';
SELECT * FROM sys.objects WHERE [type]='p';
SELECT * FROM sys.objects WHERE [type]='fn';
SELECT * FROM sys.objects WHERE [type]='if';
SELECT * FROM sys.objects WHERE [type]='tf';
SELECT * FROM sys.objects WHERE [type]='tr';

-------------------------------------------------------------


CREATE TRIGGER 巨巨更新觸發 ON 巨巨
AFTER UPDATE
AS
	DECLARE @oldPrice MONEY;
	DECLARE @newPrice MONEY;
	SELECT @newPrice=價錢 FROM inserted;
	SELECT @oldPrice=價錢 FROM deleted;
	IF @newPrice>@oldPrice*1.2 OR @newPrice<@oldPrice*0.8
		THROW 50010,'本公司產品售價調整不得超過原價百分之20',10;		
GO

SELECT * FROM [巨巨];
UPDATE [巨巨] SET 價錢=100 WHERE 產品編號=29;
UPDATE [巨巨] SET 價錢=1000 WHERE 產品編號=29;

----------------------------------------------------------------

USE 中文北風;

SELECT * FROM 員工;

------------------------------------------------

USE 練練;

DROP TRIGGER 巨巨觸發,巨巨新增觸發,巨巨更新觸發,巨巨刪除觸發;


CREATE TABLE 巨巨追蹤表
(
    產品編號 INT,
	產品名稱 NVARCHAR(10),
	售價 MONEY,
	異動狀態 NVARCHAR(10),
	帳號 NVARCHAR(100) DEFAULT SUSER_SNAME(),
	異動時間 DATETIME2(2) DEFAULT SYSDATETIME()
)
GO


CREATE TRIGGER [巨巨新增觸發] ON [巨巨]
AFTER INSERT
AS
	INSERT INTO 巨巨追蹤表(產品編號,產品名稱,售價,異動狀態)
		SELECT 產品編號,品名,價錢,'新增產品' FROM inserted;
GO
CREATE TRIGGER [巨巨刪除觸發] ON [巨巨]
AFTER DELETE
AS
	INSERT INTO 巨巨追蹤表(產品編號,產品名稱,售價,異動狀態)
		SELECT 產品編號,品名,價錢,'刪除產品' FROM deleted;
GO
CREATE TRIGGER [巨巨更新觸發] ON [巨巨]
AFTER UPDATE
AS
	IF UPDATE(品名)
	  BEGIN
	    INSERT INTO 巨巨追蹤表(產品編號,產品名稱,異動狀態)
			SELECT 產品編號,品名,'產品品名異動前' FROM deleted;
		INSERT INTO 巨巨追蹤表(產品編號,產品名稱,異動狀態)
			SELECT 產品編號,品名,'產品品名異動後' FROM inserted;
	  END
	IF UPDATE(價錢)
	  BEGIN
	    INSERT INTO 巨巨追蹤表(產品編號,售價,異動狀態)
			SELECT 產品編號,價錢,'產品價格異動前' FROM deleted;
		INSERT INTO 巨巨追蹤表(產品編號,售價,異動狀態)
			SELECT 產品編號,價錢,'產品價格異動後' FROM inserted;
	  END
GO


SELECT * FROM [巨巨];
INSERT INTO [巨巨] VALUES(30,'波卡',30);
UPDATE [巨巨] SET 價錢=35 WHERE 產品編號=30;
DELETE FROM [巨巨] WHERE 產品編號=30;

SELECT * FROM [巨巨追蹤表];

----------------------------------------------------

CREATE TABLE 姓名表
(
	姓 NVARCHAR(5),
	名 NVARCHAR(5)
)
GO

CREATE VIEW 姓名檢視
AS
	SELECT 姓+名 AS 姓名 FROM 姓名表
GO

INSERT INTO 姓名表 VALUES('孫','小美');

SELECT * FROM 姓名表;
SELECT * FROM 姓名檢視;

INSERT INTO 姓名檢視 VALUES('阿土伯');
INSERT INTO 姓名檢視 VALUES('烏咪');
INSERT INTO 姓名檢視 VALUES('撒隆巴斯');
INSERT INTO 姓名檢視 VALUES('錢夫人');
INSERT INTO 姓名檢視 VALUES('舞美拉');

CREATE TRIGGER 姓名檢視新增觸發 ON [姓名檢視]
INSTEAD OF INSERT
AS
    DECLARE @name NVARCHAR(10);
	SELECT @name=姓名 FROM inserted;

	IF LEN(@name)=2 INSERT INTO 姓名表 VALUES(SUBSTRING(@name,1,1),SUBSTRING(@name,2,1));
	IF LEN(@name)=3 INSERT INTO 姓名表 VALUES(SUBSTRING(@name,1,1),SUBSTRING(@name,2,2));
	IF LEN(@name)=4 INSERT INTO 姓名表 VALUES(SUBSTRING(@name,1,2),SUBSTRING(@name,3,2));
GO


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
