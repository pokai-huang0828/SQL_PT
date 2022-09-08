/* 子查詢 (SubQuery) PART2
	
	1. 原本需要多次查詢才可完成，希望一次搞定
	2. 撰寫上較為直覺
	3. 單一子查詢，最多32層
	4. 獨立子查詢 vs. 關聯子查詢

*/

/* 子查詢的使用位置
	
	1. 通長大部分的子查詢，可以用其他方式解決，避免子查詢
	2. WHERE: 通常效率極差
		2.1. 直接取單一值: 可使用變數來改寫
		2.2. 比對清單: 有時較為直覺，但是通常可以用JOIN 來取代，效率較高
		2.3. 測試存在: 通常效率奇佳，有奇效
	3. FROM: 使用平率非常高，對整體查詢效率幾乎不受影響
	4. COLUMN: 撰寫上較為技巧，時間效能依照查詢出的資料筆數而定

*/


USE 中文北風

SELECT TOP(10) 員工編號, 姓名, 稱呼, 職稱, 薪資 
FROM  員工 
ORDER BY 薪資 DESC;

SELECT TOP(5) 員工編號, 姓名, 稱呼, 職稱, 薪資 
FROM  員工 
ORDER BY 薪資 DESC;

---- 找薪資第 6-10 的員工
--- 子查詢不可使用 ORDER BY  0.0502
SELECT * 
FROM  (SELECT TOP(10) 員工編號, 姓名, 稱呼, 職稱, 薪資 
	FROM  員工 ORDER BY 薪資 DESC ) AS A
EXCEPT       ---INTERSECT | EXCEPT
SELECT *
FROM (SELECT TOP(5) 員工編號, 姓名, 稱呼, 職稱, 薪資 
	FROM  員工 ORDER BY 薪資 DESC ) AS B
ORDER BY 薪資 DESC; 

--- 進階版 0.0426
SELECT A.* 
FROM (SELECT TOP(10) 員工編號, 姓名, 稱呼, 職稱, 薪資 
	FROM  員工 ORDER BY 薪資 DESC ) AS A
	LEFT JOIN
	(SELECT TOP(5) 員工編號, 姓名, 稱呼, 職稱, 薪資 
		FROM  員工 ORDER BY 薪資 DESC ) AS B
	ON A.員工編號=B.員工編號
WHERE B.員工編號 IS NULL

--- 取前五但是不是最前面的五個 0.0420
SELECT TOP(5) 員工編號, 姓名, 稱呼, 職稱, 薪資 
FROM  員工 
WHERE 員工編號 NOT IN(SELECT TOP(5) 員工編號 FROM  員工 ORDER BY 薪資 DESC )
ORDER BY 薪資 DESC;

--- 0.0242 超進階
SELECT *
FROM (
	SELECT 員工編號, 姓名, 稱呼, 職稱, 薪資
		,(SELECT COUNT(*) FROM 員工 AS B WHERE B.薪資>A.薪資) AS 排名
	FROM 員工 AS A
	) AS C
WHERE 排名>=6 AND 排名<=15
ORDER BY 薪資 DESC


--- 視窗型函數(另類子查詢)
SELECT 員工編號, 姓名, 稱呼, 職稱, 薪資
	, ROW_NUMBER() OVER(ORDER BY 薪資 DESC) AS 列號	
FROM 員工 AS A

--0.157
SELECT *
FROM ( SELECT 員工編號,姓名,稱呼,職稱,薪資
			,ROW_NUMBER() OVER(ORDER BY 薪資 DESC) AS 列號
		FROM 員工 AS A ) AS B
WHERE 列號>=26 AND 列號<=30;


--視窗型函數 排序家族
SELECT 員工編號,姓名,稱呼,職稱,薪資
	,ROW_NUMBER() OVER(ORDER BY 薪資 DESC) AS 列號
FROM 員工 AS A

SELECT 員工編號,姓名,稱呼,職稱,薪資
	,RANK() OVER(ORDER BY 薪資 DESC) AS 排名
