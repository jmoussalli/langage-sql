
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

