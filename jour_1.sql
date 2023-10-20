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

