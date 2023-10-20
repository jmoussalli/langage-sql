-- 1. Créer des tables
DROP TABLE books;
CREATE TABLE books (
	id INTEGER,
	title VARCHAR(100),
	year_published SMALLINT,
	publisher VARCHAR(50),
	price MONEY,
	available  BOOL
);

DROP TABLE authors;
CREATE TABLE authors (
	id INTEGER,
	first_name VARCHAR(50),
	last_name VARCHAR(50)
);

-- 2. Insertion simple
INSERT INTO books(id, title, year_published, price, available) VALUES (1, 'Introduction au JAVA', 2020, '50', 'y');
SELECT * FROM books;

-- 3. SELECT
INSERT INTO books(id, title, year_published, price, available, publisher) VALUES (2, 'SQL pour les Full-Stack dev', 2010, '150', 'y', 'Packt');
SELECT title FROM books;
SELECT title, price, available FROM books;

SELECT 3/3;

SELECT title, price, 3+3, available FROM books;

-- 4 CHAR TYPE
DROP TABLE authors;
CREATE TABLE authors (
	id INTEGER,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	initial CHAR(3)
);

INSERT INTO authors (id, first_name, last_name, initial) VALUES (1, 'Nehemie', 'Balukidi', 'N');
INSERT INTO authors (id, first_name, last_name, initial) VALUES (2, 'Gilesd', 'Desjardin', 'GD');

SELECT CONCAT('*', initial, '*') FROM authors;

-- 5 SERIAL DATA type
DROP TABLE authors;
CREATE TABLE authors (
	id SERIAL,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	initial CHAR(3)
);
INSERT INTO authors (first_name, last_name, initial) VALUES ('Nehemie', 'Balukidi', 'N');
INSERT INTO authors (first_name, last_name, initial) VALUES ('Gilesd', 'Desjardin', 'GD');

SELECT * FROM authors;

-- 6 Select sans colones

INSERT INTO authors VALUES (DEFAULT, 'Christian', 'Lisangola', 'CL');
SELECT * FROM authors;

-- 7 Date
CREATE TABLE friends (
	name VARCHAR(20),
	dob DATE
);

INSERT INTO friends (name, dob) VALUES ('Christian', '1980-01-25');

SELECT  name, 2023 - EXTRACT(YEAR FROM dob) FROM friends;

--- 8 UPdate rows
SELECT * FROM books;
UPDATE books SET price='25' WHERE year_published = 2010;
UPDATE books SET title='Introduction au JAVA' WHERE id = 1;
 
-- 9 Modifier une table
ALTER TABLE books ALTER COLUMN price TYPE NUMERIC;
SELECT * FROM books;

ALTER TABLE books ADD COLUMN page SMALLINT;
SELECT * FROM books;

--- 10 Constraintes
DROP TABLE books;
CREATE TABLE books (
	id SERIAL,
	title VARCHAR(100),
	year_published SMALLINT,
	publisher VARCHAR(50),
	price NUMERIC NOT NULL,
	available  BOOL,
	CONSTRAINT book_price_check  CHECK(price > 10.0)
);

ALTER TABLE books DROP CONSTRAINT book_price_check, ADD CONSTRAINT book_price_check CHECK(price > 50.0);
INSERT INTO books(id, title, year_published, available, price) VALUES (1, 'Introduction au JAVA', 2020, 'y', 15.0);
INSERT INTO books(title, year_published, available, price) VALUES ('Introduction au langage SQL', 2005, 'y', 50.50);
SELECT * FROM books;

-- 11 Contraite UNIQUE