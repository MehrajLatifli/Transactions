CREATE DATABASE Blog


USE Blog


create table Users(
Id int primary key identity(1,1),
LoginName nvarchar(50) not null unique,
[Password] nvarchar(200) NOT NULL,
Rating float NOT NULL Default 0
)


create table Posts(
Id int primary key identity(1,1),
IdUser int NOT NULL FOREIGN KEY REFERENCES Users(Id),
[Message] nvarchar(MAX) not null,
DatePost datetime2 NOT NULL DEFAULT (SYSDATETIME()),
Rating float NOT NULL DEFAULT(0)
)

create table Comments(
Id int PRIMARY KEY IDENTITY(1,1),
IdUser int NOT NULL FOREIGN KEY REFERENCES Users(Id),
IdPost int not null foreign key references Posts(Id),
[Message] nvarchar(max) not null,
DateComment datetime2 NOT NULL DEFAULT (SYSDATETIME()),
Rating FLOAT NOT NULL DEFAULT(0)
)

CREATE TABLE PostRating(
IdPost int NOT NULL FOREIGN KEY REFERENCES Posts(Id),
IdUser int NOT NULL FOREIGN KEY REFERENCES Users(Id),
Mark int NOT NULL,
CONSTRAINT UQ_PostRating UNIQUE (IdPost,IdUser)
)


CREATE TABLE CommentRating(
IdComment int NOT NULL FOREIGN KEY REFERENCES Comments(Id),
IdUser int NOT NULL FOREIGN KEY REFERENCES Users(Id),
Mark int NOT NULL,
CONSTRAINT UQ_CommentRating UNIQUE (IdComment,IdUser)
)


insert into Users(LoginName,[Password])
values('Leyla123','aa'),('John_100','aa'),('Admin26','aa')


select * from Users


insert into Posts(IdUser,[Message])
values(1,'happy Day'),(1,'C# Language'),
(2,'Angular Best'),(2,'Sql is great'),
(3,'Web Design tutorials'),(3,'Programming')


select * from Posts


insert into Comments(IdUser,IdPost,[Message])
values(1,1,'Bu Post eladi'),
(2,1,'Nice'),
(2,2,'Great'),
(3,3,'Beyenmedim'),
(1,3,'Men de beyenmedim')


select * from Comments


insert into PostRating([IdUser],[IdPost],[Mark])
values
(1,1,3),
(1,2,2),
(1,3,5),
(2,1,1),
(2,2,2),
(2,3,5)
--(3,1,2),
--(3,2,2),
--(3,3,4)


select * from PostRating


insert into CommentRating([IdComment],[IdUser],[Mark])
values
(1,1,3),
(1,2,2),
(1,3,5),
(2,1,1),
(2,2,2),
(2,3,5)
--(3,1,2),
--(3,2,2),
--(3,3,4)


select *from CommentRating