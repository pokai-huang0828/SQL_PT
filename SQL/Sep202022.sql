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
	3. 

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

