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

-------------------------------
-- Update
USE �m��;
SELECT * FROM ���u��3;

UPDATE [���u��3]
SET �m�W='ZZZ'
WHERE ���u��=3;

UPDATE [���u��3]
SET �ʧO=0, �~��=60000
WHERE ���u��=4;

UPDATE [���u��3]
SET �~��=�~��+6000
WHERE ���u��=4;

UPDATE [���u��3]
SET �~��=100000; -- �S����(WHERE)=������A�ԷV�B�z!

UPDATE [���u��3] SET �m�W=NULL WHERE ���u��=7;

DELETE FROM [���u��3] WHERE ���u��=3; -- �e���y���j�q�R���A�ԷV�B�z!

-------------------------------------
--- DELETE vs. TRUNCATE
DELETE FROM [���u��3]; --- �t�٭�(log)�A�R���t�׺C
TRUNCATE TABLE [���u��3]; --- ���t�٭�A�R���t�ק֡A�ԷV�B�z

----------------------------------------------





















