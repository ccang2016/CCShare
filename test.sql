USE [master]
GO
/****** Object:  Database [CCTestDB]    Script Date: 11/08/2017 23:54:45 ******/
CREATE DATABASE [CCTestDB] ON  PRIMARY 
( NAME = N'CCTestDB', FILENAME = N'I:\Program Files (x86)\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\CCTestDB.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'CCTestDB_log', FILENAME = N'I:\Program Files (x86)\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\CCTestDB_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [CCTestDB] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CCTestDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CCTestDB] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [CCTestDB] SET ANSI_NULLS OFF
GO
ALTER DATABASE [CCTestDB] SET ANSI_PADDING OFF
GO
ALTER DATABASE [CCTestDB] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [CCTestDB] SET ARITHABORT OFF
GO
ALTER DATABASE [CCTestDB] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [CCTestDB] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [CCTestDB] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [CCTestDB] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [CCTestDB] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [CCTestDB] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [CCTestDB] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [CCTestDB] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [CCTestDB] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [CCTestDB] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [CCTestDB] SET  DISABLE_BROKER
GO
ALTER DATABASE [CCTestDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [CCTestDB] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [CCTestDB] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [CCTestDB] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [CCTestDB] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [CCTestDB] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [CCTestDB] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [CCTestDB] SET  READ_WRITE
GO
ALTER DATABASE [CCTestDB] SET RECOVERY SIMPLE
GO
ALTER DATABASE [CCTestDB] SET  MULTI_USER
GO
ALTER DATABASE [CCTestDB] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [CCTestDB] SET DB_CHAINING OFF
GO
EXEC sys.sp_db_vardecimal_storage_format N'CCTestDB', N'ON'
GO
USE [CCTestDB]
GO
/****** Object:  Table [dbo].[Course]    Script Date: 11/08/2017 23:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Course](
	[C#] [varchar](10) NULL,
	[Cname] [nvarchar](10) NULL,
	[T#] [varchar](10) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Teacher]    Script Date: 11/08/2017 23:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Teacher](
	[T#] [varchar](10) NULL,
	[Tname] [nvarchar](10) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Table_B]    Script Date: 11/08/2017 23:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Table_B](
	[PK] [int] NOT NULL,
	[Value] [varchar](10) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Table_A]    Script Date: 11/08/2017 23:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Table_A](
	[PK] [int] NOT NULL,
	[Value] [varchar](10) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Student]    Script Date: 11/08/2017 23:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Student](
	[S#] [varchar](10) NOT NULL,
	[Sname] [varchar](50) NULL,
	[SBirthday] [datetime] NULL,
	[Ssex] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[S#] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[stop_route]    Script Date: 11/08/2017 23:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[stop_route](
	[Stop] [varchar](20) NULL,
	[Route] [varchar](20) NULL,
	[Position] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SC]    Script Date: 11/08/2017 23:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SC](
	[S#] [varchar](10) NULL,
	[C#] [varchar](10) NULL,
	[score] [decimal](18, 1) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[RouteT0]    Script Date: 11/08/2017 23:54:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[RouteT0]
as
    select
        sr1.Stop as StartStop,    --启始站点
        sr2.Stop as EndStop,    --目的站点
        sr1.Route as Route,    --乘坐线路
        sr2.Position-sr1.Position as StopCount    --经过的站点数
    from
        stop_route sr1,
        stop_route sr2
    where
        sr1.Route=sr2.Route
        and sr1.Position<sr2.Position
GO
/****** Object:  StoredProcedure [dbo].[InquiryT2]    Script Date: 11/08/2017 23:54:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[InquiryT2](@StartStop varchar(32),@EndStop varchar(32))
as
begin
    select
        r1.StartStop as 启始站点,
        r1.Route as 乘坐路线1,
        r1.EndStop as 中转站点1,
        r2.Route as 乘坐路线2,
        r2.EndStop as 中转站点2,
        r3.Route as 乘坐路线3,
        r3.EndStop as 目的站点,
        r1.StopCount+r2.StopCount+r3.StopCount as 总站点数
    from
        RouteT0 r1,
        RouteT0 r2,
        RouteT0 r3
    where
        r1.StartStop=@StartStop
        and r1.EndStop=r2.StartStop
        and r2.EndStop=r3.StartStop
        and r3.EndStop=@EndStop
end
GO
/****** Object:  StoredProcedure [dbo].[InquiryT1]    Script Date: 11/08/2017 23:54:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[InquiryT1](@StartStop varchar(32),@EndStop varchar(32))
as
begin
    select
        r1.StartStop as 启始站点,
        r1.Route as 乘坐路线1,
        r1.EndStop as 中转站点,
        r2.Route as 乘坐路线2,
        r2.EndStop as 目的站点,
        r1.StopCount+r2.StopCount as 总站点数
    from
        RouteT0 r1,
        RouteT0 r2
    where
        r1.StartStop=@StartStop
        and r1.EndStop=r2.StartStop
        and r2.EndStop=@EndStop
end
GO
