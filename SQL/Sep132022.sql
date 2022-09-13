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