
USE 中文北風

DECLARE @aa NVARCHAR(10);
SET @aa = '巨匠電腦';
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

-- 變數表 VS 暫存表 VS CTS VS VIEW

-- 變數表
DECLARE @TT TABLE 
(
	編號 INT,
	姓名 NCHAR(10),
	薪資 INT
)

INSERT INTO @TT VALUES(1,'AAA',100);
INSERT INTO @TT VALUES(2,'BBB',200);
INSERT INTO @TT VALUES(3,'CCC',300);
UPDATE @TT SET 姓名=RTRIM(姓名)+'ZZ' WHERE 編號=2;
INSERT INTO @TT VALUES(4,'DDD',400);
DELETE FROM @TT WHERE 編號=3;

SELECT * FROM @TT;


--------------------------------------

DECLARE @VV MONEY = (SELECT 單價 FROM 產品資料 WHERE 產品編號=10);
SET @VV=@VV+10
PRINT @VV


DECLARE @PRICE MONEY;
SELECT @PRICE= 單價 FROM 產品資料 WHERE 產品編號=10;
SET @PRICE=@PRICE+10
PRINT @PRICE


DECLARE @NAME NVARCHAR(10);
DECLARE @PRICE MONEY;
SELECT @NAME=產品, @PRICE= 單價 FROM 產品資料 WHERE 產品編號=10;
SET @PRICE=@PRICE+10
PRINT @NAME
PRINT @PRICE



--- 沒有WHERE 的情況只會顯示最後一項結果(值)
DECLARE @NAME NVARCHAR(10);
SELECT @NAME=產品 FROM 產品資料;
PRINT @NAME


SELECT 產品 FROM 產品資料;

--------------------------------------------------------------------

DECLARE @PRICE MONEY;
SELECT @PRICE= 單價 FROM 產品資料 WHERE 產品編號=10;

IF @PRICE <= 50 
	PRINT '好便宜!' 
ELSE 
	PRINT '騙錢阿!';


DECLARE @PRICE MONEY;
SELECT @PRICE= 單價 FROM 產品資料 WHERE 產品編號=10;
--- 利用BEGIN & END 代替括號
IF @PRICE <= 50 
	BEGIN
		PRINT @PRICE;
		PRINT '好便宜!'; 
	END
ELSE 
	BEGIN
		PRINT @PRICE;
		PRINT '騙錢阿!';
	END

-------------------------------------------------------------
SELECT * FROM sys.tables;
SELECT COUNT(*) FROM sys.tables WHERE [name]='AAA';
SELECT COUNT(*) FROM sys.tables WHERE [name]='員工';


IF (SELECT COUNT(*) FROM sys.tables WHERE [name]='AAA')>0
  TRUNCATE TABLE [AAA];
ELSE
  CREATE TABLE [AAA]
  (
	編號 INT,
	資料 NVARCHAR(10)
  )


-----------------------------------------------------------------------

--- 迴圈

DECLARE @cc INT=1;
WHILE @cc<=10
  BEGIN
	PRINT @cc;
	SET @cc=@cc+1;
  END


DECLARE @maxId INT=(SELECT MAX(產品編號) FROM 產品資料);
DECLARE @id INT=1;
DECLARE @name NVARCHAR(10);
DECLARE @price MONEY;

WHILE @id<=@maxId
  BEGIN
	SELECT @name=產品,@price=單價 FROM 產品資料 WHERE 產品編號=@id;	
	PRINT CONCAT(@id,', ',@name,', ',@price);
	SET @id=@id+1;
  END

---------------------------------------------------------------


