--SELECT COUNT(*) FROM sys.tables WHERE [name]='北風產品'

IF (SELECT COUNT(*) FROM sys.tables WHERE [name]='北風產品')>0
	TRUNCATE TABLE [北風產品];
ELSE
  BEGIN
	CREATE TABLE 北風產品
	(
	   產品編號 INT,
	   產品名稱 NVARCHAR(20),
	   供應商編號 INT,
	   類別編號 INT,
	   單價 MONEY,
	   單位數量 NVARCHAR(5),
	   庫存量 INT
	)
  END

DROP TABLE 北風產品
SELECT * FROM 北風產品
