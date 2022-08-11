/*	Constraint ������� �T�O��ƥ��T��
		
	1. NULL (�L��諬�O) / NOT NULL (�ܼƥ������ƭ�)
	2. CHECK �ˬd��ƪ���



*/


USE �m��
GO

EXEC sp_helpdb '�m��';
GO
EXEC sp_help '���u��';
GO

/*
CREATE TABLE [���u��]
(
	[���u��] INT NOT NULL,
	[�m�W] NVARCHAR(10) NOT NULL,
	[�ʧO] BIT NULL,
	[�ͤ�] DATE NULL,
	[�~��] INT NULL CHECK([�~��]>=25250),
)
GO
*/

-- �зǥ��k
CREATE TABLE [���u��]
(
	[���u��] INT NOT NULL,
	[�m�W] NVARCHAR(10) NOT NULL,
	[�ʧO] BIT NULL,
	[�ͤ�] DATE NULL,
	[�~��] INT CONSTRAINT �̧C�~���ˬd�� CHECK([�~��]>=25250) NOT NULL, 
	-- CONSTRAINT �Y�S���|�����n�^�������D
)
GO

DROP TABLE [���u��]
GO

SELECT * FROM [���u��];
GO



