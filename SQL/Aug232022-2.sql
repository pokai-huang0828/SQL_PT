USE 中文北風;

SELECT 員工編號, 姓名, 職稱, 稱呼, 雇用日期, 薪資 
FROM 員工 
WHERE 薪資 >=60000;

SELECT 員工編號, 姓名, 職稱, 稱呼, 雇用日期, 薪資 
FROM 員工 
WHERE 薪資 >=50000 AND 薪資 <= 65000;

SELECT 員工編號, 姓名, 職稱, 稱呼, 雇用日期, 薪資 
FROM 員工 
WHERE 薪資 < 40000 OR 薪資 > 70000 ORDER BY 薪資 DESC; -- 大至小

-------------------------------------------------------------
--- Numeric Functions

SELECT ABS(-5);
SELECT ROUND(56.789, 2);
SELECT ROUND(56.789, 0);
SELECT ROUND(56.789, -1);
SELECT POWER(3, 4);
SELECT RAND();  -----------   0 <= ~ < 1 
SELECT SQRT(81);

SELECT CEILING(7.8);----  無條件進位
SELECT CEILING(7.3);
SELECT CEILING(77.0/10);

SELECT FLOOR(7.8);  ----  無條件捨去

SELECT 20/3;       --------	  6
SELECT 1.0*20/3;   --------   6.6666... 

--------------------------------------------------------------------
---  Date Functions

SELECT 員工編號, 姓名, 職稱, 稱呼, 雇用日期, 薪資 
FROM 員工 
WHERE 雇用日期 >= '2002-1-1';

SELECT 員工編號, 姓名, 職稱, 稱呼, 雇用日期, 薪資 
FROM 員工 
WHERE 雇用日期 >= '2002-1-1' AND 雇用日期 <= '2002-12-31 23:59:59';

SELECT 員工編號, 姓名, 職稱, 稱呼, 雇用日期, 薪資 
FROM 員工 
WHERE 雇用日期 >= '2002-1-1' AND 雇用日期 < '2003-1-1';

SELECT 員工編號, 姓名, 職稱, 稱呼, 雇用日期, 薪資 
FROM 員工 
WHERE 雇用日期 BETWEEN '2002-1-1' AND '2002-12-31 23:59:59';

/* 盡可能別在 WHERE 部分使用函數
	1.	搜尋時間變慢
	2.	導致索引無法二分搜尋法 --> 索引掃描

	WHERE Score >= 36			--- GOOD
	WHERE SQRT(Score)*10>=60	--- BAD
*/

SELECT 員工編號, 姓名, 職稱, 稱呼, 雇用日期, 薪資 
FROM 員工 
WHERE YEAR(雇用日期)=2002;

SELECT GETDATE();		-- DATETIME
SELECT SYSDATETIME();	-- DATETIME2

SELECT GETDATE();
SELECT GETDATE()+1;
SELECT GETDATE()-2;
SELECT GETDATE()+2.5;

SELECT SYSDATETIME()+2;	-- NOT WORKING

-- YEAR、MONTH、DAY
--- DATEPART(單位, 日期時間)
SELECT DATEPART(YEAR, GETDATE());
SELECT DATEPART(DAYOFYEAR, GETDATE());
SELECT DATEPART(QUARTER, GETDATE());
SELECT DATEPART(WEEKDAY, GETDATE());
SELECT DATEPART(MILLISECOND, SYSDATETIME());

-- DATEADD(單位, 數量, 日期時間)
SELECT DATEADD(WEEK, 3, SYSDATETIME());
SELECT DATEADD(DAY, 3, SYSDATETIME());
SELECT DATEADD(HOUR, 30, SYSDATETIME());
SELECT DATEADD(DAY, -20, SYSDATETIME());

--- DATEDIFF(單位, 較早時間, 較晚時間)
SELECT DATEDIFF(YEAR, '2002-9-10', GETDATE());
SELECT DATEDIFF(HOUR, GETDATE(), '2022-9-10')/24.0;

SELECT 員工編號, 姓名, 職稱, 稱呼, 出生日期, 薪資 
FROM 員工 
WHERE DATEDIFF(YEAR, 出生日期, GETDATE()) <= 40;

SELECT 員工編號, 姓名, 職稱, 稱呼, 出生日期, 薪資 
FROM 員工 
WHERE DATEDIFF(YEAR, 出生日期, GETDATE()) >= 65;