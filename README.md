# Praktická maturitní zkouška

**Střední průmyslová škola elektrotechnická, Praha 2, Ječná 30**
**Školní rok 2023/2024**
---
Jméno a příjimeni: Michal Štilec
Třída: C4b
---


## Úvod
- Problém jsem se rozhodl řešit v MSSQL Server
- Jako návrhové prostředí jsem využil Oracle DataModeler



## E-R model
- logický model databáze se nachází ve složce img a jmenuje se Logical.png
- relační model databáze se také nachází ve složce img a jmenuje se Relational.png



## Entitní integrita
- Každá entita obsahuje uměle vytvořený primární klíč, označený jako `ID`,  který se s každým dalším záznamem inkrementuje.
- ID se následně používá pro efektivní vyhledávání dat, a  pro jedinečnost záznamu.



## Doménová integrita
### Cestujici:
- Jmeno: Atribut nesmí být bez hodnoty, omezeno minimální délkou 3 znaky, maximální délka 30 znaků, datový typ varchar (libovolný znaky).
- Prijmeni: Atribut nesmí být bez hodnoty, omezeno minimální délkou 3 znaky, maximální délka 30 znaků, datový typ varchar (libovolný znaky).
- Datum_nar: Atribut nesmí být bez hodnoty, datový typ date, formát 'yyyy-mm-dd'
- Adresa: Atribut nesmí být bez hodnoty, maximální délka 60 znaků, datový typ varchar (libovolný znaky).
- Telefon: Atribut nesmí být bez hodnoty, maximální délka 20 znaků, datový typ varchar (libovolný znaky).

### Letadlo:
- Typ_letadla: Výchozí hodnota nastavena na 'Dopravni', datový typ varchar (libovolný znaky).
- Kapacita_cestujich: Atribut nesmí být bez hodnoty, datový typ int (pouze celá čísla).
- Maximalni_dolet_km: Atribut nesmí být bez hodnoty, datový typ int (pouze celá čísla).
- Velikost_nadrze_l: Atribut nesmí být bez hodnoty, datový typ int (pouze celá čísla).

### Destinace:
- Stat, Mesto, Letiste: Omezeny minimální délkou 3 znaky.
- GPS: Atribut nesmí být bez hodnoty
- Popis: Atribut nesmí být bez hodnoty

### Let:
- Nazev_letu: Atribut nesmí být bez hodnoty, maximální délka 40 znaků, datový typ varchar (libovolný znaky).
- Datum_odletu, Datum_priletu: Atribut nesmí být bez hodnoty, datový typ datetime, formát 'yyyy-mm-dd hh-mm-ss'.
- Cas_nastoupeni_do: Atribut nesmí být bez hodnoty, datový typ time, formát 'hh-mm-ss'.

### Letenka:
- Cena: Atribut nesmí být bez hodnoty, cena je kontrolována aby byla vždy větší než 0, datový typ int (pouze celá čísla).
- Sedadlo, Brana_odletu: Atribut nesmí být bez hodnoty, maximální délka 20 znaků, datový typ varchar (libovolný znaky).

### Rezervace:
- Datum_rezervace: Atribut nesmí být bez hodnoty, datový typ date, formát 'yyyy-mm-dd'
- Stav_rezervace: Atribut nesmí být bez hodnoty, maximální délka 20 znaků, datový typ varchar (libovolný znaky).



## Referenční integrita
#### Návrh obsahuje několik cizích klíčů, které jsou uvedeny níže
### Rezervace:
- Cestujici_ID: Cizí klíč odkazující na tabulku Cestujici, atribut nesmí být bez hodnoty.
- Letenka_ID: Cizí klíč odkazující na tabulku Letenka, atribut nesmí být bez hodnoty.

### Letenka:
- Let_ID: Cizí klíč odkazující na tabulku Let, atribut nesmí být bez hodnoty.

### Let:
- Destinace_Od_ID: Cizí klíč odkazující na tabulku Destinace, atribut nesmí být bez hodnoty.
- Destinace_Do_ID: Cizí klíč odkazující na tabulku Destinace, atribut nesmí být bez hodnoty.
- Letadlo_ID: Cizí klíč odkazující na tabulku Letadlo, atribut nesmí být bez hodnoty.



## Indexy 
- Databáze má pro každou entitu pouze indexy vytvořené pro primární klíče.



## Pohledy
- Návrh obsahuje pohledy na data o rezervacích a letech, které spojují informace o letech, cestujících a rezervacích. Pohled FlightReservationView kombinuje informace o letech, cestujících a rezervacích.



## Triggery
- Databáze obsahuje trigger UpdateReservationStatus, který automaticky aktualizuje stav rezervace na 'Confirmed' po přidání nové rezervace.



## Procedury
- Databáze obsahuje proceduru GetReservationDetails, která načítá informace o konkrétní rezervaci letu spolu s údaji o cestujícím.



## Transakce
- Databáze obsahuje transakci, která vloží nového cestujícího, nový let a novou rezervaci letenky do tabulek Cestujici, Let, Letenka, a Rezervace. Transakce zahrnuje kontrolu chyb a provádí rollback v případě chyby.



## Import struktury databáze a dat od zadavatele
- Nejprve je nutno si vytvořit novou databázi, čistou, bez jakýchkoliv dat
- Poté do této databáze nahrát soubor, který se nachází v /sql/structure.sql
- Pokud si přejete načíst do databáze testovací data, je nutno nahrát ještě soubor /sql/data.sql 



## Klientská aplikace
- Databáze neobsahuje klientskou aplikaci



## Požadavky na spuštění
- Software  SQL Server Management Studio (MSSQL), verze 2014 a novější
- Stáhnutá struktura a nejlépe i data ze složky /sql
- Znalost práce v MSSQL pro následné používání dat



## Návod na instalaci a ovládání aplikace
### Instalace
- Uživatel by si měl vytvořit databázi a nahrát do ní strukturu, dle kroku "Import struktury databáze  a dat od zadavatele"
- Následně naimportovat data znovu dle "Import struktury databáze  a dat od zadavatele"

### Ovládání
- Struktura má již pod Pohledem, Transakcí, ... již vytvořené příkazy Select pro otestování
- Data mají pod přidáním příkazy Select pro vypsání všech dat



## Závěr
př:
Tento systém by po menších úpravách mohl být převeden na jiný databázový systém, 
klientská aplikace není zabezpečená, 
počítá se s tím, že klient byl proškolen o používání této aplikace ...
Nepodařilo se dořešit ...
Pro další vývoj aplikace by bylo vhodné ...
