/*	Constraint 條件約束 確保資料正確性
		
	1. NULL (無實質型別) / NOT NULL (變數必須有數值)
	2. CHECK 檢查資料的值



*/


USE 練習
GO

EXEC sp_helpdb '練習';
GO
EXEC sp_help '員工表';
GO

/*
CREATE TABLE [員工表]
(
	[員工號] INT NOT NULL,
	[姓名] NVARCHAR(10) NOT NULL,
	[性別] BIT NULL,
	[生日] DATE NULL,
	[薪資] INT NULL CHECK([薪資]>=25250),
)
GO
*/

-- 標準打法
CREATE TABLE [員工表]
(
	[員工號] INT NOT NULL,
	[姓名] NVARCHAR(10) NOT NULL,
	[性別] BIT NULL,
	[生日] DATE NULL,
	[薪資] INT CONSTRAINT 最低薪資檢查表 CHECK([薪資]>=25250) NOT NULL, 
	-- CONSTRAINT 若沒打會有不好擷取的問題
)
GO

DROP TABLE [員工表]
GO

SELECT * FROM [員工表];
GO



