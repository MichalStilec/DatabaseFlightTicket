use stilec2;

INSERT INTO Cestujici (Jmeno, Prijmeni, Datum_nar, Adresa, Telefon)
VALUES 
('John', 'Doe', '1990-05-15', '123 Main St, City', '555-1234'),
('Jane', 'Smith', '1985-08-22', '456 Oak St, Town', '555-5678'),
('Bob', 'Johnson', '1992-12-10', '789 Pine St, Village', '555-9876'),
('Alice', 'Williams', '1988-03-25', '101 Elm St, Suburb', '555-3456'),
('Charlie', 'Brown', '1995-06-18', '202 Maple St, Metro', '555-6789'),
('Eva', 'Davis', '1983-09-30', '303 Birch St, City', '555-2345'),
('Sam', 'Taylor', '1998-02-05', '404 Cedar St, Town', '555-8765'),
('Olivia', 'Miller', '1980-11-12', '505 Spruce St, Village', '555-5432');

select * from Cestujici;


INSERT INTO Letadlo (Typ_letadla, Kapacita_cestujich, Maximalni_dolet_km, Velikost_nadrze_l)
VALUES 
('Dopravni', 150, 10000, 50000),
('Dopravni', 80, 20000, 65000),
('Vojenske', 30, 8000, 30000),
('Dopravni', 70, 12000, 40000),
('Privatni', 8, 3000, 15000),
('Dopravni', 200, 15000, 80000);

select * from Letadlo;


INSERT INTO Destinace (Stat, Mesto, Letiste, GPS, Popis)
VALUES 
('USA', 'New York', 'JFK Airport', '40.6413° N, 73.7781° W', 'The city that never sleeps'),
('France', 'Paris', 'Charles de Gaulle Airport', '49.0097° N, 2.5479° E', 'The city of love'),
('Japan', 'Tokyo', 'Narita International Airport', '35.7730° N, 140.3929° E', 'A mix of tradition and modernity'),
('Australia', 'Sydney', 'Sydney Airport', '33.9399° S, 151.1753° E', 'Iconic landmarks and beautiful beaches'),
('Brazil', 'Rio de Janeiro', 'Galeão International Airport', '22.8134° S, 43.2489° W', 'Carnival and stunning landscapes'),
('Germany', 'Berlin', 'Berlin Brandenburg Airport', '52.3667° N, 13.5033° E', 'Rich history and vibrant culture'),
('China', 'Beijing', 'Beijing International Airport', '40.0799° N, 116.6031° E', 'The Great Wall and Forbidden City'),
('Canada', 'Vancouver', 'Vancouver Airport', '49.2827° N, 123.1207° W', 'Scenic beauty and outdoor activities');

select * from Destinace;


INSERT INTO Let (Destinace_Od_ID, Destinace_Do_ID, Letadlo_ID, Nazev_letu, Datum_odletu, Datum_priletu, Cas_nastoupeni_do)
VALUES 
(1, 3, 2, 'NY-Tokyo', '2024-01-10 08:00:00', '2024-01-10 18:00:00', '07:00:00'),
(2, 5, 4, 'Paris-Rio', '2024-02-15 12:30:00', '2024-02-15 22:30:00', '11:30:00'),
(3, 7, 6, 'Tokyo-Berlin', '2024-03-20 16:45:00', '2024-03-20 23:45:00', '15:45:00'),
(4, 1, 1, 'Sydney-NY', '2024-04-25 20:15:00', '2024-04-26 06:15:00', '19:15:00'),
(5, 4, 3, 'Rio-Sydney', '2024-05-30 03:30:00', '2024-05-30 14:30:00', '02:30:00'),
(6, 2, 5, 'Berlin-Paris', '2024-07-05 07:00:00', '2024-07-05 14:00:00', '06:00:00'),
(7, 8, 3, 'Beijing-Vancouver', '2024-08-10 10:45:00', '2024-08-10 21:45:00', '09:45:00'),
(8, 6, 1, 'Vancouver-Beijing', '2024-09-15 14:30:00', '2024-09-15 23:30:00', '13:30:00');

select * from Let;


INSERT INTO Letenka (Let_ID, Cena, Sedadlo, Brana_odletu)
VALUES 
(1, 1200, 'A12', 'Gate 1'),
(2, 1500, 'B22', 'Gate 2'),
(3, 900, 'C15', 'Gate 3'),
(4, 1800, 'D09', 'Gate 4'),
(5, 1200, 'E18', 'Gate 5'),
(6, 1000, 'F25', 'Gate 6'),
(7, 2000, 'G07', 'Gate 7'),
(8, 1700, 'H14', 'Gate 8');

select * from Letenka;


INSERT INTO Rezervace (Cestujici_ID, Letenka_ID, Datum_rezervace, Stav_rezervace)
VALUES 
(1, 1, '2024-01-05', 'Confirmed'),
(2, 3, '2024-02-18', 'Pending'),
(3, 5, '2024-03-25', 'Confirmed'),
(4, 7, '2024-04-30', 'Pending'),
(5, 2, '2024-06-10', 'Rejected'),
(6, 4, '2024-07-15', 'Confirmed'),
(7, 6, '2024-08-20', 'Pending'),
(8, 8, '2024-09-25', 'Confirmed');

select * from Rezervace;