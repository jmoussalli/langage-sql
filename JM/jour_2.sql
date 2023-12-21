
select * from books;

-- Sous-requête

DROP TABLE IF EXISTS books;
CREATE TABLE IF NOT EXISTS books (
                                     id SERIAL,
                                     title VARCHAR(150),
                                     year_published SMALLINT,
                                     publisher VARCHAR(50),
                                     price NUMERIC(6,2)
);

INSERT INTO books (title, year_published, publisher, price) VALUES
    ('Introduction au SQL', 2000, 'Packt', 15.49),
    ('La methode Agile', 2005, 'Oreilly', 23.99),
    ('Git & GitHub', 2020, 'Oreilly', 41.99),
    ('SQL pour l''analyse des données', 2021, 'Oreilly', 59.99),
    ('Le CSS', 2014, 'Wiley', 15.99),
    ('SQL : éléments internes de la base de données', 2018, 'Packt', 63.75),
    ('Java: Introduction', 2014,'Wiley', 11.99),
    ('Laravel pour les nuls', 2012, 'Apress', 23.99),
    ('L''art du SQL', 2015, 'Wiley', 27.75);

select * from books where title ILIKE '%SQL%';
select * from books where price > 20;
select * from books where title ILIKE '%SQL%' AND id IN (select id from books where price > 20);

-- CASE: Pour les colonnes conditionnelles
SELECT *,
        CASE
            WHEN books.price > 20 THEN 'Très cher'
            WHEN books.price > 15 THEN 'Pas mal'
            WHEN books.price > 12 THEN 'Abordable'
            ELSE 'moins cher'
        END
        AS AvisSurPrix
FROM books;

--contraintes
drop table if exists books;
drop table if exists authors;
drop table if exists books_authors;

CREATE TABLE IF NOT EXISTS books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    year_published SMALLINT NOT NULL,
    publisher VARCHAR(50) NOT NULL,
    price NUMERIC(6,2) NOT NULL CHECK(price>0)
);

CREATE TABLE IF NOT EXISTS authors (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS books_authors (
    book_id INTEGER REFERENCES books,
    author_id INTEGER REFERENCES authors
);

INSERT INTO books (title, year_published, publisher, price) VALUES
                                                                ('Introduction au SQL', 2000, 'Packt', 15.49),
                                                                ('La methode Agile', 2005, 'Oreilly', 23.99),
                                                                ('Git & GitHub', 2020, 'Oreilly', 41.99),
                                                                ('SQL pour l''analyse des données', 2021, 'Oreilly', 59.99),
                                                                ('Le CSS', 2014, 'Wiley', 15.99),
                                                                ('SQL : éléments internes de la base de données', 2018, 'Packt', 63.75),
                                                                ('Java: Introduction', 2014,'Wiley', 11.99),
                                                                ('Laravel pour les nuls', 2012, 'Apress', 23.99),
                                                                ('L''art du SQL', 2015, 'Wiley', 27.75);


INSERT INTO authors (first_name, last_name) VALUES ('Xavier', 'Dupont'), ('Christophe', 'Laporte'), ('Pascal', 'Louis'), ('Claire', 'Martin');


ALTER TABLE books_authors
    DROP CONSTRAINT books_authors_book_id_fkey,
    ADD CONSTRAINT books_authors_book_id_fkey
        FOREIGN KEY(book_id) REFERENCES books
            ON DELETE CASCADE;

ALTER TABLE books_authors
    DROP CONSTRAINT books_authors_book_id_fkey,
    ADD CONSTRAINT books_authors_book_id_fkey
        FOREIGN KEY(book_id) REFERENCES books
            ON DELETE SET NULL ;

select * from books;
select * from authors;
select * from books_authors;


DROP VIEW IF EXISTS books_authors_view;
CREATE VIEW books_authors_view AS
SELECT
    b.id AS book_id,
    b.title,
    b.year_published,
    b.publisher,
    b.price,
    a.id AS author_id,
    a.first_name,
    a.last_name
FROM
    books b
        JOIN
    books_authors ba ON b.id = ba.book_id
        JOIN
    authors a ON a.id = ba.author_id;

SELECT * FROM books_authors_view;
