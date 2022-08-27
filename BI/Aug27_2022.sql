/*
1. �ƻs ��Ʈw�ɮסA���[��Ʈw
2. �ۦ�w�� SSMS
3. �w�� SQL Server CU(Cumulative Update)17  (��ܩʦw��)
https://www.microsoft.com/en-us/download/details.aspx?id=100809

4. 
VS2019�U��
https://docs.microsoft.com/en-us/visualstudio/releases/2019/release-notes

SSAS VS2019
https://marketplace.visualstudio.com/items?itemName=ProBITools.MicrosoftAnalysisServicesModelingProjects

SSIS VS2019
https://marketplace.visualstudio.com/items?itemName=SSIS.SqlServerIntegrationServicesProjects

SSRS VS2019
https://marketplace.visualstudio.com/items?itemName=ProBITools.MicrosoftReportProjectsforVisualStudio

*/

--- �פJ / �ץX
EXEC sp_attach_db  
'AdventureWorksDW2012','C:\Bi\files\AdventureWorksDW2012_Data.mdf','C:\Bi\files\AdventureWorksDW2012_log.ldf';  

EXEC sp_attach_db  
'����_��','C:\Bi\files\����_��.mdf','C:\Bi\files\����_��_log.ldf';  

/*	��ʶץX - �Q��SSIS �ʸ��ɮ�
dtexec /F C:\AA\�ʫ�.dtsx \--�K�X
*/
CREATE DATABASE �m��
ON PRIMARY
( NAME='�m�߸��',FILENAME='C:\SQLData\�m��.mdf')
LOG ON
( NAME='�m�߰O��',FILENAME='C:\SQLData\�m�O.ldf')
GO

/*
 �Q�ζפJ�ץX���F,�|�۰ʫت�
 �N ����_�� �Ȥ�M�q��D�ɶץX�� excel�� [�F��.excle]
 �פJ��SQL  �ت��a��excle
 �N ����_�� �Ȥ�M�q��D�� [�F��.excle] �פJ �m�� ��Ʈw��
 �פJ�� excel �ت��a��SQL
 �q����_���ץX ��r�� [�F���q��.txt]
 �A�N��r�� [�F���q��.txt] �פJ�� �m�� ��Ʈw��
 �p�n�A���פJ�ۦP�ɮסA�s����� �ﶵ��
 �i�H��ܧR����ƾ㵧�פJ �� ���[
 �]�w�ʸ˱Ƶ{
 �NSSMS�κ޲z����������A�s�u�� IS
 �s�W��Ƨ��A �פJ�n���檺�ʸ��ɮסA�קK�ɮײ��ʡA�y���Ƶ{����
 ���ۦbSQL Server Arent�����@�~ �s�W�@�~ �֦��� [sa]
 �s�W�W�١B�B�J�B���services�ʸ� �פJ�ʸ��ɮ� ���A�����localhost  

 ---

 �ϥΤu�@ -> �פJ�@���ɮ� pick test.csv �פJ�ܽm�� Database
 Ū�����ɮ׷|�۰�Ū���� "" �������æ۰ʹL�o�H��K�b���ɹL�{���קK�L�kŪ��

 ---
 �פJ / �ץX �U�bTerminal

 bcp /?

 bcp ����_��.dbo.�Ȥ� out C:\AA\�_���Ȥ�.txt -T -w -t,
 * �ץX���|�t����W

 -T Window ����
 -U �b�� -P �K�X SQL�{��
 -t �����j�Ÿ�
 -w unicode
 -b �妸�j�p
*/


SELECT * INTO �m��.dbo.�_���Ȥ� FROM ����_��.dbo.�Ȥ� WHERE 1=0;
-- In terminal, type: bcp �m��.dbo.�_���Ȥ� in C:\AA\�_���Ȥ�.txt -T -w -t,
SELECT * FROM �m��.dbo.�_���Ȥ�;

--bcp "SELECT �Ȥ�s��,���q�W��,�s���H,�s���H¾��,�q��,�ǯu�q��,�a�} FROM ����_��.dbo.�Ȥ� WHERE �a�} LIKE '�x�_%'" queryout C:\AA\�_���x�_�Ȥ�.csv -T -t, -w
SELECT �Ȥ�s��, ���q�W��, �s���H, �s���H¾��, �q��, �ǯu�q��, �a�} FROM ����_��.dbo.�Ȥ� WHERE �a�} LIKE '�x�_%';

----------------------------------------------------------

