/*
	Constraint ������� �T�O��ƥ��T��

	1. NULL (�L��諬�O) / NOT NULL (�ܼƥ������ƭ�)


*/


USE �m��
GO

EXEC sp_helpdb '�m��';
GO

CREATE TABLE [���u��]
(
	[���u��] INT NOT NULL,
	[�m�W] NVARCHAR(10) NOT NULL,
	[�ʧO] BIT NULL,
	[�ͤ�] DATE NULL,
	[�~��] INT NULL,
)
GO

SELECT * FROM [���u��];
GO