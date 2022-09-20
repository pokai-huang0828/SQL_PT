--- Store Procedure
USE ����_��

CREATE PROC ���~�d��
AS
	SELECT A.���~�s��, A.���~, C.������, B.���O�W��, A.���, A.���ƶq, A.�w�s�q
	FROM ���~��� AS A JOIN ���~���O AS B ON A.���O�s��=B.���O�s��
		JOIN ������ AS C ON A.�����ӽs��=C.�����ӽs��
	ORDER BY ��� DESC
GO
EXEC ���~�d��;

-----------------------------------
ALTER PROC ���~�d�� @price1 MONEY, @price2 MONEY
AS 
	SELECT A.���~�s��,A.���~,C.������,B.���O�W��,A.���,A.���ƶq,A.�w�s�q
	FROM ���~��� AS A JOIN ���~���O AS B ON A.���O�s��=B.���O�s��
		JOIN ������ AS C ON A.�����ӽs��=C.�����ӽs��
	WHERE ���>=@price1 AND ���<=@price2
	ORDER BY ��� DESC
GO

EXEC ���~�d�� 30,50;
EXEC ���~�d�� 50,100;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

ALTER PROC ���~�d�� @price1 MONEY=0,@price2 MONEY=100000
AS
	SELECT A.���~�s��,A.���~,C.������,B.���O�W��,A.���,A.���ƶq,A.�w�s�q
	FROM ���~��� AS A JOIN ���~���O AS B ON A.���O�s��=B.���O�s��
		JOIN ������ AS C ON A.�����ӽs��=C.�����ӽs��
	WHERE ���>=@price1 AND ���<=@price2
	ORDER BY ��� DESC
GO

EXEC ���~�d��;
EXEC ���~�d�� 50;
EXEC ���~�d�� 30,40;

EXEC ���~�d�� DEFAULT,30;
EXEC ���~�d�� @price2=10;
EXEC ���~�d�� @price2=10,@price1=5;

EXEC sp_helptext '���~�d��';
EXEC sp_helptext '�Բӭq���˵�';

/* �w�s�{�� VS. ���

	1. �Ҭ��sĶ�L���A�۸����U�A�w�s�{�Ǹ����Ĳv�C
	2. �w�s�{�ǥu��W�߰���A�L�k�f�t��L��SQL�y�k����;
		��ƾA�ΤW�����F���A�i���N�f�t��LSQL�y�k�t�X����C
	3. �w�s�{�� ������h�� �a�J�B�a�X��ѼơA�åB�i�H�֦��@�Ӿ�ƫ��A���Ǧ^�ȡC
	4. �w�s�{�ǭ�h�W�i�������SQL�R�O

*/
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

ALTER PROC ���~�d�� @price1 MONEY=0,@price2 MONEY=100000
	,@sum MONEY OUTPUT,@avg MONEY OUTPUT
AS
	SELECT @sum=SUM(A.���),@avg=AVG(A.���) 
	FROM ���~��� AS A		
	WHERE ���>=@price1 AND ���<=@price2;
	
	SELECT A.���~�s��,A.���~,C.������,B.���O�W��,A.���,A.���ƶq,A.�w�s�q
	FROM ���~��� AS A JOIN ���~���O AS B ON A.���O�s��=B.���O�s��
		JOIN ������ AS C ON A.�����ӽs��=C.�����ӽs��
	WHERE ���>=@price1 AND ���<=@price2
	ORDER BY ��� DESC;
GO


DECLARE @ss MONEY;
DECLARE @aa MONEY;
EXEC ���~�d�� 30,40,@ss OUTPUT,@aa OUTPUT;
PRINT @ss;
PRINT @aa;

-----------------------------------------------------------------------------------

ALTER PROC ���~�d�� @price1 MONEY=0,@price2 MONEY=100000
	,@sum MONEY OUTPUT,@avg MONEY OUTPUT
AS
	SELECT @sum=SUM(A.���),@avg=AVG(A.���)
	FROM ���~��� AS A		
	WHERE ���>=@price1 AND ���<=@price2;
	
	DECLARE @count INT;

	SELECT A.���~�s��,A.���~,C.������,B.���O�W��,A.���,A.���ƶq,A.�w�s�q
	FROM ���~��� AS A JOIN ���~���O AS B ON A.���O�s��=B.���O�s��
		JOIN ������ AS C ON A.�����ӽs��=C.�����ӽs��
	WHERE ���>=@price1 AND ���<=@price2
	ORDER BY ��� DESC;

	SET @count=@@ROWCOUNT;
	RETURN @count;
GO

DECLARE @ss MONEY;
DECLARE @aa MONEY;
DECLARE @cc INT;
EXEC @cc=���~�d�� 30,40,@ss OUTPUT,@aa OUTPUT;
PRINT @ss;
PRINT @aa;
PRINT @cc;

----------------------------------------------------------------------------------


CREATE PROC �ؤ@���
AS
    CREATE TABLE T1(C1 INT,C2 NVARCHAR(10));
	CREATE TABLE T2(C1 INT,C2 NVARCHAR(10));
	CREATE TABLE T3(C1 INT,C2 NVARCHAR(10));
	CREATE TABLE T4(C1 INT,C2 NVARCHAR(10));
	CREATE TABLE T5(C1 INT,C2 NVARCHAR(10));
	CREATE TABLE T6(C1 INT,C2 NVARCHAR(10));
GO

CREATE PROC �R�@���
AS
  DROP TABLE T1,T2,T3,T4,T5,T6;
GO  


EXEC �ؤ@���;
EXEC �R�@���;

-------------------------------------------------------------

