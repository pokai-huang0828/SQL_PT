EXEC sp_helpdb;
EXEC sp_helpdb '新新';

SELECT * FROM sys.databases;
USE [新新]
GO

--SELECT DB_NAME();  --查詢正在使用的db
EXEC sp_helpfilegroup;
SELECT * FROM sys.filegroups;


EXEC sp_helpfile;
SELECT * FROM sys.sysaltfiles;