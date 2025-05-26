CREATE DATABASE Patiserie
go
use Patiserie
go

CREATE TABLE Patiserii
(
idPatiserie INT PRIMARY KEY IDENTITY,
Denumire VARCHAR(50),
NrClienti INT
)

CREATE TABLE Tipuri
(
idTip INT PRIMARY KEY IDENTITY,
Tip VARCHAR(50),
NrProduse INT
)

CREATE TABLE Furnizori
(
idFurnizor INT PRIMARY KEY IDENTITY,
Nume VARCHAR(50),
Locatie VARCHAR(50)
)

CREATE TABLE Produse
(
idProduse INT PRIMARY KEY IDENTITY,
Denumire VARCHAR(50),
Cantitate INT,
Pret INT,
idFurnizor INT FOREIGN KEY REFERENCES Furnizori(idFurnizor),
idTip INT FOREIGN KEY REFERENCES Tipuri(idTip)
)

CREATE TABLE PatiseriiProduse
(
idPatiserie INT FOREIGN KEY REFERENCES Patiserii(idPatiserie),
idProdus INT FOREIGN KEY REFERENCES Produse(idProduse),
CONSTRAINT pkPatiseriiProduse PRIMARY KEY (idPatiserie, idProdus)
)


CREATE TABLE Departamente
(
idDepartament INT PRIMARY KEY IDENTITY,
Nume VARCHAR(50),
NrPatiseri INT,

)

CREATE TABLE Patiseri
(
idPatiser INT PRIMARY KEY IDENTITY,
Nume VARCHAR(50),
Prenume VARCHAR(50),
Vechime INT,
Departament INT FOREIGN KEY REFERENCES Departamente(idDepartament),
Patiserie INT FOREIGN KEY REFERENCES Patiserii(idPatiserie),

)

CREATE TABLE Clienti
(
idClient INT PRIMARY KEY IDENTITY,
Nume VARCHAR(50)
)

CREATE TABLE Comenzi
(
idComanda INT PRIMARY KEY IDENTITY,
idClient INT FOREIGN KEY REFERENCES Clienti(idClient),
idPatiser INT FOREIGN KEY REFERENCES Patiseri(idPatiser)
)

CREATE TABLE Manageri
(
idManager INT FOREIGN KEY REFERENCES Patiserii(idPatiserie),
Nume VARCHAR(50),
Experienta INT,
CONSTRAINT pkManager PRIMARY KEY(idManager)
)

SELECT * FROM Clienti
SELECT *FROM Comenzi WHERE idClient = idCoamanda
