/* �Ȧs��

	1. �L�ץΤ��U�ϥΦ�ظ�Ʈw�A�@�߫إߦbTEMPDB ��Ʈw
	2. TEMPDB �̵M�|�y���Ϻ� IO ��Ū�g�A�ӫD�O����
	3. 

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

SELECT * FROM #TT;