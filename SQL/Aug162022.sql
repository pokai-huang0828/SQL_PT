USE 練習
GO

EXEC sp_help '員工表';
SELECT * FROM sys.tables;


/*	自動編號 
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
INSERT INTO 編號測試表2(全球唯一編號1,資料) VALUES(NEWSEQUENTIALID(),'GGG');

SELECT * FROM [編號測試表2];



CREATE TABLE 編號測試表3
(
    自動編號 INT IDENTITY(1,1),
	全球唯一編號1 UNIQUEIDENTIFIER DEFAULT NEWID(),
	全球唯一編號2 UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID(),  --- 比較統一
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

