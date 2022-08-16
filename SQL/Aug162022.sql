USE �m��
GO

EXEC sp_help '���u��';
SELECT * FROM sys.tables;


/*	�۰ʽs�� (���~���`��)
		1. ��ƫ��O (INT�BBIGINT)
		2. �C�i��ƪ�¾�঳�@��

	���D�I: 
		1. �}��(���X�κ�)	
		2. ����
*/

CREATE TABLE �s�����ժ�
(
	�s�� INT IDENTITY(1,1), -- (�}�l��, ������)
	�m�W NVARCHAR(10),
	�~�� INT,
)

INSERT INTO �s�����ժ� VALUES('DDD','DDD');
INSERT INTO �s�����ժ� VALUES('DDD',400);

--- ��ʸɦ۰ʽs��(�U�a�����ۤv���@�M�覡)
SET IDENTITY_INSERT [�s�����ժ�] ON;
INSERT INTO �s�����ժ�(�s��, �m�W, �~��) VALUES(5, 'KKKK',400);
SET IDENTITY_INSERT [�s�����ժ�] OFF;

SELECT * FROM �s�����ժ�

----------------------------------------------------
CREATE TABLE �s�����ժ�2
(
	�۰ʽs�� INT IDENTITY(1,1), -- (�}�l��, ������)
	���y�ߤ@�s��1 UNIQUEIDENTIFIER,
	��� NVARCHAR(10),
)
GO

INSERT INTO �s�����ժ�2(���) VALUES('AAA');
INSERT INTO �s�����ժ�2(���) VALUES('BBB');
INSERT INTO �s�����ժ�2(���) VALUES('CCC');
INSERT INTO �s�����ժ�2(���y�ߤ@�s��1,���) VALUES(NEWID(),'DDD');
INSERT INTO �s�����ժ�2(���y�ߤ@�s��1,���) VALUES(NEWID(),'EEE');
INSERT INTO �s�����ժ�2(���y�ߤ@�s��1,���) VALUES(NEWID(),'FFF');

SELECT * FROM [�s�����ժ�2];

---------------------------------------------------------------------

CREATE TABLE �s�����ժ�3
(
    �۰ʽs�� INT IDENTITY(1,1),
	���y�ߤ@�s��1 UNIQUEIDENTIFIER DEFAULT NEWID(),  --- UNIQUEIDENTIFIER ���`��@��ƽs��
	���y�ߤ@�s��2 UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID(),  --- ����Τ@�A���|����
	��� NVARCHAR(10)	
)
GO

INSERT INTO �s�����ժ�3(���) VALUES('AAA');
INSERT INTO �s�����ժ�3(���) VALUES('BBB');
INSERT INTO �s�����ժ�3(���) VALUES('CCC');
INSERT INTO �s�����ժ�3(���) VALUES('DDD');
INSERT INTO �s�����ժ�3(���) VALUES('EEE');
INSERT INTO �s�����ժ�3(���) VALUES('FFF');
INSERT INTO �s�����ժ�3(���) VALUES('GGG');
INSERT INTO �s�����ժ�3(���) VALUES('HHH');
INSERT INTO �s�����ժ�3(���) VALUES('III');

SELECT * FROM [�s�����ժ�3];

----------------------------------------------------------------------
/* �����

*/
EXEC sp_help '���u��'

ALTER TABLE [���u��] ADD [��¾��] DATE CONSTRAINT ��¾��w�] DEFAULT GETDATE();
ALTER TABLE [���u��] ALTER COLUMN [�m�W] NVARCHAR(20);
ALTER TABLE [���u��] DROP COLUMN [��¾��];

ALTER TABLE [���u��] DROP CONSTRAINT ��¾��w�];
ALTER TABLE [���u��] DROP COLUMN [��¾��];

ALTER TABLE [���u��] ADD CONSTRAINT �̧C�~���ˬd CHECK(�~��>=25250);
ALTER TABLE [���u��] WITH CHECK ADD CONSTRAINT �̧C�~���ˬd CHECK(�~��>=25250);
ALTER TABLE [���u��] WITH NOCHECK ADD CONSTRAINT �̧C�~���ˬd CHECK(�~��>=25250);  -- ���e���ŦX�����O�J�ˬd

SELECT * FROM [���u��];

INSERT INTO [���u��] VALUES(7, 'JJJJ', 0, '2000-1-25', 28000, DEFAULT),
							(8, 'TTT', 1, '2002-4-25', 27000, DEFAULT),
							(9, 'UUU', 0, '1997-4-25', 38000, DEFAULT);

INSERT INTO [���u��](���u��, �m�W, �ʧO, �ͤ�, �~��) VALUES(5, 'DDDD', 1, '1995-12-25', 88000);
INSERT INTO [���u��](���u��, �m�W, �ͤ�, �~��) VALUES(6, 'DFGHH', '1999-2-25', 48000);

--- �Ȯ� ����/�}�� �������
ALTER TABLE [���u��] NOCHECK CONSTRAINT �̧C�~���ˬd;
INSERT INTO [���u��] VALUES(10,'LLLLLL',0,'1990-7-17',38000, DEFAULT);
ALTER TABLE [���u��] CHECK CONSTRAINT �̧C�~���ˬd;

SELECT * FROM [���u��];

--------------------------------------------------------------------------------
/* ��ȤW�A�T��ϥάP��(*)

	1. �����ǿ�@��L�Ϊ����
	2. �άP���N�O�i�B���M����Ƥ��e
	3. �y����Ƭd�̨߳ΤƧP�_���ǡA��ƮwŪ���t���ܺC�A���h���ާP�_���ݱq�Y�M���

*/
SELECT * FROM [���u��];

SELECT ���u��, �m�W, �~�� FROM [���u��];
SELECT ���u��, �m�W, �~�� FROM [���u��] WHERE �~�� >= 35000;

CREATE TABLE [���u2]
(
	�u�� INT,
	�m�W NVARCHAR(10),
	�ʧO BIT,
	�~�� INT
)
GO

INSERT INTO [���u2](�u��, �m�W, �ʧO, �~��)
	SELECT ���u��, �m�W, �ʧO, �~�� FROM [���u��] WHERE �~�� >= 35000; 

SELECT * FROM [���u2];

----------------------------------------------------------------------------------------
SELECT ���u��, �m�W, �~�� FROM [���u��] WHERE ���u�� <= 7;

---- SQL Server �S���y�k
SELECT ���u��, �m�W, �ʧO, �~��
INTO [���u��3] --- ���s�A���s�b����ƪ�
FROM [���u��]
WHERE ���u�� <= 7;

SELECT * FROM [���u��3];

SELECT ���u��, �m�W, �ʧO, �~��, �ͤ�
INTO [���u��4] --- ���s�A���s�b����ƪ�
FROM [���u��]
WHERE 1=0;

SELECT * FROM [���u��4];

-- MySQL
-- CREATE TABLE [���u��5] LIKE [���u��]