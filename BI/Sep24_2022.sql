
TRUNCATE TABLE [�_�����~2];

CREATE TABLE [dbo].[�_�����~2](
	[���~�s��] [int] NULL,
	[���~�W��] [nvarchar](20) NULL,
	[�����ӽs��] [int] NULL,
	[���O�s��] [int] NULL,
	[���ƶq] [nvarchar](500) NULL,
	[���] [money] NULL,
	[�w�s�q] [int] NULL
) ON [PRIMARY]
GO

SELECT * FROM [�_�����~2] order by ���~�s��
DROP TABLE [�_�����~2]

------------------------------------------------------

SELECT �Ȥ�s��, ���q�W��, �s���H, �s���H¾��, �q��, 'kenny0963676060@gmail.com' AS �q�l�l��
INTO �m��.dbo.EDM
FROM ����_��.dbo.�Ȥ�
WHERE �a�} LIKE '���%'


--�H�󩳽Z
/*
@[User::CID] +"  "+ @[User::CCompanyName] +"\n"+
"�˷R�� "+ @[User::CPerson] +" "+ @[User::CPersonJob]  +" �z�n�G\n"+
"�����q���Ӥj���I\n"+
"�Ч֨ӷm�ʡI\n\n\n���K���q �q�W"
*/



CREATE TABLE �����ѦҪ�
(
    ���� NVARCHAR(10),
	�ؼЫ��� NVARCHAR(10)
)
GO

INSERT INTO �����ѦҪ� VALUES('�x�_��','�x�_��')
INSERT INTO �����ѦҪ� VALUES('�x�_','�x�_��')
INSERT INTO �����ѦҪ� VALUES('�_��','�x�_��')
INSERT INTO �����ѦҪ� VALUES('�x�_��','�x�_��')
INSERT INTO �����ѦҪ� VALUES('�_��','�x�_��')
INSERT INTO �����ѦҪ� VALUES('��鿤','��鿤')
INSERT INTO �����ѦҪ� VALUES('�翤','��鿤')
INSERT INTO �����ѦҪ� VALUES('��饫','��饫')
INSERT INTO �����ѦҪ� VALUES('�祫','��饫')
INSERT INTO �����ѦҪ� VALUES('�s�˿�','�s�˿�')
INSERT INTO �����ѦҪ� VALUES('�˿�','�s�˿�')
INSERT INTO �����ѦҪ� VALUES('�s�˥�','�s�˥�')
INSERT INTO �����ѦҪ� VALUES('�]�ߥ�','�]�ߥ�')
INSERT INTO �����ѦҪ� VALUES('�]��','�]�߿�')
INSERT INTO �����ѦҪ� VALUES('�]�߿�','�]�߿�')
INSERT INTO �����ѦҪ� VALUES('�˥�','�s�˥�')
INSERT INTO �����ѦҪ� VALUES('�x��','�x����')
INSERT INTO �����ѦҪ� VALUES('�x����','�x����')
INSERT INTO �����ѦҪ� VALUES('����','�x����')
INSERT INTO �����ѦҪ� VALUES('�x����','�x����')
INSERT INTO �����ѦҪ� VALUES('����','�x����')
INSERT INTO �����ѦҪ� VALUES('�n�륫','�n�륫')
INSERT INTO �����ѦҪ� VALUES('�n�뿤','�n�뿤')
INSERT INTO �����ѦҪ� VALUES('�n��','�n�뿤')
INSERT INTO �����ѦҪ� VALUES('���ƿ�','���ƿ�')
INSERT INTO �����ѦҪ� VALUES('����','���ƿ�')
INSERT INTO �����ѦҪ� VALUES('���ƥ�','���ƥ�')
INSERT INTO �����ѦҪ� VALUES('����','���ƥ�')
INSERT INTO �����ѦҪ� VALUES('���L��','���L��')
INSERT INTO �����ѦҪ� VALUES('���L','���L��')
INSERT INTO �����ѦҪ� VALUES('�Ÿq��','�Ÿq��')
INSERT INTO �����ѦҪ� VALUES('�ſ�','�ſ�')
INSERT INTO �����ѦҪ� VALUES('�Ÿq��','�Ÿq��')
INSERT INTO �����ѦҪ� VALUES('�ť�','�Ÿq��')
INSERT INTO �����ѦҪ� VALUES('�x�n��','�x�n��')
INSERT INTO �����ѦҪ� VALUES('�n��','�x�n��')
INSERT INTO �����ѦҪ� VALUES('�x�n��','�x�n��')
INSERT INTO �����ѦҪ� VALUES('�n��','�x�n��')
INSERT INTO �����ѦҪ� VALUES('������','������')
INSERT INTO �����ѦҪ� VALUES('������','������')
INSERT INTO �����ѦҪ� VALUES('����','������')
INSERT INTO �����ѦҪ� VALUES('����','������')
INSERT INTO �����ѦҪ� VALUES('����','������')
INSERT INTO �����ѦҪ� VALUES('�Ὤ','�Ὤ��')
INSERT INTO �����ѦҪ� VALUES('�Ὤ��','�Ὤ��')
INSERT INTO �����ѦҪ� VALUES('�ῤ','�Ὤ��')
INSERT INTO �����ѦҪ� VALUES('�Ὤ��','�Ὤ��')
INSERT INTO �����ѦҪ� VALUES('�ᥫ','�Ὤ��')
INSERT INTO �����ѦҪ� VALUES('�y����','�y����')
INSERT INTO �����ѦҪ� VALUES('�y����','�y����')
INSERT INTO �����ѦҪ� VALUES('�y��','�y����')
INSERT INTO �����ѦҪ� VALUES('�y��','�y����')
INSERT INTO �����ѦҪ� VALUES('�y��','�y����')
INSERT INTO �����ѦҪ� VALUES('�̪F��','�̪F��')
INSERT INTO �����ѦҪ� VALUES('�̪F��','�̪F��')
INSERT INTO �����ѦҪ� VALUES('�̪F','�̪F��')
INSERT INTO �����ѦҪ� VALUES('�̿�','�̪F��')
INSERT INTO �����ѦҪ� VALUES('�̥�','�̪F��')