USE [AdventureWorksDW2012];
SELECT COUNT(*) FROM [AdventureWorksDW2012].[dbo].FactInternetSales;
--- bcp [AdventureWorksDW2012].[dbo].[FactInternetSales] out C:\SQLData\SQL_PT\BI\AW_Data.txt -T -t, -w

-----------------------------------------

RESTORE HEADERONLY FROM DISK='C:\SQLData\ContosoRetailDW.bak'
RESTORE FILELISTONLY FROM DISK='C:\SQLData\ContosoRetailDW.bak'

RESTORE DATABASE ContosoRetailDW FROM DISK='C:\SQLData\ContosoRetailDW.bak'
WITH MOVE 'ContosoRetailDW2.0' TO 'C:\SQLData\ContosoRetailDW_Data.mdf'
	,MOVE 'ContosoRetailDW2.0_log' TO 'C:\SQLData\ContosoRetailDW_Log.ldf',RECOVERY;

EXEC sp_helpdb

SELECT COUNT(*) FROM [ContosoRetailDW].[dbo].[FactSales]
SELECT TOP(1000) * FROM [ContosoRetailDW].[dbo].[FactSales]

--bcp [ContosoRetailDW].[dbo].[FactSales] out C:\AA\Contoso_Sales.txt -T -t, -w

SELECT * INTO �m��.dbo.Contoso�P���� FROM [ContosoRetailDW].[dbo].[FactSales] WHERE 1=0;
--bcp �m��.dbo.Contoso�P���� in c:\AA\Contoso_Sales.txt -T -t, -w -b10000

SELECT TOP(1000) * FROM �m��.dbo.Contoso�P����
TRUNCATE TABLE �m��.dbo.Contoso�P����


--- SQL Server �ϥΦۤv���y���ǻ���� *�t�ץ[��!

--bcp [ContosoRetailDW].[dbo].[FactSales] out C:\AA\Contoso_Sales.nn -T -n
--bcp �m��.dbo.Contoso�P���� in c:\AA\Contoso_Sales.nn -T -n -b50000


BULK INSERT �m��.dbo.Contoso�P���� FROM 'C:\AA\Contoso_Sales.nn'
WITH (DATAFILETYPE = 'native', BATCHSIZE = 10000)


BULK INSERT �m��.[dbo].[�_���Ȥ�] FROM 'C:\AA\�_���Ȥ�.txt'
WITH (DATAFILETYPE = 'widechar', FIELDTERMINATOR = ',');

TRUNCATE TABLE �m��.dbo.�_���Ȥ�
SELECT * FROM �m��.dbo.�_���Ȥ�;

---------------------

USE �m��;

CREATE TABLE �m�߭��u
(
	���u�s�� INT,
	�m�W NVARCHAR(10),
	�ͤ� DATE,
	�~�� INT
)
GO


--- BULK INSERT ���ɭԮĲv�����A�ä��]���O�� SQL Server �˦ۥhŪ�ҥH�i�H�ֳt����
-- bcp �m��.dbo.�m�߭��u in C:\AA\TestData.txt -T -t, -w

BULK INSERT �m��.[dbo].�m�߭��u FROM 'C:\AA\TestData.txt'
WITH (DATAFILETYPE = 'widechar', FIELDTERMINATOR = ',');

SELECT * FROM �m��.dbo.�m�߭��u;


--bcp "SELECT �Ȥ�s��,���q�W��,�s���H,�s���H¾��,�q��,�ǯu�q��,�a�} FROM ����_��.dbo.�Ȥ�" queryout C:\AA\�_���Ȥ��.csv -T -t, -w
SELECT �Ȥ�s��, ���q�W��, �s���H, �s���H¾��, �q��, �ǯu�q��, �a�} INTO �_���Ȥ�� FROM ����_��.dbo.�Ȥ� WHERE 1=0;

TRUNCATE TABLE [dbo].[�_���Ȥ�]
TRUNCATE TABLE [dbo].[�_���Ȥ��]
SELECT * FROM [dbo].[�_���Ȥ�]
SELECT * FROM [dbo].[�_���Ȥ��]

--- �h��ܤ���
--- bcp [�m��].[dbo].[�_���Ȥ��] format nul -T -w -t, -f C:\AA\�_����.fmt
--- �榡��: �y�z���q��ť

--- bcp [�m��].[dbo].[�_���Ȥ��] in C:\AA\�_���Ȥ�.txt -T -f C:\AA\�_����.fmt

BULK INSERT �m��.[dbo].[�_���Ȥ��] FROM 'C:\AA\�_���Ȥ�.txt'
WITH (FORMATFILE='C:\AA\�_����.fmt');