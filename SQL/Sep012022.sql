USE 練練;


/* UNION 整合
	1. 依然需要花費時間、運算成本
	2. 其來源資料欄位數必須相同
	3. 其來源資料欄位型別必須相容
	4. 其結果欄位名稱，會以第一份查詢結果的欄位為最後結果的欄名

*/
---		剔除重複值 0.02
SELECT 品名 FROM 巨巨
UNION
SELECT 品名 FROM 匠匠;

---		直接相黏 0.008
SELECT 品名 FROM 巨巨
UNION ALL
SELECT 品名 FROM 匠匠;
------------------------

--- 定序 Collation
---		會造成資料庫中的 "文字資料" 搜尋、排序 出問題
---		Server 定序不可變動，但可在新開資料庫時重新定序


USE 新新
USE 中文北風

SELECT * FROM fn_helpcollations();
SELECT * FROM fn_helpcollations() WHERE [name] LIKE '%taiwan%';
SELECT * FROM fn_helpcollations() WHERE [name] LIKE '%japan%';
SELECT * FROM fn_helpcollations() WHERE [name] LIKE '%korean%';



--建立資料庫，指定定序
CREATE DATABASE 練習
ON PRIMARY
(
	NAME='練習Data',FILENAME='C:\練習家\練習資料.mdf',
	SIZE=20MB,MAXSIZE=UNLIMITED,FILEGROWTH=30MB
)

LOG ON
(
	NAME='練習Log',FILENAME='C:\練習家\練習記錄.ldf',
	SIZE=30MB,MAXSIZE=UNLIMITED,FILEGROWTH=50%
)
COLLATE Japanese_CI_AI
GO


--建立資料表，文字欄位定序
CREATE TABLE 練習表
(
    文字欄位1 NVARCHAR(30) COLLATE Japanese_CI_AI,
	文字欄位2 NVARCHAR(30) COLLATE Chinese_Taiwan_Bopomofo_CI_AI,
	文字欄位3 NVARCHAR(30) COLLATE Korean_90_CI_AI_KS,
	數值1 INT
)

---------------------------------

SELECT * FROM 員工 ORDER BY 姓名;
SELECT * FROM 員工 ORDER BY 姓名 COLLATE Chinese_Taiwan_Bopomofo_CI_AI;

SELECT * FROM fn_helpcollations() WHERE [name] LIKE '%taiwan%';
SELECT * FROM fn_helpcollations() WHERE [name] LIKE '%taiwan%' COLLATE Chinese_Taiwan_Bopomofo_CI_AI;




USE 新新;

CREATE TABLE 新巨巨
(
    產品編號 INT,
	產品名 NVARCHAR(20),
	售價 MONEY
)

INSERT INTO 新巨巨 SELECT * FROM 練練.dbo.巨巨;

SELECT * FROM 新巨巨;

SELECT A.*,B.*
FROM 新新.dbo.新巨巨 AS A JOIN 中文北風.dbo.產品資料 AS B ON A.產品名=B.產品; -- ERROR


SELECT A.*,B.*
FROM 新新.dbo.新巨巨 AS A JOIN 中文北風.dbo.產品資料 AS B ON A.產品名=B.產品 COLLATE Chinese_Taiwan_Stroke_CI_AI;  -- PASS

SELECT * FROM SYS.databases;
SELECT [database_id], [name], [collation_name] FROM sys.databases;

---------------------------------------------------------------------------

/* 統計
	聚合函數 (Aggreate Function)

	SUM、AVG、MAX、MIN、COUNT    
	VAR、VARP、STDEV、STDEVP

	1. 可進行多類分組
	2. 可利用計算或函示結果，進行分析
	3. 注意 NULL值，彙總函數會略過，COUNT(*)例外
	4. 統計 VS. 明細 -- 有統計就不會有明細

*/
USE 中文北風

SELECT * FROM 員工

SELECT 稱呼, 職稱, COUNT(員工編號) AS 人數
	,SUM(薪資) AS 薪資總和
	,AVG(薪資) AS 平均薪資
	,MAX(薪資) AS 最高薪資
	,MIN(薪資) AS 最低薪資
FROM 員工
GROUP BY 稱呼, 職稱;


-------------------------   TEST   ------------------------------
--- 中文北風各類產品的平均價格

