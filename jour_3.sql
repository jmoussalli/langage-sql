DROP TABLE IF EXISTS books_authors;
DROP TABLE IF EXISTS  authors;
DROP TABLE IF EXISTS  books;

CREATE TABLE books (
	id SERIAL PRIMARY KEY NOT NULL,
	title VARCHAR(100) NOT NULL,
	year SMALLINT NULL,
	publisher VARCHAR(50) NULL,
	price NUMERIC(6, 2) NOT NULL CHECK(price > 0)-- 0.0 -> 9999.99
);

CREATE TABLE authors (
	id SERIAL PRIMARY KEY NOT NULL,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL
);

CREATE TABLE books_authors (
	author_id INTEGER REFERENCES authors,
	book_id INTEGER REFERENCES books
);

INSERT INTO books (title, year, publisher, price) VALUES ('Introduction au SQL', 2000, 'Packt', 15.49);
INSERT INTO books (title, year, publisher, price) VALUES ('La methode Agile', 2005, 'Oreilly', 23.99);
INSERT INTO books (title, price) VALUES ('Git & GitHub', 11.99);
INSERT INTO books (title, year, price) VALUES ('Laravel pour les nuls', 2012, 23.99);
INSERT INTO books (title, year, price) VALUES ('Java 2E', 2007, 53.99);
INSERT INTO books (title, year, price) VALUES ('Java 2E & Spring', 2004, 53.99);
INSERT INTO authors (first_name, last_name) VALUES ('Mickael', 'Seffar'),('Aurore', 'Desmis'), ('Nehemie', 'Balukidi');
INSERT INTO books_authors (author_id, book_id) VALUES (1, 1), (2, 2), (1, 3), (2, 1);

SELECT * FROM books_authors;
SELECT * FROM books;
SELECT * FROM authors;

-- JOIN(INNRE JOIN)
SELECT b.title, b.year, ba.*, b.id FROM books AS b
JOIN books_authors AS ba
ON b.id = ba.book_id;

-- LEFT JOIN
SELECT b.title, b.year, ba.*, b.id FROM books AS b
LEFT JOIN books_authors AS ba
ON b.id = ba.book_id;

-- LEFT OUTER JOIN
SELECT b.title, b.year, ba.*, b.id FROM books AS b
LEFT JOIN books_authors AS ba
ON b.id = ba.book_id
WHERE ba.book_id IS NULL;

--- RIGHT JOIN
SELECT b.title, b.year, ba.*, b.id FROM books AS b
RIGHT JOIN books_authors AS ba
ON b.id = ba.book_id;

--- RIGHT OUTER JOIN
SELECT b.title, b.year, ba.*, b.id FROM books AS b
RIGHT JOIN books_authors AS ba
ON b.id = ba.book_id
WHERE ba.book_id IS NULL;


-- JOINTURE 3 Tables
SELECT b.*, ba.*, a.* FROM books AS b
JOIN books_authors AS ba
ON b.id = ba.book_id
JOIN authors AS a
ON a.id = ba.author_id;

SELECT b.title, a.first_name, a.last_name FROM books AS b
JOIN books_authors AS ba
ON b.id = ba.book_id
JOIN authors AS a
ON a.id = ba.author_id;

SELECT b.title, a.first_name, a.last_name FROM books AS b
JOIN books_authors AS ba
ON b.id = ba.book_id
JOIN authors AS a
ON a.id = ba.author_id
WHERE a.first_name LIKE 'Aurore%';

-- tables temporaires avec WITH
WITH 
	drama_movies AS ( SELECT *, 'Drama' as Genre FROM movies WHERE category ILIKE '%drama%'),
	crime_movies AS ( SELECT *, 'Crime' as Genre FROM movies WHERE category ILIKE '%crime%'),
	biography_movies AS ( SELECT *, 'Biography' as Genre FROM movies WHERE category ILIKE '%biography%')
SELECT cm.id, cm.title, cm.category FROM crime_movies as cm
JOIN drama_movies as dm
ON cm.id = dm.id;

