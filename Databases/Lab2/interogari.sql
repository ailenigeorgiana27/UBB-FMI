USE Patiserie
go

--1) Produsele impreuna cu furnizorii care fac parte din tipul 'Chec'
SELECT p.Denumire, p.Cantitate, p.Pret, f.Nume AS Furnizor, f.Locatie
FROM Furnizori f INNER JOIN Produse p ON f.idFurnizor = p.idFurnizor
WHERE p.idTip in (SELECT t.idTip FROM Tipuri t WHERE t.tip = 'Chec')


--2)Furnizorii si numarul produselor de tip chec
SELECT f.Nume, f.Locatie, COUNT(*) AS Numar_Produse_Chec
FROM Furnizori f INNER JOIN Produse p ON f.idFurnizor = p.idFurnizor
WHERE p.idTip in (SELECT t.idTip from Tipuri t WHERE t.Tip = 'Chec')
GROUP BY f.Nume, f.Locatie

--3)Departamentele de angajati cu mai mult de 5 persoane
SELECT d.Nume, COUNT(*) AS Numar_Patiseri
FROM Departamente d
INNER JOIN Patiseri p
ON d.idDepartament = p.Departament
GROUP BY d.Nume HAVING COUNT(*)>5

--4)Patiseriile ce au mai mult de 5 angajati cu vechime >= 2 ani
SELECT pa.Denumire, pa.NrClienti, COUNT(*) AS Nr_Patiseri
FROM Patiseri p
INNER JOIN Departamente dep
ON p.Departament = dep.idDepartament
INNER JOIN Patiserii pa
ON p.Patiserie = pa.idPatiserie
WHERE p.Vechime >= 2
GROUP BY pa.Denumire, pa.NrClienti HAVING COUNT(*) > 5

--5)Managerii ce au mai mult de 2 produse in patiserie
SELECT m.Nume, pa.Denumire AS Nume_Patiserie, COUNT(*) AS Nr_produse
FROM Manageri m
INNER JOIN Patiserii pa
ON m.idManager = pa.idPatiserie
INNER JOIN PatiseriiProduse pp
ON pa.idPatiserie = pp.idPatiserie
INNER JOIN Produse p
ON pp.idProdus = p.idProduse
GROUP BY m.Nume, pa.Denumire HAVING COUNT(*) > 2


--6)Patiseriile cu produse de tip 'placinta' cu pret peste 20 de lei
SELECT DISTINCT pa.Denumire, pa.NrClienti
FROM Patiserii pa
INNER JOIN PatiseriiProduse pp
ON pa.idPatiserie = pp.idPatiserie
INNER JOIN Produse p
ON pp.idProdus = p.idProduse
WHERE p.Pret > 20

--7) Departamentele si numarul de patiseri din Patiseria cu 400 de clienti
SELECT d.Nume, COUNT(p.Nume) as Nr_Patiseri
FROM Departamente d
RIGHT OUTER JOIN Patiseri p
ON d.idDepartament = p.Departament
RIGHT OUTER JOIN Patiserii pa
ON p.Patiserie = pa.idPatiserie
WHERE pa.NrClienti = 400
GROUP BY d.Nume

--8)Departamentul ce preia comenzile clientilor patiseriei 'La Creme'
SELECT DISTINCT dep.nume
FROM Departamente dep
RIGHT OUTER JOIN Patiseri p
ON dep.idDepartament = p.Departament
RIGHT OUTER JOIN Comenzi c
ON p.idPatiser = c.idPatiser
RIGHT OUTER JOIN Patiserii pa
ON p.Patiserie = pa.idPatiserie
WHERE pa.Denumire = 'La Creme'



--9)Clientii ce au comanda pregatita de patiseri cu o vechime de peste 2 ani
SELECT c.Nume
FROM Clienti c
RIGHT OUTER JOIN Comenzi com
ON c.idClient = com.idClient
INNER JOIN Patiseri p
on com.idPatiser = p.idPatiser
WHERE p.Vechime > 2

--10)Toate departamentele din fiecare depozit
SELECT DISTINCT pa.Denumire AS Nume_Patiserie, pa.NrClienti, d.Nume AS Nume_Departament
FROM Departamente d
RIGHT OUTER JOIN Patiseri p
ON d.idDepartament = p.Departament
RIGHT OUTER JOIN Patiserii pa
ON p.Patiserie = pa.idPatiserie