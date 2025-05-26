USE Patiserie_SGBD
GO

GO
CREATE OR ALTER FUNCTION validareProdus
(@denumire VARCHAR(50), @cantitate INT, @pret INT, @idTip INT)
RETURNS VARCHAR(100)
AS
BEGIN
	DECLARE @mesaj VARCHAR(100)
	SET @mesaj = ''

	IF(NOT(EXISTS(SELECT idTip FROM Tipuri WHERE idTip = @idTip)))
		SET @mesaj += 'Nu exista tipuri cu acest id!'

	IF(@cantitate < 0)
		SET @mesaj += 'Cantitatea este incorecta!'
	
	IF(@pret < 0)
		SET @mesaj += 'Pretul este incorect!'
	
	IF (@denumire ='')
		SET @mesaj += 'Denumirea este incorecta!'

	RETURN @mesaj
END

GO
CREATE OR ALTER FUNCTION validarePatiserie
(@denumire VARCHAR(50), @nrClienti INT)
RETURNS VARCHAR(100)
AS
BEGIN
	DECLARE @mesaj VARCHAR(100)
	SET @mesaj = ''

	IF(@nrClienti < 0)
		SET @mesaj += 'NrClienti este incorect!'

	IF(@denumire = '')
		SET @mesaj += 'Denumirea este incorecta!'

	RETURN @mesaj
END

---SISTEMUL DE LOGARE---
CREATE TABLE IstoricLogare
(
	id INT PRIMARY KEY IDENTITY(1,1),
	actiune VARCHAR(15),
	tabel VARCHAR(15),
	data_executiei DATETIME
)


---PROCEDURA CE INSEREAZA DATE IN TABELELE Produse si Patiserii SI FACE ROLLBACK PE INTREAGA PROCEDURA---
GO
CREATE OR ALTER PROCEDURE AddProdusePatiserii @denumire VARCHAR(50), @cantitate INT, @pret INT, @idTip INT, @denumire_p VARCHAR(50), @nrClienti INT
AS
BEGIN
	BEGIN TRAN
	BEGIN TRY

		DECLARE @mesaj VARCHAR(100)='';

		DECLARE @mesaj_produse VARCHAR(100) = dbo.validareProdus(@denumire,@cantitate,@pret,@idTip);
		IF(@mesaj_produse <> '')
			SET @mesaj += @mesaj_produse + CHAR(13) + CHAR(10);

		DECLARE @mesaj_patiserie VARCHAR(100) = dbo.validarePatiserie(@denumire_p,@nrClienti);
		IF(@mesaj_patiserie <> '')
			SET @mesaj += @mesaj_patiserie +CHAR(13) + CHAR(10);

		IF(@mesaj <> '')
		BEGIN 
			RAISERROR(@mesaj, 14, 1);
		END

		DECLARE @idProduse INT
		DECLARE @idPatiserie INT

		INSERT INTO Produse(Denumire,Cantitate,Pret,idTip) VALUES (@denumire,@cantitate,@pret,@idTip)
		SET @idProduse = SCOPE_IDENTITY()
		INSERT INTO IstoricLogare(actiune, tabel, data_executiei) VALUES ('Insert', 'Produse', CURRENT_TIMESTAMP)

		INSERT INTO Patiserii(Denumire,NrClienti) VALUES (@denumire_p,@nrClienti)
		SET @idPatiserie = SCOPE_IDENTITY()
		INSERT INTO IstoricLogare(actiune,tabel,data_executiei) VALUES ('Insert','Patiserii',CURRENT_TIMESTAMP)

		INSERT INTO PatiseriiProduse(idPatiserie,idProdus) VALUES (@idPatiserie,@idProduse)
		INSERT INTO IstoricLogare(actiune, tabel, data_executiei) VALUES ('Insert', 'PP',CURRENT_TIMESTAMP)

		COMMIT TRAN
		SELECT 'Transaction comitted'
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
		SELECT 'Transaction rollbacked'
	END CATCH
END

SELECT * FROM Produse
SELECT * FROM Patiserii
SELECT * FROM PatiseriiProduse
SELECT * FROM Tipuri
SELECT * FROM IstoricLogare


---SCENARIUL DE SUCCES---
EXEC AddProdusePatiserii 'Prajitura', 10, 19, 1, 'Bujoru', 100


---Rollback---
EXEC AddProdusePatiserii '', 12, 10, 1, 'Royal-Sweets', 200
EXEC AddProdusePatiserii 'Cookies', -12 , 10, 1, 'Royal-Sweets', 200
EXEC AddProdusePatiserii 'Cookies', 12 , -10, 1, 'Royal-Sweets', 200
EXEC AddProdusePatiserii 'Cookies', 12 , 10, 20, 'Royal-Sweets', 200
EXEC AddProdusePatiserii 'Cookies', 12 , 10, 1, '', 200
EXEC AddProdusePatiserii 'Cookies', 12 , 10, 1, 'Royal-Sweets', -10


