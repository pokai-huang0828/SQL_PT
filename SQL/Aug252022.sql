USE ����_��;

SELECT UNICODE(N'��');
SELECT UNICODE(N'��');

SELECT * FROM ���u;
SELECT * FROM ���u WHERE ¾��='�~�ȥD��';
SELECT * FROM ���u WHERE ¾��='�D��' OR ¾��='�u�{�v' OR ¾��='�U�z';

--- * Better
SELECT * FROM ���u WHERE ¾�� IN('�D��', '�u�{�v', '�U�z');


--- ** �ҽk�j�M �U�Φr��
---		%	 �i�N�����N�r���A�t�Ŧr���B�����r��
---		_	 �i�N�����N�r���A���t�Ŧr���B�@���@�r 


--- ����W 
SELECT * FROM ���u WHERE �m�W='�B�Ѥ�';
--- ��m����
SELECT * FROM ���u WHERE �m�W LIKE '��%';
--- ��m�i�B���B��
SELECT * FROM ���u WHERE �m�W LIKE '��%' OR �m�W LIKE '�i%' OR �m�W LIKE '�L%';
SELECT * FROM ���u WHERE �m�W LIKE '[���L�i]%';

--- SQL Server �S��
SELECT * FROM �Ȥ� WHERE �Ȥ�s�� LIKE 'A%' OR �Ȥ�s�� LIKE 'D%' OR �Ȥ�s�� LIKE 'F%';  -- NORMAL
SELECT * FROM �Ȥ� WHERE �Ȥ�s�� LIKE '[ADF]%';										  -- �}�YADF
SELECT * FROM �Ȥ� WHERE �Ȥ�s�� LIKE '[ADF][O-Z]%';									  -- �}�YADF �᭱O��Z


--- �䲣�~�t��
SELECT * FROM ���~��� WHERE ���~ LIKE '%��%';