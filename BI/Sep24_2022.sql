
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
