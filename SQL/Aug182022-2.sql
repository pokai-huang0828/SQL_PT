USE 中文北風

SELECT * FROM 員工; --- 0.004
SELECT * FROM 員工 ORDER BY 薪資;  -- 排序 ASC(小-大) | DESC(大-小)  -- 0.016 (排序花3倍時間0.004*3)
SELECT * FROM 員工 ORDER BY 薪資 DESC; 