USE �m�m;


/* UNION ��X
	1. �̵M�ݭn��O�ɶ��B�B�⦨��
	2. ��ӷ�������ƥ����ۦP
	3. ��ӷ������쫬�O�����ۮe
	4. �䵲�G���W�١A�|�H�Ĥ@���d�ߵ��G����쬰�̫ᵲ�G����W

*/
---		�簣���ƭ� 0.02
SELECT �~�W FROM ����
UNION
SELECT �~�W FROM �K�K;

---		�������H 0.008
SELECT �~�W FROM ����
UNION ALL
SELECT �~�W FROM �K�K;
------------------------

--- �w�� Collation
---		�|�y����Ʈw���� "��r���" �j�M�B�Ƨ� �X���D
---		Server �w�Ǥ��i�ܰʡA���i�b�s�}��Ʈw�ɭ��s�w��


USE �s�s
USE ����_��

SELECT * FROM fn_helpcollations();
SELECT * FROM fn_helpcollations() WHERE [name] LIKE '%taiwan%';
SELECT * FROM fn_helpcollations() WHERE [name] LIKE '%japan%';
SELECT * FROM fn_helpcollations() WHERE [name] LIKE '%korean%';



--�إ߸�Ʈw�A���w�w��
CREATE DATABASE �m��
ON PRIMARY
(
	NAME='�m��Data',FILENAME='C:\�m�߮a\�m�߸��.mdf',
	SIZE=20MB,MAXSIZE=UNLIMITED,FILEGROWTH=30MB
)

LOG ON
(
	NAME='�m��Log',FILENAME='C:\�m�߮a\�m�߰O��.ldf',
	SIZE=30MB,MAXSIZE=UNLIMITED,FILEGROWTH=50%
)
COLLATE Japanese_CI_AI
GO


--�إ߸�ƪ�A��r���w��
CREATE TABLE �m�ߪ�
(
    ��r���1 NVARCHAR(30) COLLATE Japanese_CI_AI,
	��r���2 NVARCHAR(30) COLLATE Chinese_Taiwan_Bopomofo_CI_AI,
	��r���3 NVARCHAR(30) COLLATE Korean_90_CI_AI_KS,
	�ƭ�1 INT
)

---------------------------------

SELECT * FROM ���u ORDER BY �m�W;
SELECT * FROM ���u ORDER BY �m�W COLLATE Chinese_Taiwan_Bopomofo_CI_AI;

SELECT * FROM fn_helpcollations() WHERE [name] LIKE '%taiwan%';
SELECT * FROM fn_helpcollations() WHERE [name] LIKE '%taiwan%' COLLATE Chinese_Taiwan_Bopomofo_CI_AI;




USE �s�s;

CREATE TABLE �s����
(
    ���~�s�� INT,
	���~�W NVARCHAR(20),
	��� MONEY
)

INSERT INTO �s���� SELECT * FROM �m�m.dbo.����;

SELECT * FROM �s����;

SELECT A.*,B.*
FROM �s�s.dbo.�s���� AS A JOIN ����_��.dbo.���~��� AS B ON A.���~�W=B.���~; -- ERROR


SELECT A.*,B.*
FROM �s�s.dbo.�s���� AS A JOIN ����_��.dbo.���~��� AS B ON A.���~�W=B.���~ COLLATE Chinese_Taiwan_Stroke_CI_AI;  -- PASS

SELECT * FROM SYS.databases;
SELECT [database_id], [name], [collation_name] FROM sys.databases;

---------------------------------------------------------------------------

/* �έp
	�E�X��� (Aggreate Function)

	SUM�BAVG�BMAX�BMIN�BCOUNT    
	VAR�BVARP�BSTDEV�BSTDEVP
*/
USE ����_��

SELECT * FROM ���u

SELECT �٩I, COUNT(���u�s��) AS �H��
	,SUM(�~��) AS �~���`�M
	,AVG(�~��) AS �����~��
	,MAX(�~��) AS �̰��~��
	,MIN(�~��) AS �̧C�~��
FROM ���u
GROUP BY �٩I;


-------------------------   TEST   ------------------------------
--- ����_���U�����~����������

SELECT B.���O�W��
	,AVG(���) AS ������
	,MAX(���) AS �̰���
	,MIN(���) AS �̧C��
FROM ���~��� AS A JOIN ���~���O AS B ON A.���~�s��=B.���O�s��
GROUP BY B.���O�W��

------------------------------------------------------------------

