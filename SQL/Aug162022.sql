USE �m��
GO

EXEC sp_help '���u��';
SELECT * FROM sys.tables;


/*	�۰ʽs�� 
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
INSERT INTO �s�����ժ�2(���y�ߤ@�s��1,���) VALUES(NEWSEQUENTIALID(),'GGG');

SELECT * FROM [�s�����ժ�2];



CREATE TABLE �s�����ժ�3
(
    �۰ʽs�� INT IDENTITY(1,1),
	���y�ߤ@�s��1 UNIQUEIDENTIFIER DEFAULT NEWID(),
	���y�ߤ@�s��2 UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID(),  --- ����Τ@
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

