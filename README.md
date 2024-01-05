# Praktická maturitní zkouška
---
### Střední průmyslová škola elektrotechnická, Praha 2, Ječná 30
### Školní rok 2023/2024
### Jméno a příjimeni: Michal Štilec
### Třída: C4b
---


## Úvod
- Databáze eviduje letenky pro společnost Sky Airlines
- Problém jsem se rozhodl řešit v MSSQL Server na školním serveru
- Jako návrhové prostředí jsem využil Oracle DataModeler

## Předloha
![letenka](https://github.com/MichalStilec/DatabaseFlightTicket/assets/113086016/43d36c69-94ca-4dc0-86a8-ee478ac1d90a)

## E-R model
- logický model databáze se nachází ve složce img a jmenuje se Logical.png

![Logical](https://github.com/MichalStilec/DatabaseFlightTicket/assets/113086016/3815bf36-7c9e-43c1-8194-c98671fcc256)

- relační model databáze se také nachází ve složce img a jmenuje se Relational.png

![Relational](https://github.com/MichalStilec/DatabaseFlightTicket/assets/113086016/a83050a6-95e0-402f-bbd4-0f3b4b956d23)


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
- Dále jsou vytvořené dva indexy pro lepší vyhledávání
  * RezervaceCestujiciho_ID = zrychluje dotazy, které vyhledávají rezervace na základě identifikátoru cestujícího
  * LetOdDo_ID = zrychluje dotazy, které vyhledávají lety podle odjezdu a příjezdu.
Indexy jdou jednoduše vytvořit následovně
```
CREATE INDEX <NazevIndexu> ON <NazevTabulky> (<Atribut/y>);
```

## Pohledy
- Návrh obsahuje pohledy na data o rezervacích a letech, které spojují informace o letech, cestujících a rezervacích. Pohled FlightReservationView kombinuje informace o letech, cestujících a rezervacích.

![image](https://github.com/MichalStilec/DatabaseFlightTicket/assets/113086016/c0d374db-be03-41c3-abb3-6ea4fd40bb72)



## Triggery
- Databáze obsahuje trigger UpdateReservationStatus, který automaticky aktualizuje stav rezervace na 'Confirmed' po přidání nové rezervace.

![image](https://github.com/MichalStilec/DatabaseFlightTicket/assets/113086016/812c3df5-fa51-4b04-bc4e-52ca39ab92a2)



## Procedury
- Databáze obsahuje proceduru GetReservationDetails, která načítá informace o konkrétní rezervaci letu spolu s údaji o cestujícím.

![image](https://github.com/MichalStilec/DatabaseFlightTicket/assets/113086016/fa38708c-7cfe-4002-abad-ea10bf252803)



## Transakce
- Databáze obsahuje transakci, která vloží nového cestujícího, nový let a novou rezervaci letenky do tabulek Cestujici, Let, Letenka, a Rezervace. Transakce zahrnuje kontrolu chyb a provádí rollback v případě chyby.

![image](https://github.com/MichalStilec/DatabaseFlightTicket/assets/113086016/93cf628e-05c9-4a67-a2ea-30e6b3e45073)

## Zálohování
- Zálohování je proces vytváření a uchovávání kopie důležitých dat s cílem zajištění jejich obnovení v případě ztráty, poškození nebo jiných nepředvídatelných událostí.
- Tímto procesem se minimalizuje riziko datové ztráty a přispívá se k obnovitelnosti systémů a informací.
### Plné zálohování (Full Backup):
Full backup ukládá všechna data včetně struktury. Musí být vytvořen jako první záloha. Lze vytvořit následovně:

```
BACKUP DATABASE <NazevDatabaze> TO DISK = '<Cesta kam chcete uložit soubor\nazevsouboru.bak>' WITH INIT;
```

### Diferenciální zálohování (Differential Backup):
Differential backup ukládá pouze změněná data dle full backupu. Nesmí být vytvořen jako první záloha. Lze vytvořit následovně:

```
BACKUP DATABASE <NazevDatabaze> TO DISK = '<Cesta kam chcete uložit soubor\nazevsouboru.bak>' WITH DIFFERENTIAL;
```

## Nastavení uživatelských oprávnění
Protože k upravení a celkovému vytvoření mé databáze používám databázové servery Microsoft SQL Server, které provozuje škola SPŠE Ječná, tak nemohu nijak vytvářet LOGINY ani USERY.
Z toho důvodu se v této části pokusím teoreticky popsat, jak bych postupoval, pokud bych měl možnost vytvářet LOGINY, USERY a zároveň jak bych pracoval s uživatelskými oprávněními.

### Login
Login jsou přihlašovací údaje, přes které se následně připojuje do serveru
```
CREATE LOGIN <NazevLoginu>
WITH PASSWORD = <HesloLoginu>;
```

### User
User se přiděluje k loginu a má různé oprávnění
```
CREATE USER <NazevUsera> FOR LOGIN <NazevLoginu>;
```

### Role
Role je skupina oprávnění, která jsou následně přidělována uživatelům
```
CREATE ROLE <NazevRole>;
```

### Přidělení role schématu
Tento příkaz přidělí roli oprávnění pro dané schéma, v tomto příkladu přiděluji například Select
```
GRANT SELECT ON SCHEMA :: <NazevSchematu> TO <NazevRole>;
```

### Přidělení role na konkrétní objekt
Pokud nechci nastavovat práva pro celý schéma, tak je možnost také udělovat práva na konkretní objekty
```
GRANT SELECT ON <NazevTabulky> TO <NazevRole>;
```


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
### Celkově by měla být tato databáze využívána pro rezervační systém leteckých letů s možností sledování rezervací, letů, cestujících a dalších souvisejících informací.
