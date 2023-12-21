--TP1 Smartphone

CREATE DATABASE sales;

DROP TABLE IF EXISTS public.telephones;
create TABLE IF NOT EXISTS public.telephones (
                           id SERIAL PRIMARY KEY ,
                           name VARCHAR(20),
                           manufacturer VARCHAR(20),
                           price NUMERIC(6,2),
                           units_sold SMALLINT
);

select * from telephones;

INSERT INTO telephones (name, manufacturer, price, units_sold) VALUES
                       ('N1280', 'Nokia', 199, 1925),
                       ('Iphone 4', 'Apple', 399, 9436),
                       ('Galaxy S 5', 'Samsung', 299, 2359),
                       ('S5620 Monte', 'Samsung', 250, 2385),
                       ('N8', 'Nokia', 150, 7543),
                       ('Droid', 'Motorola', 150, 8395),
                       ('Iphone 13 Pro Max', 'Apple', 1300, 12849),
                       ('Galaxy Note 20', 'Samsung', 1100, 10353),
                       ('Lumia 920', 'Nokia', 299, 5847),
                       ('Iphone SE', 'Apple', 499, 9726),
                       ('Galaxy S20', 'Samsung', 899, 7435),
                       ('P40 Pro', 'Huawei', 799, 5382),
                       ('Moto G7', 'Motorola', 199, 6903),
                       ('Redmi Note 9 Pro', 'Xiaomi', 299, 4208),
                       ('Pixel 5', 'Google', 699, 3121),
                       ('Xperia 1 II', 'Sony', 1099, 1923),
                       ('3310', 'Nokia', 99, 12568),
                       ('Iphone 12', 'Apple', 1099, 10548),
                       ('Galaxy A51', 'Samsung', 399, 8620),
                       ('P30 Pro', 'Huawei', 899, 6741),
                       ('Moto G8', 'Motorola', 249, 5947),
                       ('Redmi Note 8 Pro', 'Xiaomi', 249, 5184),
                       ('Pixel 4a', 'Google', 499, 3129),
                       ('Xperia 5 II', 'Sony', 899, 2387),
                       ('6.2', 'Nokia', 179, 8412),
                       ('Iphone 11', 'Apple', 799, 10962),
                       ('Galaxy A71', 'Samsung', 499, 7692),
                       ('P20 Pro', 'Huawei', 699, 4510),
                       ('Moto E6 Plus', 'Motorola', 149, 6934),
                       ('Redmi Note 7', 'Xiaomi', 199, 4367),
                       ('Pixel 3a', 'Google', 399, 2296),
                       ('Xperia 10 II', 'Sony', 399, 1715),
                       ('Nokia 7.2', 'Nokia', 349, 4598),
                       ('Iphone X', 'Apple', 999, 8765),
                       ('Galaxy S10', 'Samsung', 799, 6543),
                       ('P30 Lite', 'Huawei', 299, 3812),
                       ('Moto G6', 'Motorola', 199, 5291),
                       ('Redmi Note 6 Pro', 'Xiaomi', 249, 3719),
                       ('Pixel 2 XL', 'Google', 599, 2098),
                       ('Xperia XZ2', 'Sony', 699, 1543),
                       ('Nokia 6.1', 'Nokia', 249, 3127),
                       ('Iphone XR', 'Apple', 799, 7392),
                       ('Galaxy A50', 'Samsung', 349, 5967),
                       ('P20 Lite', 'Huawei', 349, 4210),
                       ('Moto G5 Plus', 'Motorola', 179, 4923),
                       ('Redmi Note 5', 'Xiaomi', 199, 3176),
                       ('Pixel XL', 'Google', 499, 1823),
                       ('Xperia XZ3', 'Sony', 799, 1287),
                       ('Nokia 5.3', 'Nokia', 199, 2587),
                       ('Iphone 8', 'Apple', 699, 6098);

select * from telephones;

-- *=> Ecrire une requête pour liste tous les modèles de téléphones
select DISTINCT  telephones.manufacturer FROM telephones ORDER BY manufacturer;
select telephones.manufacturer FROM telephones GROUP BY telephones.manufacturer ORDER BY manufacturer;
-- *=> Ecrire une requête pour lister tous les détails(name, manufacturer) de tous les
-- téléphone dont le prix est supérieur à 200€
select name, manufacturer, price from telephones where price > 200 ORDER BY telephones.manufacturer, name;
-- *=> Ecrire une requête pour lister les détails(name, manufacturer) de tous les
-- téléphone dont le prix varie entre 150 et 200€
select * from telephones where price >= 150 AND price <= 200 ORDER BY telephones.manufacturer, name;
select * from telephones where price BETWEEN 150 AND 200 ORDER BY telephones.manufacturer, name;
-- *=> Lister tous les téléphones de marque samsung et Apple
select * from telephones where manufacturer IN ('Samsung', 'Apple') ORDER BY manufacturer, name;
select * from telephones where manufacturer ILIKE '%samsung%' OR manufacturer ILIKE '%Apple%' ORDER BY manufacturer, name;
-- *=> Afficher le revenu total pour les téléphones vendues.Pour chaque téléphone, vous
-- avez le prix et la quantité vendu
select *, telephones.price * telephones.units_sold AS total from telephones ORDER BY manufacturer;
-- *=> Afficher le nombre des téléphones Apple
select manufacturer, count(*) from telephones WHERE manufacturer = 'Apple' GROUP BY manufacturer;
select manufacturer, SUM(telephones.units_sold) from telephones WHERE manufacturer = 'Apple' GROUP BY manufacturer;
-- *=> Afficher toutes les données de la table téléphone en renommant les champs de la
-- manière suivante : name=>modèle, manufacturer => fabricant, price => prix,
-- units_sold => quantité vendue
select name AS modèle, manufacturer AS fabricant, price AS prix, units_sold AS "quantité vendue" FROM telephones ORDER BY manufacturer,name;
select name AS modèle, manufacturer AS fabricant, price AS prix, units_sold AS quantité_vendue FROM telephones ORDER BY manufacturer,name;

-- *=> Afficher tous les téléphones dont le prix total des ventes est supérieur à
-- 1300000€.
select *, price*units_sold AS total_ventes  from telephones where price*units_sold >1300000;

-- Chiffre d'affaire par manufacturer ?
select name, manufacturer, price * units_sold AS total_vente from telephones ORDER BY manufacturer, name;
select name, manufacturer, SUM(units_sold*price) AS total_vente from telephones GROUP BY name, manufacturer ORDER BY manufacturer, name;

select manufacturer, SUM(units_sold) as qty
from telephones GROUP BY manufacturer HAVING SUM(units_sold) > 1000 ORDER BY manufacturer;