SELECT B.類別名稱
	,AVG(單價) AS 平均價
	,MAX(單價) AS 最高價
	,MIN(單價) AS 最低價
FROM 產品資料 AS A JOIN 產品類別 AS B ON A.產品編號=B.類別編號
GROUP BY B.類別名稱

------------------------------------------------------------------
--- 中文北風各縣市人數
--- TIP SUBSTRING(擷取目標, 開始位置, 結束擷取位置)

SELECT SUBSTRING(地址, 1, 3) AS 縣市, 
	COUNT(員工編號) AS 人數
FROM 員工
GROUP BY SUBSTRING(地址, 1, 3)

SELECT SUBSTRING(地址, 1, 3) AS 縣市, 
	COUNT(*) AS 人數
FROM 員工
GROUP BY SUBSTRING(地址, 1, 3)



---------------------------------------------------------
-- 統計
SELECT 稱呼, COUNT(員工編號) AS 人數
FROM 員工
GROUP BY 稱呼;
-- 明細
SELECT 員工編號, 姓名 FROM 員工
WHERE 稱呼='小姐';



SELECT 稱呼,職稱,COUNT(員工編號) AS 人數	
FROM 員工
GROUP BY 稱呼,職稱;


SELECT 稱呼,職稱,COUNT(員工編號) AS 人數	
FROM 員工
GROUP BY 稱呼,職稱
HAVING COUNT(*) >= 3 --- HAVING : GROUP BY 之後的 WHERE


SELECT 職稱,COUNT(員工編號) AS 人數	
FROM 員工
WHERE 稱呼='小姐'
GROUP BY 職稱
HAVING COUNT(*)>=2



SELECT 職稱,COUNT(員工編號) AS 人數	
FROM 員工
WHERE 稱呼='小姐'
GROUP BY 職稱;

--- SQL Server 特有
SELECT 職稱,COUNT(員工編號) AS 人數	
FROM 員工
WHERE 稱呼='小姐'
GROUP BY ALL 職稱;

SELECT DISTINCT 職稱 FROM 員工;  --  DISTINCT去重複
SELECT 職稱 FROM 員工 WHERE 稱呼='小姐';


------------------------------------------------------------------

---- 2003 年銷售數量 TOP10
SELECT TOP(10) A.產品, SUM(數量) AS 銷售數量
FROM 
	產品資料 AS A JOIN 訂貨明細 AS B ON A.產品編號=B.產品編號
	JOIN 訂貨主檔 AS C ON C.訂單號碼=B.訂單號碼
WHERE C.訂單日期 >= '2003-1-1' AND C.訂單日期 < '2004-1-1'
GROUP BY A.產品 
ORDER BY SUM(數量) DESC

--2003年 銷售數量 排名
SELECT B.產品編號,SUM(B.數量) AS 銷售數量
FROM 訂貨主檔 AS A JOIN 訂貨明細 AS B ON A.訂單號碼=B.訂單號碼
WHERE A.訂單日期>='2003-1-1' AND A.訂單日期<'2004-1-1'
GROUP BY B.產品編號
ORDER BY 銷售數量 DESC

--2003年 最多不同客戶購買 排名  (較受歡迎的產品)
SELECT B.產品編號,COUNT(DISTINCT A.客戶編號) AS 購買次數
FROM 訂貨主檔 AS A JOIN 訂貨明細 AS B ON A.訂單號碼=B.訂單號碼
WHERE A.訂單日期>='2003-1-1' AND A.訂單日期<'2004-1-1'
GROUP BY B.產品編號
ORDER BY 購買次數 DESC


---- 2004 年有買過 "海鮮類" 的客戶，依照購買時間遞減排序

SELECT A.公司名稱, A.連絡人, SUM(數量) AS 總數量, B.訂單日期
FROM 
	客戶 AS A JOIN 訂貨主檔 AS B ON A.客戶編號=B.客戶編號
	JOIN 訂貨明細 AS C ON B.訂單號碼=C.訂單號碼
	JOIN 產品資料 AS D ON C.產品編號=D.產品編號
	JOIN 產品類別 AS E ON D.類別編號=E.類別編號
WHERE 
	B.訂單日期 > '2003-12-31' AND B.訂單日期 <= '2004-12-31'
	AND E.類別編號=8

GROUP BY A.公司名稱, A.連絡人, B.訂單日期
ORDER BY B.訂單日期 DESC
