USE ����_��;

SELECT UNICODE(N'��');
SELECT UNICODE(N'��');

SELECT * FROM ���u;
SELECT * FROM ���u WHERE ¾��='�~�ȥD��';
SELECT * FROM ���u WHERE ¾��='�D��' OR ¾��='�u�{�v' OR ¾��='�U�z';

--- * Better
SELECT * FROM ���u WHERE ¾�� IN('�D��', '�u�{�v', '�U�z');


--- ** �ҽk�j�M �U�Φr��
---		%	 �i�N�����N�r���A�t�Ŧr���B�����r��
---		_	 �i�N�����N�r���A���t�Ŧr���B�@���@�r 

--- ����W 
SELECT * FROM ���u WHERE �m�W='�B�Ѥ�';
--- ��m����
SELECT * FROM ���u WHERE �m�W LIKE '��%';
--- ��m�i�B���B��
SELECT * FROM ���u WHERE �m�W LIKE '��%' OR �m�W LIKE '�i%' OR �m�W LIKE '�L%';
SELECT * FROM ���u WHERE �m�W LIKE '[���L�i]%';

--- SQL Server �S��
SELECT * FROM �Ȥ� WHERE �Ȥ�s�� LIKE 'A%' OR �Ȥ�s�� LIKE 'D%' OR �Ȥ�s�� LIKE 'F%';  -- NORMAL
SELECT * FROM �Ȥ� WHERE �Ȥ�s�� LIKE '[ADF]%';										  -- �}�YADF
SELECT * FROM �Ȥ� WHERE �Ȥ�s�� LIKE '[ADF][O-Z]%';									  -- �}�YADF �᭱O��Z

--- �䲣�~�t��
SELECT * FROM ���~��� WHERE ���~ LIKE '%��%';

--- �ϥ�LIKE�|���C�Ĳv �֥� LIKE '%�L' (%�b�e��)
--- �ɭP���ޥ��� - �G���k���� - �ܦ����y�j�T���C�Ĳv

SELECT LEN('�x�W�찪��ުѥ��������q');
SELECT LEFT('�x�W�찪��ުѥ��������q', 4);
SELECT RIGHT('�x�W�찪��ުѥ��������q', 4);		 
SELECT SUBSTRING('�x�W�찪��ުѥ��������q', 5, 2);  --- �q5��I2
SELECT LOWER('KENNY');
SELECT UPPER('kenny');


--- LTRIM�BRTRIM�BTRIM
SELECT REPLACE('�ڥs���f��', '���f��', '���ɸ�');
SELECT REPLICATE('HA', 4);
SELECT REVERSE('I AM KENNY');
SELECT CHARINDEX('���','���K�q�����{�Ҥ���');  --- FIND WHERE IS THE '���'
SELECT CHARINDEX('���c','���K�q�����{�Ҥ���');  --- FIND WHERE IS THE '���c'
SELECT QUOTENAME('���K�q��')					  --- ADD [] INTO STRING

--SQL2017
SELECT �m�W FROM ���u;
SELECT STRING_AGG(�m�W,',') FROM ���u;

--SQL2016
SELECT * FROM STRING_SPLIT('AA,BB,CC,DD,EE,FF',',');


---------------------------------------------------------------


--- ISNULL(��, NULL ���N��)

SELECT �m�W+' : '+ISNULL(�q�ܸ��X, '����g') FROM ���u;

SELECT * FROM ���u;
SELECT �m�W+', �D�ޡG'+CONVERT(NVARCHAR,�D��) FROM ���u;
-- SELECT �m�W+', �D�ޡG'+ISNULL(�D��,'�L�D��') FROM ���u;    ERROR
SELECT �m�W+', �D�ޡG'+CONVERT(NVARCHAR,ISNULL(�D��,0)) FROM ���u;

-- SELECT '('+���u�s��+')'+�m�W+', '+�~��+'�G'+�q�ܸ��X FROM ���u;  ERROR
SELECT CONCAT('(',���u�s��,')  ',�m�W,', ���~: ',�~��,', �q�ܸ��X:',�q�ܸ��X) FROM ���u;


--- NULLIF(VALUE1, VALUE2)
SELECT NULLIF(100, 100)
SELECT NULLIF(100, 200)


--- COALESCE(VALUE1, VALUE2, VALUE3, ......)  �^�� NULL �����ƭȪ��a��
SELECT COALESCE(NULL,NULL,NULL,NULL,NULL,NULL,100,NULL)

