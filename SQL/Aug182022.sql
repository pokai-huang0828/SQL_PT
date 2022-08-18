--SQL Server
--儲存 預存程序 回傳的資料

EXEC sp_helpdb

CREATE TABLE 資料庫資訊
(
	名稱 NVARCHAR(100),
	容量 NVARCHAR(100),
	擁有者 NVARCHAR(100),
	編號 INT,
	建立時間 DATETIME2(2),
	狀態 NVARCHAR(1024),
	相容層級 INT
)
GO

SELECT * FROM 資料庫資訊;
INSERT INTO 資料庫資訊 EXEC sp_helpdb;

-------------------------------
-- Update
USE 練習;
SELECT * FROM 員工表3;

UPDATE [員工表3]
SET 姓名='ZZZ'
WHERE 員工號=3;

UPDATE [員工表3]
SET 性別=0, 薪資=60000
WHERE 員工號=4;

UPDATE [員工表3]
SET 薪資=薪資+6000
WHERE 員工號=4;

UPDATE [員工表3]
SET 薪資=100000; -- 沒條件(WHERE)=全部改，謹慎處理!

UPDATE [員工表3] SET 姓名=NULL WHERE 員工號=7;

DELETE FROM [員工表3] WHERE 員工號=3; -- 容易造成大量刪除，謹慎處理!

-------------------------------------
--- DELETE vs. TRUNCATE
DELETE FROM [員工表3]; --- 含還原(log)，刪除速度慢
TRUNCATE TABLE [員工表3]; --- 不含還原，刪除速度快，謹慎處理

----------------------------------------------





















