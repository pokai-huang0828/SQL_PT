/* 暫存表

	1. 無論用戶當下使用何種資料庫，一律建立在TEMPDB 資料庫
	2. TEMPDB 依然會造成磁碟 IO 的讀寫，而非記憶體
	3. 

*/
USE 練習;
CREATE TABLE #TT
(
	編號 INT,
	姓名 NCHAR(10),
	薪資 INT
)
GO

INSERT INTO #TT VALUES(1, 'AAA', 100);
INSERT INTO #TT VALUES(2, 'BBB', 200);
INSERT INTO #TT VALUES(3, 'CCC', 300);
UPDATE #TT SET 姓名=RTRIM(姓名)+'ZZ' WHERE 編號=2;
INSERT INTO #TT VALUES(4, 'DDD', 400);

SELECT * FROM #TT;