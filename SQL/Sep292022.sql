/*	Trigger

	1. SQL Server ���A������ DML Trigger | DDL Trigger 
	2. SQL Server ���A������ After | Instead of	
	3. �o�ͦb�S��ɶ��I�A�B����ѨϥΪ̦ۦ�I�s�A�t�����w�s�{��
	4. �b�P�@��Ʈw���A���঳�ۦP�W�r�� �w�s�{�� / Ĳ�o�{��
	5. Trigger �O���ʮį����

*/
/*	SQL �y�k����

	DDL : CREATE�BALTER�BDROP
	DML : INSERT�BUPDATE�BDELETE
	DCL : GRANT�BREVOKE�BDENY
	DQL : SELECT 
	DTL : TRANSACTION�BCOMMIT�BROLLBACK

*/

USE �m�m;
ALTER TRIGGER ����Ĳ�o ON [����]
AFTER INSERT, UPDATE, DELETE
AS 
	PRINT '����������ƳQ���ʳ�!'
GO


SELECT * FROM [����]
INSERT INTO [����] VALUES(28, '���z��', 25);
UPDATE [����] SET ���� = 35 WHERE ���~�s�� = 28;
DELETE FROM [����] WHERE ���~�s�� = 28;


CREATE TRIGGER �����s�WĲ�o ON [����]
AFTER INSERT
AS 
	PRINT '����������ƳQ�s�W��!'
GO

CREATE TRIGGER ������sĲ�o ON [����]
AFTER UPDATE
AS 
	PRINT '����������ƳQ��s��!'
GO

CREATE TRIGGER �����R��Ĳ�o ON [����]
AFTER DELETE
AS 
	PRINT '����������ƳQ�R����!'
GO

EXEC sp_helptrigger '����';
SELECT * FROM sys.triggers;
SELECT OBJECT_NAME(A.parent_id) AS ������, * FROM sys.triggers AS A;

DROP TRIGGER ����Ĳ�o, �����s�WĲ�o, ������sĲ�o, �����R��Ĳ�o;


CREATE TRIGGER �����s�WĲ�o ON ����
AFTER INSERT
AS 
	DECLARE @price MONEY;
	SELECT @price = ���� FROM inserted;
	IF @price >= 1000
		RAISERROR('�����q���P��W�L1000���H�W���~', 16, 10);
GO


ALTER TRIGGER �����s�WĲ�o ON ����
AFTER INSERT
AS
	DECLARE @price MONEY;
	SELECT @price=���� FROM inserted;
	IF @price>=1000	 
		THROW 50010,'�����q���P��W�L1000���H�W�����~',10;		
GO

INSERT INTO [����] VALUES(29, '�W�Q�«���', 900);
INSERT INTO [����] VALUES(30, '�W�Q�i��', 1200);
SELECT * FROM [����];

--------------------------------------------------------------

SELECT * FROM sys.tables;
SELECT * FROM sys.views;
SELECT * FROM sys.triggers;

SELECT * FROM sys.objects;
SELECT * FROM sys.objects WHERE [type]='u';
SELECT * FROM sys.objects WHERE [type]='v';
SELECT * FROM sys.objects WHERE [type]='p';
SELECT * FROM sys.objects WHERE [type]='fn';
SELECT * FROM sys.objects WHERE [type]='if';
SELECT * FROM sys.objects WHERE [type]='tf';
SELECT * FROM sys.objects WHERE [type]='tr';

-------------------------------------------------------------


CREATE TRIGGER ������sĲ�o ON ����
AFTER UPDATE
AS
	DECLARE @oldPrice MONEY;
	DECLARE @newPrice MONEY;
	SELECT @newPrice=���� FROM inserted;
	SELECT @oldPrice=���� FROM deleted;
	IF @newPrice>@oldPrice*1.2 OR @newPrice<@oldPrice*0.8
		THROW 50010,'�����q���~����վ㤣�o�W�L����ʤ���20',10;		
GO

SELECT * FROM [����];
UPDATE [����] SET ����=100 WHERE ���~�s��=29;
UPDATE [����] SET ����=1000 WHERE ���~�s��=29;

----------------------------------------------------------------

USE ����_��;

SELECT * FROM ���u;

------------------------------------------------

USE �m�m;

DROP TRIGGER ����Ĳ�o,�����s�WĲ�o,������sĲ�o,�����R��Ĳ�o;


