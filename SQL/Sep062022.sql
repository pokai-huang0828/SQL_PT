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
		2.1. 直接取單一值: 可使用變數來改寫
		2.2. 比對清單: 有時較為直覺，但是通常可以用JOIN 來取代，效率較高
		2.3. 測試存在: 通常效率奇佳，有奇效
	3. FROM: 使用平率非常高，對整體查詢效率幾乎不受影響

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


--- 比對清單
SELECT 品名 FROM 匠匠
SELECT * FROM 巨巨 WHERE 品名 IN(SELECT 品名 FROM 匠匠);
SELECT * FROM 巨巨 WHERE 品名 NOT IN(SELECT 品名 FROM 匠匠);


--- 沒買過東西的客戶
USE 中文北風

SELECT DISTINCT 客戶編號 FROM 訂貨主檔;

SELECT * FROM 客戶 
	WHERE 客戶編號 NOT IN(SELECT 客戶編號 FROM 訂貨主檔);

SELECT A.*,B.訂單號碼
FROM 客戶 AS A LEFT JOIN 訂貨主檔 AS B ON A.客戶編號=B.客戶編號

--0.0545
SELECT A.*
FROM 客戶 AS A LEFT JOIN 訂貨主檔 AS B ON A.客戶編號=B.客戶編號
WHERE B.訂單號碼 IS NULL


--- 2004年未賣出的產品
SELECT 產品編號 FROM 產品資料
SELECT 產品編號 FROM 訂貨明細


SELECT * FROM 產品資料
	WHERE 產品編號 NOT IN (
		SELECT B.產品編號
		FROM 
			訂貨明細 AS A JOIN 產品資料 AS B ON A.產品編號=B.產品編號
			JOIN 訂貨主檔 AS C ON A.訂單號碼=C.訂單號碼
		WHERE 
			C.訂單日期 >= '2004-1-1' AND C.訂單日期 < '2005-1-1'	
	);


--- 測試是否存在
USE 練練

SELECT * FROM 巨巨 AS A
	WHERE EXISTS(SELECT * FROM 匠匠 AS B WHERE B.品名=A.品名);

SELECT * FROM 巨巨 AS A
	WHERE NOT EXISTS(SELECT * FROM 匠匠 AS B WHERE B.品名=A.品名);


--- 沒買過東西的客戶 進階版
USE 中文北風

SELECT * FROM 客戶
	WHERE NOT EXISTS(SELECT * FROM 訂貨主檔 WHERE 客戶編號=客戶.客戶編號)


--- 高頻率使用子查詢 FROM 
--- 訂單號碼, 客戶編號, 訂單日期, 貨款金額, 運費, 貨款金額+運費 AS 總金額

--- 1.
SELECT * FROM 訂貨明細
--- 2.
SELECT 訂單號碼, 產品編號, 單價*數量*(1-折扣) AS 金額 FROM 訂貨明細
--- 3.
SELECT 訂單號碼, ROUND(SUM(單價*數量*(1-折扣)), 0) AS 金額
FROM 訂貨明細
GROUP BY 訂單號碼
--- 4. 
SELECT A.訂單號碼, A.客戶編號, A.訂單日期, B.金額, A.運費, B.金額+A.運費 AS 總金額
FROM 訂貨主檔 AS A JOIN (
	SELECT 訂單號碼, ROUND(SUM(單價*數量*(1-折扣)), 0) AS 金額
	FROM 訂貨明細
	GROUP BY 訂單號碼) AS B
	ON A.訂單號碼=B.訂單號碼

/*
1. 個職位的女生人數(Can't use GROUP BY ALL)
2. 列出各產品類別中高於該類產品均價的產品
3. 2002年 1-4季 的營收業績
4. 列出 2003年 年度累積訂單金額超過13000的客戶 top 10
5. 列出每一位客戶最後一次下單時間
6. 有買過海鮮的客戶，依照最近訂單購買時間排序
*/