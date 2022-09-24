
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



CREATE TABLE 城市參考表
(
    城市 NVARCHAR(10),
	目標城市 NVARCHAR(10)
)
GO

INSERT INTO 城市參考表 VALUES('台北市','台北市')
INSERT INTO 城市參考表 VALUES('台北','台北市')
INSERT INTO 城市參考表 VALUES('北市','台北市')
INSERT INTO 城市參考表 VALUES('台北縣','台北縣')
INSERT INTO 城市參考表 VALUES('北縣','台北縣')
INSERT INTO 城市參考表 VALUES('桃園縣','桃園縣')
INSERT INTO 城市參考表 VALUES('桃縣','桃園縣')
INSERT INTO 城市參考表 VALUES('桃園市','桃園市')
INSERT INTO 城市參考表 VALUES('桃市','桃園市')
INSERT INTO 城市參考表 VALUES('新竹縣','新竹縣')
INSERT INTO 城市參考表 VALUES('竹縣','新竹縣')
INSERT INTO 城市參考表 VALUES('新竹市','新竹市')
INSERT INTO 城市參考表 VALUES('苗栗市','苗栗市')
INSERT INTO 城市參考表 VALUES('苗栗','苗栗縣')
INSERT INTO 城市參考表 VALUES('苗栗縣','苗栗縣')
INSERT INTO 城市參考表 VALUES('竹市','新竹市')
INSERT INTO 城市參考表 VALUES('台中','台中縣')
INSERT INTO 城市參考表 VALUES('台中市','台中市')
INSERT INTO 城市參考表 VALUES('中市','台中市')
INSERT INTO 城市參考表 VALUES('台中縣','台中縣')
INSERT INTO 城市參考表 VALUES('中縣','台中縣')
INSERT INTO 城市參考表 VALUES('南投市','南投市')
INSERT INTO 城市參考表 VALUES('南投縣','南投縣')
INSERT INTO 城市參考表 VALUES('南投','南投縣')
INSERT INTO 城市參考表 VALUES('彰化縣','彰化縣')
INSERT INTO 城市參考表 VALUES('彰縣','彰化縣')
INSERT INTO 城市參考表 VALUES('彰化市','彰化市')
INSERT INTO 城市參考表 VALUES('彰市','彰化市')
INSERT INTO 城市參考表 VALUES('雲林縣','雲林縣')
INSERT INTO 城市參考表 VALUES('雲林','雲林縣')
INSERT INTO 城市參考表 VALUES('嘉義縣','嘉義縣')
INSERT INTO 城市參考表 VALUES('嘉縣','嘉縣')
INSERT INTO 城市參考表 VALUES('嘉義市','嘉義市')
INSERT INTO 城市參考表 VALUES('嘉市','嘉義市')
INSERT INTO 城市參考表 VALUES('台南市','台南市')
INSERT INTO 城市參考表 VALUES('南市','台南市')
INSERT INTO 城市參考表 VALUES('台南縣','台南縣')
INSERT INTO 城市參考表 VALUES('南縣','台南縣')
INSERT INTO 城市參考表 VALUES('高雄市','高雄市')
INSERT INTO 城市參考表 VALUES('高雄縣','高雄縣')
INSERT INTO 城市參考表 VALUES('高雄','高雄縣')
INSERT INTO 城市參考表 VALUES('雄市','高雄市')
INSERT INTO 城市參考表 VALUES('雄縣','高雄縣')
INSERT INTO 城市參考表 VALUES('花蓮','花蓮縣')
INSERT INTO 城市參考表 VALUES('花蓮縣','花蓮縣')
INSERT INTO 城市參考表 VALUES('花縣','花蓮縣')
INSERT INTO 城市參考表 VALUES('花蓮市','花蓮市')
INSERT INTO 城市參考表 VALUES('花市','花蓮市')
INSERT INTO 城市參考表 VALUES('宜蘭縣','宜蘭縣')
INSERT INTO 城市參考表 VALUES('宜蘭市','宜蘭市')
INSERT INTO 城市參考表 VALUES('宜蘭','宜蘭縣')
INSERT INTO 城市參考表 VALUES('宜縣','宜蘭縣')
INSERT INTO 城市參考表 VALUES('宜市','宜蘭市')
INSERT INTO 城市參考表 VALUES('屏東縣','屏東縣')
INSERT INTO 城市參考表 VALUES('屏東市','屏東市')
INSERT INTO 城市參考表 VALUES('屏東','屏東縣')
INSERT INTO 城市參考表 VALUES('屏縣','屏東縣')
INSERT INTO 城市參考表 VALUES('屏市','屏東市')

TRUNCATE TABLE 城市參考表
SELECT * FROM 城市參考表


CREATE TABLE 匯入客戶
(
	客戶編號 nvarchar(5) NULL,
	公司名稱 nvarchar(40) NOT NULL,
	連絡人 [nvarchar](30) NULL,
	連絡人職稱 [nvarchar](30) NULL,
	地址 [nvarchar](60) NULL,	
	城市 [nvarchar](15) NULL,		
	目標城市 [nvarchar](15) NULL,		
	相似度 [nvarchar](15) NULL,		
	郵遞區號 [nvarchar](10) NULL,	
	電話 [nvarchar](24) NULL,
	傳真電話 [nvarchar](24) NULL
)


DROP TABLE 匯入客戶
SELECT * FROM 匯入客戶


----------------------------------------------------

CREATE TABLE 匯入英文客戶
(
    客戶編號 INT,
    姓名 NCHAR(50),
    居住城市 NVARCHAR(50),
    原始城市 NVARCHAR(50),
    相似度 NVARCHAR(50)
)
GO

CREATE TABLE 英文城市參考表
(
    城市 NVARCHAR(50),
    目標城市 NVARCHAR(50)
)
GO


INSERT INTO 英文城市參考表 VALUES('New York','New York')
INSERT INTO 英文城市參考表 VALUES('Los Angeles','Los Angeles')
INSERT INTO 英文城市參考表 VALUES('New Orleans','New Orleans')
INSERT INTO 英文城市參考表 VALUES('Chicago','Chicago')
INSERT INTO 英文城市參考表 VALUES('New Jersey','New Jersey')
INSERT INTO 英文城市參考表 VALUES('Seattle','Seattle')

INSERT INTO 英文城市參考表 VALUES('NY','New York')
INSERT INTO 英文城市參考表 VALUES('LA','Los Angeles')
INSERT INTO 英文城市參考表 VALUES('CHI','Chicago')
GO

DROP TABLE 匯入英文客戶
SELECT * FROM 匯入英文客戶

SELECT 員工編號, 姓名, 稱呼, 職稱, 雇用日期, 薪資
FROM 員工
