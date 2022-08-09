-- USE 中文北風
-- GO
-- SELECT * FROM 員工
USE 練習
GO

CREATE TABLE 文字練習
(
	文字1 VARCHAR(20),
	文字2 NVARCHAR(20)
)
GO

INSERT INTO 文字練習 VALUES ('繡繡繡繡繡繡繡繡繡繡','繡繡繡繡繡繡繡繡繡繡');
INSERT INTO 文字練習 VALUES ('堃堃堃堃堃堃堃堃堃堃','堃堃堃堃堃堃堃堃堃堃');
INSERT INTO 文字練習 VALUES ('紤紤紤紤紤紤紤紤紤紤','紤紤紤紤紤紤紤紤紤紤');
INSERT INTO 文字練習 VALUES('菸菸菸菸菸菸菸菸菸菸','菸菸菸菸菸菸菸菸菸菸');
INSERT INTO 文字練習 VALUES('烟烟烟烟烟烟烟烟烟烟','烟烟烟烟烟烟烟烟烟烟');
INSERT INTO 文字練習 VALUES('喆喆喆喆喆喆喆喆喆喆','喆喆喆喆喆喆喆喆喆喆');
INSERT INTO 文字練習 VALUES('燚燚燚燚燚燚燚燚燚燚','燚燚燚燚燚燚燚燚燚燚');
INSERT INTO 文字練習 VALUES('ポイントでランクけし','ポイントでランク付けしている。ただ');
INSERT INTO 文字練習 VALUES('제품카탈로그다운로드','제품카탈로그다운로드');
INSERT INTO 文字練習 VALUES('ตรวจสอบสถานะการซ่อม','ตรวจสอบสถานะการซ่อม');

SELECT * FROM 文字練習;

-- 加了'N' (NEW CODE )可以使用UTF-16 來處理因國籍文字無法讀取的問題
INSERT INTO 文字練習 VALUES (N'繡繡繡繡繡繡繡繡繡繡',N'繡繡繡繡繡繡繡繡繡繡'); 
INSERT INTO 文字練習 VALUES (N'堃堃堃堃堃堃堃堃堃堃',N'堃堃堃堃堃堃堃堃堃堃');
INSERT INTO 文字練習 VALUES (N'紤紤紤紤紤紤紤紤紤紤',N'紤紤紤紤紤紤紤紤紤紤');
INSERT INTO 文字練習 VALUES(N'菸菸菸菸菸菸菸菸菸菸',N'菸菸菸菸菸菸菸菸菸菸');
INSERT INTO 文字練習 VALUES(N'烟烟烟烟烟烟烟烟烟烟',N'烟烟烟烟烟烟烟烟烟烟');
INSERT INTO 文字練習 VALUES(N'喆喆喆喆喆喆喆喆喆喆',N'喆喆喆喆喆喆喆喆喆喆');
INSERT INTO 文字練習 VALUES(N'燚燚燚燚燚燚燚燚燚燚',N'燚燚燚燚燚燚燚燚燚燚');
INSERT INTO 文字練習 VALUES(N'ポイントでランクけし',N'ポイントでランク付けしている。ただ');
INSERT INTO 文字練習 VALUES(N'제품카탈로그다운로드',N'제품카탈로그다운로드');
INSERT INTO 文字練習 VALUES(N'ตรวจสอบสถานะการซ่อม',N'ตรวจสอบสถานะการซ่อม');

SELECT * FROM 文字練習;

DROP TABLE 文字練習;
--------------------------------------------------

USE 新新
GO

EXEC sp_helpdb '新新';
GO

CREATE TABLE [員工表]
(
	[員工編號] INT,
	[姓名] NVARCHAR(15),
	[性別] BIT,
	[生日] DATE,
	[薪資] INT,
	[照片] VARBINARY(MAX),
)
ON [人事群]
 
/*
CREATE TABLE [員工表]
(
    [員工編號] INT,
	[姓名] NVARCHAR(10),
	性別 BIT,
	生日 DATE,
	薪資 INT,
	相片 VARBINARY(MAX)
)
ON [人事群]
TEXTIMAGE_ON [大型物件群]; -- 確保與舊版本相容
GO
*/

DROP TABLE [員工表];
SELECT * FROM [員工表];

-- Computed Column 計算欄位
CREATE TABLE [員工表]
(
	[員工編號] INT,
	[姓名] NVARCHAR(15),
	[性別] BIT,
	[生日] DATE,
	[年齡] AS YEAR(GETDATE())-YEAR([生日]),
	[薪資] INT,
	[年薪] AS [薪資]*15 PERSISTED,
)
ON [人事群]
GO


SELECT GETDATE()			--DATETIME
SELECT SYSDATETIME()		--DATETIME2

SELECT YEAR(GETDATE())





