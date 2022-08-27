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

/*
 利用匯入匯出精靈,會自動建表
 將 中文北風 客戶和訂單主檔匯出成 excel檔 [東風.excle]
 匯入選SQL  目的地選excle
 將 中文北風 客戶和訂單主檔 [東風.excle] 匯入 練習 資料庫中
 匯入選 excel 目的地選SQL
 從中文北風匯出 文字檔 [東風訂單.txt]
 再將文字檔 [東風訂單.txt] 匯入至 練習 資料庫中
 如要再次匯入相同檔案，編輯對應 選項中
 可以選擇刪除資料整筆匯入 或 附加
 設定封裝排程
 將SSMS用管理員身分執行，連線至 IS
 新增資料夾， 匯入要執行的封裝檔案，避免檔案移動，造成排程失效
 接著在SQL Server Arent中的作業 新增作業 擁有者 [sa]
 新增名稱、步驟、選取services封裝 匯入封裝檔案 伺服器選擇localhost  

 ---

 使用工作 -> 匯入一般檔案 pick test.csv 匯入至練習 Database
 讀取的檔案會自動讀取有 "" 的部分並自動過濾以方便在轉檔過程中避免無法讀取

 ---
 匯入 / 匯出 下在Terminal

 bcp /?

 bcp 中文北風.dbo.客戶 out C:\AA\北風客戶.txt -T -w -t,
 * 匯出不會含有欄名

 -T Window 驗證
 -U 帳號 -P 密碼 SQL認證
 -t 欄位分隔符號
 -w unicode
 -b 批次大小
*/


SELECT * INTO 練習.dbo.北風客戶 FROM 中文北風.dbo.客戶 WHERE 1=0;
-- In terminal, type: bcp 練習.dbo.北風客戶 in C:\AA\北風客戶.txt -T -w -t,
SELECT * FROM 練習.dbo.北風客戶;

--bcp "SELECT 客戶編號,公司名稱,連絡人,連絡人職稱,電話,傳真電話,地址 FROM 中文北風.dbo.客戶 WHERE 地址 LIKE '台北%'" queryout C:\AA\北風台北客戶.csv -T -t, -w
SELECT 客戶編號, 公司名稱, 連絡人, 連絡人職稱, 電話, 傳真電話, 地址 FROM 中文北風.dbo.客戶 WHERE 地址 LIKE '台北%';

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

SELECT * INTO 練習.dbo.Contoso銷售資料 FROM [ContosoRetailDW].[dbo].[FactSales] WHERE 1=0;
--bcp 練習.dbo.Contoso銷售資料 in c:\AA\Contoso_Sales.txt -T -t, -w -b10000

SELECT TOP(1000) * FROM 練習.dbo.Contoso銷售資料
TRUNCATE TABLE 練習.dbo.Contoso銷售資料


--- SQL Server 使用自己的語言傳遞資料 *速度加快!

--bcp [ContosoRetailDW].[dbo].[FactSales] out C:\AA\Contoso_Sales.nn -T -n
--bcp 練習.dbo.Contoso銷售資料 in c:\AA\Contoso_Sales.nn -T -n -b50000


BULK INSERT 練習.dbo.Contoso銷售資料 FROM 'C:\AA\Contoso_Sales.nn'
WITH (DATAFILETYPE = 'native', BATCHSIZE = 10000)


BULK INSERT 練習.[dbo].[北風客戶] FROM 'C:\AA\北風客戶.txt'
WITH (DATAFILETYPE = 'widechar', FIELDTERMINATOR = ',');

TRUNCATE TABLE 練習.dbo.北風客戶
SELECT * FROM 練習.dbo.北風客戶;

---------------------

USE 練習;

CREATE TABLE 練習員工
(
	員工編號 INT,
	姓名 NVARCHAR(10),
	生日 DATE,
	薪資 INT
)
GO


--- BULK INSERT 有時候效率較高，並切因為是由 SQL Server 親自去讀所以可以快速分辨
-- bcp 練習.dbo.練習員工 in C:\AA\TestData.txt -T -t, -w

BULK INSERT 練習.[dbo].練習員工 FROM 'C:\AA\TestData.txt'
WITH (DATAFILETYPE = 'widechar', FIELDTERMINATOR = ',');

SELECT * FROM 練習.dbo.練習員工;


--bcp "SELECT 客戶編號,公司名稱,連絡人,連絡人職稱,電話,傳真電話,地址 FROM 中文北風.dbo.客戶" queryout C:\AA\北風客戶少.csv -T -t, -w
SELECT 客戶編號, 公司名稱, 連絡人, 連絡人職稱, 電話, 傳真電話, 地址 INTO 北風客戶少 FROM 中文北風.dbo.客戶 WHERE 1=0;

TRUNCATE TABLE [dbo].[北風客戶]
TRUNCATE TABLE [dbo].[北風客戶少]
SELECT * FROM [dbo].[北風客戶]
SELECT * FROM [dbo].[北風客戶少]

--- 多欄至少欄
--- bcp [練習].[dbo].[北風客戶少] format nul -T -w -t, -f C:\AA\北風少.fmt
--- 格式檔: 描述給電腦聽

--- bcp [練習].[dbo].[北風客戶少] in C:\AA\北風客戶.txt -T -f C:\AA\北風少.fmt

BULK INSERT 練習.[dbo].[北風客戶少] FROM 'C:\AA\北風客戶.txt'
WITH (FORMATFILE='C:\AA\北風少.fmt');