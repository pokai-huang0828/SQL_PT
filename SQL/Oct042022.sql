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

-----------------------------------------

CREATE TABLE �K�K�l�ܪ�
(
    ���~�s�� INT,
	�²��~ NVARCHAR(10),
	�°�� MONEY,
	�s���~ NVARCHAR(10),
	�s��� MONEY,
	���ʪ��A NVARCHAR(10),
	�b�� NVARCHAR(100) DEFAULT SUSER_SNAME(),
	���ʮɶ� DATETIME2(2) DEFAULT SYSDATETIME()
)
GO

SELECT * FROM �K�K�l�ܪ�;

SELECT * FROM �K�K;



INSERT INTO [�K�K]
	OUTPUT inserted.*,'�s�W���~'
		INTO �K�K�l�ܪ�(���~�s��,�s���~,�s���,���ʪ��A)
VALUES(26,'�s���{',30);


UPDATE [�K�K]
SET �~�W='�j���s���{',����=45
	OUTPUT inserted.*,deleted.�~�W,deleted.����,'���~��Ʋ���'
		INTO �K�K�l�ܪ�(���~�s��,�s���~,�s���,�²��~,�°��,���ʪ��A)
WHERE ���~�s��=26;


DELETE FROM [�K�K]
	OUTPUT deleted.*,'�R�����~'
		INTO �K�K�l�ܪ�(���~�s��,�²��~,�°��,���ʪ��A)
WHERE ���~�s��=26;

---------------------------------------------------------------------------------------------------------------------------------

CREATE PROC �K�K�s�W @id INT,@name NVARCHAR(10),@price MONEY
AS
	INSERT INTO [�K�K]
		OUTPUT inserted.*,'�s�W���~'
			INTO �K�K�l�ܪ�(���~�s��,�s���~,�s���,���ʪ��A)
	VALUES(@id,@name,@price);
GO

CREATE PROC �K�K�ק� @id INT,@name NVARCHAR(10),@price MONEY
AS
	UPDATE [�K�K]
	SET �~�W=@name,����=@price
		OUTPUT inserted.*,deleted.�~�W,deleted.����,'���~��Ʋ���'
			INTO �K�K�l�ܪ�(���~�s��,�s���~,�s���,�²��~,�°��,���ʪ��A)
	WHERE ���~�s��=@id;
GO

CREATE PROC �K�K�R�� @id INT
AS
	DELETE FROM [�K�K]
		OUTPUT deleted.*,'�R�����~'
			INTO �K�K�l�ܪ�(���~�s��,�²��~,�°��,���ʪ��A)
	WHERE ���~�s��=@id;
GO


EXEC �K�K�s�W 27,'����',80;
EXEC �K�K�ק� 27,'�j����',180;
EXEC �K�K�R�� 27;

SELECT * FROM �K�K;
SELECT * FROM �K�K�l�ܪ�;

--------------------------------------------------------