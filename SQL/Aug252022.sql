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