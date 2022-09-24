
TRUNCATE TABLE [北風產品2];

CREATE TABLE [dbo].[北風產品2](
	[產品編號] [int] NULL,
	[產品名稱] [nvarchar](20) NULL,
	[供應商編號] [int] NULL,
	[類別編號] [int] NULL,
	[單位數量] [nvarchar](500) NULL,
	[單價] [money] NULL,
	[庫存量] [int] NULL
) ON [PRIMARY]
GO

SELECT * FROM [北風產品2] order by 產品編號
DROP TABLE [北風產品2]

------------------------------------------------------

SELECT 客戶編號, 公司名稱, 連絡人, 連絡人職稱, 電話, 'kenny0963676060@gmail.com' AS 電子郵件
INTO 練習.dbo.EDM
FROM 中文北風.dbo.客戶
WHERE 地址 LIKE '桃園%'


--信件底稿
/*
@[User::CID] +"  "+ @[User::CCompanyName] +"\n"+
"親愛的 "+ @[User::CPerson] +" "+ @[User::CPersonJob]  +" 您好：\n"+
"本公司跳樓大拍賣！\n"+
"請快來搶購！\n\n\n巨匠公司 敬上"
*/



