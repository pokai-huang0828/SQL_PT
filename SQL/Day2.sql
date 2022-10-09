USE 練習
GO

--SELECT DB_NAME();  --查詢正在使用的db
EXEC sp_helpfilegroup;
SELECT * FROM sys.filegroups;

EXEC sp_helpfile;
SELECT * FROM sys.sysaltfiles;


--離線 / 上限 資料庫
ALTER DATABASE [新新] SET OFFLINE;
GO
ALTER DATABASE [新新] SET ONLINE;
GO

--卸離 / 附加 資料庫 - 1
EXEC sp_helpdb '新新';
EXECUTE sp_detach_db '新新';
EXECUTE sp_attach_db '新新','C:\新新家\D\新主.mdf',
	'C:\新新家\E\人1.ndf','C:\新新家\E\人2.ndf','C:\新新家\E\人3.ndf',
	'C:\新新家\F\會1.ndf','C:\新新家\F\會2.ndf','C:\新新家\G\新記.ldf';
GO

--卸離 / 附加 資料庫 - 2
EXEC sp_detach_db '新新';
CREATE DATABASE [新新]
ON
( FILENAME='C:\新新家\D\新主.mdf' ),
( FILENAME='C:\新新家\E\人1.ndf' ),
( FILENAME='C:\新新家\E\人2.ndf' ),
( FILENAME='C:\新新家\E\人3.ndf' ),
( FILENAME='C:\新新家\F\會1.ndf' ),
( FILENAME='C:\新新家\F\會2.ndf' ),
( FILENAME='C:\新新家\G\新記.ldf' )
FOR ATTACH;

EXEC sp_helpdb [新新];
SELECT * FROM sys.databases;
SELECT [database_id],[name],[recovery_model_desc],[is_ansi_nulls_on],[is_ansi_null_default_on] FROM sys.databases;

ALTER DATABASE [新新] SET ONLINE;

ALTER DATABASE [新新] SET RECOVERY SIMPLE;
ALTER DATABASE [新新] SET ANSI_NULLS ON;
ALTER DATABASE [新新] SET ANSI_NULL_DEFAULT ON;


/* When user is using, some thing that you can not do.
	1. 刪除
	2. 離線
	3. 卸離
	4. 還原
	5. 某些設定不可調整
*/
USE [新新];
ALTER DATABASE [新新] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
ALTER DATABASE [新新] SET MULTI_USER WITH ROLLBACK IMMEDIATE;
	

USE [master]
GO
CREATE DATABASE [AdventureWorks2012] ON 
( FILENAME = N'C:\SQLData\AdventureWorks2012_Data.mdf' ),
( FILENAME = N'C:\SQLData\AdventureWorks2012_log.ldf' )
 FOR ATTACH
GO

CREATE DATABASE [中文北風] ON 
( FILENAME = N'C:\SQLData\中文北風.mdf' ),
( FILENAME = N'C:\SQLData\中文北風_log.ldf' )
 FOR ATTACH
GO

CREATE DATABASE [練練] ON 
( FILENAME = N'C:\SQLData\練練.mdf' ),
( FILENAME = N'C:\SQLData\練練_log.ldf' )
 FOR ATTACH
GO

SELECT * FROM sys.databases;
ALTER DATABASE [AdventureWorks2012] SET COMPATIBILITY_LEVEL=150;