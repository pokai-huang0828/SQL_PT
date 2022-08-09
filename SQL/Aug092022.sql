-- USE 中文北風
-- GO
-- SELECT * FROM 員工
USE 練習
GO

CREATE TABLE 文字練習
(
	文字1 VARCHAR(20),
	文字2 NVARCHAR(20)
)
GO

INSERT INTO 文字練習 VALUES ('繡繡繡繡繡繡繡繡繡繡','繡繡繡繡繡繡繡繡繡繡');
INSERT INTO 文字練習 VALUES ('堃堃堃堃堃堃堃堃堃堃','堃堃堃堃堃堃堃堃堃堃');

SELECT * FROM 文字練習;

-- 加了'N' (NEW CODE )可以使用UTF-16 來處理因國籍文字無法讀取的問題
INSERT INTO 文字練習 VALUES (N'繡繡繡繡繡繡繡繡繡繡',N'繡繡繡繡繡繡繡繡繡繡'); 
INSERT INTO 文字練習 VALUES (N'堃堃堃堃堃堃堃堃堃堃',N'堃堃堃堃堃堃堃堃堃堃');

SELECT * FROM 文字練習;

DROP TABLE 文字練習;