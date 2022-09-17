
----  課程教學進度
--- 成功/失敗通知
--- 時序容器

--- 控制台 -> 服務 -> DTC (Distributed Transaction Coordinator) Check Enable!
--- 分散式交易協調器

--- 錯誤報告 OLE DB 目的地錯誤輸出 
--- 利用時序容器調整偵錯順序

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

--- 顯示->其他視窗-> variable

---  1. 每次匯出 北風客戶_20220917_162430.csv
---  2. 每次備分資料庫
---  提示 : 執行 SQL 工作編輯器 -> SQLSourseType -> 變數
