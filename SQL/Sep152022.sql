
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


