--SQL Server
--�x�s �w�s�{�� �^�Ǫ����

EXEC sp_helpdb

CREATE TABLE ��Ʈw��T
(
	�W�� NVARCHAR(100),
	�e�q NVARCHAR(100),
	�֦��� NVARCHAR(100),
	�s�� INT,
	�إ߮ɶ� DATETIME2(2),
	���A NVARCHAR(1024),
	�ۮe�h�� INT
)
GO

SELECT * FROM ��Ʈw��T;

INSERT INTO ��Ʈw��T EXEC sp_helpdb;