--- COALESCE ���νd�� ------
CREATE TABLE �m�߭��u��
(
  ���u�s�� INT IDENTITY(1,1) PRIMARY KEY,
  �m�W NVARCHAR(10),
  ���u���� TINYINT,
  �~�� MONEY,
  ���~ MONEY,
  �u�@�ɼ� MONEY,
  �P����B MONEY,
  �Ī���v MONEY
)
GO
INSERT INTO �m�߭��u�� VALUES('���p��',1,35000,NULL,NULL,NULL,NULL)
INSERT INTO �m�߭��u�� VALUES('���p��',1,28000,NULL,NULL,NULL,NULL)
INSERT INTO �m�߭��u�� VALUES('�L�j��',2,NULL,110,275,NULL,NULL)
INSERT INTO �m�߭��u�� VALUES('���p��',2,NULL,125,346,NULL,NULL)
INSERT INTO �m�߭��u�� VALUES('�L���R',2,NULL,105,758,NULL,NULL)
INSERT INTO �m�߭��u�� VALUES('���ҤH',3,NULL,NULL,NULL,7567632,0.1)
INSERT INTO �m�߭��u�� VALUES('���g�B',3,NULL,NULL,NULL,543243,0.08)
INSERT INTO �m�߭��u�� VALUES('�Ԥӭ�',3,NULL,NULL,NULL,357654,0.12)
GO

SELECT * FROM �m�߭��u��

SELECT ���u�s��,�m�W,���u����
	,COALESCE(�~��*15,���~*�u�@�ɼ�,�P����B*�Ī���v) AS ���I���B
FROM �m�߭��u��

-----------------------------------------------------------------------

SELECT ���u�s��, �m�W, ¾��, ���Τ��, �~�� 
FROM ���u;

--CONVERT(�ؼЫ��O, �� [,�榡�Ѽ�]) https://docs.microsoft.com/zh-tw/sql/t-sql/functions/cast-and-convert-transact-sql?view=sql-server-ver16
SELECT CONVERT(NVARCHAR, GETDATE());
SELECT CONVERT(NVARCHAR, GETDATE(), 100);	--�����^��
SELECT CONVERT(NVARCHAR, GETDATE(), 101);	--ANSI
SELECT CONVERT(NVARCHAR, GETDATE(), 102);	--�^���^��/�k��
SELECT CONVERT(NVARCHAR, GETDATE(), 104);	--�w��
SELECT CONVERT(NVARCHAR, GETDATE(), 111);	--�饻
SELECT CONVERT(NVARCHAR, GETDATE(), 110);	--USA

SELECT ���u�s��, �m�W, ¾��, ���Τ��,
	CONVERT(nvarchar, CAST(�~�� AS money), 1) AS �~�� FROM ���u;


--- SEARCH �зǼƭȮ榡�r�� https://docs.microsoft.com/zh-tw/dotnet/standard/base-types/standard-numeric-format-strings
--- FORMAT(��, �榡��)
SELECT FORMAT(54000, 'C');
SELECT FORMAT(255, 'X');
SELECT FORMAT(0.8756, 'P');
SELECT FORMAT(54000, '#.0');
SELECT FORMAT(0.8756, '#.0%');


SELECT FORMAT(GETDATE(), 'D');  --- �����
SELECT FORMAT(GETDATE(), 'd');  --- �u���
SELECT FORMAT(GETDATE(), 'F');
SELECT FORMAT(GETDATE(),'f')
SELECT FORMAT(GETDATE(),'T')
SELECT FORMAT(GETDATE(),'t')
SELECT FORMAT(GETDATE(),'yyyy-MM-dd dddd HH:mm:ss')

SELECT DATEPART(WEEKDAY, GETDATE());
SELECT FORMAT(GETDATE(), 'ddd');


SELECT FORMAT(GETDATE(), 'F', 'en-us');  --- �y�t
SELECT FORMAT(GETDATE(),'F','en-us')
SELECT FORMAT(GETDATE(),'F','en-gb')
SELECT FORMAT(GETDATE(),'F','fr-fr')
SELECT FORMAT(GETDATE(),'F','ja-jp')
SELECT FORMAT(GETDATE(),'F','ko-kr')
SELECT FORMAT(GETDATE(),'ddd','ja-jp')
SELECT FORMAT(GETDATE(),'dddd','ja-jp')


SELECT FORMAT(54000.567,'C','fr-fr')
SELECT FORMAT(54000.567,'C','ja-jp')
SELECT FORMAT(54000.567,'C','ko-kr')
SELECT FORMAT(54000.567,'C','ja-jp')
SELECT FORMAT(54000.567,'C','it-it')
