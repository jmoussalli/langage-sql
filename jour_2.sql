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

SELECT * FROM books WHERE id > 4;
DELETE FROM books WHERE id > 4;

SELECT * FROM authors;

SELECT * FROM books_authors;

INSERT INTO authors (first_name, last_name) VALUES ('Mickael', 'Seffar'),('Aurore', 'Desmis');
INSERT INTO books_authors (author_id, book_id) VALUES (1, 1), (2, 2), (1, 3);

-- INSERT INTO books_authors (author_id, book_id) VALUES (1, 4), (2, 4);

SELECT * FROM books_authors;

SELECT * FROM books WHERE title LIKE 'La %';
SELECT * FROM books WHERE title ILIKE 'la%';

SELECT * FROM books WHERE year IS NULL;
SELECT * FROM books WHERE publisher IS NULL;
SELECT * FROM books WHERE year IS NULL AND publisher IS NULL;
SELECT * FROM books WHERE year IS NULL OR publisher IS NULL;

-- La supremission n'est pas possile grace aux contraintes
DELETE FROM books WHERE id = 1;

-- Recreons la contrainte pour permettere la suppression:
-- Lors de la supression d'une entree dans books referencee dans books_authors, supprimons tout entree dans books_authors
ALTER TABLE books_authors
DROP CONSTRAINT books_authors_book_id_fkey,
ADD CONSTRAINT books_authors_book_id_fkey
FOREIGN KEY(book_id) REFERENCES books 
ON DELETE CASCADE;

-- La suppression est de nouveau possible
DELETE FROM books WHERE id = 1;
SELECT * FROM books_authors;
SELECT * FROM books;

-- Lors de la supression d'une entree dans books referencee dans books_authors, mettons a jour tout entree dans books_authors, noubelle valuere est NULL
ALTER TABLE books_authors
DROP CONSTRAINT books_authors_book_id_fkey,
ADD CONSTRAINT books_authors_book_id_fkey
FOREIGN KEY(book_id) REFERENCES books 
ON DELETE SET NULL(book_id);

-- La clause WHERE
DELETE FROM books WHERE id = 2;
SELECT * FROM books_authors;

SELECT * FROM books WHERE price > 12 AND price < 17; -- [12, 17]

-- La clause ORDER BY
SELECT * FROM books ORDER BY title ASC;
SELECT * FROM books ORDER BY title DESC;

SELECT * FROM books ORDER BY price DESC;
SELECT * FROM books ORDER BY price ASC;
SELECT * FROM books ORDER BY year ASC;

-- Limiter le resultat
SELECT * FROM books ORDER BY year ASC LIMIT 2;
SELECT * FROM books ORDER BY year ASC LIMIT 1;

SELECT * FROM books WHERE year IS NOT NULL ORDER BY year DESC;
SELECT title FROM books WHERE year IS NOT NULL ORDER BY year DESC LIMIT 1;
SELECT title AS "titre du livre" FROM books WHERE year IS NOT NULL ORDER BY year DESC LIMIT 1;


-- Creer des colonnes conditionelles
SELECT 3+4 AS Somme;

SELECT *, CONCAT(first_name, ' ', last_name) FROM authors;
SELECT *, CONCAT_WS('--', first_name, last_name) AS "Nom complet" FROM authors;

SELECT * FROM books;
-- Si price > 20 Trop Cher
-- Si price > 15 Assez Cher
-- Si price > 10 Abordable
-- Sinon Moins cher

SELECT *, 
CASE
	WHEN price > 20 THEN 'Trop Cher'
	WHEN price > 15 THEN 'Assez Cher'
	WHEN price > 10 THEN 'Abordable'
	ELSE 'Moins Cher'
END AS Avis
FROM books;

-- Aggregation: compter les entrees: COUNT
SELECT COUNT(*) AS "Nombre de livre" FROM books;

SELECT COUNT(title) FROM books;
SELECT COUNT(year) FROM books;
SELECT COUNT(id) FROM books;
SELECT COUNT(publisher) AS "Livre avec info du publisher" FROM books;

