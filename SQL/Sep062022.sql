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
		2.1. ��������@��: �i�ϥ��ܼƨӧ�g
		2.2. ���M��: ���ɸ�����ı�A���O�q�`�i�H��JOIN �Ө��N�A�Ĳv����
		2.3. ���զs�b: �q�`�Ĳv�_�ΡA���_��
	3. FROM: �ϥΥ��v�D�`���A�����d�߮Ĳv�X�G�����v�T

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


--- ���M��
SELECT �~�W FROM �K�K
SELECT * FROM ���� WHERE �~�W IN(SELECT �~�W FROM �K�K);
SELECT * FROM ���� WHERE �~�W NOT IN(SELECT �~�W FROM �K�K);


--- �S�R�L�F�誺�Ȥ�
USE ����_��

SELECT DISTINCT �Ȥ�s�� FROM �q�f�D��;

SELECT * FROM �Ȥ� 
	WHERE �Ȥ�s�� NOT IN(SELECT �Ȥ�s�� FROM �q�f�D��);

SELECT A.*,B.�q�渹�X
FROM �Ȥ� AS A LEFT JOIN �q�f�D�� AS B ON A.�Ȥ�s��=B.�Ȥ�s��

--0.0545
SELECT A.*
FROM �Ȥ� AS A LEFT JOIN �q�f�D�� AS B ON A.�Ȥ�s��=B.�Ȥ�s��
WHERE B.�q�渹�X IS NULL


--- 2004�~����X�����~
SELECT ���~�s�� FROM ���~���
SELECT ���~�s�� FROM �q�f����


SELECT * FROM ���~���
	WHERE ���~�s�� NOT IN (
		SELECT B.���~�s��
		FROM 
			�q�f���� AS A JOIN ���~��� AS B ON A.���~�s��=B.���~�s��
			JOIN �q�f�D�� AS C ON A.�q�渹�X=C.�q�渹�X
		WHERE 
			C.�q���� >= '2004-1-1' AND C.�q���� < '2005-1-1'	
	);


--- ���լO�_�s�b
USE �m�m

SELECT * FROM ���� AS A
	WHERE EXISTS(SELECT * FROM �K�K AS B WHERE B.�~�W=A.�~�W);

SELECT * FROM ���� AS A
	WHERE NOT EXISTS(SELECT * FROM �K�K AS B WHERE B.�~�W=A.�~�W);


--- �S�R�L�F�誺�Ȥ� �i����
USE ����_��

SELECT * FROM �Ȥ�
	WHERE NOT EXISTS(SELECT * FROM �q�f�D�� WHERE �Ȥ�s��=�Ȥ�.�Ȥ�s��)


--- ���W�v�ϥΤl�d�� FROM 
--- �q�渹�X, �Ȥ�s��, �q����, �f�ڪ��B, �B�O, �f�ڪ��B+�B�O AS �`���B

--- 1.
SELECT * FROM �q�f����
--- 2.
SELECT �q�渹�X, ���~�s��, ���*�ƶq*(1-�馩) AS ���B FROM �q�f����
--- 3.
SELECT �q�渹�X, ROUND(SUM(���*�ƶq*(1-�馩)), 0) AS ���B
FROM �q�f����
GROUP BY �q�渹�X
--- 4. 
SELECT A.�q�渹�X, A.�Ȥ�s��, A.�q����, B.���B, A.�B�O, B.���B+A.�B�O AS �`���B
FROM �q�f�D�� AS A JOIN (
	SELECT �q�渹�X, ROUND(SUM(���*�ƶq*(1-�馩)), 0) AS ���B
	FROM �q�f����
	GROUP BY �q�渹�X) AS B
	ON A.�q�渹�X=B.�q�渹�X

/*
1. ��¾�쪺�k�ͤH��(Can't use GROUP BY ALL)
2. �C�X�U���~���O������������~���������~
3. 2002�~ 1-4�u ���禬�~�Z
4. �C�X 2003�~ �~�ײֿn�q����B�W�L13000���Ȥ� top 10
5. �C�X�C�@��Ȥ�̫�@���U��ɶ�
6. ���R�L���A���Ȥ�A�̷ӳ̪�q���ʶR�ɶ��Ƨ�
*/