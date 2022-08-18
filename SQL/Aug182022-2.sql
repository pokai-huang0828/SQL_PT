USE 中文北風

--- 可使用"估計執行計畫"(Ctrl+L) 預先檢查
--- "包括執行計畫"(Ctrl+M) Run Code 並回報執行計畫

SELECT * FROM 員工; --- 0.004
SELECT * FROM 員工 ORDER BY 薪資;  -- 排序 ASC(小-大) | DESC(大-小)  -- 0.016 (排序花3倍時間0.004*3)
SELECT * FROM 員工 ORDER BY 薪資 DESC; 

SELECT * FROM 員工 ORDER BY 稱呼, 薪資 DESC;  --- 多欄排序
SELECT * FROM 員工 ORDER BY 4,8 DESC; --- 第四欄、第八欄排序

----------------------------------------
--- 衍生欄位(Drived Column)
SELECT 員工編號, 姓名, 職稱, 稱呼, 雇用日期, 薪資 FROM 員工;

SELECT 員工編號, 姓名, 職稱, 稱呼, 
	雇用日期, 
	YEAR(GETDATE())-YEAR(雇用日期) AS [年資],
	薪資,
	薪資*15 AS [年薪]
FROM 員工


SELECT * FROM 訂貨主檔
SELECT 客戶編號 FROM 訂貨主檔 --- 0.0138
SELECT ALL 客戶編號 FROM 訂貨主檔
SELECT DISTINCT 客戶編號 FROM 訂貨主檔 --- 剔除重複值  0.0377
SELECT DISTINCT 客戶編號, 訂單號碼 FROM 訂貨主檔 --- 注意結果，欄位比對























