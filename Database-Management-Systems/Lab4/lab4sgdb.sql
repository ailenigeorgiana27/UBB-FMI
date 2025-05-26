USE Patiserie_SGBD
GO

-- Log istoric
CREATE TABLE IstoricTranzactii (
	ID INT PRIMARY KEY IDENTITY(1,1),
	actiune VARCHAR(50),
	data_executiei DATETIME,
	mesaj VARCHAR(100)
)

SELECT * FROM IstoricTranzactii
SELECT * FROM Patiserii

--------------------------------------------------------------- Dirty Reads ---------------------------------------------------------
-- 1 --
BEGIN TRANSACTION 
UPDATE Patiserii SET NrClienti = 100 WHERE Denumire = 'DulceBun';
WAITFOR DELAY '00:00:05'
ROLLBACK TRANSACTION
INSERT INTO IstoricTranzactii(actiune, data_executiei, mesaj) VALUES('Dr Rollback', CURRENT_TIMESTAMP, 'Rollback successfully')

-- 2-WRONG --
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
BEGIN TRANSACTION
SELECT * FROM Patiserii;
WAITFOR DELAY '00:00:10'
SELECT * FROM Patiserii;
COMMIT TRANSACTION

-- 2-SOLUTION --
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
BEGIN TRANSACTION
SELECT * FROM Patiserii;
WAITFOR DELAY '00:00:10'
SELECT * FROM Patiserii;
COMMIT TRANSACTION

-------------------------------------------------------- Non-Repeatable Reads ------------------------------------------------------------
-- 1-WRONG --
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
BEGIN TRANSACTION
SELECT * FROM Patiserii;
WAITFOR DELAY '00:00:06'
SELECT * FROM Patiserii;
COMMIT TRANSACTION

-- 1-SOLUTION --
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
BEGIN TRANSACTION
SELECT * FROM Patiserii;
WAITFOR DELAY '00:00:06'
SELECT * FROM Patiserii;
COMMIT TRANSACTION

-- 2 --
BEGIN TRANSACTION
WAITFOR DELAY '00:00:03'
UPDATE Patiserii SET NrClienti = 150 WHERE Denumire = 'DulceBun';
COMMIT TRANSACTION

-------------------------------------------------------- Phantom Reads -------------------------------------------------------------------
-- 1-WRONG --
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRANSACTION;
SELECT * FROM Patiseri WHERE Vechime BETWEEN 1 AND 5;
WAITFOR DELAY '00:00:07';
SELECT * FROM Patiseri WHERE Vechime BETWEEN 1 AND 5;
COMMIT TRANSACTION

-- 1-SOLUTION --
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN TRANSACTION
SELECT * FROM Patiseri WHERE Vechime BETWEEN 1 AND 5;
WAITFOR DELAY '00:00:07'
SELECT * FROM Patiseri WHERE Vechime BETWEEN 1 AND 5;
COMMIT TRANSACTION

-- 2 --
BEGIN TRANSACTION
WAITFOR DELAY '00:00:05'
INSERT INTO Patiseri(Nume, Prenume, Vechime, Departament, Patiserie)
VALUES ('Ion', 'Pop', 2, 1, 1);
COMMIT TRANSACTION

------------------------------------------------------------- Deadlock -------------------------------------------------------------------
-- 1 --
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN TRAN
UPDATE Patiserii SET NrClienti = 999 WHERE Denumire = 'DulceBun';
WAITFOR DELAY '00:00:05'
UPDATE Patiseri SET Vechime = Vechime + 1 WHERE Nume = 'Ion';
COMMIT TRAN

-- 2-WRONG --
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN TRAN
UPDATE Patiseri SET Vechime = Vechime + 2 WHERE Nume = 'Ion';
WAITFOR DELAY '00:00:05'
UPDATE Patiserii SET NrClienti = 800 WHERE Denumire = 'DulceBun';
COMMIT TRAN

-- 2-SOLUTION --
SET DEADLOCK_PRIORITY HIGH;
BEGIN TRANSACTION
UPDATE Patiseri SET Vechime = Vechime + 2 WHERE Nume = 'Ion';
WAITFOR DELAY '00:00:05'
UPDATE Patiserii SET NrClienti = 800 WHERE Denumire = 'DulceBun';
COMMIT TRANSACTION

SELECT * FROM Patiseri
SELECT * FROM Patiserii

----------------------------------------------------------- C# style procedure -----------------------------------------------------------
GO
CREATE OR ALTER PROCEDURE run_thread1
AS
BEGIN
    BEGIN TRANSACTION
    UPDATE Patiserii SET NrClienti = 50 WHERE Denumire = 'DulceBun';
    WAITFOR DELAY '00:00:10'
    UPDATE Patiseri SET Nume = Nume + ' THR1' WHERE Nume = 'Ion';
    COMMIT TRANSACTION
END

GO
CREATE OR ALTER PROCEDURE run_thread2
AS
BEGIN
    SET DEADLOCK_PRIORITY HIGH
    BEGIN TRANSACTION
    UPDATE Patiserii SET NrClienti = 70 WHERE Denumire = 'DulceBun';
    WAITFOR DELAY '00:00:10'
    UPDATE Patiseri SET Nume = Nume + ' THR2' WHERE Nume = 'Ion';
    COMMIT TRANSACTION
END
