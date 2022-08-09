CREATE DATABASE [NewDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( 
	NAME = N'NewDB', 
	FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\NewDB.mdf' , 
	SIZE = 8192KB , 
	FILEGROWTH = 65536KB 
)
 LOG ON 
( 
	NAME = N'NewDB_log', 
	FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\NewDB_log.ldf' , 
	SIZE = 8192KB , 
	FILEGROWTH = 65536KB 
)
GO
ALTER DATABASE [NewDB] SET COMPATIBILITY_LEVEL = 150
GO
ALTER DATABASE [NewDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [NewDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [NewDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [NewDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [NewDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [NewDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [NewDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [NewDB] SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF)
GO
ALTER DATABASE [NewDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [NewDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [NewDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [NewDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [NewDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [NewDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [NewDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [NewDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [NewDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [NewDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [NewDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [NewDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [NewDB] SET  READ_WRITE 
GO
ALTER DATABASE [NewDB] SET RECOVERY FULL 
GO
ALTER DATABASE [NewDB] SET  MULTI_USER 
GO
ALTER DATABASE [NewDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [NewDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [NewDB] SET DELAYED_DURABILITY = DISABLED 
GO
USE [NewDB]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = Off;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = Primary;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = On;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = Primary;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = Off;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = Primary;
GO
USE [NewDB]
GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'PRIMARY') ALTER DATABASE [NewDB] MODIFY FILEGROUP [PRIMARY] DEFAULT
GO
