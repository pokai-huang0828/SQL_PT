EXEC sp_helpdb '新新';

USE [新新];
GO

EXEC sp_helpfile;
SELECT * FROM sys.sysfiles;

EXEC sp_helpfilegroup;
SELECT * FROM sys.filegroups;

ALTER DATABASE [新新] MODIFY FILEGROUP [人事群] DEFAULT;
ALTER DATABASE [新新] MODIFY FILEGROUP [行銷群] READ_ONLY;

--卸離 / 附加 資料庫
EXEC sp_helpdb '新新';
EXECUTE sp_detach_db '新新';

CREATE DATABASE [新新]
ON
(FILENAME='C:\新新家\D\新主.mdf'),
(FILENAME='C:\新新家\E\人1.ndf'),
(FILENAME='C:\新新家\F\會1.ndf'),
(FILENAME='C:\新新家\G\新記.ldf'),
(FILENAME='C:\新新家\H\行銷1.ndf'),
(FILENAME='C:\新新家\I\人2.ndf')
FOR ATTACH;
GO


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
