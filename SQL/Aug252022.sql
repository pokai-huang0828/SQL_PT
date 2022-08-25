USE 中文北風;

SELECT UNICODE(N'我');
SELECT UNICODE(N'們');

SELECT * FROM 員工;
SELECT * FROM 員工 WHERE 職稱='業務主管';
SELECT * FROM 員工 WHERE 職稱='主管' OR 職稱='工程師' OR 職稱='助理';

--- * Better
SELECT * FROM 員工 WHERE 職稱 IN('主管', '工程師', '助理');


--- ** 模糊搜尋 萬用字元
---		%	 可代替任意字元，含空字元且不限字數
---		_	 可代替任意字元，不含空字元且一次一字 

--- 找全名 
SELECT * FROM 員工 WHERE 姓名='劉天王';
--- 找姓陳的
SELECT * FROM 員工 WHERE 姓名 LIKE '陳%';
--- 找姓張、陳、李
SELECT * FROM 員工 WHERE 姓名 LIKE '陳%' OR 姓名 LIKE '張%' OR 姓名 LIKE '林%';
SELECT * FROM 員工 WHERE 姓名 LIKE '[陳林張]%';

--- SQL Server 特有
SELECT * FROM 客戶 WHERE 客戶編號 LIKE 'A%' OR 客戶編號 LIKE 'D%' OR 客戶編號 LIKE 'F%';  -- NORMAL
SELECT * FROM 客戶 WHERE 客戶編號 LIKE '[ADF]%';										  -- 開頭ADF
SELECT * FROM 客戶 WHERE 客戶編號 LIKE '[ADF][O-Z]%';									  -- 開頭ADF 後面O到Z

--- 找產品含肉
SELECT * FROM 產品資料 WHERE 產品 LIKE '%肉%';

--- 使用LIKE會降低效率 少用 LIKE '%林' (%在前面)
--- 導致索引失效 - 二分法失效 - 變成掃描大幅降低效率

SELECT LEN('台灣科高科技股份有限公司');
SELECT LEFT('台灣科高科技股份有限公司', 4);
SELECT RIGHT('台灣科高科技股份有限公司', 4);		 
SELECT SUBSTRING('台灣科高科技股份有限公司', 5, 2);  --- 從5後截2
SELECT LOWER('KENNY');
SELECT UPPER('kenny');


--- LTRIM、RTRIM、TRIM
SELECT REPLACE('我叫黃柏凱', '黃柏凱', '李怡萱');
SELECT REPLICATE('HA', 4);
SELECT REVERSE('I AM KENNY');
SELECT CHARINDEX('桃園','巨匠電腦桃園認證中心');  --- FIND WHERE IS THE '桃園'
SELECT CHARINDEX('中壢','巨匠電腦桃園認證中心');  --- FIND WHERE IS THE '中壢'
SELECT QUOTENAME('巨匠電腦')					  --- ADD [] INTO STRING

--SQL2017
SELECT 姓名 FROM 員工;
SELECT STRING_AGG(姓名,',') FROM 員工;

--SQL2016
SELECT * FROM STRING_SPLIT('AA,BB,CC,DD,EE,FF',',');


---------------------------------------------------------------


--- ISNULL(值, NULL 取代值)

SELECT 姓名+' : '+ISNULL(電話號碼, '未填寫') FROM 員工;

SELECT * FROM 員工;
SELECT 姓名+', 主管：'+CONVERT(NVARCHAR,主管) FROM 員工;
-- SELECT 姓名+', 主管：'+ISNULL(主管,'無主管') FROM 員工;    ERROR
SELECT 姓名+', 主管：'+CONVERT(NVARCHAR,ISNULL(主管,0)) FROM 員工;

-- SELECT '('+員工編號+')'+姓名+', '+薪資+'：'+電話號碼 FROM 員工;  ERROR
SELECT CONCAT('(',員工編號,')  ',姓名,', 月薪: ',薪資,', 電話號碼:',電話號碼) FROM 員工;


--- NULLIF(VALUE1, VALUE2)
SELECT NULLIF(100, 100)
SELECT NULLIF(100, 200)


--- COALESCE(VALUE1, VALUE2, VALUE3, ......)  擷取 NULL 中有數值的地方
SELECT COALESCE(NULL,NULL,NULL,NULL,NULL,NULL,100,NULL)

--- COALESCE 應用範例 ------
CREATE TABLE 練習員工表
(
  員工編號 INT IDENTITY(1,1) PRIMARY KEY,
  姓名 NVARCHAR(10),
  員工種類 TINYINT,
  薪資 MONEY,
  時薪 MONEY,
  工作時數 MONEY,
  銷售金額 MONEY,
  傭金比率 MONEY
)
GO
INSERT INTO 練習員工表 VALUES('王小明',1,35000,NULL,NULL,NULL,NULL)
INSERT INTO 練習員工表 VALUES('李小明',1,28000,NULL,NULL,NULL,NULL)
INSERT INTO 練習員工表 VALUES('林大雄',2,NULL,110,275,NULL,NULL)
INSERT INTO 練習員工表 VALUES('廖小美',2,NULL,125,346,NULL,NULL)
INSERT INTO 練習員工表 VALUES('林美麗',2,NULL,105,758,NULL,NULL)
INSERT INTO 練習員工表 VALUES('錢夫人',3,NULL,NULL,NULL,7567632,0.1)
INSERT INTO 練習員工表 VALUES('ㄚ土伯',3,NULL,NULL,NULL,543243,0.08)
INSERT INTO 練習員工表 VALUES('忍太郎',3,NULL,NULL,NULL,357654,0.12)
GO

SELECT * FROM 練習員工表

SELECT 員工編號,姓名,員工種類
	,COALESCE(薪資*15,時薪*工作時數,銷售金額*傭金比率) AS 給付金額
FROM 練習員工表