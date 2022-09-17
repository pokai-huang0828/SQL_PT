/*
1. 複製 資料庫檔案，附加資料庫
2. 自行安裝 SSMS
3. 安裝 SQL Server CU(Cumulative Update)17  (選擇性安裝)
https://www.microsoft.com/en-us/download/details.aspx?id=100809

4. 
VS2019下載
https://docs.microsoft.com/en-us/visualstudio/releases/2019/release-notes

SSAS VS2019
https://marketplace.visualstudio.com/items?itemName=ProBITools.MicrosoftAnalysisServicesModelingProjects

SSIS VS2019
https://marketplace.visualstudio.com/items?itemName=SSIS.SqlServerIntegrationServicesProjects

SSRS VS2019
https://marketplace.visualstudio.com/items?itemName=ProBITools.MicrosoftReportProjectsforVisualStudio

*/

--- 匯入 / 匯出
EXEC sp_attach_db  
'AdventureWorksDW2012','C:\Bi\files\AdventureWorksDW2012_Data.mdf','C:\Bi\files\AdventureWorksDW2012_log.ldf';  

EXEC sp_attach_db  
'中文北風','C:\Bi\files\中文北風.mdf','C:\Bi\files\中文北風_log.ldf';  

/*	手動匯出 - 利用SSIS 封裝檔案
dtexec /F C:\AA\封封.dtsx \--密碼
*/
CREATE DATABASE 練習
ON PRIMARY
( NAME='練習資料',FILENAME='C:\SQLData\練資.mdf')
LOG ON
( NAME='練習記錄',FILENAME='C:\SQLData\練記.ldf')
GO


SELECT * FROM 練習.dbo.客戶;

