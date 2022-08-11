/*	Constraint 條件約束 確保資料正確性
		
	1. NULL (無實質型別) / NOT NULL (變數必須有數值)
	2. CHECK		檢查資料的值
	3. DEFAULT		預設值
	4. PRIMARY KEY	主鍵	 
		4.1 確保資料不重複
		4.2 辨識/確認資料 Easy to find.



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

DROP TABLE [員工表]
GO

SELECT * FROM [員工表];
GO



