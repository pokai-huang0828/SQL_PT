/* VIEW(�˵�) �T�w�x�s�_�Ӫ��@�qSQL SELECT �d�߻y�k�A�u�O�ӥN�W��
				�ɥN�����\�A�����S���U�󴣤ɬd�߮į઺�@��
	
	1. ²��(����)������SQL�y�k
	2. ��K�v���t�m�α���
	3. �]�O�t�����l�d��

*/

USE ����_��


CREATE VIEW �Բӭq���˵�
AS
	SELECT 
		A.�q�渹�X, B.���q�W��, B.�s���H, B.�s���H¾��, B.�q��, 
		C.�m�W AS �t�d���u, D.�f�B���q�W�� AS �B�e�覡, A.�B�O
	FROM 
		�q�f�D�� AS A JOIN �Ȥ� AS B ON A.�Ȥ�s��=B.�Ȥ�s��
		JOIN ���u AS C ON A.���u�s��=C.���u�s��
		JOIN �f�B���q AS D ON A.�e�f�覡=D.�f�B���q�s��
GO

SELECT * FROM �Բӭq���˵�


CREATE VIEW ���u������˵�
AS
	SELECT [���u�s��], [�m�W], [¾��], [�٩I], [�X�ͤ��], [���Τ��], [�a�}], [�~��], [�q�ܸ��X], [�����������X], [�ۤ�], [����], [�D��]
	FROM ���u
GO

CREATE VIEW ���u�@�����˵�
AS
	SELECT [���u�s��], [�m�W], [¾��], [�٩I], [���Τ��], [�����������X], [�ۤ�], [�D��]
	FROM ���u
GO


SELECT * FROM ���u������˵�;
SELECT * FROM ���u�@�����˵�;

---------------------------------------------------------------------------------------------

USE �m�m

CREATE VIEW �������~�˵�
AS
	SELECT ���~�s��, �~�W, ����
	FROM ����
GO
SELECT * FROM �������~�˵�
DROP VIEW �������~�˵�

/* SCHEMABINDING �ϥΫe��
	
	1. ���o�ϥ� * ��
	2. ����Ҷ���q���g�k

*/
CREATE VIEW �������~�˵�
WITH SCHEMABINDING
AS
	SELECT ����.���~�s��, ����.�~�W, ����.����
	FROM DBO.����
GO
SELECT * FROM �������~�˵�
ALTER TABLE ���� DROP COLUMN ����;
DROP TABLE ����;

CREATE VIEW ����40���H�W�����~�˵�
AS
	SELECT ���~�s��, �~�W, ����
	FROM ����
	WHERE ����>=40
GO
SELECT * FROM ����40���H�W�����~�˵�



SELECT * FROM sys.tables;
SELECT * FROM sys.views;

EXEC sp_helptext '����40���H�W���~�˵�';


/* �Q��VIEW �ӽs��(INSERT�BUPDATE�BDELETE) ��ƪ��e��

	1. �ӷ������P�@�iTABLE(����o�� JOIN)
	2. �ӷ�TABLE ���঳�l�����
	3. VIEW ���e���ର�J�`���G(����GROUP BY)
*/
SELECT * FROM ���� ORDER BY ���~�s�� 
SELECT * FROM ����40���H�W�����~�˵�

INSERT INTO ����40���H�W�����~�˵� VALUES(26, '�i��', 30);
INSERT INTO ����40���H�W�����~�˵� VALUES(27, '�f���}', 10);


ALTER VIEW ����40���H�W�����~�˵�
AS
	SELECT ���~�s��, �~�W, ����
	FROM ����
	WHERE ����>=40
	WITH CHECK OPTION
GO

INSERT INTO ����40���H�W�����~�˵� VALUES(28, '�֨�', 30);
INSERT INTO ����40���H�W�����~�˵� VALUES(28, '����', 82);

---------------------------------------------------------------------------
/* ISO SQL : 2003
	CTE (Common Table Expression)
	�{�ɩʡB�@���ʪ��d�� View (�Χ���|����)

	1. ²�Ƥl�d�߼��g��������
	2. �W�i �u�����l�d�� ���d�߮į�

*/

