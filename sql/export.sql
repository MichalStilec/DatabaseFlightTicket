USE [master]
GO
/****** Object:  Database [stilec2]    Script Date: 05.01.2024 17:44:35 ******/
CREATE DATABASE [stilec2]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'stilec2', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS2019\MSSQL\DATA\stilec2.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'stilec2_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS2019\MSSQL\DATA\stilec2_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [stilec2] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [stilec2].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [stilec2] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [stilec2] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [stilec2] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [stilec2] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [stilec2] SET ARITHABORT OFF 
GO
ALTER DATABASE [stilec2] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [stilec2] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [stilec2] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [stilec2] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [stilec2] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [stilec2] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [stilec2] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [stilec2] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [stilec2] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [stilec2] SET  ENABLE_BROKER 
GO
ALTER DATABASE [stilec2] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [stilec2] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [stilec2] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [stilec2] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [stilec2] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [stilec2] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [stilec2] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [stilec2] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [stilec2] SET  MULTI_USER 
GO
ALTER DATABASE [stilec2] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [stilec2] SET DB_CHAINING OFF 
GO
ALTER DATABASE [stilec2] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [stilec2] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [stilec2] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [stilec2] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [stilec2] SET QUERY_STORE = OFF
GO
USE [stilec2]
GO
/****** Object:  Table [dbo].[Letenka]    Script Date: 05.01.2024 17:44:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Letenka](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Let_ID] [int] NOT NULL,
	[Cena] [int] NOT NULL,
	[Sedadlo] [varchar](20) NOT NULL,
	[Brana_odletu] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rezervace]    Script Date: 05.01.2024 17:44:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rezervace](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Cestujici_ID] [int] NOT NULL,
	[Letenka_ID] [int] NOT NULL,
	[Datum_rezervace] [date] NOT NULL,
	[Stav_rezervace] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cestujici]    Script Date: 05.01.2024 17:44:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cestujici](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Jmeno] [varchar](30) NOT NULL,
	[Prijmeni] [varchar](30) NOT NULL,
	[Datum_nar] [date] NOT NULL,
	[Adresa] [varchar](60) NOT NULL,
	[Telefon] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Let]    Script Date: 05.01.2024 17:44:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Let](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Destinace_Od_ID] [int] NOT NULL,
	[Destinace_Do_ID] [int] NOT NULL,
	[Letadlo_ID] [int] NOT NULL,
	[Nazev_letu] [varchar](40) NOT NULL,
	[Datum_odletu] [datetime] NOT NULL,
	[Datum_priletu] [datetime] NOT NULL,
	[Cas_nastoupeni_do] [time](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[FlightReservationView]    Script Date: 05.01.2024 17:44:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[FlightReservationView]
AS
SELECT 
    R.ID AS ReservationID,
    C.Jmeno,
    C.Prijmeni,
    L.Nazev_letu,
    L.Datum_odletu,
    L.Datum_priletu,
    LT.Sedadlo,
    LT.Brana_odletu,
    R.Datum_rezervace,
    R.Stav_rezervace
FROM Rezervace R
INNER JOIN Cestujici C ON R.Cestujici_ID = C.ID
INNER JOIN Letenka LT ON R.Letenka_ID = LT.ID
INNER JOIN Let L ON LT.Let_ID = L.ID;
GO
/****** Object:  Table [dbo].[Destinace]    Script Date: 05.01.2024 17:44:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Destinace](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Stat] [varchar](50) NOT NULL,
	[Mesto] [varchar](50) NOT NULL,
	[Letiste] [varchar](50) NOT NULL,
	[GPS] [varchar](100) NOT NULL,
	[Popis] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Letadlo]    Script Date: 05.01.2024 17:44:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Letadlo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Typ_letadla] [varchar](30) NULL,
	[Kapacita_cestujich] [int] NOT NULL,
	[Maximalni_dolet_km] [int] NOT NULL,
	[Velikost_nadrze_l] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Cestujici] ON 
GO
INSERT [dbo].[Cestujici] ([ID], [Jmeno], [Prijmeni], [Datum_nar], [Adresa], [Telefon]) VALUES (1, N'John', N'Doe', CAST(N'1990-05-15' AS Date), N'123 Main St, City', N'555-1234')
GO
INSERT [dbo].[Cestujici] ([ID], [Jmeno], [Prijmeni], [Datum_nar], [Adresa], [Telefon]) VALUES (2, N'Jane', N'Smith', CAST(N'1985-08-22' AS Date), N'456 Oak St, Town', N'555-5678')
GO
INSERT [dbo].[Cestujici] ([ID], [Jmeno], [Prijmeni], [Datum_nar], [Adresa], [Telefon]) VALUES (3, N'Bob', N'Johnson', CAST(N'1992-12-10' AS Date), N'789 Pine St, Village', N'555-9876')
GO
INSERT [dbo].[Cestujici] ([ID], [Jmeno], [Prijmeni], [Datum_nar], [Adresa], [Telefon]) VALUES (4, N'Alice', N'Williams', CAST(N'1988-03-25' AS Date), N'101 Elm St, Suburb', N'555-3456')
GO
INSERT [dbo].[Cestujici] ([ID], [Jmeno], [Prijmeni], [Datum_nar], [Adresa], [Telefon]) VALUES (5, N'Charlie', N'Brown', CAST(N'1995-06-18' AS Date), N'202 Maple St, Metro', N'555-6789')
GO
INSERT [dbo].[Cestujici] ([ID], [Jmeno], [Prijmeni], [Datum_nar], [Adresa], [Telefon]) VALUES (6, N'Eva', N'Davis', CAST(N'1983-09-30' AS Date), N'303 Birch St, City', N'555-2345')
GO
INSERT [dbo].[Cestujici] ([ID], [Jmeno], [Prijmeni], [Datum_nar], [Adresa], [Telefon]) VALUES (7, N'Sam', N'Taylor', CAST(N'1998-02-05' AS Date), N'404 Cedar St, Town', N'555-8765')
GO
INSERT [dbo].[Cestujici] ([ID], [Jmeno], [Prijmeni], [Datum_nar], [Adresa], [Telefon]) VALUES (8, N'Olivia', N'Miller', CAST(N'1980-11-12' AS Date), N'505 Spruce St, Village', N'555-5432')
GO
INSERT [dbo].[Cestujici] ([ID], [Jmeno], [Prijmeni], [Datum_nar], [Adresa], [Telefon]) VALUES (9, N'John', N'Nuts', CAST(N'1990-01-01' AS Date), N'123 Main St', N'555-1234')
GO
SET IDENTITY_INSERT [dbo].[Cestujici] OFF
GO
SET IDENTITY_INSERT [dbo].[Destinace] ON 
GO
INSERT [dbo].[Destinace] ([ID], [Stat], [Mesto], [Letiste], [GPS], [Popis]) VALUES (1, N'USA', N'New York', N'JFK Airport', N'40.6413° N, 73.7781° W', N'The city that never sleeps')
GO
INSERT [dbo].[Destinace] ([ID], [Stat], [Mesto], [Letiste], [GPS], [Popis]) VALUES (2, N'France', N'Paris', N'Charles de Gaulle Airport', N'49.0097° N, 2.5479° E', N'The city of love')
GO
INSERT [dbo].[Destinace] ([ID], [Stat], [Mesto], [Letiste], [GPS], [Popis]) VALUES (3, N'Japan', N'Tokyo', N'Narita International Airport', N'35.7730° N, 140.3929° E', N'A mix of tradition and modernity')
GO
INSERT [dbo].[Destinace] ([ID], [Stat], [Mesto], [Letiste], [GPS], [Popis]) VALUES (4, N'Australia', N'Sydney', N'Sydney Airport', N'33.9399° S, 151.1753° E', N'Iconic landmarks and beautiful beaches')
GO
INSERT [dbo].[Destinace] ([ID], [Stat], [Mesto], [Letiste], [GPS], [Popis]) VALUES (5, N'Brazil', N'Rio de Janeiro', N'Galeao International Airport', N'22.8134° S, 43.2489° W', N'Carnival and stunning landscapes')
GO
INSERT [dbo].[Destinace] ([ID], [Stat], [Mesto], [Letiste], [GPS], [Popis]) VALUES (6, N'Germany', N'Berlin', N'Berlin Brandenburg Airport', N'52.3667° N, 13.5033° E', N'Rich history and vibrant culture')
GO
INSERT [dbo].[Destinace] ([ID], [Stat], [Mesto], [Letiste], [GPS], [Popis]) VALUES (7, N'China', N'Beijing', N'Beijing International Airport', N'40.0799° N, 116.6031° E', N'The Great Wall and Forbidden City')
GO
INSERT [dbo].[Destinace] ([ID], [Stat], [Mesto], [Letiste], [GPS], [Popis]) VALUES (8, N'Canada', N'Vancouver', N'Vancouver Airport', N'49.2827° N, 123.1207° W', N'Scenic beauty and outdoor activities')
GO
SET IDENTITY_INSERT [dbo].[Destinace] OFF
GO
SET IDENTITY_INSERT [dbo].[Let] ON 
GO
INSERT [dbo].[Let] ([ID], [Destinace_Od_ID], [Destinace_Do_ID], [Letadlo_ID], [Nazev_letu], [Datum_odletu], [Datum_priletu], [Cas_nastoupeni_do]) VALUES (1, 1, 3, 2, N'NY-Tokyo', CAST(N'2024-01-10T08:00:00.000' AS DateTime), CAST(N'2024-01-10T18:00:00.000' AS DateTime), CAST(N'07:00:00' AS Time))
GO
INSERT [dbo].[Let] ([ID], [Destinace_Od_ID], [Destinace_Do_ID], [Letadlo_ID], [Nazev_letu], [Datum_odletu], [Datum_priletu], [Cas_nastoupeni_do]) VALUES (2, 2, 5, 4, N'Paris-Rio', CAST(N'2024-02-15T12:30:00.000' AS DateTime), CAST(N'2024-02-15T22:30:00.000' AS DateTime), CAST(N'11:30:00' AS Time))
GO
INSERT [dbo].[Let] ([ID], [Destinace_Od_ID], [Destinace_Do_ID], [Letadlo_ID], [Nazev_letu], [Datum_odletu], [Datum_priletu], [Cas_nastoupeni_do]) VALUES (3, 3, 7, 6, N'Tokyo-Berlin', CAST(N'2024-03-20T16:45:00.000' AS DateTime), CAST(N'2024-03-20T23:45:00.000' AS DateTime), CAST(N'15:45:00' AS Time))
GO
INSERT [dbo].[Let] ([ID], [Destinace_Od_ID], [Destinace_Do_ID], [Letadlo_ID], [Nazev_letu], [Datum_odletu], [Datum_priletu], [Cas_nastoupeni_do]) VALUES (4, 4, 1, 1, N'Sydney-NY', CAST(N'2024-04-25T20:15:00.000' AS DateTime), CAST(N'2024-04-26T06:15:00.000' AS DateTime), CAST(N'19:15:00' AS Time))
GO
INSERT [dbo].[Let] ([ID], [Destinace_Od_ID], [Destinace_Do_ID], [Letadlo_ID], [Nazev_letu], [Datum_odletu], [Datum_priletu], [Cas_nastoupeni_do]) VALUES (5, 5, 4, 3, N'Rio-Sydney', CAST(N'2024-05-30T03:30:00.000' AS DateTime), CAST(N'2024-05-30T14:30:00.000' AS DateTime), CAST(N'02:30:00' AS Time))
GO
INSERT [dbo].[Let] ([ID], [Destinace_Od_ID], [Destinace_Do_ID], [Letadlo_ID], [Nazev_letu], [Datum_odletu], [Datum_priletu], [Cas_nastoupeni_do]) VALUES (6, 6, 2, 5, N'Berlin-Paris', CAST(N'2024-07-05T07:00:00.000' AS DateTime), CAST(N'2024-07-05T14:00:00.000' AS DateTime), CAST(N'06:00:00' AS Time))
GO
INSERT [dbo].[Let] ([ID], [Destinace_Od_ID], [Destinace_Do_ID], [Letadlo_ID], [Nazev_letu], [Datum_odletu], [Datum_priletu], [Cas_nastoupeni_do]) VALUES (7, 7, 8, 3, N'Beijing-Vancouver', CAST(N'2024-08-10T10:45:00.000' AS DateTime), CAST(N'2024-08-10T21:45:00.000' AS DateTime), CAST(N'09:45:00' AS Time))
GO
INSERT [dbo].[Let] ([ID], [Destinace_Od_ID], [Destinace_Do_ID], [Letadlo_ID], [Nazev_letu], [Datum_odletu], [Datum_priletu], [Cas_nastoupeni_do]) VALUES (8, 8, 6, 1, N'Vancouver-Beijing', CAST(N'2024-09-15T14:30:00.000' AS DateTime), CAST(N'2024-09-15T23:30:00.000' AS DateTime), CAST(N'13:30:00' AS Time))
GO
INSERT [dbo].[Let] ([ID], [Destinace_Od_ID], [Destinace_Do_ID], [Letadlo_ID], [Nazev_letu], [Datum_odletu], [Datum_priletu], [Cas_nastoupeni_do]) VALUES (9, 1, 2, 1, N'Flight to Paris', CAST(N'2024-01-01T12:00:00.000' AS DateTime), CAST(N'2024-01-01T15:00:00.000' AS DateTime), CAST(N'12:00:00' AS Time))
GO
SET IDENTITY_INSERT [dbo].[Let] OFF
GO
SET IDENTITY_INSERT [dbo].[Letadlo] ON 
GO
INSERT [dbo].[Letadlo] ([ID], [Typ_letadla], [Kapacita_cestujich], [Maximalni_dolet_km], [Velikost_nadrze_l]) VALUES (1, N'Dopravni', 150, 10000, 50000)
GO
INSERT [dbo].[Letadlo] ([ID], [Typ_letadla], [Kapacita_cestujich], [Maximalni_dolet_km], [Velikost_nadrze_l]) VALUES (2, N'Dopravni', 80, 20000, 65000)
GO
INSERT [dbo].[Letadlo] ([ID], [Typ_letadla], [Kapacita_cestujich], [Maximalni_dolet_km], [Velikost_nadrze_l]) VALUES (3, N'Vojenske', 30, 8000, 30000)
GO
INSERT [dbo].[Letadlo] ([ID], [Typ_letadla], [Kapacita_cestujich], [Maximalni_dolet_km], [Velikost_nadrze_l]) VALUES (4, N'Dopravni', 70, 12000, 40000)
GO
INSERT [dbo].[Letadlo] ([ID], [Typ_letadla], [Kapacita_cestujich], [Maximalni_dolet_km], [Velikost_nadrze_l]) VALUES (5, N'Privatni', 8, 3000, 15000)
GO
INSERT [dbo].[Letadlo] ([ID], [Typ_letadla], [Kapacita_cestujich], [Maximalni_dolet_km], [Velikost_nadrze_l]) VALUES (6, N'Dopravni', 200, 15000, 80000)
GO
SET IDENTITY_INSERT [dbo].[Letadlo] OFF
GO
SET IDENTITY_INSERT [dbo].[Letenka] ON 
GO
INSERT [dbo].[Letenka] ([ID], [Let_ID], [Cena], [Sedadlo], [Brana_odletu]) VALUES (1, 1, 1200, N'A12', N'Gate 1')
GO
INSERT [dbo].[Letenka] ([ID], [Let_ID], [Cena], [Sedadlo], [Brana_odletu]) VALUES (2, 2, 1500, N'B22', N'Gate 2')
GO
INSERT [dbo].[Letenka] ([ID], [Let_ID], [Cena], [Sedadlo], [Brana_odletu]) VALUES (3, 3, 900, N'C15', N'Gate 3')
GO
INSERT [dbo].[Letenka] ([ID], [Let_ID], [Cena], [Sedadlo], [Brana_odletu]) VALUES (4, 4, 1800, N'D09', N'Gate 4')
GO
INSERT [dbo].[Letenka] ([ID], [Let_ID], [Cena], [Sedadlo], [Brana_odletu]) VALUES (5, 5, 1200, N'E18', N'Gate 5')
GO
INSERT [dbo].[Letenka] ([ID], [Let_ID], [Cena], [Sedadlo], [Brana_odletu]) VALUES (6, 6, 1000, N'F25', N'Gate 6')
GO
INSERT [dbo].[Letenka] ([ID], [Let_ID], [Cena], [Sedadlo], [Brana_odletu]) VALUES (7, 7, 2000, N'G07', N'Gate 7')
GO
INSERT [dbo].[Letenka] ([ID], [Let_ID], [Cena], [Sedadlo], [Brana_odletu]) VALUES (8, 8, 1700, N'H14', N'Gate 8')
GO
INSERT [dbo].[Letenka] ([ID], [Let_ID], [Cena], [Sedadlo], [Brana_odletu]) VALUES (9, 9, 500, N'A12', N'Gate 1')
GO
SET IDENTITY_INSERT [dbo].[Letenka] OFF
GO
SET IDENTITY_INSERT [dbo].[Rezervace] ON 
GO
INSERT [dbo].[Rezervace] ([ID], [Cestujici_ID], [Letenka_ID], [Datum_rezervace], [Stav_rezervace]) VALUES (1, 1, 1, CAST(N'2024-01-05' AS Date), N'Confirmed')
GO
INSERT [dbo].[Rezervace] ([ID], [Cestujici_ID], [Letenka_ID], [Datum_rezervace], [Stav_rezervace]) VALUES (2, 2, 3, CAST(N'2024-02-18' AS Date), N'Pending')
GO
INSERT [dbo].[Rezervace] ([ID], [Cestujici_ID], [Letenka_ID], [Datum_rezervace], [Stav_rezervace]) VALUES (3, 3, 5, CAST(N'2024-03-25' AS Date), N'Confirmed')
GO
INSERT [dbo].[Rezervace] ([ID], [Cestujici_ID], [Letenka_ID], [Datum_rezervace], [Stav_rezervace]) VALUES (4, 4, 7, CAST(N'2024-04-30' AS Date), N'Pending')
GO
INSERT [dbo].[Rezervace] ([ID], [Cestujici_ID], [Letenka_ID], [Datum_rezervace], [Stav_rezervace]) VALUES (5, 5, 2, CAST(N'2024-06-10' AS Date), N'Rejected')
GO
INSERT [dbo].[Rezervace] ([ID], [Cestujici_ID], [Letenka_ID], [Datum_rezervace], [Stav_rezervace]) VALUES (6, 6, 4, CAST(N'2024-07-15' AS Date), N'Confirmed')
GO
INSERT [dbo].[Rezervace] ([ID], [Cestujici_ID], [Letenka_ID], [Datum_rezervace], [Stav_rezervace]) VALUES (7, 7, 6, CAST(N'2024-08-20' AS Date), N'Pending')
GO
INSERT [dbo].[Rezervace] ([ID], [Cestujici_ID], [Letenka_ID], [Datum_rezervace], [Stav_rezervace]) VALUES (8, 8, 8, CAST(N'2024-09-25' AS Date), N'Confirmed')
GO
INSERT [dbo].[Rezervace] ([ID], [Cestujici_ID], [Letenka_ID], [Datum_rezervace], [Stav_rezervace]) VALUES (9, 5, 3, CAST(N'2024-05-07' AS Date), N'Confirmed')
GO
INSERT [dbo].[Rezervace] ([ID], [Cestujici_ID], [Letenka_ID], [Datum_rezervace], [Stav_rezervace]) VALUES (10, 9, 9, CAST(N'2024-01-02' AS Date), N'Confirmed')
GO
SET IDENTITY_INSERT [dbo].[Rezervace] OFF
GO
/****** Object:  Index [LetOdDo_ID]    Script Date: 05.01.2024 17:44:36 ******/
CREATE NONCLUSTERED INDEX [LetOdDo_ID] ON [dbo].[Let]
(
	[Destinace_Od_ID] ASC,
	[Destinace_Do_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [RezervaceCestujiciho_ID]    Script Date: 05.01.2024 17:44:36 ******/
CREATE NONCLUSTERED INDEX [RezervaceCestujiciho_ID] ON [dbo].[Rezervace]
(
	[Cestujici_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Letadlo] ADD  DEFAULT ('Dopravni') FOR [Typ_letadla]
GO
ALTER TABLE [dbo].[Let]  WITH CHECK ADD FOREIGN KEY([Destinace_Do_ID])
REFERENCES [dbo].[Destinace] ([ID])
GO
ALTER TABLE [dbo].[Let]  WITH CHECK ADD FOREIGN KEY([Destinace_Od_ID])
REFERENCES [dbo].[Destinace] ([ID])
GO
ALTER TABLE [dbo].[Let]  WITH CHECK ADD FOREIGN KEY([Letadlo_ID])
REFERENCES [dbo].[Letadlo] ([ID])
GO
ALTER TABLE [dbo].[Letenka]  WITH CHECK ADD FOREIGN KEY([Let_ID])
REFERENCES [dbo].[Let] ([ID])
GO
ALTER TABLE [dbo].[Rezervace]  WITH CHECK ADD FOREIGN KEY([Cestujici_ID])
REFERENCES [dbo].[Cestujici] ([ID])
GO
ALTER TABLE [dbo].[Rezervace]  WITH CHECK ADD FOREIGN KEY([Letenka_ID])
REFERENCES [dbo].[Letenka] ([ID])
GO
ALTER TABLE [dbo].[Cestujici]  WITH CHECK ADD CHECK  ((len([Jmeno])>(2)))
GO
ALTER TABLE [dbo].[Cestujici]  WITH CHECK ADD CHECK  ((len([Prijmeni])>(2)))
GO
ALTER TABLE [dbo].[Destinace]  WITH CHECK ADD CHECK  ((len([Letiste])>(2)))
GO
ALTER TABLE [dbo].[Destinace]  WITH CHECK ADD CHECK  ((len([Mesto])>(2)))
GO
ALTER TABLE [dbo].[Destinace]  WITH CHECK ADD CHECK  ((len([Stat])>(2)))
GO
ALTER TABLE [dbo].[Letenka]  WITH CHECK ADD CHECK  (([cena]>(0)))
GO
/****** Object:  StoredProcedure [dbo].[GetReservationDetails]    Script Date: 05.01.2024 17:44:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetReservationDetails]
    @ReservationID int
AS
BEGIN
    SELECT 
        R.ID AS ReservationID,
        C.Jmeno,
        C.Prijmeni,
        L.Nazev_letu,
        L.Datum_odletu,
        L.Datum_priletu,
        L.Letadlo_ID
    FROM Rezervace R
    INNER JOIN Cestujici C ON R.Cestujici_ID = C.ID
    INNER JOIN Letenka LT ON R.Letenka_ID = LT.ID
    INNER JOIN Let L ON LT.Let_ID = L.ID
    WHERE R.ID = @ReservationID;
END;
GO
/****** Object:  Trigger [dbo].[UpdateReservationStatus]    Script Date: 05.01.2024 17:44:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[UpdateReservationStatus]
ON [dbo].[Rezervace]
AFTER INSERT
AS
BEGIN
    UPDATE R
    SET Stav_rezervace = 'Confirmed'
    FROM Rezervace R
    INNER JOIN inserted I ON R.ID = I.ID;
END;
GO
ALTER TABLE [dbo].[Rezervace] ENABLE TRIGGER [UpdateReservationStatus]
GO
USE [master]
GO
ALTER DATABASE [stilec2] SET  READ_WRITE 
GO
