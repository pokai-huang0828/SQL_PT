/*	Constraint 條件約束 確保資料正確性

	1. NULL (無實質型別) / NOT NULL (變數必須有數值)
	2. CHECK		檢查資料的值
	3. DEFAULT		預設值
	4. PRIMARY KEY	主鍵(PK)	 
		4.1 確保資料不重複
		4.2 辨識/確認資料 Easy to find

	5. UNIQUE		所有值只能出現一次
	6. FOREIGN KEY	

*/
-- 展示UNIQUE
/*
CREATE TABLE [員工表]
(
	[員工號] INT CONSTRAINT 員工號主鍵 PRIMARY KEY, 
	[姓名] NVARCHAR(10) NULL CONSTRAINT 姓名唯一 UNIQUE,
	[性別] BIT NOT NULL,
)
GO
*/
USE 練習
GO

EXEC sp_helpdb '練習';
GO
EXEC sp_help '員工表';
GO

-- 標準打法
CREATE TABLE [員工表]
(
	[員工號] INT NOT NULL,
	[姓名] NVARCHAR(10) NOT NULL,
	[性別] BIT NOT NULL,
	[生日] DATE NOT NULL,
	[薪資] INT CONSTRAINT 薪資預設 DEFAULT(25250),
	[建檔時間] DATETIME2(2) CONSTRAINT 建檔預設時間 DEFAULT(GETDATE()),

	-- 整張資料表的Constraint (只要有任何一個不成立即不可填入資料庫內)
	CONSTRAINT 員工表主鍵 PRIMARY KEY (員工號, 姓名), -- 一次設置多個 PK
	CONSTRAINT 童工檢查 CHECK(YEAR(GETDATE())-YEAR([生日]) >= 16), 
	CONSTRAINT 未來生日檢查 CHECK(生日 < GETDATE()),
	-- 每一種FUNCTION 只能出現一次
	CONSTRAINT 最低薪資檢查 CHECK(薪資>=25250), 
	-- CONSTRAINT 後的文字是用來做講查項目的解釋若沒打會有不好擷取的問題(會出現亂序文字導致不易閱讀)
	
)
GO

CREATE TABLE 小員工
(
	員工號 INT PRIMARY KEY,
	姓名 NVARCHAR(10),
	薪資 INT,
)
GO

CREATE TABLE 小訂單
(
	訂單編號 INT PRIMARY KEY,
	金額 INT,
	負責員工 INT CONSTRAINT 員工訂單關聯 FOREIGN KEY REFERENCES 小員工(員工號), 
	定單時間 DATETIME2(2) DEFAULT SYSDATETIME()
)
GO

DROP TABLE 小訂單
CREATE TABLE 小訂單
(
	訂單編號 INT PRIMARY KEY,
	金額 INT,
	負責員工 INT CONSTRAINT 員工訂單關聯 FOREIGN KEY REFERENCES 小員工(員工號)
		ON UPDATE CASCADE -- NO ACTION | CASCADE | SET NULL | SET DEFAULT 
		ON DELETE SET NULL,
	定單時間 DATETIME2(2) DEFAULT SYSDATETIME()
)
GO

SELECT * FROM [員工表];
GO

EXEC sp_help '員工表';
SELECT * FROM sys.tables;


/*	自動編號 
		1. 整數型別 (INT、BIGINT)
		2. 每張資料表職能有一個

	問題點: 
		1. 破表(號碼用盡)	
		2. 跳號
*/

CREATE TABLE 編號測試表
(
	編號 INT IDENTITY(1,1), -- (開始值, 成長值)
	姓名 NVARCHAR(10),
	薪資 INT,
)




