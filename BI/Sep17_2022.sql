--SELECT COUNT(*) FROM sys.tables WHERE [name]='�_�����~'

IF (SELECT COUNT(*) FROM sys.tables WHERE [name]='�_�����~')>0
	TRUNCATE TABLE [�_�����~];
ELSE
  BEGIN
	CREATE TABLE �_�����~
	(
	   ���~�s�� INT,
	   ���~�W�� NVARCHAR(20),
	   �����ӽs�� INT,
	   ���O�s�� INT,
	   ��� MONEY,
	   ���ƶq NVARCHAR(5),
	   �w�s�q INT
	)
  END

DROP TABLE �_�����~
SELECT * FROM �_�����~
