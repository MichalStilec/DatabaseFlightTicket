use stilec2;

create table Cestujici(
ID int identity(1,1) primary key,
Jmeno varchar(30) NOT NULL CHECK (LEN(Jmeno) > 2),
Prijmeni varchar(30) NOT NULL CHECK (LEN(Prijmeni) > 2),
Datum_nar date NOT NULL,
Adresa varchar(60) NOT NULL,
Telefon varchar(20) NOT NULL
);

create table Letadlo(
ID int identity(1,1) primary key,
Typ_letadla varchar(30) DEFAULT 'Dopravni',
Kapacita_cestujich int NOT NULL,
Maximalni_dolet_km int NOT NULL,
Velikost_nadrze_l int NOT NULL
);

create table Destinace(
ID int identity(1,1) primary key,
Stat varchar(50) NOT NULL CHECK (LEN(Stat) > 2),
Mesto varchar(50) NOT NULL CHECK (LEN(Mesto) > 2),
Letiste varchar(50) NOT NULL CHECK (LEN(Letiste) > 2),
GPS varchar(100) NOT NULL,
Popis varchar(200) 
);

create table Let(
ID int identity(1,1) primary key,
Destinace_Od_ID int NOT NULL,
foreign key (Destinace_Od_ID) references Destinace(ID),
Destinace_Do_ID int NOT NULL,
foreign key (Destinace_Do_ID) references Destinace(ID),
Letadlo_ID int NOT NULL,
foreign key (Letadlo_ID) references Letadlo(ID),
Nazev_letu varchar(40) NOT NULL,
Datum_odletu datetime NOT NULL,
Datum_priletu datetime NOT NULL,
Cas_nastoupeni_do time NOT NULL
);

create table Letenka(
ID int identity(1,1) primary key,
Let_ID int NOT NULL,
foreign key (Let_ID) references Let(ID),
Cena int NOT NULL check(cena > 0),
Sedadlo varchar(20) NOT NULL,
Brana_odletu varchar(20) NOT NULL
);

create table Rezervace(
ID int identity(1,1) primary key,
Cestujici_ID int NOT NULL,
foreign key (Cestujici_ID) references Cestujici(ID),
Letenka_ID int NOT NULL,
foreign key (Letenka_ID) references Letenka(ID),
Datum_rezervace date NOT NULL,
Stav_rezervace varchar(20) NOT NULL
);


-- načte informace o konkrétní rezervaci letu spolu s údaji o cestujícím
CREATE PROCEDURE GetReservationDetails
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

EXEC GetReservationDetails 1;



-- automaticky aktualizuje stav rezervace při přidání nové rezervace
CREATE TRIGGER UpdateReservationStatus
ON Rezervace
AFTER INSERT
AS
BEGIN
    UPDATE R
    SET Stav_rezervace = 'Confirmed'
    FROM Rezervace R
    INNER JOIN inserted I ON R.ID = I.ID;
END;

insert into Rezervace(Cestujici_ID, Letenka_ID, Datum_rezervace, Stav_rezervace) values(5, 3, '2024-05-07', 'Pending');
select * from Rezervace;



-- kombinuje informace o letech, cestujících a rezervacích
CREATE VIEW FlightReservationView
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

SELECT * FROM FlightReservationView;



BEGIN TRY
    BEGIN TRANSACTION;

    -- Vložení nového cestujícího do tabulky Cestujici
    INSERT INTO Cestujici (Jmeno, Prijmeni, Datum_nar, Adresa, Telefon)
    VALUES ('John', 'Nuts', '1990-01-01', '123 Main St', '555-1234');

    -- Vložení nového letu do tabulky Let
    INSERT INTO Let (Destinace_Od_ID, Destinace_Do_ID, Letadlo_ID, Nazev_letu, Datum_odletu, Datum_priletu, Cas_nastoupeni_do)
    VALUES (1, 2, 1, 'Flight to Paris', '2024-01-01 12:00:00', '2024-01-01 15:00:00', '12:00:00');

    -- Vložení nové rezervace letenky do tabulky Rezervace
    DECLARE @CestujiciID int, @LetID int, @LetenkaID int;

    SELECT @CestujiciID = SCOPE_IDENTITY();
    SELECT @LetID = SCOPE_IDENTITY();

    INSERT INTO Letenka (Let_ID, Cena, Sedadlo, Brana_odletu)
    VALUES (@LetID, 500, 'A12', 'Gate 1');

    SELECT @LetenkaID = SCOPE_IDENTITY();

    INSERT INTO Rezervace (Cestujici_ID, Letenka_ID, Datum_rezervace, Stav_rezervace)
    VALUES (@CestujiciID, @LetenkaID, GETDATE(), 'Pending');

    COMMIT;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK;

    PRINT 'Nekde se stala chyba, transakce se rusi';
END CATCH;


-- Tento index může zrychlit dotazy, které vyhledávají rezervace na základě identifikátoru cestujícího
CREATE INDEX idx_Rezervace_Cestujici_ID ON Rezervace (Cestujici_ID);

-- Tento index může zrychlit dotazy, které vyhledávají lety podle odjezdu a příjezdu.
CREATE INDEX idx_Let_Destinace ON Let (Destinace_Od_ID, Destinace_Do_ID);



-- Vypíše jméno a příjmení cestujících seřazených abecedně od konce
Select Jmeno, Prijmeni from Cestujici order by Prijmeni desc;

-- Vypíše všechny informace o letenkách, které jsou dražší než 1200
Select * from Letenka where Cena > 1200;

-- Spočítá počet vytvořených cestujících
Select COUNT(*) as TotalCestujici from Cestujici;

-- Ukáže všechny cestující a počet jejich rezervací 
SELECT Jmeno, Prijmeni, SUM(1) AS TotalReservations
FROM Cestujici
JOIN Rezervace ON Cestujici.ID = Rezervace.Cestujici_ID
GROUP BY Jmeno, Prijmeni;

-- Najde největší cenu letenky
SELECT MAX(Cena) AS MaxTicketPrice
FROM Letenka;

-- Najde letadlo s nejmenším počtem kapacity pro cestující
SELECT MIN(Kapacita_cestujich) AS MinAvailableSeats
FROM Letadlo;

-- Spočítá průměrnou cenu letenek
SELECT AVG(Cena) AS AverageTicketPrice
FROM Letenka;
