/* �l�d�� (SubQuery) PART2
	
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
	4. COLUMN: ���g�W�����ޥ��A�ɶ��į�̷Ӭd�ߥX����Ƶ��Ʀөw

*/


USE ����_��

SELECT TOP(10) ���u�s��, �m�W, �٩I, ¾��, �~�� 
FROM  ���u 
ORDER BY �~�� DESC;

SELECT TOP(5) ���u�s��, �m�W, �٩I, ¾��, �~�� 
FROM  ���u 
ORDER BY �~�� DESC;

---- ���~��� 6-10 �����u
--- �l�d�ߤ��i�ϥ� ORDER BY  0.0502
SELECT * 
FROM  (SELECT TOP(10) ���u�s��, �m�W, �٩I, ¾��, �~�� 
	FROM  ���u ORDER BY �~�� DESC ) AS A
EXCEPT       ---INTERSECT | EXCEPT
SELECT *
FROM (SELECT TOP(5) ���u�s��, �m�W, �٩I, ¾��, �~�� 
	FROM  ���u ORDER BY �~�� DESC ) AS B
ORDER BY �~�� DESC; 

--- �i���� 0.0426
SELECT A.* 
FROM (SELECT TOP(10) ���u�s��, �m�W, �٩I, ¾��, �~�� 
	FROM  ���u ORDER BY �~�� DESC ) AS A
	LEFT JOIN
	(SELECT TOP(5) ���u�s��, �m�W, �٩I, ¾��, �~�� 
		FROM  ���u ORDER BY �~�� DESC ) AS B
	ON A.���u�s��=B.���u�s��
WHERE B.���u�s�� IS NULL

--- ���e�����O���O�̫e�������� 0.0420
SELECT TOP(5) ���u�s��, �m�W, �٩I, ¾��, �~�� 
FROM  ���u 
WHERE ���u�s�� NOT IN(SELECT TOP(5) ���u�s�� FROM  ���u ORDER BY �~�� DESC )
ORDER BY �~�� DESC;

--- 0.0242 �W�i��
SELECT *
FROM (
	SELECT ���u�s��, �m�W, �٩I, ¾��, �~��
		,(SELECT COUNT(*) FROM ���u AS B WHERE B.�~��>A.�~��) AS �ƦW
	FROM ���u AS A
	) AS C
WHERE �ƦW>=6 AND �ƦW<=15
ORDER BY �~�� DESC


--- ���������(�t���l�d��)
SELECT ���u�s��, �m�W, �٩I, ¾��, �~��
	, ROW_NUMBER() OVER(ORDER BY �~�� DESC) AS �C��	
FROM ���u AS A

--0.157
SELECT *
FROM ( SELECT ���u�s��,�m�W,�٩I,¾��,�~��
			,ROW_NUMBER() OVER(ORDER BY �~�� DESC) AS �C��
		FROM ���u AS A ) AS B
WHERE �C��>=26 AND �C��<=30;


--��������� �ƧǮa��
SELECT ���u�s��,�m�W,�٩I,¾��,�~��
	,ROW_NUMBER() OVER(ORDER BY �~�� DESC) AS �C��
FROM ���u AS A

SELECT ���u�s��,�m�W,�٩I,¾��,�~��
	,RANK() OVER(ORDER BY �~�� DESC) AS �ƦW
FROM ���u AS A

SELECT ���u�s��,�m�W,�٩I,¾��,�~��
	,DENSE_RANK() OVER(ORDER BY �~�� DESC) AS �ƦW
FROM ���u AS A


---- �A�X�d�� �ʤ��񪺸��
SELECT ���u�s��,�m�W,�٩I,¾��,�~��
	,NTILE(4) OVER(ORDER BY �~�� DESC) AS �s��
FROM ���u AS A




SELECT �Ȥ�s��, �q�渹�X FROM �q�f�D��;
SELECT �Ȥ�s��, �q�渹�X FROM �q�f�D�� ORDER BY �Ȥ�s��;

SELECT �Ȥ�s��, �q�渹�X
		, ROW_NUMBER() OVER(PARTITION BY �Ȥ�s�� ORDER BY �Ȥ�s�� ) AS �y����
FROM �q�f�D��;





--- SQL2012 ���L�e����

--- �����U�Ӫ�����
