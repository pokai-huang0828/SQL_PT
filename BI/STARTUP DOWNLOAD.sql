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


SELECT * FROM �m��.dbo.�Ȥ�;

