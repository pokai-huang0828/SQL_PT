EXEC sp_helpdb;
EXEC sp_helpdb '�s�s';

SELECT * FROM sys.databases;
USE [�s�s]
GO

--SELECT DB_NAME();  --�d�ߥ��b�ϥΪ�db
EXEC sp_helpfilegroup;
SELECT * FROM sys.filegroups;


EXEC sp_helpfile;
SELECT * FROM sys.sysaltfiles;