---PROCEDURA CE INSEREAZA DATE IN TABELELE Produse SI Patiserii SI PASTREAZA CE E CORECT
GO
CREATE OR ALTER PROCEDURE AddProdusePatiserii2 @denumire VARCHAR(50), @cantitate INT, @pret INT, @idTip INT, @denumire_p VARCHAR(30), @nrClienti INT
AS
BEGIN
	DECLARE @inserareProduse INT
	SET @inserareProduse = 0

	BEGIN TRAN
	BEGIN TRY
		DECLARE @mesaj_produse VARCHAR(100) = dbo.validareProdus(@denumire,@cantitate,@pret,@idTip);
		IF(@mesaj_produse <> '')
		BEGIN
			RAISERROR(@mesaj_produse, 14, 1);
		END
		DECLARE @idProdus INT

		INSERT INTO Produse(Denumire,Cantitate,Pret,idTip) VALUES (@denumire,@cantitate,@pret,@idTip)
		SET @idProdus = SCOPE_IDENTITY()
		INSERT INTO IstoricLogare(actiune,tabel,data_executiei) VALUES ('Insert','Produse',CURRENT_TIMESTAMP)

		COMMIT TRAN
		SELECT 'Transaction Produse committed'
		SET @inserareProduse = @idProdus
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
		SELECT 'Transaction Produse rollbacked'
		INSERT INTO IstoricLogare(actiune,tabel,data_executiei) VALUES ('ROLLBACK','Produse',CURRENT_TIMESTAMP)
	END CATCH


	DECLARE @inserarePatiserie INT
	SET @inserarePatiserie = 0

	BEGIN TRAN
	BEGIN TRY
		DECLARE @mesaj_patiserie VARCHAR(100) = dbo.validarePatiserie(@denumire_p,@nrClienti);
		IF(@mesaj_patiserie <> '')
		BEGIN
			RAISERROR(@mesaj_patiserie, 14, 1);
		END
		DECLARE @idPatiserie INT

		INSERT INTO Patiserii(Denumire,NrClienti) VALUES (@denumire_p,@nrClienti)
		SET @idPatiserie = SCOPE_IDENTITY()
		INSERT INTO IstoricLogare(actiune,tabel,data_executiei) VALUES ('Insert','Patiserii', CURRENT_TIMESTAMP)

		COMMIT TRAN
		SELECT 'Transaction Patiserie committed'
		SET @inserarePatiserie = @idPatiserie
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
		SELECT 'Transaction Patiserie rollbacked'
		INSERT INTO IstoricLogare(actiune,tabel,data_executiei) VALUES ('ROLLBACK','Patiserii',CURRENT_TIMESTAMP)
	END CATCH


	BEGIN TRAN
	BEGIN TRY
		IF(@inserarePatiserie = 0 or @inserareProduse = 0)
		BEGIN
			RAISERROR(@mesaj_patiserie, 14, 1);
		END

		INSERT INTO PatiseriiProduse(idPatiserie,idProdus) VALUES (@inserarePatiserie,@inserareProduse)
		INSERT INTO IstoricLogare(actiune,tabel,data_executiei) VALUES ('Insert','PP',CURRENT_TIMESTAMP)

		COMMIT TRAN
		SELECT 'Transaction PatiseriiProduse committed'
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
		SELECT 'Transaction PatiseriiProduse rollbacked'
		INSERT INTO IstoricLogare(actiune,tabel,data_executiei) VALUES ('ROLLBACK','PP', CURRENT_TIMESTAMP)
	END CATCH
END

SELECT * FROM Produse
SELECT * FROM Patiserii
SELECT * FROM PatiseriiProduse
SELECT * FROM Tipuri
SELECT * FROM IstoricLogare

DELETE FROM Patiserii WHERE idPatiserie=7
DELETE FROM Produse WHERE idProduse=16
DELETE FROM PatiseriiProduse
DBCC CHECKIDENT ('Patiserii', RESEED, 5);
DBCC CHECKIDENT ('Produse', RESEED, 14);


DELETE FROM IstoricLogare

---SCENARIUL DE SUCCES--
EXEC AddProdusePatiserii2 'Prajitura', 10, 19, 1, 'Bujoru', 100
--ROLLBACK
---SE ADAUGA PATISERII, DAR PRODUSE SI PATISERIIPRODUSE NU SE ADAUGA
EXEC AddProdusePatiserii2 '', 10, 19, 1, 'Bujoru', 100
EXEC AddProdusePatiserii2 'Prajitura', -10, 19, 1, 'Bujoru', 100
EXEC AddProdusePatiserii2 'Prajitura', 10, -19, 1, 'Bujoru', 100
EXEC AddProdusePatiserii2 'Prajitura', 10, 19, 100, 'Bujoru', 100



---SE ADAUGA PRODUSE, DAR PATISERII SI PATISERIIPRODUSE NU SE ADAUGA
EXEC AddProdusePatiserii2 'Prajitura', 10, 19, 1, '', 100
EXEC AddProdusePatiserii2 'Prajitura', 10, 19, 1, 'Bujoru', -100