CREATE DATABASE LanguageCourse;
GO

use LanguageCourse;
GO

CREATE SCHEMA language;
GO

CREATE LOGIN languagecourseadmin
WITH PASSWORD = 'mucahitburak'
GO

CREATE TABLE language.language(
	id Integer NOT NULL PRIMARY KEY,
	name nvarchar(30) NOT NULL
)
GO

CREATE TABLE language.level(
	id Integer NOT NULL PRIMARY KEY,
	name nvarchar(30) NOT NULL,
	code nvarchar(3) NOT NULL
)
GO

CREATE TABLE language.course(
	id Integer NOT NULL PRIMARY KEY,
	lessons Integer NOT NULL,
	description varchar(100) NOT NULL,
	term varchar(100) NOT NULL,
	language_id int FOREIGN KEY REFERENCES language.language(id),
	level_id int FOREIGN KEY REFERENCES language.level(id)
)
GO

CREATE TABLE language.student(
	id Integer NOT NULL PRIMARY KEY,
	fname varchar(100) NOT NULL,
	lname varchar(100) NOT NULL,
	data_birth DATE,
	city varchar(100),
	gender varchar(1),
	email varchar(100),
	phone varchar(100)
)
GO

CREATE TABLE language.student_acc(
	id INTEGER NOT NULL PRIMARY KEY,
	student_id int FOREIGN KEY REFERENCES language.student(id),
	is_active BIT NOT NULL,
	login varchar(100),
	password varchar(100)
)
GO

CREATE TABLE language.teacher(
	id INTEGER NOT NULL PRIMARY KEY,
	description varchar(200) NOT NULL,
	fname varchar(100) NOT NULL,
	lname varchar(100) NOT NULL,
	email varchar(100) NOT NULL,
	phone varchar(100) NOT NULL
)
GO

CREATE TABLE language.teacher_acc(
	id INTEGER NOT NULL PRIMARY KEY,
	teacher_id int FOREIGN KEY REFERENCES language.teacher(id),
	is_active BIT NOT NULL,
	login varchar(100),
	password varchar(100)
)
GO

CREATE TABLE language.class(
	id INTEGER NOT NULL PRIMARY KEY,
	name varchar(30) NOT NULL,
	start_date DATE NOT NULL,
	end_date DATE NOT NULL,
	teacher_class_id INT FOREIGN KEY REFERENCES language.teacher(id),
	course_class_id INT FOREIGN KEY REFERENCES language.course(id)
) 
GO

CREATE TABLE language.class_student(
	id INTEGER NOT NULL PRIMARY KEY,
	class_id INT FOREIGN KEY REFERENCES language.class(id),
	student_class_id INT FOREIGN KEY REFERENCES language.student(id)
)
GO

CREATE TABLE language.payment_method(
	id INTEGER NOT NULL PRIMARY KEY,
	name varchar(100) NOT NULL
)
GO

CREATE TABLE language.payment(
	id INTEGER NOT NULL PRIMARY KEY,
	payment_date DATE,
	amount money,
	status varchar(100) NOT NULL,
	payment_method INT FOREIGN KEY REFERENCES language.payment_method(id),
	student_id_payment INT FOREIGN KEY REFERENCES language.student(id)
)
GO


-------------------------------------------------------------------------------------------------------------------
INSERT INTO language.payment_method(
       [id]
      ,[name])

VALUES 
		(1,'cash'), (2,'credit card'), (3,'debit card')
-------------------------------------------------------------------------------------------------------------------
INSERT INTO language.student(
       [id]
      ,[fname]
      ,[lname]
      ,[data_birth]
      ,[city]
	  ,[gender]
      ,[email]
      ,[phone])

