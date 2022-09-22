
USE ����_��;
SELECT STRING_AGG([���~], ',') FROM ���~���;

--- CURSOR 

DECLARE @nameList NVARCHAR(1024) = ''; -- '' => �Ŧr��
SET @nameList = @nameList + '���K';
SELECT @nameList;

DECLARE @nameList NVARCHAR(1024) = ''; -- '' => �Ŧr��
SELECT @nameList = @nameList + [���~] + ', '
FROM ���~���;
SET @nameList = SUBSTRING(@nameList, 1, LEN(@nameList)-1); -- �h���r��
SELECT @nameList;


CREATE FUNCTION �������~�M��(@typeId INT) RETURNS NVARCHAR(1024)
AS 
	BEGIN 
		DECLARE @nameList NVARCHAR(1024) = ''; -- '' => �Ŧr��
		SELECT @nameList = @nameList + [���~] + ', ' FROM ���~��� WHERE ���O�s�� = @typeId;
		SET @nameList = SUBSTRING(@nameList, 1, LEN(@nameList)-1); -- �h���r��
		RETURN @nameList;
	END
GO

DECLARE @nn NVARCHAR(1024);
SET @nn=dbo.�������~�M��(1);
PRINT @nn;

----------------------------------------------------------------

/* HOMEWORK

1. �q��X�f�@��

�ҡG
�q�渹  �Ȥḹ  �e�f�a�}					�q�ʲ��~
10248	VINET	�x�_���_���F��24��3�Ӥ��@   42(10), 72(5)
10249	TOMSP	�������������@�q12��        14(9), 51(40)
10250	HANAR	�������������@�q12��        41(10), 51(35), 65(15)
*/

--2. ���u�}�v

CREATE TABLE �}�v��
(
  �u�O CHAR(2),
  ���O INT,
  �}�v MONEY
)
GO
INSERT INTO �}�v�� VALUES('L1',1,0.8),('L1',2,0.9),('L1',3,0.7)
INSERT INTO �}�v�� VALUES('L2',1,0.9),('L2',2,0.9),('L2',3,0.8),('L2',4,0.9)

SELECT * FROM �}�v��

--------------------------------------------------------------
CREATE TABLE �m�߭q��
(
    �q��s�� CHAR(14) DEFAULT dbo.�ۭq�渹(),
	���B INT,
	�q��ɶ� DATETIME2(2) DEFAULT SYSDATETIME()
)
GO

CREATE FUNCTION �ۭq�渹() RETURNS VARCHAR(14)
AS 
	BEGIN 
		DECLARE @prefixOrderId VARCHAR(14);
		DECLARE @searchOrderId VARCHAR(14);
		DECLARE @lastOrderId VARCHAR(14);
		DECLARE @finalOrderId VARCHAR(14);

		DECLARE @num INT;
		DECLARE @numS VARCHAR(6);

		SET @prefixOrderId = FORMAT(GETDATE(), 'yyyyMMdd');
		SET @searchOrderId = @prefixOrderId + '%';

		SELECT TOP(1) @lastOrderId = �q��s�� FROM �m�߭q��
		WHERE �q��s�� LIKE @searchOrderId
		ORDER BY �q��s�� DESC;

		IF @@ROWCOUNT=0
		SET @finalOrderId=@prefixOrderId+'000001';
		ELSE
		  BEGIN
			SET @numS=SUBSTRING(@lastOrderId,9,6);
			SET @num=CONVERT(INT,@numS)+1;
			SET @numS=FORMAT(@num,'000000');
			SET @finalOrderId=@prefixOrderId+@numS;
		  END
		RETURN @finalOrderId
	 END
GO


-----------------------------------------------------------------

SELECT TOP(3) C.���~,SUM(B.�ƶq) AS �ʶR�ƶq
FROM �q�f�D�� AS A JOIN �q�f���� AS B ON A.�q�渹�X=B.�q�渹�X
	JOIN ���~��� AS C ON B.���~�s��=C.���~�s��
WHERE A.�Ȥ�s��='ANATR'
GROUP BY C.���~
ORDER BY �ʶR�ƶq DESC


CREATE FUNCTION �Ȥ��ʶR�e�T(@customerId VARCHAR(5)) RETURNS TABLE
AS
	RETURN (
		SELECT TOP(3) C.���~,SUM(B.�ƶq) AS �ʶR�ƶq
		FROM �q�f�D�� AS A JOIN �q�f���� AS B ON A.�q�渹�X=B.�q�渹�X
			JOIN ���~��� AS C ON B.���~�s��=C.���~�s��
		WHERE A.�Ȥ�s��=@customerId
		GROUP BY C.���~
		ORDER BY �ʶR�ƶq DESC
	)
GO
	
SELECT * FROM �Ȥ�
SELECT * FROM dbo.�Ȥ��ʶR�e�T('BLAUS')

SELECT A.�Ȥ�s��,A.���q�W��,B.���~,B.�ʶR�ƶq
FROM �Ȥ� AS A CROSS APPLY dbo.�Ȥ��ʶR�e�T(A.�Ȥ�s��) AS B;