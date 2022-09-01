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
*/
USE 中文北風

SELECT * FROM 員工

SELECT 稱呼, COUNT(員工編號) AS 人數
	,SUM(薪資) AS 薪資總和
	,AVG(薪資) AS 平均薪資
	,MAX(薪資) AS 最高薪資
	,MIN(薪資) AS 最低薪資
FROM 員工
GROUP BY 稱呼;


-------------------------   TEST   ------------------------------
--- 中文北風各類產品的平均價格

SELECT B.類別名稱
	,AVG(單價) AS 平均價
	,MAX(單價) AS 最高價
	,MIN(單價) AS 最低價
FROM 產品資料 AS A JOIN 產品類別 AS B ON A.產品編號=B.類別編號
GROUP BY B.類別名稱

------------------------------------------------------------------