CREATE TABLE �����l�ܪ�
(
    ���~�s�� INT,
	���~�W�� NVARCHAR(10),
	��� MONEY,
	���ʪ��A NVARCHAR(10),
	�b�� NVARCHAR(100) DEFAULT SUSER_SNAME(),
	���ʮɶ� DATETIME2(2) DEFAULT SYSDATETIME()
)
GO


CREATE TRIGGER [�����s�WĲ�o] ON [����]
AFTER INSERT
AS
	INSERT INTO �����l�ܪ�(���~�s��,���~�W��,���,���ʪ��A)
		SELECT ���~�s��,�~�W,����,'�s�W���~' FROM inserted;
GO
CREATE TRIGGER [�����R��Ĳ�o] ON [����]
AFTER DELETE
AS
	INSERT INTO �����l�ܪ�(���~�s��,���~�W��,���,���ʪ��A)
		SELECT ���~�s��,�~�W,����,'�R�����~' FROM deleted;
GO
CREATE TRIGGER [������sĲ�o] ON [����]
AFTER UPDATE
AS
	IF UPDATE(�~�W)
	  BEGIN
	    INSERT INTO �����l�ܪ�(���~�s��,���~�W��,���ʪ��A)
			SELECT ���~�s��,�~�W,'���~�~�W���ʫe' FROM deleted;
		INSERT INTO �����l�ܪ�(���~�s��,���~�W��,���ʪ��A)
			SELECT ���~�s��,�~�W,'���~�~�W���ʫ�' FROM inserted;
	  END
	IF UPDATE(����)
	  BEGIN
	    INSERT INTO �����l�ܪ�(���~�s��,���,���ʪ��A)
			SELECT ���~�s��,����,'���~���沧�ʫe' FROM deleted;
		INSERT INTO �����l�ܪ�(���~�s��,���,���ʪ��A)
			SELECT ���~�s��,����,'���~���沧�ʫ�' FROM inserted;
	  END
GO


SELECT * FROM [����];
INSERT INTO [����] VALUES(30,'�i�d',30);
UPDATE [����] SET ����=35 WHERE ���~�s��=30;
DELETE FROM [����] WHERE ���~�s��=30;

SELECT * FROM [�����l�ܪ�];

----------------------------------------------------

CREATE TABLE �m�W��
(
	�m NVARCHAR(5),
	�W NVARCHAR(5)
)
GO

CREATE VIEW �m�W�˵�
AS
	SELECT �m+�W AS �m�W FROM �m�W��
GO

INSERT INTO �m�W�� VALUES('�]','�p��');

SELECT * FROM �m�W��;
SELECT * FROM �m�W�˵�;

INSERT INTO �m�W�˵� VALUES('���g�B');
INSERT INTO �m�W�˵� VALUES('�Q�}');
INSERT INTO �m�W�˵� VALUES('�����ڴ�');
INSERT INTO �m�W�˵� VALUES('���ҤH');
INSERT INTO �m�W�˵� VALUES('�R����');

CREATE TRIGGER �m�W�˵��s�WĲ�o ON [�m�W�˵�]
INSTEAD OF INSERT
AS
    DECLARE @name NVARCHAR(10);
	SELECT @name=�m�W FROM inserted;

	IF LEN(@name)=2 INSERT INTO �m�W�� VALUES(SUBSTRING(@name,1,1),SUBSTRING(@name,2,1));
	IF LEN(@name)=3 INSERT INTO �m�W�� VALUES(SUBSTRING(@name,1,1),SUBSTRING(@name,2,2));
	IF LEN(@name)=4 INSERT INTO �m�W�� VALUES(SUBSTRING(@name,1,2),SUBSTRING(@name,3,2));
GO


--Output    �f�t DML �ϥ� inserted / deleted

SELECT * FROM [�K�K];
INSERT INTO [�K�K] VALUES(26,'�s���{',30);
UPDATE [�K�K] SET ����=45 WHERE ���~�s��=26;
DELETE FROM [�K�K] WHERE ���~�s��=26;

--�� �� �� �� �� �� �� �� �� 

INSERT INTO [�K�K]
	OUTPUT inserted.*
VALUES(26,'�s���{',30);

DELETE FROM [�K�K]
	OUTPUT deleted.*
WHERE ���~�s��=26;

UPDATE [�K�K] SET ����=45
	OUTPUT inserted.���~�s��,inserted.�~�W,inserted.����,deleted.����
		,inserted.����-deleted.���� AS ���t
WHERE ���~�s��=26;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT * FROM �m�߭q��;

INSERT INTO �m�߭q��(���B) VALUES(1111);
INSERT INTO �m�߭q��(���B) OUTPUT inserted.�q��s�� VALUES(5678);
