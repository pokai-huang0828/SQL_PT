/*	ISO RDMS �R�W�W�h:
		1. �u��Τ�r�Ω��u�}�Y�C
		2. ��2�r�i�Τ�r�B���u�μƦr�C
		3. ���o�ϥ�����r(KeyWord)�C
		4. �i�Q�� [] �Ӫ�F�S��R�W�B�ΦW�r�H�ΪťաC

*/
-- ����R�O ==> GO
-- SQL �y�k���b�G����A�Ȭ��F�K���[��!
-- ���椤�i�Q�ηƹ������I�����Ӱ����鷺��code!
CREATE DATABASE [DATABASE_NAME]; --�إ߸�Ʈw
GO

DROP DATABASE [DATABASE_NAME]; -- �R����Ʈw
GO
-- �@������妸�R�O(�妸����)

-- *���n!!��t�αY��L�k�s�u�ɶi�J�H�Upath�i�[�ݿ��~�ɮװT��:
-- C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Log

-- ���s�ظm�s��ERRORLOG file
EXECUTE sp_cycle_errorlog;
EXEC sp_cycle_errorlog;

--
CREATE DATABASE TEST1
ON PRIMARY
(
	NAME='TESTDATA', FILENAME='C:\test+\testdata.mdf',
	SIZE=20MB, MAXSIZE=UNLIMITED, FILEGROWTH=30MB
)

--------------------------------------------------

CREATE DATABASE �m��
ON PRIMARY
(
	NAME='�D�����', FILENAME='C:\�m�ߪ��a\�m��.mdf',
	SIZE=20MB, MAXSIZE=UNLIMITED, FILEGROWTH=50%
)
LOG ON
(
	NAME='�O����', FILENAME='C:\�m�ߪ��a\�m�O.ldf',
	SIZE=30MB, MAXSIZE=UNLIMITED, FILEGROWTH=60%
)


EXEC sp_helpdb;
EXEC sp_helpdb '�m��';

SELECT * FROM sys.databases;
USE �m��
GO

--SELECT DB_NAME();  --�d�ߥ��b�ϥΪ�db
EXEC sp_helpfilegroup;
SELECT * FROM sys.filegroups;


EXEC sp_helpfile;
SELECT * FROM sys.sysaltfiles;

/*--- �޲z���M�ݳs�u (DAC)
	1. �������޲z���b��
	2. �C��SQL�������(instance)�u���@��
	3. �w�]�u�ॻ���s�u�ϥΡA�L�k���ݳs�u�ϥ�(���i�}�ҡA��G�ۭt)
*/

CREATE DATABASE [�s�s]
ON PRIMARY
(
	NAME='�s�s�D��',FILENAME='C:\�s�s�a\D\�s�D.mdf',
	SIZE=20MB,MAXSIZE=UNLIMITED,FILEGROWTH=30%
),
FILEGROUP �H�Ƹs
(
	NAME='�H��1',FILENAME='C:\�s�s�a\E\�H1.ndf',
	SIZE=10MB,MAXSIZE=UNLIMITED,FILEGROWTH=40%
),
(
	NAME='�H��2',FILENAME='C:\�s�s�a\F\�H2.ndf',
	SIZE=10MB,MAXSIZE=UNLIMITED,FILEGROWTH=40%
),
(
	NAME='�H��3',FILENAME='C:\�s�s�a\G\�H3.ndf',
	SIZE=10MB,MAXSIZE=UNLIMITED,FILEGROWTH=40%
),
FILEGROUP �|�p�s
(
	NAME='�|�p1',FILENAME='C:\�s�s�a\H\�|1.ndf',
	SIZE=15MB,MAXSIZE=UNLIMITED,FILEGROWTH=50%
),
(
	NAME='�|�p2',FILENAME='C:\�s�s�a\I\�|2.ndf',
	SIZE=15MB,MAXSIZE=UNLIMITED,FILEGROWTH=50%
)

LOG ON
(
	NAME='�s�s�O��',FILENAME='C:\�s�s�a\J\�s�O.ldf',
	SIZE=50MB,MAXSIZE=UNLIMITED,FILEGROWTH=30%
)

-----------------------------------------------------