SELECT ���~�s��, �~�W, ����
FROM (SELECT * FROM ����) AS A

-- | | | |
-- v v v v 

WITH Temp(�f��, �f�~�W, ���)
AS 
(
	SELECT * FROM ����
)
SELECT * FROM Temp ORDER BY ��� DESC

----------------------------------------------------------------------

WITH T1 
AS 
(
	SELECT TOP(10) ���u�s��, �m�W, �٩I, ¾��, �~�� 
	FROM  ���u ORDER BY �~�� DESC )
	
	, T2
AS
(
	SELECT TOP(5) ���u�s��, �m�W, �٩I, ¾��, �~�� 
	FROM  ���u ORDER BY �~�� DESC
)

SELECT * FROM T1 LEFT JOIN T2 ON T1.���u�s��=T2.���u�s��

-----------------------------------------------------------------------------

WITH T1
AS
( SELECT �٩I,¾��,COUNT(*) �H��
  FROM ���u
  GROUP BY �٩I,¾��
 )

SELECT [¾��],[�p�j],[����]
FROM T1 
PIVOT (SUM(�H��) FOR �٩I IN([�p�j],[����])) AS P;

----------------------------------------------------------------------------

/* CTE �����j

*/

WITH EE(���u��,�m�W,¾��,���h)
AS
(
	SELECT ���u�s��,�m�W,¾��,1
	FROM ���u
	WHERE �D�� IS NULL
	UNION ALL
	SELECT A.���u�s��,A.�m�W,A.¾��,B.���h+1
	FROM ���u AS A JOIN EE AS B ON A.�D��=B.���u��
)
SELECT * FROM EE;

SELECT ���u�s��,�m�W,¾��,�D�� FROM ���u;

/* CTE �����j
1. �̦h�i���j32767��
2. �w�]�u�|����100��
3. �i�Q�� �d�ߴ��� �ӽվ㻼�j����
*/
WITH EE(���u��,�m�W,¾��,���h)
AS
(
	SELECT ���u�s��,�m�W,¾��,1
	FROM ���u
	WHERE �D�� IS NULL
	UNION ALL
	SELECT A.���u�s��,A.�m�W,A.¾��,B.���h+1
	FROM ���u AS A JOIN EE AS B ON A.�D��=B.���u��
)
SELECT * FROM EE;
SELECT * FROM EE OPTION (MAXRECURSION 1);


--- 1. CTE ���u�����ɶ��h (�ҡG(2)���u�a��(1)�i�Զ���(4)�L���R)

/*  2. ���u�W�Z��X�ʶ�

EmployeeID Date
----------------------
1001 2007/03/24
1002 2007/03/24
1003 2007/03/24
1001 2007/03/25
1002 2007/03/25
1001 2007/03/26
1003 2007/03/26

�q�W���i�H�ݥX..���u�����b2007/03/25�S����d.���|�b2007/03/26�S����d.
�ҥH�ڷQ�o�X�p�U����T:
EmployeeID Date
-----------------------
1003 2007/03/25
1002 2007/03/26

-----------------------------------------------------------------------

CREATE TABLE #���u
(
  ���u�s�� VARCHAR(4),
  �m�W NVARCHAR(10)
)
go
CREATE TABLE #�X�ʶ�
(
  ���u�s�� VARCHAR(4),
  �W�Z�� DATE
)
go

INSERT INTO #���u VALUES('1001','�i�T')
INSERT INTO #���u VALUES('1002','���|')
INSERT INTO #���u VALUES('1003','����')

INSERT INTO #�X�ʶ� VALUES('1001','2007/03/24')
INSERT INTO #�X�ʶ� VALUES('1002','2007/03/24')
INSERT INTO #�X�ʶ� VALUES('1003','2007/03/24')
INSERT INTO #�X�ʶ� VALUES('1001','2007/03/25')
INSERT INTO #�X�ʶ� VALUES('1002','2007/03/25')
INSERT INTO #�X�ʶ� VALUES('1001','2007/03/26')
INSERT INTO #�X�ʶ� VALUES('1003','2007/03/26')

*/