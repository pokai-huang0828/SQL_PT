/* �Ȧs��

	1. �L�ץΤ��U�ϥΦ�ظ�Ʈw�A�@�߫إߦbTEMPDB ��Ʈw
	2. TEMPDB �̵M�|�y���Ϻ� IO ��Ū�g�A�ӫD�O����
	3. #TT �ӤH�Ȧs vs. ##TTT ����@�μȦs
	4. �����ɾ�

*/
USE �m��;
CREATE TABLE #TT
(
	�s�� INT,
	�m�W NCHAR(10),
	�~�� INT
)
GO

INSERT INTO #TT VALUES(1, 'AAA', 100);
INSERT INTO #TT VALUES(2, 'BBB', 200);
INSERT INTO #TT VALUES(3, 'CCC', 300);
UPDATE #TT SET �m�W=RTRIM(�m�W)+'ZZ' WHERE �s��=2;
INSERT INTO #TT VALUES(4, 'DDD', 400);
DELETE FROM #TT WHERE �s��=3;


SELECT * FROM #TT;


CREATE TABLE ##TTT
(
	�s�� INT,
	�m�W NCHAR(10),
	�~�� INT
)
GO

INSERT INTO ##TTT VALUES(1, 'AAA', 100);
INSERT INTO ##TTT VALUES(2, 'BBB', 200);
INSERT INTO ##TTT VALUES(3, 'CCC', 300);

SELECT * FROM ##TTT;
----------------------------------------------------------------------------
USE �m�m;

SELECT * FROM ����;
SELECT * FROM �K�K;

--SQL89
SELECT ����.�~�W AS �������~,����.���� AS �������
	,�K�K.�~�W AS �K�K���~,�K�K.���� AS �K�K���
FROM ����,�K�K
WHERE ����.�~�W=�K�K.�~�W;

SELECT ����.�~�W AS �������~,����.���� AS �������
	,�K�K.�~�W AS �K�K���~,�K�K.���� AS �K�K���
FROM ����,�K�K
WHERE ����.�~�W=�K�K.�~�W AND ����.����>=40;

--SQL92
SELECT ����.�~�W AS �������~,����.���� AS �������
	,�K�K.�~�W AS �K�K���~,�K�K.���� AS �K�K���
FROM ���� INNER JOIN �K�K ON ����.�~�W=�K�K.�~�W
WHERE ����.����>=40;

SELECT A.�~�W AS �������~,A.���� AS �������
	,B.�~�W AS �K�K���~,B.���� AS �K�K���
FROM ���� AS A INNER JOIN �K�K AS B ON A.�~�W=B.�~�W
WHERE A.����>=40;

-----------------------------------------------------------
/* JOIN
	1. ���� ��Ʈw���W�� -> ��Ƥ����b�U��Ƥ�
	2. ���O�B��ɶ�
	 
	INNER JOIN 
	LEFT OUTER JOIN
	RIGHT OUTER JOIN
	FULL OUTER JOIN
	CROSS JOIN

*/
USE ����_��;

SELECT * FROM ���~���   --- 0.031

SELECT A.���~�s��, A.���~, B.������, C.���O�W��, A.���, A.���ƶq, A.�w�s�q   --- 0.076
FROM [���~���] AS A INNER JOIN ������ AS B ON A.�����ӽs��=B.�����ӽs��
	JOIN ���~���O AS C ON A.���O�s��=C.���O�s��



SELECT A.�q�渹�X, B.���q�W��, B.�s���H, B.�s���H¾��, B.�q��,
		A.�q����, C.�m�W AS �t�d���u, 
		D.�f�B���q�W�� AS �B�e�覡, A.�B�O
FROM �q�f�D�� AS A JOIN �Ȥ� AS B ON A.�Ȥ�s��=B.�Ȥ�s��
	JOIN ���u AS C ON A.���u�s��=C.���u�s��
	JOIN �f�B���q AS D ON A.�e�f�覡=D.�f�B���q�s��

--- ADD INTO
SELECT A.�q�渹�X,B.���q�W��,B.�s���H,B.�s���H¾��,B.�q��
	,A.�q����,C.�m�W AS �t�d���u
	,D.�f�B���q�W�� AS �B�e�覡,A.�B�O
INTO �Բӭq��@��
FROM �q�f�D�� AS A JOIN �Ȥ� AS B ON A.�Ȥ�s��=B.�Ȥ�s��
	JOIN ���u AS C ON A.���u�s��=C.���u�s��
	JOIN �f�B���q AS D ON A.�e�f�覡=D.�f�B���q�s��

SELECT * FROM �Բӭq��@��;		--0.011


--0.04
SELECT A.�q�渹�X,A.�Ȥ�s��,A.���u�s��,A.�q����,D.�f�B���q�W��,A.�B�O
FROM �q�f�D�� AS A JOIN �f�B���q AS D ON A.�e�f�覡=D.�f�B���q�s��

SELECT CHOOSE(5,'AA','BB','CC','DD','EE','FF')

--0.0139
SELECT A.�q�渹�X,A.�Ȥ�s��,A.���u�s��,A.�q����,A.�B�O
	,CHOOSE(A.�e�f�覡,'�ֻ�','�l�H','�˰e') AS �B�e�覡
FROM �q�f�D�� AS A

----------------------------------------------
USE �m�m;

SELECT * FROM ����;
SELECT * FROM �K�K;

SELECT A.�~�W AS �������~,A.���� AS �������
	,B.�~�W AS �K�K���~,B.���� AS �K�K���
FROM ���� AS A LEFT OUTER JOIN �K�K AS B ON A.�~�W=B.�~�W


SELECT A.�~�W AS �������~,A.���� AS �������
	,B.�~�W AS �K�K���~,B.���� AS �K�K���
FROM ���� AS A RIGHT JOIN �K�K AS B ON A.�~�W=B.�~�W

SELECT A.�~�W AS �������~,A.���� AS �������
	---B.�~�W AS �K�K���~,B.���� AS �K�K���
FROM ���� AS A LEFT OUTER JOIN �K�K AS B ON A.�~�W=B.�~�W
WHERE B.�~�W IS NULL


---- SQL Server �S��
SELECT A.�~�W AS �������~,A.���� AS �������
	,B.�~�W AS �K�K���~,B.���� AS �K�K���
FROM ���� AS A FULL OUTER JOIN �K�K AS B ON A.�~�W=B.�~�W;



SELECT A.�~�W AS �������~,A.���� AS �������
	,B.�~�W AS �K�K���~,B.���� AS �K�K���
FROM ���� AS A CROSS JOIN �K�K AS B;


-------------------------------------------------------------

----���ǦP�ƥ[�~5%���~���W�L7�U
USE ����_��;

SELECT [���u�s��], [�m�W], [¾��], [�~��], [�~��]*1.05 AS ���~��
FROM ���u
WHERE [�~��]*1.05 >= 70000


--- ��ܥD�ީm�W�Ӥ��O�N��
SELECT [���u�s��], [�m�W], [¾��], [�D��] FROM ���u;

SELECT A.���u�s��, A.�m�W, A.¾��
	, B.���u�s�� AS �D�޽s��
	, B.�m�W AS �D�ީm�W
	, B.¾�� AS �D��¾��
FROM ���u AS A LEFT JOIN ���u AS B ON A.�D��=B.���u�s��;