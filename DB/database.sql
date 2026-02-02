USE PruebaT;

CREATE TABLE Pais (
    id INTEGER AUTO_INCREMENT,
    name VARCHAR(256) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pais_id_pk PRIMARY KEY(id)
);

CREATE TABLE Empresa (
    id INTEGER AUTO_INCREMENT,
    name varchar(256),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT empresa_id_pk PRIMARY KEY(id)
);

CREATE TABLE Empresa_Pais (
    id_empresa INTEGER NOT NULL,
    id_pais INTEGER NOT NULL,

    CONSTRAINT empresa_pais_pk
        PRIMARY KEY (id_empresa, id_pais),

    CONSTRAINT empresa_pais_empresa_fk
        FOREIGN KEY (id_empresa)
        REFERENCES Empresa(id)
        ON DELETE CASCADE,

    CONSTRAINT empresa_pais_pais_fk
        FOREIGN KEY (id_pais)
        REFERENCES Pais(id)
        ON DELETE CASCADE
);

CREATE TABLE Sede (
    id INTEGER AUTO_INCREMENT,
    id_empresa INTEGER,
    id_pais INTEGER,
    name varchar(256) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT sede_id_pk PRIMARY KEY(id),
    CONSTRAINT sede_id_empresa_fk FOREIGN KEY (id_empresa) REFERENCES Empresa(id) ON DELETE CASCADE,
    CONSTRAINT sede_id_pais_fk FOREIGN KEY (id_pais) REFERENCES Pais(id) ON DELETE CASCADE
);

CREATE TABLE Pregunta (
    id INTEGER AUTO_INCREMENT,
    text_pregunta varchar(256),
    CONSTRAINT pregunta_id_pk PRIMARY KEY(id)
);

CREATE TABLE Resena (
    id INTEGER AUTO_INCREMENT,
    id_sede INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT resena_id_pk PRIMARY KEY(id),
    CONSTRAINT respuesta_id_sede_fk FOREIGN KEY (id_sede) REFERENCES Sede(id) ON DELETE CASCADE
);

CREATE TABLE Respuesta (
    id INTEGER AUTO_INCREMENT,
    id_pregunta INTEGER,
    id_resena INTEGER,
    valoracion INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT respuesta_id_pk PRIMARY KEY(id),
    CONSTRAINT respuesta_id_pregunta_fk FOREIGN KEY (id_pregunta) REFERENCES Pregunta(id) ON DELETE CASCADE,
    CONSTRAINT respuesta_id_resena_fk FOREIGN KEY (id_resena) REFERENCES Resena(id) ON DELETE CASCADE
);

DROP TABLE Respuesta;
DROP TABLE Pregunta;
DROP TABLE Resena;
DROP TABLE Sede;
DROP TABLE Empresa_Pais;
DROP TABLE Empresa;
DROP TABLE Pais;

SHOW TABLES;

INSERT INTO Pregunta(text_pregunta) VALUES ('¿Qué tan satisfecho(a) estás con la atención recibida en la sede?');
INSERT INTO Pregunta(text_pregunta) VALUES ('¿Cómo calificarías la calidad del servicio brindado por el personal?');
INSERT INTO Pregunta(text_pregunta) VALUES ('¿Qué tan rápido consideras que fue el tiempo de atención?');
INSERT INTO Pregunta(text_pregunta) VALUES ('¿Cómo evaluarías el cuidado que se tuvo con tu vehículo durante el lavado?');
INSERT INTO Pregunta(text_pregunta) VALUES ('En general, ¿qué tan probable es que recomiendes esta sede a otras personas?');

SELECT * FROM Pregunta;

INSERT INTO Pais(name) VALUES ('GUATEMALA');
INSERT INTO Pais(name) VALUES ('EL SALVADOR');
INSERT INTO Pais(name) VALUES ('HONDURAS');
INSERT INTO Pais(name) VALUES ('COSTA RICA');
INSERT INTO Pais(name) VALUES ('NICARAGUA');

SELECT * FROM Pais;

INSERT INTO Empresa(name)VALUES ('CleanRide');
INSERT INTO Empresa(name) VALUES ('Brillo Total');

SELECT * FROM Empresa;

INSERT INTO Empresa_Pais(id_empresa, id_pais) VALUES (1,1);
INSERT INTO Empresa_Pais(id_empresa, id_pais) VALUES (1,3);
INSERT INTO Empresa_Pais(id_empresa, id_pais) VALUES (1,4);
INSERT INTO Empresa_Pais(id_empresa, id_pais) VALUES (1,2);
INSERT INTO Empresa_Pais(id_empresa, id_pais) VALUES (2,4);
INSERT INTO Empresa_Pais(id_empresa, id_pais) VALUES (2,3);

SELECT * FROM Empresa_Pais;

SELECT p.name
FROM Empresa e
JOIN  Empresa_Pais ep ON e.id = ep.id_empresa
JOIN Pais p ON ep.id_pais = p.id
WHERE e.name = 'CleanRide';

/*Brillo Total*/
INSERT INTO Sede(id_empresa, id_pais, name) VALUES (2,3,'Tegucigalpa Centro');
INSERT INTO Sede(id_empresa, id_pais, name) VALUES (2,3,'Morazán');
INSERT INTO Sede(id_empresa, id_pais, name) VALUES (2,3,'San Pedro Sula');

INSERT INTO Sede(id_empresa, id_pais, name) VALUES (2,4,'Alajuela');
INSERT INTO Sede(id_empresa, id_pais, name) VALUES (2,4,'San Jose Centro');
INSERT INTO Sede(id_empresa, id_pais, name) VALUES (2,4,'Escazú');

/*CleanRide*/
INSERT INTO Sede(id_empresa, id_pais, name) VALUES (1,1,'Zona 10');
INSERT INTO Sede(id_empresa, id_pais, name) VALUES (1,1,'Roosevelt');
INSERT INTO Sede(id_empresa, id_pais, name) VALUES (1,1,'Mixco');

INSERT INTO Sede(id_empresa, id_pais, name) VALUES (1,2,'San Salvador');
INSERT INTO Sede(id_empresa, id_pais, name) VALUES (1,2,'Santa Tecla');
INSERT INTO Sede(id_empresa, id_pais, name) VALUES (1,2,'Soyapando');

INSERT INTO Sede(id_empresa, id_pais, name) VALUES (1,3,'La Ceiba');
INSERT INTO Sede(id_empresa, id_pais, name) VALUES (1,3,'Choluteca');
INSERT INTO Sede(id_empresa, id_pais, name) VALUES (1,3,'Comayagua');

INSERT INTO Sede(id_empresa, id_pais, name) VALUES (1,4,'Heredia');
INSERT INTO Sede(id_empresa, id_pais, name) VALUES (1,4,'LIberia');
INSERT INTO Sede(id_empresa, id_pais, name) VALUES (1,4,'Cartago');

SELECT e.name, p.name, s.name
FROM Empresa e
JOIN Sede s ON s.id_empresa = e.id
JOIN Pais p ON s.id_pais = p.id
Where e.name = 'CleanRide';