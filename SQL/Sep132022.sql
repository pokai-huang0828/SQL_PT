/* VIEW(�˵�) �T�w�x�s�_�Ӫ��@�qSQL SELECT �d�߻y�k�A�u�O�ӥN�W��
				�ɥN�����\�A�����S���U�󴣤ɬd�߮į઺�@��
	
	1. ²��(����)������SQL�y�k
	2. ��K�v���t�m�α���
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


CREATE VIEW ����40���H�W�����~�˵�
AS
	SELECT ���~�s��, �~�W, ����
	FROM ����
	WHERE ����>=40
GO
SELECT * FROM ����40���H�W�����~�˵�
