-- Asigurare constrângeri suplimentare pentru validarea datelor
ALTER TABLE Patiserii ADD CONSTRAINT chk_NrClienti CHECK (NrClienti >= 0);
ALTER TABLE Tipuri ADD CONSTRAINT chk_NrProduse CHECK (NrProduse >= 0);
ALTER TABLE Produse ADD CONSTRAINT chk_Cantitate CHECK (Cantitate >= 0);
ALTER TABLE Produse ADD CONSTRAINT chk_Pret CHECK (Pret > 0);
ALTER TABLE Patiseri ADD CONSTRAINT chk_Vechime CHECK (Vechime >= 0);
ALTER TABLE Manageri ADD CONSTRAINT chk_Experienta CHECK (Experienta >= 0);

-- Funcție pentru formatarea numelui (litera mare la început)
CREATE FUNCTION FormatNume(@Nume VARCHAR(50))
RETURNS VARCHAR(50)
AS
BEGIN
    RETURN UPPER(LEFT(@Nume, 1)) + LOWER(SUBSTRING(@Nume, 2, LEN(@Nume)));
END;

-- 1. Proceduri CRUD pentru tabela "Patiserii"
CREATE PROCEDURE AddPatiserie
    @Denumire VARCHAR(50),
    @NrClienti INT
AS
BEGIN
    SET @Denumire = dbo.FormatNume(@Denumire);
    INSERT INTO Patiserii (Denumire, NrClienti)
    VALUES (@Denumire, @NrClienti);
END;
GO

CREATE PROCEDURE UpdatePatiserie
    @idPatiserie INT,
    @Denumire VARCHAR(50),
    @NrClienti INT
AS
BEGIN
    SET @Denumire = dbo.FormatNume(@Denumire);
    UPDATE Patiserii
    SET Denumire = @Denumire, NrClienti = @NrClienti
    WHERE idPatiserie = @idPatiserie;
END;
GO

CREATE PROCEDURE DeletePatiserie
    @idPatiserie INT
AS
BEGIN
    DELETE FROM Patiserii WHERE idPatiserie = @idPatiserie;
END;
GO

CREATE PROCEDURE GetPatiserii
AS
BEGIN
    SELECT * FROM Patiserii;
END;
GO

-- 2. Proceduri CRUD pentru tabela "Tipuri"
CREATE PROCEDURE AddTip
    @Tip VARCHAR(50),
    @NrProduse INT
AS
BEGIN
    SET @Tip = dbo.FormatNume(@Tip);
    INSERT INTO Tipuri (Tip, NrProduse)
    VALUES (@Tip, @NrProduse);
END;
GO

CREATE PROCEDURE UpdateTip
    @idTip INT,
    @Tip VARCHAR(50),
    @NrProduse INT
AS
BEGIN
    SET @Tip = dbo.FormatNume(@Tip);
    UPDATE Tipuri
    SET Tip = @Tip, NrProduse = @NrProduse
    WHERE idTip = @idTip;
END;
GO

CREATE PROCEDURE DeleteTip
    @idTip INT
AS
BEGIN
    DELETE FROM Tipuri WHERE idTip = @idTip;
END;
GO

CREATE PROCEDURE GetTipuri
AS
BEGIN
    SELECT * FROM Tipuri;
END;
GO

-- 3. Proceduri CRUD pentru tabela "Produse"
CREATE PROCEDURE AddProdus
    @Denumire VARCHAR(50),
    @Cantitate INT,
    @Pret INT,
    @idFurnizor INT,
    @idTip INT
AS
BEGIN
    SET @Denumire = dbo.FormatNume(@Denumire);
    INSERT INTO Produse (Denumire, Cantitate, Pret, idFurnizor, idTip)
    VALUES (@Denumire, @Cantitate, @Pret, @idFurnizor, @idTip);
END;
GO

CREATE PROCEDURE UpdateProdus
    @idProdus INT,
    @Denumire VARCHAR(50),
    @Cantitate INT,
    @Pret INT,
    @idFurnizor INT,
    @idTip INT
AS
BEGIN
    SET @Denumire = dbo.FormatNume(@Denumire);
    UPDATE Produse
    SET Denumire = @Denumire, Cantitate = @Cantitate, Pret = @Pret, idFurnizor = @idFurnizor, idTip = @idTip
    WHERE idProduse = @idProdus;
END;
GO

CREATE PROCEDURE DeleteProdus
    @idProdus INT
AS
BEGIN
    DELETE FROM Produse WHERE idProduse = @idProdus;
END;
GO

CREATE PROCEDURE GetProduse
AS
BEGIN
    SELECT * FROM Produse;
END;
GO

-- 4. Proceduri CRUD pentru tabela "Patiseri"
CREATE PROCEDURE AddPatiser
    @Nume VARCHAR(50),
    @Prenume VARCHAR(50),
    @Vechime INT,
    @Departament INT,
    @Patiserie INT
