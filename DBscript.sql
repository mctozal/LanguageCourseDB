USE [master]
GO
/****** Object:  Database [LanguageCourse]    Script Date: 26.11.2018 17:05:06 ******/
CREATE DATABASE [LanguageCourse]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'LanguageCourse', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\LanguageCourse.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'LanguageCourse_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\LanguageCourse_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [LanguageCourse] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [LanguageCourse].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [LanguageCourse] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [LanguageCourse] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [LanguageCourse] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [LanguageCourse] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [LanguageCourse] SET ARITHABORT OFF 
GO
ALTER DATABASE [LanguageCourse] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [LanguageCourse] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [LanguageCourse] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [LanguageCourse] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [LanguageCourse] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [LanguageCourse] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [LanguageCourse] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [LanguageCourse] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [LanguageCourse] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [LanguageCourse] SET  ENABLE_BROKER 
GO
ALTER DATABASE [LanguageCourse] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [LanguageCourse] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [LanguageCourse] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [LanguageCourse] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [LanguageCourse] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [LanguageCourse] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [LanguageCourse] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [LanguageCourse] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [LanguageCourse] SET  MULTI_USER 
GO
ALTER DATABASE [LanguageCourse] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [LanguageCourse] SET DB_CHAINING OFF 
GO
ALTER DATABASE [LanguageCourse] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [LanguageCourse] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [LanguageCourse] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [LanguageCourse] SET QUERY_STORE = OFF
GO
USE [LanguageCourse]
GO
/****** Object:  Schema [language]    Script Date: 26.11.2018 17:05:07 ******/
CREATE SCHEMA [language]
GO
/****** Object:  UserDefinedFunction [language].[Age]    Script Date: 26.11.2018 17:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE FUNCTION [language].[Age](@DOB Date)  
  RETURNS INT
  AS
    BEGIN  
		DECLARE @Age INT  
		SET @Age = DATEDIFF(YEAR, @DOB, GETDATE()) - CASE 
		WHEN (MONTH(@DOB) > MONTH(GETDATE())) OR 
		(MONTH(@DOB) = MONTH(GETDATE()) AND
		DAY(@DOB) > DAY(GETDATE())) THEN 1 ELSE 0 END  
		RETURN @Age  
END

--SELECT fname,lname, dbo.Age(data_birth) AS age FROM language.student--
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
GO
/****** Object:  UserDefinedFunction [language].[fullName]    Script Date: 26.11.2018 17:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE FUNCTION [language].[fullName](@fname VARCHAR(50), @lname VARCHAR(50))
  RETURNS VARCHAR(200)
  AS
    BEGIN 
       RETURN (SELECT  @fname + ' ' + @lname )
    END

	
--SELECT dbo.fullname(fname,lname) FROM language.student--
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
GO
/****** Object:  UserDefinedFunction [language].[genderabrv]    Script Date: 26.11.2018 17:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE FUNCTION [language].[genderabrv](@gender VARCHAR(6))
  RETURNS VARCHAR(200)
  AS
    BEGIN 	
		DECLARE @CharGnder Char(1),@Genderab Varchar(20);
		SET @Genderab = 
		CASE @gender
		WHEN 'm'  THEN 'Male'
		WHEN 'M'  THEN 'Male'
		WHEN 'F'  THEN 'Female'
		WHEN 'f'  THEN 'Female'
	END
       RETURN (SELECT @Genderab )
    END


--select dbo.Genderabrv(gender) FROM language.student--
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
GO
/****** Object:  Table [language].[student]    Script Date: 26.11.2018 17:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [language].[student](
	[id] [int] NOT NULL,
	[fname] [varchar](100) NOT NULL,
	[lname] [varchar](100) NOT NULL,
	[data_birth] [date] NULL,
	[city] [varchar](100) NULL,
	[gender] [varchar](1) NULL,
	[email] [varchar](100) NULL,
	[phone] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [language].[payment]    Script Date: 26.11.2018 17:05:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [language].[payment](
	[id] [int] NOT NULL,
	[payment_date] [date] NULL,
	[amount] [money] NULL,
	[status] [varchar](100) NOT NULL,
	[payment_method] [int] NULL,
	[student_id_payment] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Payment with Average Student]    Script Date: 26.11.2018 17:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

--1.PRINT ALL STUDENT WITH THE AVERAGE PAYMENT AND HOW MUCH THEY PAID.--

CREATE VIEW [dbo].[Payment with Average Student] AS
SELECT s.fname, p.amount AS Paid, (Select AVG(amount) FROM language.payment) AS AvgPaid
FROM language.student s, language.payment p
WHERE s.id = p.student_id_payment

--SELECT * FROM [Payment with Average Student]--
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
GO
/****** Object:  View [dbo].[Student with Age]    Script Date: 26.11.2018 17:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

--2.PRINT ALL STUDENT NAME AND THEIR AGES BY USING FUNCTION(Age)--

CREATE VIEW [dbo].[Student with Age] AS
SELECT s.fname,language.Age(s.data_birth) AS Age
FROM language.student s


--SELECT * FROM [Student with Age]--
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
GO
/****** Object:  Table [language].[payment_method]    Script Date: 26.11.2018 17:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [language].[payment_method](
	[id] [int] NOT NULL,
	[name] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Paid with Cash]    Script Date: 26.11.2018 17:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

--3.RETRIEVE ALL PAYMENT WITH ORDERLY: NAME,AMOUNT AND PAYMENT METHOD WHERE IT IS DONE BY CASH--

CREATE VIEW [dbo].[Paid with Cash] AS
SELECT s.fname AS name,m.name AS paidmethod ,p.amount
FROM language.payment p
JOIN language.student s ON s.id = p.student_id_payment
JOIN language.payment_method m ON m.id = p.payment_method
WHERE m.name = 'Cash'

--SELECT * FROM [Paid with Cash]--
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
GO
/****** Object:  Table [language].[teacher]    Script Date: 26.11.2018 17:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [language].[teacher](
	[id] [int] NOT NULL,
	[description] [varchar](200) NOT NULL,
	[fname] [varchar](100) NOT NULL,
	[lname] [varchar](100) NOT NULL,
	[email] [varchar](100) NOT NULL,
	[phone] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Teachers with Branch]    Script Date: 26.11.2018 17:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

--4.PRINT ALL TEACHER WITH FULLNAME USE FUNCTION(Fullname) AND THEIR BRANCHES--

CREATE VIEW [dbo].[Teachers with Branch] AS
SELECT language.fullName(fname,lname) AS Fullname, description AS Branch
FROM language.teacher

--SELECT * FROM [Teachers with Branch]--
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
GO
/****** Object:  Table [language].[language]    Script Date: 26.11.2018 17:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [language].[language](
	[id] [int] NOT NULL,
	[name] [nvarchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [language].[course]    Script Date: 26.11.2018 17:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [language].[course](
	[id] [int] NOT NULL,
	[lessons] [int] NOT NULL,
	[description] [varchar](100) NOT NULL,
	[term] [varchar](100) NOT NULL,
	[language_id] [int] NULL,
	[level_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Language course lesson]    Script Date: 26.11.2018 17:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

--5.RETRIEVE ALL LANGUAGES FOR EACH COURSE HOW LONG THEY LAST--

CREATE VIEW [dbo].[Language course lesson] AS
SELECT l.name AS Language , c.lessons
FROM language.language l, language.course c
WHERE  l.id = c.language_id

--SELECT * FROM [Language course lesson]--
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
GO
/****** Object:  Table [language].[level]    Script Date: 26.11.2018 17:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [language].[level](
	[id] [int] NOT NULL,
	[name] [nvarchar](30) NOT NULL,
	[code] [nvarchar](3) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [language].[teacher_acc]    Script Date: 26.11.2018 17:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [language].[teacher_acc](
	[id] [int] NOT NULL,
	[teacher_id] [int] NULL,
	[is_active] [bit] NOT NULL,
	[login] [varchar](100) NULL,
	[password] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [language].[class]    Script Date: 26.11.2018 17:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [language].[class](
	[id] [int] NOT NULL,
	[name] [varchar](30) NOT NULL,
	[start_date] [date] NOT NULL,
	[end_date] [date] NOT NULL,
	[teacher_class_id] [int] NULL,
	[course_class_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Languages with Level and Teacher]    Script Date: 26.11.2018 17:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

--6.SELECT ALL LANGUAGES WITH THEIR TEACHING LEVEL AND WHO TEACH THEM IF THE TEACHER IS ACTIVE 1--

CREATE VIEW [dbo].[Languages with Level and Teacher] AS
SELECT  t.fname AS TeacherName, c.description, l.code AS Level
FROM language.course c
JOIN language.level l ON c.level_id = l.id
JOIN language.class class ON class.course_class_id = c.id
JOIN language.teacher t ON t.id = class.teacher_class_id 
JOIN language.teacher_acc ta ON t.id = ta.teacher_id
WHERE ta.is_active = 1

--SELECT * FROM [Languages with Level and Teacher]--
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
GO
/****** Object:  View [dbo].[Class with description]    Script Date: 26.11.2018 17:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

--7.RETRIEVE ALL CLASS WITH NAME AND DESCRIPTION --

CREATE VIEW [dbo].[Class with description] AS
SELECT DISTINCT c.name, co.description
FROM language.class c
JOIN language.course co ON co.id = c.course_class_id

--SELECT * FROM [Number of students each class]--
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
GO
/****** Object:  Table [language].[class_student]    Script Date: 26.11.2018 17:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [language].[class_student](
	[id] [int] NOT NULL,
	[class_id] [int] NULL,
	[student_class_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Number of students each class]    Script Date: 26.11.2018 17:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

--9.RETRIEVE STUDENTS WHO IS LEARNING SPANISH--

CREATE VIEW [dbo].[Number of students each class] AS
SELECT c.name, COUNT(class_id) AS NumberofStudents
FROM language.class_student cs
JOIN language.student s ON cs.student_class_id = s.id
JOIN language.class c ON c.id = cs.class_id
GROUP BY c.name

--SELECT * FROM [Number of students each class]--
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
GO
/****** Object:  View [dbo].[Spanish Course Students]    Script Date: 26.11.2018 17:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

--9.RETRIEVE STUDENTS WHO IS LEARNING SPANISH--

CREATE VIEW [dbo].[Spanish Course Students] AS
SELECT language.fullName(fname,lname) AS FullName
FROM language.student s
JOIN language.class_student cs ON s.id = cs.student_class_id
JOIN language.class c ON c.id = cs.class_id
JOIN language.course co ON c.course_class_id = co.id
JOIN language.language l ON co.language_id = l.id
and l.name = 'Spanish'

--SELECT * FROM [Spanish Course Students]--
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
GO
/****** Object:  View [dbo].[Less Payment Made]    Script Date: 26.11.2018 17:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

--10.RETRIEVE STUDENT WHO MADE THE LESS PAYMENT AND WITH PAYMENT METHOD--

CREATE VIEW [dbo].[Less Payment Made] AS
SELECT s.fname AS name, p.payment_date , pm.name AS method
FROM language.student s
JOIN language.payment p ON p.student_id_payment = s.id 
JOIN language.payment_method pm ON pm.id = p.payment_method
WHERE p.amount IN (
SELECT MIN(p.amount)
FROM language.payment p )

--SELECT * FROM [Less Payment Made]--
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
GO
/****** Object:  Table [language].[student_acc]    Script Date: 26.11.2018 17:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [language].[student_acc](
	[id] [int] NOT NULL,
	[student_id] [int] NULL,
	[is_active] [bit] NOT NULL,
	[login] [varchar](100) NULL,
	[password] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [language].[class] ([id], [name], [start_date], [end_date], [teacher_class_id], [course_class_id]) VALUES (1, N'B1-4', CAST(N'2017-01-10' AS Date), CAST(N'2017-04-20' AS Date), 1, 1)
INSERT [language].[class] ([id], [name], [start_date], [end_date], [teacher_class_id], [course_class_id]) VALUES (2, N'B1-4', CAST(N'2017-05-01' AS Date), CAST(N'2017-09-12' AS Date), 3, 1)
INSERT [language].[class] ([id], [name], [start_date], [end_date], [teacher_class_id], [course_class_id]) VALUES (3, N'B1-4', CAST(N'2017-10-10' AS Date), CAST(N'2018-01-20' AS Date), 2, 1)
INSERT [language].[class] ([id], [name], [start_date], [end_date], [teacher_class_id], [course_class_id]) VALUES (4, N'B1-6', CAST(N'2017-10-14' AS Date), CAST(N'2018-01-02' AS Date), 4, 3)
INSERT [language].[class] ([id], [name], [start_date], [end_date], [teacher_class_id], [course_class_id]) VALUES (5, N'B1-6', CAST(N'2017-05-05' AS Date), CAST(N'2017-08-05' AS Date), 5, 3)
INSERT [language].[class] ([id], [name], [start_date], [end_date], [teacher_class_id], [course_class_id]) VALUES (6, N'B1-2', CAST(N'2017-10-09' AS Date), CAST(N'2018-01-14' AS Date), 6, 2)
INSERT [language].[class_student] ([id], [class_id], [student_class_id]) VALUES (1, 2, 1)
INSERT [language].[class_student] ([id], [class_id], [student_class_id]) VALUES (2, 2, 4)
INSERT [language].[class_student] ([id], [class_id], [student_class_id]) VALUES (3, 2, 7)
INSERT [language].[class_student] ([id], [class_id], [student_class_id]) VALUES (4, 2, 10)
INSERT [language].[class_student] ([id], [class_id], [student_class_id]) VALUES (5, 2, 13)
INSERT [language].[class_student] ([id], [class_id], [student_class_id]) VALUES (6, 4, 2)
INSERT [language].[class_student] ([id], [class_id], [student_class_id]) VALUES (7, 4, 5)
INSERT [language].[class_student] ([id], [class_id], [student_class_id]) VALUES (8, 4, 8)
INSERT [language].[class_student] ([id], [class_id], [student_class_id]) VALUES (9, 4, 11)
INSERT [language].[class_student] ([id], [class_id], [student_class_id]) VALUES (10, 4, 14)
INSERT [language].[class_student] ([id], [class_id], [student_class_id]) VALUES (11, 6, 3)
INSERT [language].[class_student] ([id], [class_id], [student_class_id]) VALUES (12, 6, 6)
INSERT [language].[class_student] ([id], [class_id], [student_class_id]) VALUES (13, 6, 9)
INSERT [language].[class_student] ([id], [class_id], [student_class_id]) VALUES (14, 6, 12)
INSERT [language].[class_student] ([id], [class_id], [student_class_id]) VALUES (15, 6, 15)
INSERT [language].[course] ([id], [lessons], [description], [term], [language_id], [level_id]) VALUES (1, 32, N'English Course', N'Güz', 1, 4)
INSERT [language].[course] ([id], [lessons], [description], [term], [language_id], [level_id]) VALUES (2, 28, N'Spanish Course', N'Güz', 2, 2)
INSERT [language].[course] ([id], [lessons], [description], [term], [language_id], [level_id]) VALUES (3, 30, N'Germany Course', N'Sonhabar', 3, 1)
INSERT [language].[language] ([id], [name]) VALUES (1, N'English')
INSERT [language].[language] ([id], [name]) VALUES (2, N'Spanish')
INSERT [language].[language] ([id], [name]) VALUES (3, N'Germany')
INSERT [language].[level] ([id], [name], [code]) VALUES (1, N'Elementary', N'A2')
INSERT [language].[level] ([id], [name], [code]) VALUES (2, N'High-Elementary', N'A1')
INSERT [language].[level] ([id], [name], [code]) VALUES (3, N'Pre-Intermediate', N'B2')
INSERT [language].[level] ([id], [name], [code]) VALUES (4, N'Intermediate', N'B1')
INSERT [language].[level] ([id], [name], [code]) VALUES (5, N'Upper-Intermediate', N'C1')
INSERT [language].[level] ([id], [name], [code]) VALUES (6, N'Advanced', N'C2')
INSERT [language].[payment] ([id], [payment_date], [amount], [status], [payment_method], [student_id_payment]) VALUES (1, CAST(N'2017-09-12' AS Date), 5000.0000, N'Ödeme yapıldı', 1, 1)
INSERT [language].[payment] ([id], [payment_date], [amount], [status], [payment_method], [student_id_payment]) VALUES (2, CAST(N'2017-08-29' AS Date), 4850.0000, N'Ödeme yapıldı', 2, 2)
INSERT [language].[payment] ([id], [payment_date], [amount], [status], [payment_method], [student_id_payment]) VALUES (3, CAST(N'2017-09-03' AS Date), 4900.0000, N'Taksit Bekleniyor', 2, 3)
INSERT [language].[payment] ([id], [payment_date], [amount], [status], [payment_method], [student_id_payment]) VALUES (4, CAST(N'2017-09-03' AS Date), 4920.0000, N'Ödeme yapıldı', 1, 4)
INSERT [language].[payment] ([id], [payment_date], [amount], [status], [payment_method], [student_id_payment]) VALUES (5, CAST(N'2017-09-04' AS Date), 4950.0000, N'Taksit Bekleniyor', 3, 5)
INSERT [language].[payment] ([id], [payment_date], [amount], [status], [payment_method], [student_id_payment]) VALUES (6, CAST(N'2017-08-28' AS Date), 4870.0000, N'Ödeme yapıldı', 2, 6)
INSERT [language].[payment] ([id], [payment_date], [amount], [status], [payment_method], [student_id_payment]) VALUES (7, CAST(N'2017-09-13' AS Date), 5000.0000, N'Taksit Bekleniyor', 3, 7)
INSERT [language].[payment] ([id], [payment_date], [amount], [status], [payment_method], [student_id_payment]) VALUES (8, CAST(N'2017-09-13' AS Date), 5000.0000, N'Ödeme yapıldı', 1, 8)
INSERT [language].[payment] ([id], [payment_date], [amount], [status], [payment_method], [student_id_payment]) VALUES (9, CAST(N'2017-09-11' AS Date), 4800.0000, N'Taksit Bekleniyor', 2, 9)
INSERT [language].[payment] ([id], [payment_date], [amount], [status], [payment_method], [student_id_payment]) VALUES (10, CAST(N'2017-09-15' AS Date), 5100.0000, N'Taksit Bekleniyor', 3, 10)
INSERT [language].[payment] ([id], [payment_date], [amount], [status], [payment_method], [student_id_payment]) VALUES (11, CAST(N'2017-09-06' AS Date), 4980.0000, N'Ödeme yapıldı', 1, 11)
INSERT [language].[payment] ([id], [payment_date], [amount], [status], [payment_method], [student_id_payment]) VALUES (12, CAST(N'2017-09-01' AS Date), 4790.0000, N'Ödeme yapıldı', 3, 12)
INSERT [language].[payment] ([id], [payment_date], [amount], [status], [payment_method], [student_id_payment]) VALUES (13, CAST(N'2017-09-02' AS Date), 4820.0000, N'Ödeme yapıldı', 2, 13)
INSERT [language].[payment] ([id], [payment_date], [amount], [status], [payment_method], [student_id_payment]) VALUES (14, CAST(N'2017-08-30' AS Date), 4900.0000, N'Ödeme yapıldı', 1, 14)
INSERT [language].[payment] ([id], [payment_date], [amount], [status], [payment_method], [student_id_payment]) VALUES (15, CAST(N'2017-09-09' AS Date), 5040.0000, N'Taksit Bekleniyor', 2, 15)
INSERT [language].[payment_method] ([id], [name]) VALUES (1, N'cash')
INSERT [language].[payment_method] ([id], [name]) VALUES (2, N'credit card')
INSERT [language].[payment_method] ([id], [name]) VALUES (3, N'debit card')
INSERT [language].[student] ([id], [fname], [lname], [data_birth], [city], [gender], [email], [phone]) VALUES (1, N'Elif', N'Abacı', CAST(N'1998-12-17' AS Date), N'Istanbul', N'F', N'e.abaci@hotmail.com', N'+905366344872')
INSERT [language].[student] ([id], [fname], [lname], [data_birth], [city], [gender], [email], [phone]) VALUES (2, N'Eren', N'Denlik', CAST(N'1999-06-20' AS Date), N'Istanbul', N'M', N'eren231@hotmail.com', N'+905691230123')
INSERT [language].[student] ([id], [fname], [lname], [data_birth], [city], [gender], [email], [phone]) VALUES (3, N'Demir', N'Can', CAST(N'1998-09-08' AS Date), N'Ankara', N'M', N'demircan@hotmail.com', N'+905125132152')
INSERT [language].[student] ([id], [fname], [lname], [data_birth], [city], [gender], [email], [phone]) VALUES (4, N'Selin', N'Dogmus', CAST(N'1997-01-05' AS Date), N'Izmir', N'F', N'selindogmus@hotmail.com', N'+905432562131')
INSERT [language].[student] ([id], [fname], [lname], [data_birth], [city], [gender], [email], [phone]) VALUES (5, N'Ahmet', N'Okumus', CAST(N'1997-05-02' AS Date), N'Istanbul', N'M', N'ahmetokumus@hotmail.com', N'+905561231875')
INSERT [language].[student] ([id], [fname], [lname], [data_birth], [city], [gender], [email], [phone]) VALUES (6, N'Busra', N'Sevecan', CAST(N'1998-04-23' AS Date), N'Istanbul', N'F', N'busrasevecan@hotmail.com', N'+905422227559')
INSERT [language].[student] ([id], [fname], [lname], [data_birth], [city], [gender], [email], [phone]) VALUES (7, N'Nesli', N'Kosava', CAST(N'1996-11-11' AS Date), N'Izmir', N'F', N'neslikosava@gmail.com', N'+905328769300')
INSERT [language].[student] ([id], [fname], [lname], [data_birth], [city], [gender], [email], [phone]) VALUES (8, N'Ahmet', N'Kahvecioglu', CAST(N'1998-12-02' AS Date), N'Ankara', N'M', N'ahmetkah.213@gmail.com', N'+905326770029')
INSERT [language].[student] ([id], [fname], [lname], [data_birth], [city], [gender], [email], [phone]) VALUES (9, N'Ferhat', N'Sanlık', CAST(N'1998-02-21' AS Date), N'Izmir', N'M', N'ferhatsanlık@hotmail.com', N'+905315639658')
INSERT [language].[student] ([id], [fname], [lname], [data_birth], [city], [gender], [email], [phone]) VALUES (10, N'Merve', N'Yalnız', CAST(N'1999-12-12' AS Date), N'Istanbul', N'F', N'merveya2@hotmail.com', N'+905213123216')
INSERT [language].[student] ([id], [fname], [lname], [data_birth], [city], [gender], [email], [phone]) VALUES (11, N'Ismail', N'Derin', CAST(N'1997-01-01' AS Date), N'Bursa', N'M', N'ismailderin@hotmail.com', N'+905422569821')
INSERT [language].[student] ([id], [fname], [lname], [data_birth], [city], [gender], [email], [phone]) VALUES (12, N'Eda', N'Gelincik', CAST(N'1995-03-12' AS Date), N'Istanbul', N'F', N'edagelincik@hotmail.com', N'+905326702108')
INSERT [language].[student] ([id], [fname], [lname], [data_birth], [city], [gender], [email], [phone]) VALUES (13, N'Can', N'Durmaz', CAST(N'2000-11-06' AS Date), N'Nevsehir', N'M', N'candurmaz@hotmail.com', N'+905356728629')
INSERT [language].[student] ([id], [fname], [lname], [data_birth], [city], [gender], [email], [phone]) VALUES (14, N'Duygu', N'Ates', CAST(N'1999-10-25' AS Date), N'Istanbul', N'F', N'duygu.ates@hotmail.com', N'+905469212017')
INSERT [language].[student] ([id], [fname], [lname], [data_birth], [city], [gender], [email], [phone]) VALUES (15, N'Nazlı', N'Soyluoglu', CAST(N'1994-08-21' AS Date), N'Istanbul', N'F', N'nazlı.soyluogulu@hotmail.com', N'+9054216729613')
INSERT [language].[student_acc] ([id], [student_id], [is_active], [login], [password]) VALUES (1, 1, 1, N'elifabacı', N'elfabac212')
INSERT [language].[student_acc] ([id], [student_id], [is_active], [login], [password]) VALUES (2, 2, 1, N'erendenlik', N'erendnlk99')
INSERT [language].[student_acc] ([id], [student_id], [is_active], [login], [password]) VALUES (3, 3, 1, N'demircan', N'demrcancan08')
INSERT [language].[student_acc] ([id], [student_id], [is_active], [login], [password]) VALUES (4, 4, 1, N'selindogmus', N'selndogms9701')
INSERT [language].[student_acc] ([id], [student_id], [is_active], [login], [password]) VALUES (5, 5, 1, N'ahmetokumus', N'ahmetokms87')
INSERT [language].[student_acc] ([id], [student_id], [is_active], [login], [password]) VALUES (6, 6, 1, N'busrasevecan', N'sevcanbusra98')
INSERT [language].[student_acc] ([id], [student_id], [is_active], [login], [password]) VALUES (7, 7, 1, N'neslikosava', N'kosava.nesli11')
INSERT [language].[student_acc] ([id], [student_id], [is_active], [login], [password]) VALUES (8, 8, 1, N'ahmetkahvecioglu', N'ahmetkhvci22')
INSERT [language].[student_acc] ([id], [student_id], [is_active], [login], [password]) VALUES (9, 9, 0, N'ferhatsanlık', N'ferhatsanlık0221')
INSERT [language].[student_acc] ([id], [student_id], [is_active], [login], [password]) VALUES (10, 10, 1, N'merve Yalnız', N'merveyanlız99')
INSERT [language].[student_acc] ([id], [student_id], [is_active], [login], [password]) VALUES (11, 11, 1, N',smailderin', N'derinismail0101')
INSERT [language].[student_acc] ([id], [student_id], [is_active], [login], [password]) VALUES (12, 12, 0, N'edaGelincik', N'edagelincik950312')
INSERT [language].[student_acc] ([id], [student_id], [is_active], [login], [password]) VALUES (13, 13, 1, N'candurmaz', N'candurmaz.gs')
INSERT [language].[student_acc] ([id], [student_id], [is_active], [login], [password]) VALUES (14, 14, 1, N'duyguaes', N'atesduygu1025')
INSERT [language].[student_acc] ([id], [student_id], [is_active], [login], [password]) VALUES (15, 15, 1, N'nazlısoylugolu', N'nazlıfb.s212')
INSERT [language].[teacher] ([id], [description], [fname], [lname], [email], [phone]) VALUES (1, N'English Teacher', N'Muharrem', N'Selim', N'muharremselim@hotmail.com', N'+905366344872')
INSERT [language].[teacher] ([id], [description], [fname], [lname], [email], [phone]) VALUES (2, N'English Teacher', N'Songul', N'Enka', N'songulenka@hotmail.com', N'+90536356323')
INSERT [language].[teacher] ([id], [description], [fname], [lname], [email], [phone]) VALUES (3, N'English Teacher', N'Elif', N'Demiroglu', N'elifdemiroglu@hotmail.com', N'+905346578224')
INSERT [language].[teacher] ([id], [description], [fname], [lname], [email], [phone]) VALUES (4, N'Germany Teacher', N'James', N'Haloyen', N'jameshaloyen@hotmail.com', N'+4205105125')
INSERT [language].[teacher] ([id], [description], [fname], [lname], [email], [phone]) VALUES (5, N'Germany Teacher', N'Mehmet', N'Degirmen', N'mehmetdegirmen@hotmail.com', N'+905367232590')
INSERT [language].[teacher] ([id], [description], [fname], [lname], [email], [phone]) VALUES (6, N'Spanish Teacher', N'Joshua', N'Soln', N'joshuasoln@gmail.com', N'+2852513123')
INSERT [language].[teacher_acc] ([id], [teacher_id], [is_active], [login], [password]) VALUES (1, 1, 0, N'muammerselim', N'muhammerselim39')
INSERT [language].[teacher_acc] ([id], [teacher_id], [is_active], [login], [password]) VALUES (2, 2, 1, N'elifdemiroglu', N'heydos26213')
INSERT [language].[teacher_acc] ([id], [teacher_id], [is_active], [login], [password]) VALUES (3, 3, 0, N'songulenka', N'songulenka212')
INSERT [language].[teacher_acc] ([id], [teacher_id], [is_active], [login], [password]) VALUES (4, 4, 1, N'jameshaloyen', N'jameshaloyen42')
INSERT [language].[teacher_acc] ([id], [teacher_id], [is_active], [login], [password]) VALUES (5, 5, 0, N'mehmetdegirmen', N'mehmetdegirmen00')
INSERT [language].[teacher_acc] ([id], [teacher_id], [is_active], [login], [password]) VALUES (6, 6, 1, N'joshunasoln', N'joshuasoln9292')
ALTER TABLE [language].[class]  WITH CHECK ADD FOREIGN KEY([course_class_id])
REFERENCES [language].[course] ([id])
GO
ALTER TABLE [language].[class]  WITH CHECK ADD FOREIGN KEY([teacher_class_id])
REFERENCES [language].[teacher] ([id])
GO
ALTER TABLE [language].[class_student]  WITH CHECK ADD FOREIGN KEY([class_id])
REFERENCES [language].[class] ([id])
GO
ALTER TABLE [language].[class_student]  WITH CHECK ADD FOREIGN KEY([student_class_id])
REFERENCES [language].[student] ([id])
GO
ALTER TABLE [language].[course]  WITH CHECK ADD FOREIGN KEY([language_id])
REFERENCES [language].[language] ([id])
GO
ALTER TABLE [language].[course]  WITH CHECK ADD FOREIGN KEY([level_id])
REFERENCES [language].[level] ([id])
GO
ALTER TABLE [language].[payment]  WITH CHECK ADD FOREIGN KEY([payment_method])
REFERENCES [language].[payment_method] ([id])
GO
ALTER TABLE [language].[payment]  WITH CHECK ADD FOREIGN KEY([student_id_payment])
REFERENCES [language].[student] ([id])
GO
ALTER TABLE [language].[student_acc]  WITH CHECK ADD FOREIGN KEY([student_id])
REFERENCES [language].[student] ([id])
GO
ALTER TABLE [language].[teacher_acc]  WITH CHECK ADD FOREIGN KEY([teacher_id])
REFERENCES [language].[teacher] ([id])
GO
USE [master]
GO
ALTER DATABASE [LanguageCourse] SET  READ_WRITE 
GO
