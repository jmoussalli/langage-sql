CREATE DATABASE bookstore;
CREATE SCHEMA public;
CREATE SCHEMA toto;

create TABLE IF NOT EXISTS public.books (
	id INTEGER,
	title VARCHAR(150),
	year_published SMALLINT,
	price NUMERIC
);

-- DROP TABLE IF EXISTS public.books;
-- Ceci est un commentaire

create TABLE IF NOT EXISTS books.books (
	id INTEGER,
	title VARCHAR(150)
);
INSERT INTO books (id, title) VALUES (1, 'Coin coin !');

INSERT INTO public.books (id, title, year_published, price) VALUES (1, 'Introduction to SQL', 2010, 15.49);
INSERT INTO public.books (id, title, year_published, price) VALUES (1, 'Git & GitHub', 2014, 21.99);

select count(*) from public.books;

select * from public.books LIMIT 1;

select count(*) from public.books;

delete from books;

select count(*) from public.books;


SELECT 3+3;

SELECT SUM(price) from public.books;

select * from books.books;


create TABLE IF NOT EXISTS authors (
	id INTEGER,
	first_name VARCHAR(100),
	last_name VARCHAR(100)
);

DROP TABLE IF EXISTS books;

CREATE TABLE IF NOT EXISTS public.books (
	id SERIAL,
	title VARCHAR(150),
	year_published SMALLINT,
	price NUMERIC
);

-- Ceci est un commentaire

INSERT INTO books (id, title, year_published, price) VALUES (1, 'Introduction to SQL', 2010, 15.49);
INSERT INTO books (id, title, year_published, price) VALUES (2, 'Git & GitHub', 2014, 21.99);

-- Lire tables
SELECT * FROM books;

SELECT id FROM books;
SELECT id, title FROM books;
SELECT 39*3 AS product;
SELECT title, 6+6 FROM books;
SELECT id, title, price - 5 AS discount FROM books;
SELECT id, title,'Disponible' AS availability FROM books;

-- Limiter le nombre d'entree
SELECT * FROM books LIMIT 1;

-- Supprimer
DELETE FROM books WHERE year_published=2010;
SELECT * FROM books;

-- Filtres
SELECT * FROM books WHERE year_published=2010;
SELECT * FROM books WHERE price=21.99;

TRUNCATE TABLE books;

INSERT INTO books (title, year_published, price) VALUES
('Introduction au SQL', 2000, 15.49),
('La methode Agile', 2005, 23.99),
('Git & GitHub', 2020, 41.99),
('SQL pour l''analyse des données', 2021, 59.99),
('Le CSS', 2014, 15.99),
('SQL : éléments internes de la base de données', 2018, 63.75),
('Java: Introduction', 2014, 11.99),
('Laravel pour les nuls', 2012, 23.99),
('L''art du SQL', 2015, 27.75);

-- Multiple filtres
SELECT * FROM books WHERE year_published>2014 OR price > 20;

DROP TABLE books;
CREATE TABLE IF NOT EXISTS public.books (
	id SERIAL,
	title VARCHAR(150),
	year_published SMALLINT,
	price NUMERIC
);
INSERT INTO books (title, year_published, price) VALUES
('Introduction au SQL', 2000, 15.49),
('La methode Agile', 2005, 23.99),
('Git & GitHub', 2020, 41.99),
('SQL pour l''analyse des données', 2021, 59.99),
('Le CSS', 2014, 15.99),
('SQL : éléments internes de la base de données', 2018, 63.75),
('Java: Introduction', 2014, 11.99),
('Laravel pour les nuls', 2012, 23.99),
('L''art du SQL', 2015, 27.75);

SELECT * FROM books;

-- Modifier les entrees
UPDATE books SET price=10.49 WHERE id=1;

-- Ordonner le resultat
SELECT * FROM books ORDER BY year_published;
SELECT * FROM books ORDER BY year_published DESC;
SELECT * FROM books ORDER BY year_published, id ASC;
SELECT * FROM books ORDER BY year_published, id DESC;

-- Sans duplicat
SELECT DISTINCT year_published FROM books;

-- Modifier structure table
ALTER TABLE books ADD COLUMN page SMALLINT;

SELECT * FROM books;

UPDATE books SET page=300 WHERE id=3;

SELECT * FROM books WHERE page IS NOT NULL;

-- LIKE & ILIKE
SELECT * FROM books WHERE id IN (4, 9, 1, 6);
SELECT * FROM books WHERE title LIKE 'SQL%';
SELECT * FROM books WHERE title LIKE '%SQL';
SELECT * FROM books WHERE title ILIKE '%sql%';

SELECT * FROM books WHERE id IN (4, 9, 1, 6) AND  title LIKE 'SQL%';
SELECT * FROM books WHERE id IN (4, 9, 1, 6) OR  title LIKE 'SQL%';

-- Aggregations: SUM, MIN, MAX, AVG, COUNT
-- COUNT
SELECT COUNT(*) FROM books;
SELECT COUNT(*) AS total FROM books;
SELECT COUNT(id) AS total FROM books;
SELECT COUNT(year_published) AS total FROM books;
SELECT COUNT(page) AS total FROM books;

-- MIN
SELECT MIN(year_published) FROM books;

-- MAX
SELECT MAX(year_published) FROM books;

-- SUM
SELECT SUM(price) FROM books;

-- AVG
SELECT AVG(price) FROM books;

-- ROUND
SELECT ROUND(AVG(price)) FROM books;


