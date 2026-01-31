
create database PruebaT;

use PruebaT;

CREATE TABLE PAIS (
    id INTEGER,
    name VARCHAR(256) NOT NULL,
    CONSTRAINT pais_id_pk PRIMARY KEY(id)
);



SHOW TABLES;

SELECT * FROM PAIS;