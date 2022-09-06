USE 中文北風

--- 沒有GROUP BY 的GROUP BY
--- 如果今天使用彙總函數 而沒有使用GROUP BY，將視為全體總數

SELECT COUNT(員工編號) AS 人數
	,SUM(薪資) AS 薪資總和
	,AVG(薪資) AS 平均薪資
	,MAX(薪資) AS 最高薪資
	,MIN(薪資) AS 最低薪資
FROM 員工

SELECT 稱呼, 職稱, COUNT(*) AS 人數
FROM 員工
GROUP BY 稱呼, 職稱
UNION ALL --- 將兩份連結起來
SELECT NULL, NULL, COUNT(*) FROM 員工

--- ISO SQL 2006
SELECT 稱呼, 職稱, COUNT(*) AS 人數
FROM 員工
GROUP BY CUBE(稱呼, 職稱) --- 對每一角度進行加總

SELECT 稱呼, 職稱, COUNT(*) AS 人數
FROM 員工
GROUP BY ROLLUP(稱呼, 職稱) --- 依照第一欄位進行加總

SELECT 稱呼, 職稱, COUNT(*) AS 人數
FROM 員工
GROUP BY GROUPING SETS( (稱呼, 職稱), () ) --- ()空括號意思為全體小記加總

SELECT 稱呼, 職稱, COUNT(*) AS 人數
FROM 員工
GROUP BY GROUPING SETS( (稱呼, 職稱), (職稱) )

SELECT 稱呼, 職稱, COUNT(*) AS 人數
FROM 員工
GROUP BY GROUPING SETS( (稱呼, 職稱), (稱呼), (職稱), () )


/* 子查詢 (SubQuery)
	
	1. 原本需要多次查詢才可完成，希望一次搞定
	2. 撰寫上較為直覺
	3. 單一子查詢，最多32層
	4. 獨立子查詢 vs. 關聯子查詢

*/

/* 子查詢的使用位置
	
	1. 通長大部分的子查詢，可以用其他方式解決，避免子查詢
	2. WHERE: 通常效率極差
		2.1 直接取單一值

*/

USE 練練

--- 直接取單一值
SELECT MAX(價錢) FROM 匠匠 --- 匠匠表中最貴得
SELECT * FROM 巨巨 WHERE 價錢 >= 123.79
---| | | |
---V V V V
SELECT * FROM 巨巨
	WHERE 價錢 >= (SELECT MAX(價錢) FROM 匠匠)


--- BEST SOLUTION !! 先用 DECLARE 先算出再丟回去算
DECLARE @VV MONEY =(SELECT MAX(價錢) FROM 匠匠);
SELECT * FROM 巨巨 WHERE 價錢 >= @VV

