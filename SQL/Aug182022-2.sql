USE ����_��

--- �i�ϥ�"���p����p�e"(Ctrl+L) �w���ˬd
--- "�]�A����p�e"(Ctrl+M) Run Code �æ^������p�e

SELECT * FROM ���u; --- 0.004
SELECT * FROM ���u ORDER BY �~��;  -- �Ƨ� ASC(�p-�j) | DESC(�j-�p)  -- 0.016 (�ƧǪ�3���ɶ�0.004*3)
SELECT * FROM ���u ORDER BY �~�� DESC; 

SELECT * FROM ���u ORDER BY �٩I, �~�� DESC;  --- �h��Ƨ�
SELECT * FROM ���u ORDER BY 4,8 DESC; --- �ĥ|��B�ĤK��Ƨ�

----------------------------------------
--- �l�����(Drived Column)
SELECT ���u�s��, �m�W, ¾��, �٩I, ���Τ��, �~�� FROM ���u;

SELECT ���u�s��, �m�W, ¾��, �٩I, 
	���Τ��, 
	YEAR(GETDATE())-YEAR(���Τ��) AS [�~��],
	�~��,
	�~��*15 AS [�~�~]
FROM ���u


SELECT * FROM �q�f�D��
SELECT �Ȥ�s�� FROM �q�f�D�� --- 0.0138
SELECT ALL �Ȥ�s�� FROM �q�f�D��
SELECT DISTINCT �Ȥ�s�� FROM �q�f�D�� --- �簣���ƭ�  0.0377
SELECT DISTINCT �Ȥ�s��, �q�渹�X FROM �q�f�D�� --- �`�N���G�A�����























