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