AS
BEGIN
    SET @Nume = dbo.FormatNume(@Nume);
    SET @Prenume = dbo.FormatNume(@Prenume);
    INSERT INTO Patiseri (Nume, Prenume, Vechime, Departament, Patiserie)
    VALUES (@Nume, @Prenume, @Vechime, @Departament, @Patiserie);
END;
GO

CREATE PROCEDURE UpdatePatiser
    @idPatiser INT,
    @Nume VARCHAR(50),
    @Prenume VARCHAR(50),
    @Vechime INT,
    @Departament INT,
    @Patiserie INT
AS
BEGIN
    SET @Nume = dbo.FormatNume(@Nume);
    SET @Prenume = dbo.FormatNume(@Prenume);
    UPDATE Patiseri
    SET Nume = @Nume, Prenume = @Prenume, Vechime = @Vechime, Departament = @Departament, Patiserie = @Patiserie
    WHERE idPatiser = @idPatiser;
END;
GO

CREATE PROCEDURE DeletePatiser
    @idPatiser INT
AS
BEGIN
    DELETE FROM Patiseri WHERE idPatiser = @idPatiser;
END;
GO

CREATE PROCEDURE GetPatiseri
AS
BEGIN
    SELECT * FROM Patiseri;
END;
GO

-- 5. Proceduri CRUD pentru tabela "Comenzi"
CREATE PROCEDURE AddComanda
    @idClient INT,
    @idPatiser INT
AS
BEGIN
    INSERT INTO Comenzi (idClient, idPatiser)
    VALUES (@idClient, @idPatiser);
END;
GO

CREATE PROCEDURE UpdateComanda
    @idComanda INT,
    @idClient INT,
    @idPatiser INT
AS
BEGIN
    UPDATE Comenzi
    SET idClient = @idClient, idPatiser = @idPatiser
    WHERE idComanda = @idComanda;
END;
GO

CREATE PROCEDURE DeleteComanda
    @idComanda INT
AS
BEGIN
    DELETE FROM Comenzi WHERE idComanda = @idComanda;
END;
GO

CREATE PROCEDURE GetComenzi
AS
BEGIN
    SELECT * FROM Comenzi;
END;
GO

-- View-uri și indecși non-clustered
CREATE VIEW vwProduseFurnizori AS
SELECT p.Denumire AS Produs, p.Pret, f.Nume AS Furnizor, t.Tip AS TipProdus
FROM Produse p
JOIN Furnizori f ON p.idFurnizor = f.idFurnizor
JOIN Tipuri t ON p.idTip = t.idTip;
GO

CREATE VIEW vwComenziDetalii AS
SELECT c.idComanda, cl.Nume AS Client, pa.Nume AS Patiser
FROM Comenzi c
JOIN Clienti cl ON c.idClient = cl.idClient
JOIN Patiseri pa ON c.idPatiser = pa.idPatiser;
GO

CREATE NONCLUSTERED INDEX idx_Produse_Pret ON Produse (Pret);
CREATE NONCLUSTERED INDEX idx_Comenzi_Client ON Comenzi (idClient);

--Citește datele
EXEC GetPatiserii;
EXEC GetTipuri;
EXEC GetProduse;
EXEC GetPatiseri;
EXEC GetComenzi;

--Actualizează un rând
EXEC UpdatePatiserie @idPatiserie = 1, @Denumire = 'Patiseria Noua', @NrClienti = 25;
EXEC UpdateProdus @idProdus = 1, @Denumire = 'Tort Ciocolata', @Cantitate = 15, @Pret = 120, @idFurnizor = 1, @idTip = 1;

--Șterge un rând
EXEC DeleteComanda @idComanda = 1;
EXEC DeletePatiser @idPatiser = 1;

--Vezi informațiile din view-uri
SELECT * FROM vwProduseFurnizori;
SELECT * FROM vwComenziDetalii;

--Rulează interogări care beneficiază de indecsi
SELECT Denumire, Pret FROM Produse WHERE Pret > 50;
SELECT idClient FROM Comenzi WHERE idClient = 1;

--Verifică utilizarea indecșilor cu DMV-uri:
SELECT OBJECT_NAME(s.object_id) AS TableName, i.name AS IndexName, u.*
FROM sys.dm_db_index_usage_stats u
JOIN sys.indexes i ON i.index_id = u.index_id AND i.object_id = u.object_id
JOIN sys.objects s ON s.object_id = i.object_id
WHERE OBJECT_NAME(s.object_id) IN ('Produse', 'Comenzi');

INSERT INTO Furnizori (Nume, Locatie) VALUES ('Furnizor1', 'Locatie1');
INSERT INTO Tipuri (Tip, NrProduse) VALUES ('Tarte', 30);
INSERT INTO Produse (Denumire, Cantitate, Pret, idFurnizor, idTip) VALUES ('Ecler', 20, 50, 1, 1);
