
----  �ҵ{�оǶi��
--- ���\/���ѳq��
--- �ɧǮe��

--- ����x -> �A�� -> DTC (Distributed Transaction Coordinator) Check Enable!
--- �����������վ�

--- ���~���i OLE DB �ت��a���~��X 
--- �Q�ήɧǮe���վ㰻������

IF (SELECT COUNT(*) FROM sys.tables WHERE [name]='�_�����~')>0
	TRUNCATE TABLE [�_�����~];
ELSE
  BEGIN
	CREATE TABLE �_�����~
	(
	   ���~�s�� INT,
	   ���~�W�� NVARCHAR(20),
	   �����ӽs�� INT,
	   ���O�s�� INT,
	   ��� MONEY,
	   ���ƶq NVARCHAR(5),
	   �w�s�q INT
	)
  END



DROP TABLE �_�����~
SELECT * FROM �_�����~

--- ���->��L����-> variable

---  1. �C���ץX �_���Ȥ�_20220917_162430.csv
---  2. �C���Ƥ���Ʈw
---  ���� : ���� SQL �u�@�s�边 -> SQLSourseType -> �ܼ�
