USE [master]
GO

--離線 / 上限 資料庫
ALTER DATABASE [新新] SET OFFLINE;
GO
ALTER DATABASE [新新] SET ONLINE;
GO

--卸離 / 附加 資料庫
EXEC sp_helpdb '新新';
EXECUTE sp_detach_db '新新';
EXECUTE sp_attach_db '新新','C:\新新家\D\新主.mdf',
	'C:\新新家\E\人1.ndf','C:\新新家\E\人2.ndf','C:\新新家\E\人3.ndf',
	'C:\新新家\F\會1.ndf','C:\新新家\F\會2.ndf','C:\新新家\G\新記.ldf';
GO

/* 壓縮資料庫 / 檔案
	Shrink 功能目標
	1. 搬家
	2. 併檔
*/
USE [新新]
GO
DBCC SHRINKFILE(N'人事3', EMPTYFILE)
GO
ALTER DATABASE [新新] REMOVE FILE [人事3];
GO
DBCC SHRINKFILE(N'人事2', EMPTYFILE)
GO
ALTER DATABASE [新新] REMOVE FILE [人事2];
GO
DBCC SHRINKFILE(N'會計2', EMPTYFILE)
GO
ALTER DATABASE [新新] REMOVE FILE [會計2];
GO

-- 加入資料 / 群組
ALTER DATABASE [新新] ADD FILE
(
	NAME='人事2', FILENAME='C:\新新家\I\人2.ndf',
	SIZE=10MB, FILEGROWTH=40%
) TO FILEGROUP [人事群]
GO

ALTER DATABASE [新新] ADD FILEGROUP [行銷群]
GO

ALTER DATABASE [新新] ADD FILE
(
	NAME='行銷1', FILENAME='C:\新新家\H\行銷1.ndf',
	SIZE=10MB, FILEGROWTH=40%
) TO FILEGROUP [行銷群]
GO
EXEC sp_helpdb '新新';