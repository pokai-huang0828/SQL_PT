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