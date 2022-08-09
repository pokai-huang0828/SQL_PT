/*	ISO RDMS 命名規則:
		1. 只能用文字或底線開頭。
		2. 第2字可用文字、底線或數字。
		3. 不得使用關鍵字(KeyWord)。
		4. 可利用 [] 來表達特殊命名、或名字以及空白。

*/
-- 執行命令 ==> GO
-- SQL 語法不在乎換行，僅為了便於觀看!
-- 執行中可利用滑鼠圈選並點選執行來執行圈選內的code!
CREATE DATABASE [DATABASE_NAME]; --建立資料庫
GO

DROP DATABASE [DATABASE_NAME]; -- 刪除資料庫
GO
-- 一次執行批次命令(批次執行)

-- *重要!!當系統崩潰無法連線時進入以下path可觀看錯誤檔案訊息:
-- C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Log

-- 重新建置新的ERRORLOG file
EXECUTE sp_cycle_errorlog;
EXEC sp_cycle_errorlog;

--
CREATE DATABASE TEST1
ON PRIMARY
(
	NAME='TESTDATA', FILENAME='C:\test+\testdata.mdf',
	SIZE=20MB, MAXSIZE=UNLIMITED, FILEGROWTH=30MB
)
