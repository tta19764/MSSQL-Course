USE master;
GO
CREATE DATABASE TechShop
ON PRIMARY
(
	NAME = TechShopDat,
	FILENAME = 'D:\Документы\TechShop\TechShop.mdf',
	SIZE = 6,
	MAXSIZE = 1 GB,
	FILEGROWTH = 20 KB
)
LOG ON
(
	NAME = TechShopLog,
	FILENAME = 'D:\Документы\TechShop\TechShop.ldf',
	SIZE = 6,
	MAXSIZE = 1 GB,
	FILEGROWTH = 20 KB
)
GO
USE TechShop;
GO
CREATE TABLE Manufacturers
(
	Id int PRIMARY KEY IDENTITY,
	Country nvarchar(50) NOT NUll 
)
GO 
CREATE TABLE Brands
(
	Id int PRIMARY KEY IDENTITY,
	BrandName nvarchar(50) NOT NULL UNIQUE
)
GO 
CREATE TABLE Positions
(
	Id int PRIMARY KEY IDENTITY,
	PositionName nvarchar(50) NOT NULL UNIQUE,
	Salary money NOT NULL
)
GO 
CREATE TABLE Employees
(
	Id int PRIMARY KEY IDENTITY,
	FirstName nvarchar(20) NOT NULL,
	LastName nvarchar(30) NOT NULL,
	PositionId int NOT NULL FOREIGN KEY REFERENCES Positions(Id),
	Telephone nvarchar(13) NOT NULL UNIQUE
)
GO 
CREATE TABLE Departments
(
	Id int PRIMARY KEY IDENTITY,
	DepartmentName nvarchar(50) NOT NULL UNIQUE,
	ConsultantId int NOT NULL FOREIGN KEY REFERENCES Employees(Id)
)
GO
CREATE TABLE Categories
(
	Id int PRIMARY KEY IDENTITY,
	CategoryName nvarchar(50) NOT NULL UNIQUE,
	DepartmentId int NOT NULL FOREIGN KEY REFERENCES Departments(Id)
)
GO
CREATE TABLE Items
(
	Id int PRIMARY KEY IDENTITY,
	[Name] nvarchar(128) NOT NULL UNIQUE,
	CategoryId int NOT NULL FOREIGN KEY REFERENCES Categories(Id),
	BrandId int NOT NULL FOREIGN KEY REFERENCES Brands(Id),
	Price money NOT NULL,
	ManufacturerId int NOT NULL FOREIGN KEY REFERENCES Manufacturers(Id),
	ItemsLeft int NOT NULL
)
GO
CREATE TABLE Clients
(
	Id int PRIMARY KEY IDENTITY,
	FirstName nvarchar(20) NOT NULL,
	LastName nvarchar(30) NOT NULL,
	Email nvarchar(30) NOT NULL UNIQUE,
	Telephone nvarchar(13) NOT NULL UNIQUE
)
GO 
CREATE TABLE Sells
(
	Id int PRIMARY KEY IDENTITY,
	ItemId int NOT NULL FOREIGN KEY REFERENCES Items(Id),
	NumberOfItems int NOT NULL
)
GO
CREATE TABLE Orders
(
	Id int PRIMARY KEY IDENTITY,
	ClientId int NOT NULL FOREIGN KEY REFERENCES Clients(Id),
	RegistrationDate datetime NOT NULL
)
GO
CREATE TABLE SellsOrders
(
	Id int PRIMARY KEY IDENTITY,
	SellId int NOT NULL FOREIGN KEY REFERENCES Sells(Id),
	OrderId int NOT NULL FOREIGN KEY REFERENCES Orders(Id)
)
GO


INSERT INTO Brands VALUES ('Samsung'),
						('Apple'),
						('Xiaomi'),
						('Bosch'),
						('LG'),
						('Philips'),
						('Sennheiser'),
						('Sony'),
						('Panasonic');

INSERT INTO Manufacturers VALUES('China'),
								('Germany'),
								('Korea'),
								('Vietnam');

INSERT INTO Positions VALUES('Cleaner', 7500.00),
							('Consultant', 10500.00),
							('Cashier', 12000.00),
							('Manager', 20000.00),
							('security guard', 11000.00);

INSERT INTO Employees VALUES('Paul', 'Black', 1, '+380746592389'),
							('Leon', 'White', 1, '+380774957385'),
							('Karl', 'Orange', 2, '+380836495765'),
							('Sam', 'Blue', 2, '+380883647582'),
							('Sandy', 'Grenn', 2, '+380937596850'),
							('Gary', 'Yellow', 3, '+380884756334'),
							('Gohn', 'Purple', 3, '+380008263544'),
							('Jinx', 'Clay', 3, '+380946555643'),
							('Ginger', 'Red', 4, '+380994857763'),
							('Clark', 'Kent', 4, '+380663847559'),
							('Bruse', 'Vane', 5, '+380953644443'),
							('Tony', 'Stark', 5, '+380998366764');

INSERT INTO Departments VALUES('Home Appliances', 3),
							('Gadgets', 4),
							('Audio', 5);

INSERT INTO Categories VALUES('Small kitchen appliances', 1),
							('Big appliances', 1),
							('Climatic equipment', 1),
							('Smartphones', 2),
							('Laptops', 2),
							('Tablests', 2),
							('Headphones', 3),
							('Acustics', 3),
							('Headphone accessories', 3);