FROM 員工 AS A

SELECT 員工編號,姓名,稱呼,職稱,薪資
	,DENSE_RANK() OVER(ORDER BY 薪資 DESC) AS 排名
FROM 員工 AS A


---- 適合查詢 百分比的資料
SELECT 員工編號,姓名,稱呼,職稱,薪資
	,NTILE(4) OVER(ORDER BY 薪資 DESC) AS 群組
FROM 員工 AS A




SELECT 客戶編號, 訂單號碼 FROM 訂貨主檔;
SELECT 客戶編號, 訂單號碼 FROM 訂貨主檔 ORDER BY 客戶編號;

SELECT 客戶編號, 訂單號碼
		, ROW_NUMBER() OVER(PARTITION BY 客戶編號 ORDER BY 客戶編號 ) AS 流水號
FROM 訂貨主檔;


--MySQL
--SELECT 員工編號,姓名,稱呼,職稱,薪資 FROM 員工 ORDER BY 薪資 DESC LIMITS 10,10;

--- SQL2012 略過前五筆
SELECT 員工編號,姓名,稱呼,職稱,薪資
FROM 員工
ORDER BY 薪資 DESC OFFSET 5 ROWS;

---  略過前五筆取接下來的五筆
SELECT 員工編號,姓名,稱呼,職稱,薪資
FROM 員工
ORDER BY 薪資 DESC OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY;


SELECT 員工編號,姓名,稱呼,職稱,薪資
		, LAG(薪資) OVER(ORDER BY 薪資 ASC ) AS 後一位薪資
		, 薪資 - LAG(薪資) OVER(ORDER BY 薪資 ASC ) AS 薪資差
		, LAG(薪資, 2) OVER(ORDER BY 薪資 ASC ) AS 後二位薪資
		, LAG(薪資, 2, 0) OVER(ORDER BY 薪資 ASC ) AS 後二位薪資
FROM 員工 AS A

SELECT 員工編號,姓名,稱呼,職稱,薪資
		, LEAD(薪資, 1, 0) OVER(ORDER BY 薪資 ASC ) AS 後一位薪資
		, 薪資 - LEAD(薪資) OVER(ORDER BY 薪資 ASC ) AS 薪資差
		, LEAD(薪資, 2) OVER(ORDER BY 薪資 ASC ) AS 後二位薪資
		, LEAD(薪資, 2, 0) OVER(ORDER BY 薪資 ASC ) AS 後二位薪資
FROM 員工 AS A

/*
1. 2003年 各月營收金額(包含上月業績、月成長(Format百分比))

2. 每位客戶的平均購買間隔天數

https://docs.microsoft.com/zh-tw/sql/t-sql/functions/percentile-cont-transact-sql?view=sql-server-ver16
3-1. 全體同仁的薪資中位數
3-2. 整體產品的售價 25% 中位數 50% 75% 90%
3-3. 各項產品的售價 25% 中位數 50% 75% 90%

4-1. 每位員工在該職位群中的薪資百分位
4-2. 每項產品在該類產品群中的價格百分位
*/

SELECT 稱呼, 職稱, COUNT(*) 人數
FROM 員工
GROUP BY 稱呼, 職稱

--- 樞紐 查詢資料呈現 (源自於 GROUP BY)
SELECT 稱呼, 職稱, COUNT(*) 人數
FROM 員工
GROUP BY 稱呼, 職稱

--- |
--- V

SELECT [職稱], [小姐], [先生]
FROM (	SELECT 稱呼, 職稱, COUNT(*) 人數
		FROM 員工
		GROUP BY 稱呼, 職稱 ) AS A
PIVOT (SUM(人數) FOR 稱呼 IN([小姐], [先生])) AS P

/*
5-1. 各類產品(列)、各年(欄) 的 銷售金額 樞紐分析
5-2. 各縣市(列)、各類產品(欄) 的 銷售數量 樞紐分析
*/



