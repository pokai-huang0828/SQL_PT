
USE ����_��

DECLARE @aa NVARCHAR(10);
SET @aa = '���K�q��';
PRINT @aa;

DECLARE @bb INT;
SET @bb=100;
SET @bb=@bb+200;
PRINT @bb;

DECLARE @cc INT=100;
SET @cc+=200;
SELECT @cc;
