/* VIEW(檢視) 固定儲存起來的一段SQL SELECT 查詢語法，只是個代名詞
				時代的眼淚，完全沒有助於提升查詢效能的作用
	
	1. 簡化(隱藏)複雜的SQL語法
	2. 方便權限配置及控管
	3. 也是另類的子查詢

*/

USE 中文北風


CREATE VIEW 詳細訂單檢視
AS
	SELECT 
		A.訂單號碼, B.公司名稱, B.連絡人, B.連絡人職稱, B.電話, 
		C.姓名 AS 負責員工, D.貨運公司名稱 AS 運送方式, A.運費
	FROM 
		訂貨主檔 AS A JOIN 客戶 AS B ON A.客戶編號=B.客戶編號
		JOIN 員工 AS C ON A.員工編號=C.員工編號
		JOIN 貨運公司 AS D ON A.送貨方式=D.貨運公司編號
GO

SELECT * FROM 詳細訂單檢視


CREATE VIEW 員工全資料檢視
AS
	SELECT [員工編號], [姓名], [職稱], [稱呼], [出生日期], [雇用日期], [地址], [薪資], [電話號碼], [內部分機號碼], [相片], [附註], [主管]
	FROM 員工
GO

CREATE VIEW 員工一般資料檢視
AS
	SELECT [員工編號], [姓名], [職稱], [稱呼], [雇用日期], [內部分機號碼], [相片], [主管]
	FROM 員工
GO


SELECT * FROM 員工全資料檢視;
SELECT * FROM 員工一般資料檢視;

---------------------------------------------------------------------------------------------

USE 練練

CREATE VIEW 巨巨產品檢視
AS
	SELECT 產品編號, 品名, 價錢
	FROM 巨巨
GO
SELECT * FROM 巨巨產品檢視
DROP VIEW 巨巨產品檢視

/* SCHEMABINDING 使用前提
	
	1. 不得使用 * 號
	2. 物件皆須兩段式寫法

*/
CREATE VIEW 巨巨產品檢視
WITH SCHEMABINDING
AS
	SELECT 巨巨.產品編號, 巨巨.品名, 巨巨.價錢
	FROM DBO.巨巨
GO
SELECT * FROM 巨巨產品檢視
ALTER TABLE 巨巨 DROP COLUMN 價錢;
DROP TABLE 巨巨;

CREATE VIEW 巨巨40元以上的產品檢視
AS
	SELECT 產品編號, 品名, 價錢
	FROM 巨巨
	WHERE 價錢>=40
GO
SELECT * FROM 巨巨40元以上的產品檢視



SELECT * FROM sys.tables;
SELECT * FROM sys.views;

EXEC sp_helptext '巨巨40元以上產品檢視';


/* 利用VIEW 來編修(INSERT、UPDATE、DELETE) 資料的前提

	1. 來源必須同一張TABLE(不能發生 JOIN)
	2. 來源TABLE 不能有衍生欄位
	3. VIEW 內容不能為彙總結果(不能GROUP BY)
*/
SELECT * FROM 巨巨 ORDER BY 產品編號 
SELECT * FROM 巨巨40元以上的產品檢視

INSERT INTO 巨巨40元以上的產品檢視 VALUES(26, '可樂', 30);
INSERT INTO 巨巨40元以上的產品檢視 VALUES(27, '口香糖', 10);


ALTER VIEW 巨巨40元以上的產品檢視
AS
	SELECT 產品編號, 品名, 價錢
	FROM 巨巨
	WHERE 價錢>=40
	WITH CHECK OPTION
GO

INSERT INTO 巨巨40元以上的產品檢視 VALUES(28, '樂事', 30);
INSERT INTO 巨巨40元以上的產品檢視 VALUES(28, '金莎', 82);

---------------------------------------------------------------------------
/* ISO SQL : 2003
	CTE (Common Table Expression)
	臨時性、一次性的查詢 View (用完後會消失)

	1. 簡化子查詢撰寫的複雜度
	2. 增進 真正的子查詢 的查詢效能

*/

SELECT 產品編號, 品名, 價錢
FROM (SELECT * FROM 巨巨) AS A

-- | | | |
-- v v v v 

WITH Temp(貨號, 貨品名, 售價)
AS 
(
	SELECT * FROM 巨巨
)
SELECT * FROM Temp ORDER BY 售價 DESC

----------------------------------------------------------------------

WITH T1 
AS 
(
	SELECT TOP(10) 員工編號, 姓名, 稱呼, 職稱, 薪資 
	FROM  員工 ORDER BY 薪資 DESC )
	
	, T2
AS
(
	SELECT TOP(5) 員工編號, 姓名, 稱呼, 職稱, 薪資 
	FROM  員工 ORDER BY 薪資 DESC
)

SELECT * FROM T1 LEFT JOIN T2 ON T1.員工編號=T2.員工編號

-----------------------------------------------------------------------------

WITH T1
AS
( SELECT 稱呼,職稱,COUNT(*) 人數
  FROM 員工
  GROUP BY 稱呼,職稱
 )

SELECT [職稱],[小姐],[先生]
FROM T1 
PIVOT (SUM(人數) FOR 稱呼 IN([小姐],[先生])) AS P;