INSERT INTO Items VALUES('Блендер MSM2620B', 1, 4, 1853.00, 2, 25),
						('М ясорубка MFW2515W', 1, 4, 4429.00, 2, 15),
						('Мультипіч HD9650/90', 1, 6, 11999.00, 1, 22),
						('Мікрохвильова MS23K3614AS/UA SOLO', 2, 1, 5399.00, 3, 9),
						('Двокамерний холодильник GW-B459SLCM', 2, 5, 26999.00, 4, 4),
						('Морозильна камера RZ32T7435AP/UA+RA-R23DAA05GG', 2, 1, 36599.00, 3, 5),
						('Кондиціонер Standard Plus PC12SQ', 3, 5, 31499.00, 4, 7),
						('Кондиціонер inverte AR09AXHZAWKNUA', 3, 1, 20099.00, 3, 2),
						('Кондиціонер GEO Wind Free AR12AXAAAWKNER', 3, 1, 39999.00, 3, 0),
						('Galaxy Flip 4 F721B 2022 (SM-F721BZAGSEK)', 4, 1, 39999.00, 3, 0),
						('iPhone 14 Pro Max Space Black (MQ9U3)', 4, 2, 67999.00, 1, 6),
						('Galaxy A33 2022 A336B Black (SM-A336BZKGSEK)', 4, 1, 14399.00, 3, 3),
						('MacBook Air M1 Chip 13"/256 (MGN63UA/A) Space Gray 2020', 5, 2, 42999.00, 1, 5),
						('MacBook Air M2 Chip 13" 8/256GB Starlight (MLY13) 2022', 5, 2, 54999.00, 1, 2),
						('MacBook Pro M1 Pro Chip 14'' 512GB (Space Gray)', 5, 2, 88999.00, 1, 6),
						('Galaxy Tab А7 Lite 8.7" 4/64Gb Wi-Fi Grey (SM-T220NZAFSEK)', 6, 1, 6999.00, 3, 5),
						('MatePad T10s (2nd Gen) 10.1" 4/128 Wi-Fi Deep Blue (53012NFA)', 6, 3, 8999.00, 1, 0),
						('iPad Pro 11" 128GB M2 Wi-Fi+4G Silver (MNYD3) 2022', 6, 2, 54999.00, 4, 2),
						('Навушники HD 350 BT (Black) 508384', 7, 7, 3279.00, 2, 7),
						('Навушники WH-XB910N (Blue) WHXB910NL.CE7', 7, 8, 8999.00, 3, 3),
						('Навушники (RP-HJE125E-K) Black', 7, 9, 369.00, 2, 6),
						('Саундбар SJ3', 8, 5, 7699.00, 1, 8),
						('Акустика SRS-XB13 (Beige) SRSXB13C.RU2', 8, 8, 2199.00, 4, 9),
						('Саундбар HW-Q800A/RU', 8, 1, 18999.00, 3, 2),
						('Чохол Uniq Terra Geniune Leather для AirPods Pine (Olive)', 9, 2, 399.00, 4, 27),
						('Чохол Araree (Clear) AR20-00571B для Galaxy Buds Plus', 9, 1, 299.00, 3, 12),
						('Чехол для наушников Buds 2 Water Resistant Cover', 9, 1, 849.00, 3, 1);

INSERT INTO Clients VALUES	('Kanye', 'West', 'hjekjnvu@gmail.com', '+380657485912'),
							('Adolph', 'Hitler', 'idefbfviuj@mail.com', '+380993477756'),
							('Rayan', 'Gosling', 'ijwbigi@gmail', '+380958765474'),
							('Adam', 'Ted', 'wkniwujbigb@mail.com', '+380746586743'),
							('Bruse', 'Benner', 'wpijeowbni@gmail.com', '+380955698747'),
							('Semen', 'Producer', 'ehgikrbn@mail.com', '+380660546985'),
							('Cum', 'Eater', 'wni9ugpdj@gmail.com', '+380502546985'),
							('Wander', 'Colt', 'wughib80@mail.com', '+380660985699'),
							('Joy', 'Boy', 'eiubuud88@gmail.com', '+380509866455');

INSERT INTO Orders VALUES	(1, '2022-12-11'),
							(2, '2022-11-12'),
							(3, '2022-10-13'),
							(4, '2022-09-14'),
							(5, '2022-08-15'),
							(6, '2022-07-16'),
							(7, '2022-06-17'),
							(8, '2022-05-18'),
							(9, '2022-04-19');

INSERT INTO Sells VALUES	(1, 7),
							(2, 1),
							(3, 12),
							(4, 4),
							(5, 1),
							(6, 12),
							(7, 41),
							(8, 2),
							(9, 12),
							(10, 42),
							(11, 12),
							(12, 51),
							(13, 42),
							(14, 12),
							(15, 42),
							(16, 62),
							(17, 1),
							(18, 21),
							(19, 11),
							(20, 3),
							(21, 31),
							(22, 4),
							(23, 1),
							(24, 2),
							(25, 3),
							(26, 1),
							(27, 2);

INSERT INTO SellsOrders VALUES	(1, 1),
								(2, 1),
								(3, 1),
								(4, 2),
								(5, 2),
								(6, 2),
								(7, 3),
								(8, 3),
								(9, 3),
								(10, 4),
								(11, 4),
								(12, 4),
								(13, 5),
								(14, 5),
								(15, 5),
								(17, 6),
								(18, 6),
								(19, 6),
								(20, 7),
								(21, 7),
								(22, 7),
								(23, 8),
								(24, 8),
								(25, 8),
								(26, 9),
								(27, 9),
								(16, 9);