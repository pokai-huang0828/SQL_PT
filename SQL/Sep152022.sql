
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

---- CASE
SELECT 員工編號, 姓名, 職稱, 稱呼 FROM 員工


SELECT 員工編號, 姓名, 職稱, '母' AS 性別 FROM 員工 WHERE 稱呼='小姐'
UNION ALL 
SELECT 員工編號, 姓名, 職稱, '公' FROM 員工 WHERE 稱呼='先生'


SELECT 員工編號, 姓名, 職稱, 
	CASE 稱呼
		WHEN '小姐' THEN '母'
		WHEN '先生' THEN '公'
	END AS 性別
FROM 員工

SELECT 產品編號, 產品, 單價, 
	CASE 
		WHEN 單價>=100 THEN '高價位'
		WHEN 單價>=50 THEN '中價位'
		WHEN 單價>=20 THEN '低價位'
		ELSE '超便宜' END AS 價位等級
FROM 產品資料

-------------------------------------------------------------------------------

/*
CASE 
	WHEN 1 THEN INSERT INTO ....
	WHEN 2 THEN UPDATE......
	WHEN 3 THEN DELETE FROM ......
	ELSE SELECT * FROM .....
END
*/

--IIF(邏輯判斷, 成立值, 不成立值)
SELECT 員工編號,姓名,職稱,IIF(稱呼='小姐','母','公') AS 性別
FROM 員工

SELECT 產品編號,產品,單價
	,IIF(單價>=100,'高價位',IIF(單價>=50,'中價位',IIF(單價>=20,'低價位','超便宜'))) AS 價位等級
FROM 產品資料

---------------------------------------------------------------------------------------------------

--CHOOSE(選項, 值1, 值2, 值3, ... )

SELECT CHOOSE(2,'AA','BB','CC','DD','EE')
SELECT CHOOSE(4,'AA','BB','CC','DD','EE')


SELECT 訂單號碼,客戶編號,訂單日期,送貨方式 FROM 訂貨主檔;	--0.0138

SELECT 訂單號碼,客戶編號,訂單日期,B.貨運公司名稱
FROM 訂貨主檔 AS A JOIN 貨運公司 AS B ON A.送貨方式=B.貨運公司編號;		--0.0418

SELECT 訂單號碼,客戶編號,訂單日期
	,CHOOSE(送貨方式,'快遞','郵寄','親送') AS 運送方式
FROM 訂貨主檔;	--0.0139

-------------------------------------------------------------------------------------------------------

--- RAISERROR( 錯誤號 OR 錯誤訊息， 錯誤等級1-25， 狀態1-127) 

RAISERROR('這是自訂的錯誤訊息', 16, 10);

UPDATE 產品資料 SET 單價=500 WHERE 產品編號=500;
IF @@ROWCOUNT = 0 RAISERROR('未更新到任何資料!!', 16, 10);


--- THROW 錯誤號(50000以上), 錯誤訊息, 狀態1-127   一律錯誤等級16
THROW 50010, '這是自訂的錯誤訊息!!', 10;

---------------------------------------------------------------------------

EXECUTE sp_helpdb;
EXEC sp_helpdb;

--- 可執行 文字型態的SQL 命令
EXECUTE ('SELECT * FROM 產品資料');

DECLARE @NAME1 NVARCHAR(10);
SET @NAME1='產品資料';
SELECT * FROM @NAME1;


/*
SELECT * FROM '產品資料';
SELECT * FROM 產品資料;
*/

DECLARE @sql NVARCHAR(100);
SET @sql='SELECT * FROM ';
DECLARE @name NVARCHAR(10);
SET @name='產品資料';

--PRINT @sql+@name;
EXECUTE(@sql+@name);


DECLARE @sql NVARCHAR(100);
SET @sql='SELECT * FROM ';
DECLARE @name NVARCHAR(10);
SET @name='產品資料';
EXECUTE(@sql+@name);

SET @name='產品類別';
EXECUTE(@sql+@name);

SET @name='客戶';
EXECUTE(@sql+@name);

---------------------------------------------------------------------












