USE ����_��

--- �S��GROUP BY ��GROUP BY
--- �p�G���ѨϥηJ�`��� �ӨS���ϥ�GROUP BY�A�N���������`��

SELECT COUNT(���u�s��) AS �H��
	,SUM(�~��) AS �~���`�M
	,AVG(�~��) AS �����~��
	,MAX(�~��) AS �̰��~��
	,MIN(�~��) AS �̧C�~��
FROM ���u

SELECT �٩I, ¾��, COUNT(*) AS �H��
FROM ���u
GROUP BY �٩I, ¾��
UNION ALL --- �N����s���_��
SELECT NULL, NULL, COUNT(*) FROM ���u

--- ISO SQL 2006
SELECT �٩I, ¾��, COUNT(*) AS �H��
FROM ���u
GROUP BY CUBE(�٩I, ¾��) --- ��C�@���׶i��[�`

SELECT �٩I, ¾��, COUNT(*) AS �H��
FROM ���u
GROUP BY ROLLUP(�٩I, ¾��) --- �̷ӲĤ@���i��[�`

SELECT �٩I, ¾��, COUNT(*) AS �H��
FROM ���u
GROUP BY GROUPING SETS( (�٩I, ¾��), () ) --- ()�ŬA���N�䬰����p�O�[�`

SELECT �٩I, ¾��, COUNT(*) AS �H��
FROM ���u
GROUP BY GROUPING SETS( (�٩I, ¾��), (¾��) )

SELECT �٩I, ¾��, COUNT(*) AS �H��
FROM ���u
GROUP BY GROUPING SETS( (�٩I, ¾��), (�٩I), (¾��), () )


/* �l�d�� (SubQuery)
	
	1. �쥻�ݭn�h���d�ߤ~�i�����A�Ʊ�@���d�w
	2. ���g�W������ı
	3. ��@�l�d�ߡA�̦h32�h
	4. �W�ߤl�d�� vs. ���p�l�d��

*/

/* �l�d�ߪ��ϥΦ�m
	
	1. �q���j�������l�d�ߡA�i�H�Ψ�L�覡�ѨM�A�קK�l�d��
	2. WHERE: �q�`�Ĳv���t
		2.1 ��������@��

*/

USE �m�m

--- ��������@��
SELECT MAX(����) FROM �K�K --- �K�K���̶Q�o
SELECT * FROM ���� WHERE ���� >= 123.79
---| | | |
---V V V V
SELECT * FROM ����
	WHERE ���� >= (SELECT MAX(����) FROM �K�K)


--- BEST SOLUTION !! ���� DECLARE ����X�A��^�h��
DECLARE @VV MONEY =(SELECT MAX(����) FROM �K�K);
SELECT * FROM ���� WHERE ���� >= @VV