VALUES 
		(1,'Elif' , 'Abacı' , '1998-12-17','Istanbul','F','e.abaci@hotmail.com','+905366344872'),
		(2,'Eren' , 'Denlik', '1999-06-20','Istanbul','M','eren231@hotmail.com','+905691230123'),
		(3,'Demir', 'Can', '1998-09-08','Ankara','M','demircan@hotmail.com','+905125132152'),
		(4,'Selin', 'Dogmus', '1997-01-05', 'Izmir','F','selindogmus@hotmail.com','+905432562131'),
		(5,'Ahmet', 'Okumus', '1997-05-02', 'Istanbul','M','ahmetokumus@hotmail.com','+905561231875'),
		(6,'Busra', 'Sevecan', '1998-04-23', 'Istanbul','F', 'busrasevecan@hotmail.com','+905422227559'),
		(7,'Nesli', 'Kosava', '1996-11-11', 'Izmir','F','neslikosava@gmail.com', '+905328769300'),
		(8,'Ahmet', 'Kahvecioglu', '1998-12-02', 'Ankara','M', 'ahmetkah.213@gmail.com', '+905326770029'),
		(9,'Ferhat', 'Sanlık', '1998-02-21', 'Izmir', 'M','ferhatsanlık@hotmail.com', '+905315639658'),
		(10,'Merve', 'Yalnız', '1999-12-12', 'Istanbul', 'F','merveya2@hotmail.com', '+905213123216'),
		(11,'Ismail','Derin', '1997-01-01', 'Bursa', 'M','ismailderin@hotmail.com', '+905422569821'),
		(12,'Eda', 'Gelincik','1995-03-12', 'Istanbul','F', 'edagelincik@hotmail.com', '+905326702108'),
		(13,'Can', 'Durmaz', '2000-11-6', 'Nevsehir','M', 'candurmaz@hotmail.com', '+905356728629'),
		(14,'Duygu','Ates', '1999-10-25', 'Istanbul','F', 'duygu.ates@hotmail.com', '+905469212017'),
		(15,'Nazlı', 'Soyluoglu', '1994-08-21', 'Istanbul','F', 'nazlı.soyluogulu@hotmail.com', '+9054216729613')
-------------------------------------------------------------------------------------------------------------------
INSERT INTO language.payment(
       [id]
      ,[payment_date]
      ,[amount]
      ,[status]
	  ,[payment_method]
	  ,[student_id_payment])

VALUES 
		( 1, '2017-09-12', '5000', 'Ödeme yapıldı', 1, 1),
		( 2, '2017-08-29', '4850', 'Ödeme yapıldı', 2, 2),
		( 3, '2017-09-03', '4900', 'Taksit Bekleniyor', 2, 3),
		( 4, '2017-09-03', '4920', 'Ödeme yapıldı', 1, 4),
		( 5, '2017-09-04', '4950', 'Taksit Bekleniyor', 3, 5),
		( 6, '2017-08-28', '4870', 'Ödeme yapıldı', 2, 6),
		( 7, '2017-09-13', '5000', 'Taksit Bekleniyor', 3, 7),
		( 8, '2017-09-13', '5000', 'Ödeme yapıldı', 1, 8),
		( 9, '2017-09-11', '4800', 'Taksit Bekleniyor', 2, 9),
		( 10,'2017-09-15', '5100', 'Taksit Bekleniyor', 3, 10),
		( 11,'2017-09-06', '4980', 'Ödeme yapıldı', 1, 11),
		( 12,'2017-09-01', '4790', 'Ödeme yapıldı', 3,12),
		( 13,'2017-09-02', '4820', 'Ödeme yapıldı', 2,13),
		( 14,'2017-08-30', '4900', 'Ödeme yapıldı', 1,14),
		( 15,'2017-09-09', '5040', 'Taksit Bekleniyor', 2,15)	
-------------------------------------------------------------------------------------------------------------------
INSERT INTO language.student_acc(
        [id]
	   ,[student_id]
       ,[is_active]
       ,[login]
       ,[password])

VALUES
		( 1,1,1,'elifabacı','elfabac212'),
		( 2,2,1,'erendenlik','erendnlk99'),
		( 3,3,1,'demircan','demrcancan08'),
		( 4,4,1,'selindogmus','selndogms9701'),
		( 5,5,1,'ahmetokumus','ahmetokms87'),
		( 6,6,1,'busrasevecan','sevcanbusra98'),
		( 7,7,1,'neslikosava','kosava.nesli11'),
		( 8,8,1,'ahmetkahvecioglu','ahmetkhvci22'),
		( 9,9,0,'ferhatsanlık','ferhatsanlık0221'),
		(10,10,1,'merve Yalnız','merveyanlız99'),
		(11,11,1,',smailderin','derinismail0101'),
		(12,12,0,'edaGelincik','edagelincik950312'),
		(13,13,1,'candurmaz','candurmaz.gs'),
		(14,14,1,'duyguaes','atesduygu1025'),
		(15,15,1,'nazlısoylugolu','nazlıfb.s212')