TRUNCATE TABLE �����ѦҪ�
SELECT * FROM �����ѦҪ�


CREATE TABLE �פJ�Ȥ�
(
	�Ȥ�s�� nvarchar(5) NULL,
	���q�W�� nvarchar(40) NOT NULL,
	�s���H [nvarchar](30) NULL,
	�s���H¾�� [nvarchar](30) NULL,
	�a�} [nvarchar](60) NULL,	
	���� [nvarchar](15) NULL,		
	�ؼЫ��� [nvarchar](15) NULL,		
	�ۦ��� [nvarchar](15) NULL,		
	�l���ϸ� [nvarchar](10) NULL,	
	�q�� [nvarchar](24) NULL,
	�ǯu�q�� [nvarchar](24) NULL
)


DROP TABLE �פJ�Ȥ�
SELECT * FROM �פJ�Ȥ�


----------------------------------------------------

CREATE TABLE �פJ�^��Ȥ�
(
    �Ȥ�s�� INT,
    �m�W NCHAR(50),
    �~���� NVARCHAR(50),
    ��l���� NVARCHAR(50),
    �ۦ��� NVARCHAR(50)
)
GO

CREATE TABLE �^�嫰���ѦҪ�
(
    ���� NVARCHAR(50),
    �ؼЫ��� NVARCHAR(50)
)
GO


INSERT INTO �^�嫰���ѦҪ� VALUES('New York','New York')
INSERT INTO �^�嫰���ѦҪ� VALUES('Los Angeles','Los Angeles')
INSERT INTO �^�嫰���ѦҪ� VALUES('New Orleans','New Orleans')
INSERT INTO �^�嫰���ѦҪ� VALUES('Chicago','Chicago')
INSERT INTO �^�嫰���ѦҪ� VALUES('New Jersey','New Jersey')
INSERT INTO �^�嫰���ѦҪ� VALUES('Seattle','Seattle')

INSERT INTO �^�嫰���ѦҪ� VALUES('NY','New York')
INSERT INTO �^�嫰���ѦҪ� VALUES('LA','Los Angeles')
INSERT INTO �^�嫰���ѦҪ� VALUES('CHI','Chicago')
GO

DROP TABLE �פJ�^��Ȥ�
SELECT * FROM �פJ�^��Ȥ�

SELECT ���u�s��, �m�W, �٩I, ¾��, ���Τ��, �~��
FROM ���u
