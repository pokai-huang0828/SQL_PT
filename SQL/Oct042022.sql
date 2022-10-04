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

--SQL2016 �ɺA��

--DROP TABLE �s����;
--SELECT * FROM sys.tables


CREATE TABLE dbo.�s����
(    
	���~�s�� INT NOT NULL PRIMARY KEY
	, ���~�W�� NVARCHAR(10) NOT NULL  
	, ��� MONEY NOT NULL     
	, [�}�l�ɶ�] DATETIME2(2) GENERATED ALWAYS AS ROW START  
	, [�����ɶ�] DATETIME2(2) GENERATED ALWAYS AS ROW END  
	, PERIOD FOR SYSTEM_TIME (�}�l�ɶ�, �����ɶ�)
)    
WITH (SYSTEM_VERSIONING = ON(HISTORY_TABLE = dbo.�s�����l��));  


DROP TABLE �s����;
ALTER TABLE �s���� SET (SYSTEM_VERSIONING = OFF);
DROP TABLE �s����;
DROP TABLE [dbo].[MSSQL_TemporalHistoryFor_1525580473];

INSERT INTO �s����(���~�s��, ���~�W��, ���)
	SELECT ���~�s��, �~�W, ���� FROM �m�m.dbo.����;

SELECT * FROM �s����;

INSERT INTO �s����(���~�s��,���~�W��,���) VALUES(30,'�i�d',35);
DELETE FROM �s���� WHERE ���~�s��=29;
UPDATE �s���� SET ���~�W��='�j���F',���=180 WHERE ���~�s��=28;
INSERT INTO �s����(���~�s��,���~�W��,���) VALUES(31,'�ۦh�q',30);
UPDATE �s���� SET ���~�W��='�j�i�d',���=50 WHERE ���~�s��=30;
UPDATE �s���� SET ���~�W��='�j�����F',���=280 WHERE ���~�s��=28;


SELECT * FROM �s����;
SELECT * FROM �s���� FOR SYSTEM_TIME ALL;
SELECT * FROM �s���� FOR SYSTEM_TIME ALL WHERE ���~�s��= 28 ORDER BY �����ɶ�;

ALTER TABLE �s���� SET (SYSTEM_VERSIONING = OFF);
ALTER TABLE �s���� SET (SYSTEM_VERSIONING = ON(HISTORY_TABLE = dbo.�s�����l��));

-----------------------------------------------------

/*--- ACID ����欰(NON-SQL �S��)
ACID�A�O����Ʈw�޲z�t�Ρ]DBMS�^�b�g�J�Χ�s��ƪ��L�{���A
���O�Ҩưȡ]transaction�^�O���T�i�a���A�ҥ�����ƪ��|�ӯS�ʡG
	1. ��l�ʡ]atomicity�A�κ٤��i���Ωʡ^
	2. �@�P�ʡ]consistency�^
	3. �j���ʡ]isolation�A�S�ٿW�ߩʡ^
	4. ���[�ʡ]durability�^

�b��Ʈw�t�Τ��A�@�ӨưȬO���G�Ѥ@�t�C��Ʈw�ާ@�զ����@�ӧ��㪺�޿�L�{�C
	�Ҧp�Ȧ���b�A�q��b�ᦩ�����B�A�H�ΦV�ؼбb��K�[���B�A�o��Ӹ�Ʈw�ާ@���`�M�A�c���@�ӧ��㪺�޿�L�{�A���i����C
	�o�ӹL�{�Q�٬��@�ӨưȡA�㦳ACID�S�ʡC
*/


SELECT * INTO �s�K�K FROM �m�m.dbo.�K�K;


SELECT * FROM �s�K�K;

DELETE FROM �s�K�K WHERE ���~�s��>=26;

INSERT INTO �s�K�K VALUES(26,'AAA',260);
INSERT INTO �s�K�K VALUES(27,'BBB','BBB');
INSERT INTO �s�K�K VALUES(28,'CCC',280);
---------------
INSERT INTO �s�K�K VALUES(26,'AAA',260),(27,'BBB','BBB'),(28,'CCC',280);

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT * FROM �s�K�K;

--BEGIN TRANSACTION   �f�t COMMIT / ROLLBACK
BEGIN TRAN
	INSERT INTO �s�K�K VALUES(26,'AAA',260);
	INSERT INTO �s�K�K VALUES(27,'BBB','BBB');
	INSERT INTO �s�K�K VALUES(28,'CCC',280);
COMMIT

BEGIN TRAN
	INSERT INTO �s�K�K VALUES(26,'AAA',260);
	INSERT INTO �s�K�K VALUES(27,'BBB',270);
	INSERT INTO �s�K�K VALUES(28,'CCC',280);
ROLLBACK