-------------------------------------------------------------------------------------------------------------------
INSERT INTO language.level(
       [id]
      ,[name]
      ,[code])
VALUES 
		( 1, 'Elementary', 'A2'),
		( 2, 'High-Elementary', 'A1'),
		( 3, 'Pre-Intermediate','B2'),
		( 4, 'Intermediate', 'B1'),
		( 5, 'Upper-Intermediate', 'C1'),
		( 6, 'Advanced', 'C2')
-------------------------------------------------------------------------------------------------------------------
INSERT INTO language.language(
      [id]
     ,[name])

VALUES 
		( 1 , 'English'),
		( 2 , 'Spanish'),
		( 3 , 'Germany')
-------------------------------------------------------------------------------------------------------------------
INSERT INTO language.course(
       [id]
      ,[lessons]
      ,[description]
      ,[term]
	  ,[language_id]
	  ,[level_id])

	 VALUES ( 1, 32 , 'English Course' , 'Güz', 1 , 4),
		    ( 2, 28 , 'Spanish Course' , 'Güz', 2, 2),
	        ( 3, 30 , 'Germany Course' , 'Sonhabar', 3, 1)
-------------------------------------------------------------------------------------------------------------------
INSERT INTO language.teacher(
       [id]
      ,[description]
      ,[fname]
      ,[lname]
      ,[email]
      ,[phone])

VALUES 
		( 1,'English Teacher', 'Muharrem','Selim', 'muharremselim@hotmail.com','+905366344872'),
		( 2,'English Teacher', 'Songul', 'Enka', 'songulenka@hotmail.com', '+90536356323'),
		( 3,'English Teacher', 'Elif', 'Demiroglu', 'elifdemiroglu@hotmail.com', '+905346578224'),
		( 4,'Germany Teacher', 'James','Haloyen', 'jameshaloyen@hotmail.com', '+4205105125'),
		( 5,'Germany Teacher', 'Mehmet', 'Degirmen', 'mehmetdegirmen@hotmail.com', '+905367232590'),
		( 6,'Spanish Teacher', 'Joshua', 'Soln', 'joshuasoln@gmail.com', '+2852513123')
-------------------------------------------------------------------------------------------------------------------
INSERT INTO language.teacher_acc(
	   [id]
	  ,[teacher_id]
      ,[is_active]
      ,[login]
      ,[password])

VALUES 
		( 1, 1, 0, 'muammerselim', 'muhammerselim39'),
		( 2, 2, 1, 'elifdemiroglu', 'heydos26213'),
		( 3, 3, 0, 'songulenka', 'songulenka212'),
		( 4, 4, 1, 'jameshaloyen','jameshaloyen42'),
		( 5, 5, 0, 'mehmetdegirmen','mehmetdegirmen00'),
		( 6, 6, 1, 'joshunasoln', 'joshuasoln9292')
-------------------------------------------------------------------------------------------------------------------
INSERT INTO language.class(
	   [id]
      ,[name]
      ,[start_date]
      ,[end_date]
	  ,[teacher_class_id]
	  ,[course_class_id])

VALUES
        ( 1, 'B1-4', '2017-01-10', '2017-04-20', 1, 1),
		( 2, 'B1-4', '2017-05-01', '2017-09-12', 3, 1),
		( 3, 'B1-4', '2017-10-10', '2018-01-20', 2, 1),
		( 4, 'B1-6', '2017-10-14', '2018-01-02', 4, 3),
		( 5, 'B1-6', '2017-05-05', '2017-08-05', 5, 3),
		( 6, 'B1-2', '2017-10-09', '2018-01-14', 6, 2)		
-------------------------------------------------------------------------------------------------------------------
INSERT INTO language.class_student(  
	   [id]
	  ,[class_id]
      ,[student_class_id])