-- Aggregation: compter les entrees: MAX, MIN
SELECT * FROM books;
SELECT MIN(price) FROM books;
SELECT MAX(price) FROM books;

SELECT MIN(price) AS "Plus petit prix", MAX(price) AS "Plus grand prix" FROM books;

-- Aggreagation: AVG et ROUND
SELECT AVG(price) FROM books;

SELECT ROUND(AVG(price), 2) FROM books;


/************************************************************************************/
/**************************** Resolution du TP 2 ************************************/
/************************************************************************************/

CREATE TABLE IF NOT EXISTS movies (
	id SERIAL PRIMARY KEY,
	title VARCHAR(100) NOT NULL,
	year SMALLINT NOT NULL,
	category VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS actors (
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	dob DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS movies_actors (
	id SERIAL,
	actor_id INTEGER REFERENCES actors ON DELETE CASCADE,
	movie_id INTEGER REFERENCES movies ON DELETE CASCADE,
	PRIMARY KEY (actor_id, movie_id)
);

CREATE TABLE IF NOT EXISTS ratings (
	movie_id INTEGER REFERENCES movies ON DELETE CASCADE,
	score NUMERIC(4, 2),
	PRIMARY KEY (movie_id)
);

/**************************** Insertion des données ****************************/
INSERT INTO movies (title, category, year) VALUES 
('The Great Gatsby','Drama/Romance','2013'),
('Shutter Island','Mystery/Thriller', '2010'),
('La La Land','Drama/Musical','2016'),
('A Beautiful Mind','Biography/Drama','2001'),
('The Shape of Water','Adventure/Drama', '2017'),
('Blade Runner 2049','Sci-Fi/Thriller', '2017'),
('Jurassic Park','Adventure/Sci-Fi', '1993'),
('Fight Club','Drama','1999'),
('The Matrix','Action/Sci-Fi','1999'),
('The Godfather','Crime/Drama','1972'),
('Pulp Fiction','Crime/Drama','1994'),
('The Dark Knight','Action/Crime','2008'),
('The Dark Knight Rises','Action/Crime','2012'),
('Forrest Gump','Drama/Romance','1994'),
('Goodfellas','Biography/Crime','1990'),
('Saving Private Ryan','Drama/War','1998'),
('Gladiator','Action/Adventure','2000'),
('Titanic','Drama/Romance','1997'),
('The Revenant','Action/Adventure','2015'),
('Spider-Man','Action/Sci-Fi','2002'),
('Dunkirk',' Action/History','2017'),
('Inception','Action/Adventure','2010'), 
('Wonder Woman','Action/Adventure','2017');

INSERT INTO actors (first_name, last_name, dob) VALUES
('Tobey', 'Maguire', '1975-06-27'),
('Willem', 'Dafoe', '1955-07-22'),
('Leonardo', 'DiCaprio', '1974-11-11'),
('Cillian', 'Murphy', '1976-05-25'),
('Kate', 'Winslet', '1975-10-05'),
('Russell', 'Crowe', '1964-04-07'),
('Tom', 'Hanks', '1956-07-09'),
('Matt', 'Damon', '1970-10-08'),
('Samuel L.', 'Jackson', '1948-12-21'),
('Robert', 'De Niro', '1943-08-17'),
('Gal', 'Gadot', '1985-04-30'),
('Christian', 'Bale', '1974-01-30'),
('Joseph', 'Gordon-Levitt', '1981-02-17'),
('Tom', 'Hardy', '1977-09-15'),
('John', 'Travolta', '1954-02-18'),
('Keanu', 'Reeves', '1964-09-02'),
('Laurence', 'Fishburne', '1961-07-30'),
('Brad', 'Pitt', '1963-12-18'),
('Ryan', 'Gosling', '1980-11-12'),
('Al', 'Pacino', '1940-04-25'),
('Robin', 'Wright', '1966-04-08');

INSERT INTO movies_actors (actor_id, movie_id) VALUES
(1, 20), (1, 1),
(2, 20),
(3, 1), (3, 2), (3, 18), (3, 19), (3, 22),
(4, 21), (4, 12),
(5, 18),
(6, 4), (6, 17),
(7, 14),(7, 16),
(8, 16),
(9, 11),(9, 15),
(10, 15),
(11, 23),
(12, 12),(12, 13),
(13, 12),
(14, 21),(14, 13),(14, 19),(14, 22),
(15, 11),
(16, 9),
(17, 9),
(18, 8),
(19, 3),(19, 6),
(20, 10),
(21, 14), (21, 23);

INSERT INTO ratings (movie_id, score) VALUES
(1, 7.2),(3, 8),(4, 8.2),(8, 8.8),(9, 8.7),(10, 9.2),(11, 8.9),
(12, 9),(13, 8.4),(14, 8.8),(15, 8.7),(16, 8.6),(17, 8.5),
(18, 7.8),(19, 8),(20, 7.4),(21, 7.8),(22, 8.8),(23, 7.4);

SELECT * FROM movies;
SELECT * FROM actors;
SELECT * FROM movies_actors;

-- Q1.
SELECT title, year FROM movies;
SELECT title, year FROM movies ORDER BY title, year;

SELECT title, year FROM movies
ORDER BY year, title;


-- Q2
SELECT mv.title, mv.category FROM movies AS mv WHERE mv.category ILIKE '%Drama%';

-- Q3
SELECT * FROM movies
WHERE category ILIKE '%Adventure%' AND category ILIKE '%Action%';

-- Q4
SELECT movies.title FROM movies WHERE movies.title LIKE 'The%'

-- Q5
SELECT movie_id FROM ratings
ORDER BY score DESC
LIMIT 3;

-- Q5.2
SELECT m.id,m.title,r.score
FROM movies m , ratings r
WHERE r.movie_id = m.id
ORDER BY r.score DESC NULLS LAST
LIMIT 3

-- Q5.3
SELECT movie_id, m.title, score 
FROM ratings 
JOIN movies AS m
ON movie_id = m.id
ORDER BY score DESC LIMIT 3;

-- Q6.1
SELECT title, year, category FROM movies ORDER BY year ASC LIMIT 1; -- 281

-- Q6.2
SELECT title,year
FROM movies
WHERE year = ( SELECT min(year) FROM movies ) -- 204

-- Q6.3
SELECT title,year
FROM movies
WHERE year = ( 1972 ) -- 206

-- Q7
SELECT * FROM actors WHERE dob IS NOT NULL ORDER BY dob DESC LIMIT 1;

SELECT CONCAT_WS(' ', first_name, last_name) as Nom,
EXTRACT(YEAR FROM NOW()) - EXTRACT(YEAR FROM dob) AS age 
FROM actors
ORDER BY dob
DESC LIMIT 1;

-- Q7.3
SELECT concat_WS(' - ',first_name,last_name),
EXTRACT(YEAR FROM NOW()) - EXTRACT(YEAR FROM dob) AS "Age"
FROM actors WHERE dob =(SELECT MAX(dob) FROM actors);


SELECT mv.title FROM movies mv where mv.year = '1990';

-- Q8.1
SELECT * FROM movies
WHERE year BETWEEN 1990 AND 1999;

-- Q8.2
SELECT * FROM movies WHERE year >= 1990 AND year < 2000;

-- Q8.3
SELECT mv.title FROM movies mv WHERE mv."year" IN (1990, 1991, 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999);

-- Q8.4
SELECT mv.title FROM movies mv WHERE mv."year" IN (SELECT year FROM movies WHERE year >= 1990 AND year < 2000);

-- Q8.5
SELECT * FROM movies WHERE year::TEXT ILIKE '199%' ;

-- Q9.1
SELECT * FROM movies WHERE year >= 2010 AND year <= 2015;

-- Q9.2
SELECT * FROM movies WHERE year BETWEEN 2010 AND 2015;

-- Q10.1
SELECT  year, COUNT(year) FROM movies GROUP BY year ORDER BY year;
SELECT year, COUNT(*) FROM movies GROUP BY year ORDER BY year DESC LIMIT 1;

-- Q10. 2
SELECT MAX(YEAR) AS "Prolic Year" FROM (SELECT year, COUNT(year) FROM movies GROUP BY year)

-- Q11.2
SELECT COUNT(*) FROM movies WHERE year <2000;

-- Q12.1
SELECT last_name, EXTRACT(YEAR FROM age(dob)) AS age
FROM actors;

-- Q12.2
SELECT concat_WS(' - ',first_name,last_name) AS prenom_nom, AGE(NOW(), dob) AS age FROM actors;

-- Q12.3
SELECT CONCAT(a.first_name, ' ' , a.last_name) AS "Actor", date_part('year', AGE(a.dob)) AS age FROM actors a;

-- Q12.4
SELECT  CONCAT(first_name, ' ', last_name) AS "Nom complet",
EXTRACT(YEAR FROM NOW()) - EXTRACT(YEAR FROM dob) 
FROM actors WHERE dob IS NOT NULL order by dob desc ;

-- Q13.1
SELECT AVG(AGE(dob)) AS average_age FROM actors;

-- Q13.2
SELECT ROUND(AVG(EXTRACT(YEAR FROM age(dob)))) AS age_moyen FROM actors;

-- Q 13.3
SELECT to_char(AVG(AGE(CURRENT_DATE,dob)),'YY')
FROM actors

-- Q 13.4
SELECT ROUND(AVG(EXTRACT(year FROM age(NOW(), dob)))) AS "Âge Moyen des Acteurs"
FROM actors;

-- Q 14.1
SELECT MIN(EXTRACT(year FROM AGE(NOW(), dob))) AS "Âge Minimum",
       MAX(EXTRACT(year FROM AGE(NOW(), dob))) AS "Âge Maximum"
FROM actors;

-- Q 14.2
SELECT to_char(MIN(AGE(CURRENT_DATE,dob)),'YY') AS "AGE_MINI",
to_char(MAX(AGE(CURRENT_DATE,dob)),'YY') AS "AGE_MAXI"
FROM actors

-- Q 14.3
SELECT MIN(EXTRACT(YEAR FROM age(dob))) AS Min_Age, MAX(EXTRACT(YEAR FROM age(dob))) AS Max_Age FROM actors;

-- Q 14.4
SELECT MIN(actor_age), MAX(actor_age) FROM (SELECT date_part('year', AGE(a.dob)) AS actor_age FROM actors a);

-- Q 14.5
SELECT MIN(AGE(NOW(), dob)) AS min_age, MAX(AGE(NOW(), dob)) AS max_age FROM actors;


-- Q 15
SELECT *
FROM movies
WHERE title LIKE '%2049%';

-- Q 16.1
SELECT title
FROM movies
WHERE  upper(category) like'%CRIME%' AND upper(category) like '%BIOGRAPHY%';

-- Q 16.1'
SELECT DISTINCT category FROM movies
WHERE category LIKE '%Crime%' OR category LIKE '%Biography%';

-- Q 16.3
SELECT * FROM movies WHERE category ILIKE '%Crime%' AND category ILIKE '%Biography%';


-- Q 17.1
SELECT *, CASE
	WHEN score >= 9 THEN 'Génial'
	WHEN score > 8.5 THEN 'Très bien'
	WHEN score >= 7 THEN 'Bien'
	ELSE 'Ennuyeux' -- ! Devrait etre < 5
END	AS Avis
FROM ratings;

-- Q 17.2: Ancienne methode pour effectuer les jointures.
SELECT title,
CASE	when r.score >=9 	then 'Génial'
		when r.score >8.5 	then 'Très Bien'
		when r.score >=7	then 'Bien'
		when r.score <=5	then 'Ennuyeux'
		else 'Pas mal'
END	
FROM movies m , ratings r
WHERE r.movie_id = m.id

-- Q 17.3
SELECT movies.title,
	CASE
		WHEN ratings.score >= 9 THEN 'Génial'
		WHEN ratings.score > 8.5 THEN 'Très bien'
		WHEN ratings.score >= 7 THEN 'Bien'
		WHEN ratings.score > 5 THEN 'Normal'
		WHEN ratings.score <= 5 THEN 'Ennuyeux'
		ELSE 'Pas de score enregistré'
	END AS repertorier_entrees_des_films FROM movies INNER JOIN ratings ON movies.id = ratings.movie_id;
