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
