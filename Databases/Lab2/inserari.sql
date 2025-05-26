USE Patiserie
go

--- Patiserii
INSERT INTO Patiserii(Denumire, NrClienti)
VALUES ('La Creme', 40),
		('A la Tarte', 60),
		('Dulcinella', 300),
		('Bujor', 100),
		('Royal Sweets', 400)

---Tipuri
INSERT INTO Tipuri(Tip, NrProduse)
VALUES ('Prajituri', 100),
		('Chec', 50),
		('Cookies', 40),
		('Croissant', 30),
		('Placinta', 15),
		('Tort', 10)

---Furnizori
INSERT INTO Furnizori(Nume, Locatie)
Values ('Novapan', 'Cluj-Napoca'),
		('Pavoni', 'Suceava'),
		('FoodTools', 'Cluj-Napoca'),
		('Domino', 'Bucuresti'),
		('Anneliese', 'Suceava')

---Produse
INSERT INTO Produse(Denumire, Cantitate, Pret, idFurnizor, idTip)
VALUES ('Briose', 100, 10, 1, 1),
		('Brownies', 50, 15, 2, 1),
		('Chec cu ciocolata', 10, 25, 3, 2),
		('Chec cu visine', 8, 23, 3, 2),
		('Chec de casa', 5, 30, 2, 2),
		('Croissant cu unt', 30, 6, 5, 4),
		('Croissant cu ciocolata', 30, 6, 4, 4),
		('Croissant cu vanilie', 30, 6, 5, 4),
		('Placinta cu mere', 10, 20, 5, 5),
		('Placinta cu dovleac', 10, 23, 4, 5),
		('Placinta cu carne', 10, 25, 3, 5),
		('Tort de ciocolata', 4, 50, 2, 6),
		('Tort de vanilie', 4, 50, 3, 6),
		('Tort de morcovi', 4, 55, 1, 6)

---PatiseriiProduse
INSERT INTO PatiseriiProduse(idPatiserie, idProdus)
VALUES (1, 1), (5, 3), (3, 9), (2, 7), (3, 14), (4, 12),
		(2, 11), (1, 2), (3, 10), (4, 4), (5, 5), (1, 6), (2, 8), (3, 13)


---Departamente
INSERT INTO Departamente(Nume, NrPatiseri)
VALUES ('Dozarea semipreparatelor', 5),
		('Omogenizarea cremelor', 6),
		('Pregatirea blatului/aluatului', 7),
		('Asamblarea produselor', 3),
		('Portionarea', 3),
		('Decorarea', 2),
		('Impachetarea', 3)


---Patiseri
INSERT INTO Patiseri(Nume, Prenume, Vechime, Departament, Patiserie)
VALUES ('Andrei', 'Toma', 3, 1, 4),
		('Costi', 'Cornea', 4, 2, 1),
		('Radu', 'Dragus', 5, 1, 3),
		('Carmen', 'Tomescu', 1, 3, 4),
		('Cristina', 'Gogea', 7, 4, 5),
		('Augustin', 'Arcos', 2, 6, 2),
		('Rodica', 'Mihai', 1, 2, 4),
		('Doru', 'Popa', 3, 4, 5),
		('Tudor', 'Mihail', 4, 1, 3),
		('Horea', 'Goga', 1, 3, 2),
		('Marc', 'Vladu', 2, 2, 5),
		('Tudor', 'Plesu', 5, 1, 4),
		('Ana', 'Pavel', 7, 2, 5),
		('Ion', 'Theo', 4, 3, 2),
		('Mircea', 'Cojocar', 3, 5, 1),
		('Ioana', 'Voicu', 6, 2, 4),
		('Toma', 'Oprea', 5, 4, 1),
		('Viorel', 'Stefan', 1, 3, 2),
		('Bogdan', 'Banciu', 3, 1, 4),
		('Gabi', 'Cozma', 4, 2, 5),
		('Costela', 'Tomescu', 5, 3,2 ),
		('Marina', 'Cezar', 8, 5, 3),
		('Gabriela', 'Poenaru', 5, 3, 5),
		('Mihai', 'Pop', 1, 5, 4), 
		('Dorina', 'Pop', 2, 6, 1),
		('Andra', 'Cristea', 3, 3, 4),
		('Costica', 'Pacurar', 3, 7, 5),
		('Antoni', 'Cosma', 4, 7, 2),
		('Vlad', 'Pasnea', 1, 7, 3)

---Clienti
INSERT INTO Clienti(Nume)
VALUES ('Ioana Toma'),
		('Mircea Bartos'),
		('Alexandra Oprea'),
		('Mihaela Andreea'),
		('Ion Pavel')

---Comenzi
INSERT INTO Comenzi(idClient, idPatiser)
VALUES (1, 2), (3, 2), (2, 7), (4, 15), (5, 5)

---Manageri
INSERT INTO Manageri(idManager, Nume, Experienta)
VALUES (1, 'Mihai Ion', 5),
		(2, 'Vasi Valeriu', 6),
		(3, 'Pop Emilian', 11)
