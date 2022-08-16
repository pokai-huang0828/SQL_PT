USE 練習
GO

EXEC sp_help '員工表';
SELECT * FROM sys.tables;


/*	自動編號 (企業不常用)
		1. 整數型別 (INT、BIGINT)
		2. 每張資料表職能有一個

	問題點: 
		1. 破表(號碼用盡)	
		2. 跳號
*/

CREATE TABLE 編號測試表
(
	編號 INT IDENTITY(1,1), -- (開始值, 成長值)
	姓名 NVARCHAR(10),
	薪資 INT,
)

INSERT INTO 編號測試表 VALUES('DDD','DDD');
INSERT INTO 編號測試表 VALUES('DDD',400);

--- 手動補自動編號(各家都有自己的一套方式)
SET IDENTITY_INSERT [編號測試表] ON;
INSERT INTO 編號測試表(編號, 姓名, 薪資) VALUES(5, 'KKKK',400);
SET IDENTITY_INSERT [編號測試表] OFF;

SELECT * FROM 編號測試表

----------------------------------------------------
CREATE TABLE 編號測試表2
(
	自動編號 INT IDENTITY(1,1), -- (開始值, 成長值)
	全球唯一編號1 UNIQUEIDENTIFIER,
	資料 NVARCHAR(10),
)
GO

INSERT INTO 編號測試表2(資料) VALUES('AAA');
INSERT INTO 編號測試表2(資料) VALUES('BBB');
INSERT INTO 編號測試表2(資料) VALUES('CCC');
INSERT INTO 編號測試表2(全球唯一編號1,資料) VALUES(NEWID(),'DDD');
INSERT INTO 編號測試表2(全球唯一編號1,資料) VALUES(NEWID(),'EEE');
INSERT INTO 編號測試表2(全球唯一編號1,資料) VALUES(NEWID(),'FFF');

SELECT * FROM [編號測試表2];

---------------------------------------------------------------------

CREATE TABLE 編號測試表3
(
    自動編號 INT IDENTITY(1,1),
	全球唯一編號1 UNIQUEIDENTIFIER DEFAULT NEWID(),  --- UNIQUEIDENTIFIER 較常當作資料編號
	全球唯一編號2 UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID(),  --- 比較統一，不會重複
	資料 NVARCHAR(10)	
)
GO

INSERT INTO 編號測試表3(資料) VALUES('AAA');
INSERT INTO 編號測試表3(資料) VALUES('BBB');
INSERT INTO 編號測試表3(資料) VALUES('CCC');
INSERT INTO 編號測試表3(資料) VALUES('DDD');
INSERT INTO 編號測試表3(資料) VALUES('EEE');
INSERT INTO 編號測試表3(資料) VALUES('FFF');
INSERT INTO 編號測試表3(資料) VALUES('GGG');
INSERT INTO 編號測試表3(資料) VALUES('HHH');
INSERT INTO 編號測試表3(資料) VALUES('III');

SELECT * FROM [編號測試表3];

----------------------------------------------------------------------
/* 更改表格

*/
EXEC sp_help '員工表'

ALTER TABLE [員工表] ADD [到職日] DATE CONSTRAINT 到職日預設 DEFAULT GETDATE();
ALTER TABLE [員工表] ALTER COLUMN [姓名] NVARCHAR(20);
ALTER TABLE [員工表] DROP COLUMN [到職日];

ALTER TABLE [員工表] DROP CONSTRAINT 到職日預設;
ALTER TABLE [員工表] DROP COLUMN [到職日];

ALTER TABLE [員工表] ADD CONSTRAINT 最低薪資檢查 CHECK(薪資>=25250);
ALTER TABLE [員工表] WITH CHECK ADD CONSTRAINT 最低薪資檢查 CHECK(薪資>=25250);
ALTER TABLE [員工表] WITH NOCHECK ADD CONSTRAINT 最低薪資檢查 CHECK(薪資>=25250);  -- 之前不符合的不記入檢查

SELECT * FROM [員工表];

INSERT INTO [員工表] VALUES(7, 'JJJJ', 0, '2000-1-25', 28000, DEFAULT),
							(8, 'TTT', 1, '2002-4-25', 27000, DEFAULT),
							(9, 'UUU', 0, '1997-4-25', 38000, DEFAULT);

INSERT INTO [員工表](員工號, 姓名, 性別, 生日, 薪資) VALUES(5, 'DDDD', 1, '1995-12-25', 88000);
INSERT INTO [員工表](員工號, 姓名, 生日, 薪資) VALUES(6, 'DFGHH', '1999-2-25', 48000);

--- 暫時 關閉/開啟 條件約束
ALTER TABLE [員工表] NOCHECK CONSTRAINT 最低薪資檢查;
INSERT INTO [員工表] VALUES(10,'LLLLLL',0,'1990-7-17',38000, DEFAULT);
ALTER TABLE [員工表] CHECK CONSTRAINT 最低薪資檢查;

SELECT * FROM [員工表];

--------------------------------------------------------------------------------
/* 實務上，禁止使用星號(*)

	1. 網路傳輸一堆無用的資料
	2. 用星號就是懶、不清楚資料內容
	3. 造成資料查詢最佳化判斷失準，資料庫讀取速度變慢，失去索引判斷必需從頭尋到尾

*/
SELECT * FROM [員工表];

SELECT 員工號, 姓名, 薪資 FROM [員工表];
SELECT 員工號, 姓名, 薪資 FROM [員工表] WHERE 薪資 >= 35000;

CREATE TABLE [員工2]
(
	工號 INT,
	姓名 NVARCHAR(10),
	性別 BIT,
	薪水 INT
)
GO

INSERT INTO [員工2](工號, 姓名, 性別, 薪水)
	SELECT 員工號, 姓名, 性別, 薪資 FROM [員工表] WHERE 薪資 >= 35000; 

SELECT * FROM [員工2];

----------------------------------------------------------------------------------------
SELECT 員工號, 姓名, 薪資 FROM [員工表] WHERE 員工號 <= 7;

---- SQL Server 特有語法
SELECT 員工號, 姓名, 性別, 薪資
INTO [員工表3] --- 全新，不存在的資料表
FROM [員工表]
WHERE 員工號 <= 7;

SELECT * FROM [員工表3];

SELECT 員工號, 姓名, 性別, 薪資, 生日
INTO [員工表4] --- 全新，不存在的資料表
FROM [員工表]
WHERE 1=0;

SELECT * FROM [員工表4];

-- MySQL
-- CREATE TABLE [員工表5] LIKE [員工表]