VALUES 
		( 1, 2, 1 ),
		( 2, 2, 4 ),
		( 3, 2, 7),
		( 4, 2, 10),
		( 5, 2, 13),
		( 6, 4, 2),
		( 7, 4, 5),
		( 8, 4, 8),
		( 9, 4, 11),
		(10, 4, 14),
		(11, 6, 3),
		(12, 6, 6),
		(13, 6, 9),
		(14, 6, 12),
		(15, 6, 15)

		
		
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
GO
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE FUNCTION language.Age(@DOB Date)  
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
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE FUNCTION language.fullName(@fname VARCHAR(50), @lname VARCHAR(50))
  RETURNS VARCHAR(200)
  AS
    BEGIN 
       RETURN (SELECT  @fname + ' ' + @lname )
    END

	
--SELECT dbo.fullname(fname,lname) FROM language.student--
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
GO
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE FUNCTION language.genderabrv(@gender VARCHAR(6))
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
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TRIGGER student_validate_information
ON language.student
FOR INSERT
AS
BEGIN
	SET NOCOUNT ON;
	Declare @nemail varchar(100)
	SET @nemail = (Select email from inserted)
	IF @nemail NOT LIKE '%_@%_.__%' 
	BEGIN
	DELETE FROM language.student WHERE @nemail = email
	print(CHAR(10) + 'Please write validate mail adress');
	END
	ELSE
	BEGIN
	Declare @id int
	Declare @is_active bit
	Declare @login varchar(40)
	Declare @password varchar(40)
	Declare @acc_id int
	SET @acc_id = (SELECT MAX(id)FROM language.student_acc) + 1
	SET @id = ( SELECT id FROM inserted )
	SET @is_active = 1
	SET @login = (SELECT fname + lname FROM inserted)
	SET @password = (SELECT SUBSTRING(CONVERT(varchar(40), NEWID()),0,9))
	INSERT INTO language.student_acc VALUES(@acc_id,@id,@is_active,@login,@password)
	SELECT * FROM language.student_acc WHERE student_id = @id
	END
END;

--INSERT into language.student values (16,'hasan','ali','08/08/1991','Ist','M','hasanali@hot','+4214124142')--
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
GO
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TRIGGER validate_payment
ON language.payment
FOR INSERT
AS
BEGIN
	set nocount on
	Declare @amount money
	SET @amount = (Select amount from inserted)
	IF (@amount < 4700 ) 
	BEGIN
	DELETE FROM language.payment WHERE @amount = amount
	print(CHAR(10) + 'Payment is so less.. Bad deal');
	END
	ELSE
	print(CHAR(10) + 'Inserted succesfully');
END;

--INSERT into language.payment values (16,'07/07/95',5000,'done',1,21)--
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
GO
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TRIGGER updateLevel
ON language.course
AFTER UPDATE
AS
BEGIN
	set nocount off
	Declare @old varchar(30)
	Declare @new varchar(30)
	Declare @lan varchar(20)

	SET @old = (Select name from language.level WHERE (Select level_id from inserted) = id )
	SET @new = (Select name from language.level WHERE (Select level_id from deleted) = id )
	SET @lan = (SELECT name FROM language.language WHERE (SELECT language_id from inserted) = id)

	SELECT @old AS old_level ,@new AS new_level, @lan AS language
END


--UPDATE language.course SET level_id = 3 WHERE language_id=1--
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
GO
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TRIGGER updateClass
ON language.class
AFTER UPDATE
AS
BEGIN
	set nocount off
	Declare @classo varchar(10)
	Declare @classn varchar(10)
	SET @classo = (SELECT name FROM deleted)
	SET @classn = (SELECT name FROM inserted)
	SELECT @classo AS OldClass, @classn AS NewClass, course.description
	FROM language.course,language.class
	WHERE course.id = class.course_class_id and class.name = @classn

END

--UPDATE language.class SET name='A1-2' WHERE course_class_id=2--
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
GO
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TRIGGER teacheracc
ON language.teacher
FOR INSERT
AS
BEGIN
	set nocount off
	Declare @id int
	Declare @is_active bit
	Declare @login varchar(40)
	Declare @password varchar(40)
	Declare @acc_id int
	SET @acc_id = (SELECT MAX(id)FROM language.teacher_acc) + 1
	print(@acc_id)
	SET @id = ( SELECT id FROM inserted )
	SET @is_active = 1
	SET @login = (SELECT fname + lname FROM inserted)
	SET @password = (SELECT SUBSTRING(CONVERT(varchar(40), NEWID()),0,9))
	INSERT INTO language.teacher_acc VALUES(@acc_id,@id,@is_active,@login,@password)
	SELECT * FROM language.teacher_acc WHERE teacher_id = @id

