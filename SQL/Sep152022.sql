
USE ����_��

DECLARE @aa NVARCHAR(10);
SET @aa = '���K�q��';
PRINT @aa;

DECLARE @bb INT;
SET @bb=100;
SET @bb=@bb+200;
PRINT @bb;

DECLARE @cc INT=100;
SET @cc+=200;
SELECT @cc;


SELECT @@VERSION
SELECT @@SERVERNAME
SELECT @@SERVICENAME
SELECT @@ROWCOUNT
SELECT @@ERROR
SELECT @@SPID

-- �ܼƪ� VS �Ȧs�� VS CTS VS VIEW

-- �ܼƪ�
DECLARE @TT TABLE 
(
	�s�� INT,
	�m�W NCHAR(10),
	�~�� INT
)

INSERT INTO @TT VALUES(1,'AAA',100);
INSERT INTO @TT VALUES(2,'BBB',200);
INSERT INTO @TT VALUES(3,'CCC',300);
UPDATE @TT SET �m�W=RTRIM(�m�W)+'ZZ' WHERE �s��=2;
INSERT INTO @TT VALUES(4,'DDD',400);
DELETE FROM @TT WHERE �s��=3;

SELECT * FROM @TT;


--------------------------------------

DECLARE @VV MONEY = (SELECT ��� FROM ���~��� WHERE ���~�s��=10);
SET @VV=@VV+10
PRINT @VV


DECLARE @PRICE MONEY;
SELECT @PRICE= ��� FROM ���~��� WHERE ���~�s��=10;
SET @PRICE=@PRICE+10
PRINT @PRICE


DECLARE @NAME NVARCHAR(10);
DECLARE @PRICE MONEY;
SELECT @NAME=���~, @PRICE= ��� FROM ���~��� WHERE ���~�s��=10;
SET @PRICE=@PRICE+10
PRINT @NAME
PRINT @PRICE



--- �S��WHERE �����p�u�|��̫ܳ�@�����G(��)
DECLARE @NAME NVARCHAR(10);
SELECT @NAME=���~ FROM ���~���;
PRINT @NAME


SELECT ���~ FROM ���~���;

--------------------------------------------------------------------

DECLARE @PRICE MONEY;
SELECT @PRICE= ��� FROM ���~��� WHERE ���~�s��=10;

IF @PRICE <= 50 
	PRINT '�n�K�y!' 
ELSE 
	PRINT '�F����!';


DECLARE @PRICE MONEY;
SELECT @PRICE= ��� FROM ���~��� WHERE ���~�s��=10;
--- �Q��BEGIN & END �N���A��
IF @PRICE <= 50 
	BEGIN
		PRINT @PRICE;
		PRINT '�n�K�y!'; 
	END
ELSE 
	BEGIN
		PRINT @PRICE;
		PRINT '�F����!';
	END

-------------------------------------------------------------
SELECT * FROM sys.tables;
SELECT COUNT(*) FROM sys.tables WHERE [name]='AAA';
SELECT COUNT(*) FROM sys.tables WHERE [name]='���u';


IF (SELECT COUNT(*) FROM sys.tables WHERE [name]='AAA')>0
  TRUNCATE TABLE [AAA];
ELSE
  CREATE TABLE [AAA]
  (
	�s�� INT,
	��� NVARCHAR(10)
  )


-----------------------------------------------------------------------

--- �j��

DECLARE @cc INT=1;
WHILE @cc<=10
  BEGIN
	PRINT @cc;
	SET @cc=@cc+1;
  END


DECLARE @maxId INT=(SELECT MAX(���~�s��) FROM ���~���);
DECLARE @id INT=1;
DECLARE @name NVARCHAR(10);
DECLARE @price MONEY;

WHILE @id<=@maxId
  BEGIN
	SELECT @name=���~,@price=��� FROM ���~��� WHERE ���~�s��=@id;	
	PRINT CONCAT(@id,', ',@name,', ',@price);
	SET @id=@id+1;
  END

---------------------------------------------------------------

