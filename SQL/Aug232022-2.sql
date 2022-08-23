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





