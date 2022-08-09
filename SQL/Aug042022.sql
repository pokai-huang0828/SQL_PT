EXEC sp_helpdb '�s�s';

USE [�s�s];
GO

EXEC sp_helpfile;
SELECT * FROM sys.sysfiles;

EXEC sp_helpfilegroup;
SELECT * FROM sys.filegroups;

ALTER DATABASE [�s�s] MODIFY FILEGROUP [�H�Ƹs] DEFAULT;
ALTER DATABASE [�s�s] MODIFY FILEGROUP [��P�s] READ_ONLY;

--���� / ���[ ��Ʈw
EXEC sp_helpdb '�s�s';
EXECUTE sp_detach_db '�s�s';

CREATE DATABASE [�s�s]
ON
(FILENAME='C:\�s�s�a\D\�s�D.mdf'),
(FILENAME='C:\�s�s�a\E\�H1.ndf'),
(FILENAME='C:\�s�s�a\F\�|1.ndf'),
(FILENAME='C:\�s�s�a\G\�s�O.ldf'),
(FILENAME='C:\�s�s�a\H\��P1.ndf'),
(FILENAME='C:\�s�s�a\I\�H2.ndf')
FOR ATTACH;
GO


EXEC sp_helpdb [�s�s];
SELECT * FROM sys.databases;
SELECT [database_id],[name],[recovery_model_desc],[is_ansi_nulls_on],[is_ansi_null_default_on] FROM sys.databases;


ALTER DATABASE [�s�s] SET ONLINE;

ALTER DATABASE [�s�s] SET RECOVERY SIMPLE;
ALTER DATABASE [�s�s] SET ANSI_NULLS ON;
ALTER DATABASE [�s�s] SET ANSI_NULL_DEFAULT ON;


/* When user is using, some thing that you can not do.
	1. �R��
	2. ���u
	3. ����
	4. �٭�
	5. �Y�ǳ]�w���i�վ�

*/
USE [�s�s];
ALTER DATABASE [�s�s] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
ALTER DATABASE [�s�s] SET MULTI_USER WITH ROLLBACK IMMEDIATE;
	

USE [master]
GO
CREATE DATABASE [AdventureWorks2012] ON 
( FILENAME = N'C:\SQLData\AdventureWorks2012_Data.mdf' ),
( FILENAME = N'C:\SQLData\AdventureWorks2012_log.ldf' )
 FOR ATTACH
GO

CREATE DATABASE [����_��] ON 
( FILENAME = N'C:\SQLData\����_��.mdf' ),
( FILENAME = N'C:\SQLData\����_��_log.ldf' )
 FOR ATTACH
GO

CREATE DATABASE [�m�m] ON 
( FILENAME = N'C:\SQLData\�m�m.mdf' ),
( FILENAME = N'C:\SQLData\�m�m_log.ldf' )
 FOR ATTACH
GO

SELECT * FROM sys.databases;
ALTER DATABASE [AdventureWorks2012] SET COMPATIBILITY_LEVEL=150;