END

--INSERT INTO language.teacher VALUES(7,'MAt','Ayse','ozturk','adasd@hotmail.com','+4124124142')--
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
GO
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

--1.PRINT ALL STUDENT WITH THE AVERAGE PAYMENT AND HOW MUCH THEY PAID.--

CREATE VIEW [Payment with Average Student] AS
SELECT s.fname, p.amount AS Paid, (Select AVG(amount) FROM language.payment) AS AvgPaid
FROM language.student s, language.payment p
WHERE s.id = p.student_id_payment

--SELECT * FROM [Payment with Average Student]--
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
GO
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

--2.PRINT ALL STUDENT NAME AND THEIR AGES BY USING FUNCTION(Age)--

CREATE VIEW [Student with Age] AS
SELECT s.fname,language.Age(s.data_birth) AS Age
FROM language.student s


--SELECT * FROM [Student with Age]--
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
GO
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

--3.RETRIEVE ALL PAYMENT WITH ORDERLY: NAME,AMOUNT AND PAYMENT METHOD WHERE IT IS DONE BY CASH--

CREATE VIEW [Paid with Cash] AS
SELECT s.fname AS name,m.name AS paidmethod ,p.amount
FROM language.payment p
JOIN language.student s ON s.id = p.student_id_payment
JOIN language.payment_method m ON m.id = p.payment_method
WHERE m.name = 'Cash'

--SELECT * FROM [Paid with Cash]--
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
GO
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

--4.PRINT ALL TEACHER WITH FULLNAME USE FUNCTION(Fullname) AND THEIR BRANCHES--

CREATE VIEW [Teachers with Branch] AS
SELECT language.fullName(fname,lname) AS Fullname, description AS Branch
FROM language.teacher

--SELECT * FROM [Teachers with Branch]--
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
GO
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

--5.RETRIEVE ALL LANGUAGES FOR EACH COURSE HOW LONG THEY LAST--

CREATE VIEW [Language course lesson] AS
SELECT l.name AS Language , c.lessons
FROM language.language l, language.course c
WHERE  l.id = c.language_id

--SELECT * FROM [Language course lesson]--
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
GO
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

--6.SELECT ALL LANGUAGES WITH THEIR TEACHING LEVEL AND WHO TEACH THEM IF THE TEACHER IS ACTIVE 1--

CREATE VIEW [Languages with Level and Teacher] AS
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
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

--7.RETRIEVE ALL CLASS WITH NAME AND DESCRIPTION --

CREATE VIEW [Class with description] AS
SELECT DISTINCT c.name, co.description
FROM language.class c
JOIN language.course co ON co.id = c.course_class_id

--SELECT * FROM [Number of students each class]--
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
GO
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

--9.RETRIEVE STUDENTS WHO IS LEARNING SPANISH--

CREATE VIEW [Number of students each class] AS
SELECT c.name, COUNT(class_id) AS NumberofStudents
FROM language.class_student cs
JOIN language.student s ON cs.student_class_id = s.id
JOIN language.class c ON c.id = cs.class_id
GROUP BY c.name

--SELECT * FROM [Number of students each class]--
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
GO
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

--9.RETRIEVE STUDENTS WHO IS LEARNING SPANISH--

CREATE VIEW [Spanish Course Students] AS
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
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

--10.RETRIEVE STUDENT WHO MADE THE LESS PAYMENT AND WITH PAYMENT METHOD--

CREATE VIEW [Less Payment Made] AS
SELECT s.fname AS name, p.payment_date , pm.name AS method
FROM language.student s
JOIN language.payment p ON p.student_id_payment = s.id 
JOIN language.payment_method pm ON pm.id = p.payment_method
WHERE p.amount IN (
SELECT MIN(p.amount)
FROM language.payment p )

--SELECT * FROM [Less Payment Made]--
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
