USE [master]
GO

--���u / �W�� ��Ʈw
ALTER DATABASE [�s�s] SET OFFLINE;
GO
ALTER DATABASE [�s�s] SET ONLINE;
GO

--���� / ���[ ��Ʈw
EXEC sp_helpdb '�s�s';
EXECUTE sp_detach_db '�s�s';
EXECUTE sp_attach_db '�s�s','C:\�s�s�a\D\�s�D.mdf',
	'C:\�s�s�a\E\�H1.ndf','C:\�s�s�a\E\�H2.ndf','C:\�s�s�a\E\�H3.ndf',
	'C:\�s�s�a\F\�|1.ndf','C:\�s�s�a\F\�|2.ndf','C:\�s�s�a\G\�s�O.ldf';
GO

/* ���Y��Ʈw / �ɮ�
	Shrink �\��ؼ�
	1. �h�a
	2. ����
*/
USE [�s�s]
GO
DBCC SHRINKFILE(N'�H��3', EMPTYFILE)
GO
ALTER DATABASE [�s�s] REMOVE FILE [�H��3];
GO
DBCC SHRINKFILE(N'�H��2', EMPTYFILE)
GO
ALTER DATABASE [�s�s] REMOVE FILE [�H��2];
GO
DBCC SHRINKFILE(N'�|�p2', EMPTYFILE)
GO
ALTER DATABASE [�s�s] REMOVE FILE [�|�p2];
GO

-- �[�J��� / �s��
ALTER DATABASE [�s�s] ADD FILE
(
	NAME='�H��2', FILENAME='C:\�s�s�a\I\�H2.ndf',
	SIZE=10MB, FILEGROWTH=40%
) TO FILEGROUP [�H�Ƹs]
GO

ALTER DATABASE [�s�s] ADD FILEGROUP [��P�s]
GO

ALTER DATABASE [�s�s] ADD FILE
(
	NAME='��P1', FILENAME='C:\�s�s�a\H\��P1.ndf',
	SIZE=10MB, FILEGROWTH=40%
) TO FILEGROUP [��P�s]
GO
EXEC sp_helpdb '�s�s';