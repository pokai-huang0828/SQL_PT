/*	Constraint ������� �T�O��ƥ��T��
		
	1. NULL (�L��諬�O) / NOT NULL (�ܼƥ������ƭ�)
	2. CHECK		�ˬd��ƪ���
	3. DEFAULT		�w�]��
	4. PRIMARY KEY	�D��	 
		4.1 �T�O��Ƥ�����
		4.2 ����/�T�{��� Easy to find.



*/


USE �m��
GO

EXEC sp_helpdb '�m��';
GO
EXEC sp_help '���u��';
GO

-- �зǥ��k
CREATE TABLE [���u��]
(
	[���u��] INT NOT NULL,
	[�m�W] NVARCHAR(10) NOT NULL,
	[�ʧO] BIT NOT NULL,
	[�ͤ�] DATE NOT NULL,
	[�~��] INT CONSTRAINT �~��w�] DEFAULT(25250),
	[���ɮɶ�] DATETIME2(2) CONSTRAINT ���ɹw�]�ɶ� DEFAULT(GETDATE()),

	-- ��i��ƪ�Constraint (�u�n������@�Ӥ����ߧY���i��J��Ʈw��)
	CONSTRAINT ���u��D�� PRIMARY KEY (���u��, �m�W), -- �@���]�m�h�� PK
	CONSTRAINT ���u�ˬd CHECK(YEAR(GETDATE())-YEAR([�ͤ�]) >= 16), 
	CONSTRAINT ���ӥͤ��ˬd CHECK(�ͤ� < GETDATE()),
	-- �C�@��FUNCTION �u��X�{�@��
	CONSTRAINT �̧C�~���ˬd CHECK(�~��>=25250), 
	-- CONSTRAINT �᪺��r�O�ΨӰ����d���ت������Y�S���|�����n�^�������D(�|�X�{�çǤ�r�ɭP�����\Ū)
	
)
GO

DROP TABLE [���u��]
GO

SELECT * FROM [���u��];
GO



