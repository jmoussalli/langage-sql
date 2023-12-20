-- CREATE DATABASE bookstore;

-- CREATE SCHEMA public;
-- CREATE SCHEMA toto;

DROP TABLE IF EXISTS books;

CREATE TABLE IF NOT EXISTS public.books (
	id INTEGER,
	title VARCHAR(150),
	year_published SMALLINT,
	price NUMERIC
);

-- Ceci est un commentaire

INSERT INTO books (id, title, year_published, price) VALUES (1, 'Introduction to SQL', 2010, 15.49);

-- Lire tables
SELECT * FROM books;

