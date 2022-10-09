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