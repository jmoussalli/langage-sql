-- 1. Créer des tables
CREATE TABLE books (
	id INTEGER,
	title VARCHAR(100),
	year_published SMALLINT,
	publisher VARCHAR(50),
	price MONEY
);


CREATE TABLE authors (
	id INTEGER,
	first_name VARCHAR(50),
	last_name VARCHAR(50)
);