---- CASE
SELECT ���u�s��, �m�W, ¾��, �٩I FROM ���u


SELECT ���u�s��, �m�W, ¾��, '��' AS �ʧO FROM ���u WHERE �٩I='�p�j'
UNION ALL 
SELECT ���u�s��, �m�W, ¾��, '��' FROM ���u WHERE �٩I='����'


SELECT ���u�s��, �m�W, ¾��, 
	CASE �٩I
		WHEN '�p�j' THEN '��'
		WHEN '����' THEN '��'
	END AS �ʧO
FROM ���u

SELECT ���~�s��, ���~, ���, 
	CASE 
		WHEN ���>=100 THEN '������'
		WHEN ���>=50 THEN '������'
		WHEN ���>=20 THEN '�C����'
		ELSE '�W�K�y' END AS ���쵥��
FROM ���~���

-------------------------------------------------------------------------------

/*
CASE 
	WHEN 1 THEN INSERT INTO ....
	WHEN 2 THEN UPDATE......
	WHEN 3 THEN DELETE FROM ......
	ELSE SELECT * FROM .....
END
*/

--IIF(�޿�P�_, ���߭�, �����߭�)
SELECT ���u�s��,�m�W,¾��,IIF(�٩I='�p�j','��','��') AS �ʧO
FROM ���u

SELECT ���~�s��,���~,���
	,IIF(���>=100,'������',IIF(���>=50,'������',IIF(���>=20,'�C����','�W�K�y'))) AS ���쵥��
FROM ���~���

---------------------------------------------------------------------------------------------------

--CHOOSE(�ﶵ, ��1, ��2, ��3, ... )

SELECT CHOOSE(2,'AA','BB','CC','DD','EE')
SELECT CHOOSE(4,'AA','BB','CC','DD','EE')


SELECT �q�渹�X,�Ȥ�s��,�q����,�e�f�覡 FROM �q�f�D��;	--0.0138

SELECT �q�渹�X,�Ȥ�s��,�q����,B.�f�B���q�W��
FROM �q�f�D�� AS A JOIN �f�B���q AS B ON A.�e�f�覡=B.�f�B���q�s��;		--0.0418

SELECT �q�渹�X,�Ȥ�s��,�q����
	,CHOOSE(�e�f�覡,'�ֻ�','�l�H','�˰e') AS �B�e�覡
FROM �q�f�D��;	--0.0139

-------------------------------------------------------------------------------------------------------

--- RAISERROR( ���~�� OR ���~�T���A ���~����1-25�A ���A1-127) 

RAISERROR('�o�O�ۭq�����~�T��', 16, 10);

UPDATE ���~��� SET ���=500 WHERE ���~�s��=500;
IF @@ROWCOUNT = 0 RAISERROR('����s�������!!', 16, 10);


--- THROW ���~��(50000�H�W), ���~�T��, ���A1-127   �@�߿��~����16
THROW 50010, '�o�O�ۭq�����~�T��!!', 10;

---------------------------------------------------------------------------

EXECUTE sp_helpdb;
EXEC sp_helpdb;

--- �i���� ��r���A��SQL �R�O
EXECUTE ('SELECT * FROM ���~���');

DECLARE @NAME1 NVARCHAR(10);
SET @NAME1='���~���';
SELECT * FROM @NAME1;


/*
SELECT * FROM '���~���';
SELECT * FROM ���~���;
*/

DECLARE @sql NVARCHAR(100);
SET @sql='SELECT * FROM ';
DECLARE @name NVARCHAR(10);
SET @name='���~���';

--PRINT @sql+@name;
EXECUTE(@sql+@name);


DECLARE @sql NVARCHAR(100);
SET @sql='SELECT * FROM ';
DECLARE @name NVARCHAR(10);
SET @name='���~���';
EXECUTE(@sql+@name);

SET @name='���~���O';
EXECUTE(@sql+@name);

SET @name='�Ȥ�';
EXECUTE(@sql+@name);

---------------------------------------------------------------------












