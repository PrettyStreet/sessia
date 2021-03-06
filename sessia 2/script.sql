USE [master]
GO
/****** Object:  Database [phoneSystem]    Script Date: 29.12.2021 11:08:59 ******/
CREATE DATABASE [phoneSystem]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'phoneSystem', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLSERVER\MSSQL\DATA\phoneSystem.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'phoneSystem_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLSERVER\MSSQL\DATA\phoneSystem_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [phoneSystem] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [phoneSystem].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [phoneSystem] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [phoneSystem] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [phoneSystem] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [phoneSystem] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [phoneSystem] SET ARITHABORT OFF 
GO
ALTER DATABASE [phoneSystem] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [phoneSystem] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [phoneSystem] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [phoneSystem] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [phoneSystem] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [phoneSystem] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [phoneSystem] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [phoneSystem] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [phoneSystem] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [phoneSystem] SET  DISABLE_BROKER 
GO
ALTER DATABASE [phoneSystem] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [phoneSystem] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [phoneSystem] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [phoneSystem] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [phoneSystem] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [phoneSystem] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [phoneSystem] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [phoneSystem] SET RECOVERY FULL 
GO
ALTER DATABASE [phoneSystem] SET  MULTI_USER 
GO
ALTER DATABASE [phoneSystem] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [phoneSystem] SET DB_CHAINING OFF 
GO
ALTER DATABASE [phoneSystem] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [phoneSystem] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [phoneSystem] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'phoneSystem', N'ON'
GO
ALTER DATABASE [phoneSystem] SET QUERY_STORE = OFF
GO
USE [phoneSystem]
GO
/****** Object:  Table [dbo].[Абоненты]    Script Date: 29.12.2021 11:09:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Абоненты](
	[id_абонента] [int] NOT NULL,
	[Фамилия] [varchar](50) NULL,
	[Имя] [varchar](50) NULL,
	[Отчество] [varchar](50) NULL,
	[Адрес] [varchar](50) NULL,
 CONSTRAINT [PK_Абоненты] PRIMARY KEY CLUSTERED 
(
	[id_абонента] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Телефоны]    Script Date: 29.12.2021 11:09:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Телефоны](
	[id_телефона] [int] NOT NULL,
	[Номер_договора] [varchar](50) NULL,
	[Дата_установки] [varchar](50) NULL,
	[Номер_телефона] [varchar](50) NULL,
	[id_абонента] [int] NULL,
 CONSTRAINT [PK_Телефон] PRIMARY KEY CLUSTERED 
(
	[id_телефона] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Разговоры]    Script Date: 29.12.2021 11:09:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Разговоры](
	[id_разговора] [int] NOT NULL,
	[Дата_разговора] [varchar](50) NULL,
	[Продолжительность] [int] NULL,
	[Оплачен] [bit] NULL,
	[id_тарифа] [int] NULL,
	[id_телефона] [int] NULL,
 CONSTRAINT [PK_Разговоры] PRIMARY KEY CLUSTERED 
(
	[id_разговора] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Статистика_Разговоров]    Script Date: 29.12.2021 11:09:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Статистика_Разговоров]
AS
SELECT  Телефоны.Номер_телефона,
		Абоненты.Фамилия + ' ' + Абоненты.Имя + ' ' + Абоненты.Отчество as 'ФИО',
		count(*) as 'Кол_во разговоров'
FROM Разговоры
INNER JOIN Телефоны
ON Телефоны.id_телефона = Разговоры.id_телефона
INNER JOIN Абоненты
ON Абоненты.id_абонента = Телефоны.id_абонента
GROUP BY Абоненты.Фамилия, Абоненты.Имя, Абоненты.Отчество, Телефоны.Номер_телефона
GO
/****** Object:  Table [dbo].[Тарифы]    Script Date: 29.12.2021 11:09:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Тарифы](
	[id_Тариф] [int] NOT NULL,
	[Название_города] [varchar](50) NULL,
	[Цена] [decimal](18, 0) NULL,
 CONSTRAINT [PK_Тарифы] PRIMARY KEY CLUSTERED 
(
	[id_Тариф] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Разговоры]  WITH CHECK ADD  CONSTRAINT [FK_Разговоры_Тарифы] FOREIGN KEY([id_тарифа])
REFERENCES [dbo].[Тарифы] ([id_Тариф])
GO
ALTER TABLE [dbo].[Разговоры] CHECK CONSTRAINT [FK_Разговоры_Тарифы]
GO
ALTER TABLE [dbo].[Разговоры]  WITH CHECK ADD  CONSTRAINT [FK_Разговоры_Телефоны] FOREIGN KEY([id_телефона])
REFERENCES [dbo].[Телефоны] ([id_телефона])
GO
ALTER TABLE [dbo].[Разговоры] CHECK CONSTRAINT [FK_Разговоры_Телефоны]
GO
ALTER TABLE [dbo].[Телефоны]  WITH CHECK ADD  CONSTRAINT [FK_Телефон_Абоненты] FOREIGN KEY([id_абонента])
REFERENCES [dbo].[Абоненты] ([id_абонента])
GO
ALTER TABLE [dbo].[Телефоны] CHECK CONSTRAINT [FK_Телефон_Абоненты]
GO
/****** Object:  StoredProcedure [dbo].[addAbonent]    Script Date: 29.12.2021 11:09:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[addAbonent]
	@id_abonent int,
	@name varchar(50),
	@surename varchar(50),
	@fathername varchar(50),
	@address varchar(50)
AS
INSERT INTO Абоненты (id_абонента, Имя, Фамилия, Отчество, Адрес) VALUES (@id_abonent, @name, @surename, @fathername, @address);

exec addAbonent @id_abonent = 12, @name = 'Сергей', @surename = 'Аверин', @fathername = 'Викторович', @address = 'г. Омск, ул. Ленина, 5,24';
GO
/****** Object:  StoredProcedure [dbo].[addAbonent3]    Script Date: 29.12.2021 11:09:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[addAbonent3]
	@id_abonent int,
	@name varchar(50),
	@surename varchar(50),
	@fathername varchar(50),
	@address varchar(50)
AS
INSERT INTO Абоненты (id_абонента, Имя, Фамилия, Отчество, Адрес) VALUES (@id_abonent, @name, @surename, @fathername, @address);
GO
/****** Object:  StoredProcedure [dbo].[deleteAbonent]    Script Date: 29.12.2021 11:09:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[deleteAbonent]
	@id_abonent int
as
DELETE FROM Абоненты where id_абонента = @id_abonent;

exec deleteAbonent @id_abonent = 12;
GO
USE [master]
GO
ALTER DATABASE [phoneSystem] SET  READ_WRITE 
GO
