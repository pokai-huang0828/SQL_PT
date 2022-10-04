--Output    搭配 DML 使用 inserted / deleted

SELECT * FROM [匠匠];
INSERT INTO [匠匠] VALUES(26,'御飯糰',30);
UPDATE [匠匠] SET 價錢=45 WHERE 產品編號=26;
DELETE FROM [匠匠] WHERE 產品編號=26;

--↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ 

INSERT INTO [匠匠]
	OUTPUT inserted.*
VALUES(26,'御飯糰',30);

DELETE FROM [匠匠]
	OUTPUT deleted.*
WHERE 產品編號=26;

UPDATE [匠匠] SET 價錢=45
	OUTPUT inserted.產品編號,inserted.品名,inserted.價錢,deleted.價錢
		,inserted.價錢-deleted.價錢 AS 價差
WHERE 產品編號=26;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT * FROM 練習訂單;

INSERT INTO 練習訂單(金額) VALUES(1111);
INSERT INTO 練習訂單(金額) OUTPUT inserted.訂單編號 VALUES(5678);

-----------------------------------------

CREATE TABLE 匠匠追蹤表
(
    產品編號 INT,
	舊產品 NVARCHAR(10),
	舊售價 MONEY,
	新產品 NVARCHAR(10),
	新售價 MONEY,
	異動狀態 NVARCHAR(10),
	帳號 NVARCHAR(100) DEFAULT SUSER_SNAME(),
	異動時間 DATETIME2(2) DEFAULT SYSDATETIME()
)
GO

SELECT * FROM 匠匠追蹤表;

SELECT * FROM 匠匠;



INSERT INTO [匠匠]
	OUTPUT inserted.*,'新增產品'
		INTO 匠匠追蹤表(產品編號,新產品,新售價,異動狀態)
VALUES(26,'御飯糰',30);


UPDATE [匠匠]
SET 品名='大顆御飯糰',價錢=45
	OUTPUT inserted.*,deleted.品名,deleted.價錢,'產品資料異動'
		INTO 匠匠追蹤表(產品編號,新產品,新售價,舊產品,舊售價,異動狀態)
WHERE 產品編號=26;


DELETE FROM [匠匠]
	OUTPUT deleted.*,'刪除產品'
		INTO 匠匠追蹤表(產品編號,舊產品,舊售價,異動狀態)
WHERE 產品編號=26;

---------------------------------------------------------------------------------------------------------------------------------

CREATE PROC 匠匠新增 @id INT,@name NVARCHAR(10),@price MONEY
AS
	INSERT INTO [匠匠]
		OUTPUT inserted.*,'新增產品'
			INTO 匠匠追蹤表(產品編號,新產品,新售價,異動狀態)
	VALUES(@id,@name,@price);
GO

CREATE PROC 匠匠修改 @id INT,@name NVARCHAR(10),@price MONEY
AS
	UPDATE [匠匠]
	SET 品名=@name,價錢=@price
		OUTPUT inserted.*,deleted.品名,deleted.價錢,'產品資料異動'
			INTO 匠匠追蹤表(產品編號,新產品,新售價,舊產品,舊售價,異動狀態)
	WHERE 產品編號=@id;
GO

CREATE PROC 匠匠刪除 @id INT
AS
	DELETE FROM [匠匠]
		OUTPUT deleted.*,'刪除產品'
			INTO 匠匠追蹤表(產品編號,舊產品,舊售價,異動狀態)
	WHERE 產品編號=@id;
GO


EXEC 匠匠新增 27,'金莎',80;
EXEC 匠匠修改 27,'大金莎',180;
EXEC 匠匠刪除 27;

SELECT * FROM 匠匠;
SELECT * FROM 匠匠追蹤表;

--------------------------------------------------------