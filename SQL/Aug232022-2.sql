USE ����_��;

SELECT ���u�s��, �m�W, ¾��, �٩I, ���Τ��, �~�� 
FROM ���u 
WHERE �~�� >=60000;

SELECT ���u�s��, �m�W, ¾��, �٩I, ���Τ��, �~�� 
FROM ���u 
WHERE �~�� >=50000 AND �~�� <= 65000;

SELECT ���u�s��, �m�W, ¾��, �٩I, ���Τ��, �~�� 
FROM ���u 
WHERE �~�� < 40000 OR �~�� > 70000 ORDER BY �~�� DESC; -- �j�ܤp

-------------------------------------------------------------
--- Numeric Functions

SELECT ABS(-5);
SELECT ROUND(56.789, 2);
SELECT ROUND(56.789, 0);
SELECT ROUND(56.789, -1);
SELECT POWER(3, 4);
SELECT RAND();  -----------   0 <= ~ < 1 
SELECT SQRT(81);

SELECT CEILING(7.8);----  �L����i��
SELECT CEILING(7.3);
SELECT CEILING(77.0/10);

SELECT FLOOR(7.8);  ----  �L����˥h

SELECT 20/3;       --------	  6
SELECT 1.0*20/3;   --------   6.6666... 

--------------------------------------------------------------------
---  Date Functions

SELECT ���u�s��, �m�W, ¾��, �٩I, ���Τ��, �~�� 
FROM ���u 
WHERE ���Τ�� >= '2002-1-1';

SELECT ���u�s��, �m�W, ¾��, �٩I, ���Τ��, �~�� 
FROM ���u 
WHERE ���Τ�� >= '2002-1-1' AND ���Τ�� <= '2002-12-31 23:59:59';

SELECT ���u�s��, �m�W, ¾��, �٩I, ���Τ��, �~�� 
FROM ���u 
WHERE ���Τ�� >= '2002-1-1' AND ���Τ�� < '2003-1-1';

SELECT ���u�s��, �m�W, ¾��, �٩I, ���Τ��, �~�� 
FROM ���u 
WHERE ���Τ�� BETWEEN '2002-1-1' AND '2002-12-31 23:59:59';

/* �ɥi��O�b WHERE �����ϥΨ��
	1.	�j�M�ɶ��ܺC
	2.	�ɭP���޵L�k�G���j�M�k --> ���ޱ��y

	WHERE Score >= 36			--- GOOD
	WHERE SQRT(Score)*10>=60	--- BAD
*/

SELECT ���u�s��, �m�W, ¾��, �٩I, ���Τ��, �~�� 
FROM ���u 
WHERE YEAR(���Τ��)=2002;
