#creazione degli account utente
# DELETE FROM utente WHERE TRUE;
INSERT INTO utente (email, nome,cognome,token,ban,ruolo,mansione) VALUES
    ('testAdmin@itiszuccante.edu.it','admin','admin','testtoken',FALSE,'admin',NULL),

    ('davide.yeh@itiszuccante.edu.it','Davide','Yeh','testtoken',FALSE,'utente',NULL),
    ('matteo.valerii@itiszuccante.edu.it','Matteo','Valerii','testtoken',FALSE,'utente',NULL),
    ('alessandro.corliano@itiszuccante.edu.it','Alessandro','Corlianò','testtoken',FALSE,'utente',NULL),
    ('diego.denunzio@itiszuccante.edu.it','Diego','De Nunzio','testtoken',FALSE,'tecnico',NULL),
    ('fiorenzo.donofrio@itiszuccante.edu.it','Fiorenzo','D`onofrio','testtoken',FALSE,'tecnico',NULL),

    #tecnici del piano terra
    ('massimo.ballin@itiszuccante.edu.it','Massimo','Ballin','testtoken',FALSE,'tecnico',NULL),

    #tecnici del 2o piano
    ('gianluca.masetti@itiszuccante.edu.it','Gianluca','Masetti','testtoken',FALSE,'tecnico',NULL);


INSERT INTO piano (id,nome)VALUES
    (0, 'terra'),
    (1, 'primo'),
    (2, 'secondo');


DELETE FROM stanza WHERE TRUE;
ALTER TABLE stanza AUTO_INCREMENT = 1;
INSERT INTO stanza (nome,piano,tipo) VALUES
    ('3IA',0,'aula'),
    ('4IA',0,'aula'),
    ('5IA',0,'aula'),
    ('3IB',0,'aula'),
    ('4IB',0,'aula'),
    ('5IB',0,'aula'),
    ('Aula relax',0,'aula'),
    ('3ID',0,'aula'),
    ('3IE',0,'aula'),
    ('LAS',0,'laboratorio'),
    ('Locale A.T. LAS',0,'ufficio'),
    ('LLM',0,'laboratorio'),
    ('LAP2',0,'laboratorio'),
    ('LAM',0,'laboratorio'),
    ('WC1',0,'bagno'),
    ('WC2',0,'bagno'),
    ('LASA',0,'laboratorio'),
    ('OEN1',0,'laboratorio'),
    ('Palestra',0,'aula'),
    ('Spogliatoio maschile',0,'bagno'),
    ('Spogliatoio femminile',0,'bagno'),

    ('4EA-TA',1,'aula'),
    ('4TA',1,'aula'),
    ('5EA-TA',1,'aula'),
    ('5TA',1,'aula'),
    ('3EA',1,'aula'),
    ('4AB',1,'aula'),
    ('5AB',1,'aula'),
    ('4IC',1,'aula'),
    ('3IC',1,'aula'),
    ('5IC',1,'aula'),
    ('3AA',1,'aula'),
    ('4AA',1,'aula'),
    ('5AA',1,'aula'),
    ('Musica',1,'aula'),
    ('WC3',1,'bagno'),
    ('WC4',1,'bagno'),
    ('Sala lettura',1,'aula'),
    ('Deposito libri',1,'aula'),
    ('Aula insegnanti',1,'aula'),
    ('Locale A.T. LAP1',1,'ufficio'),
    ('LAP1',1,'laboratorio'),
    ('CIM/SALA SERVER',1,'ufficio'),
    ('OEN2',1,'laboratorio'),
    ('WC5',1,'bagno'),
    ('WC6',1,'bagno'),
    ('BAR',1,'bar'),

    ('LEN5',2,'laboratorio'),
    ('LEN4',2,'laboratorio'),
    ('Uffico tecnico',2,'ufficio'),
    ('Segreteria didattica',2,'ufficio'),
    ('PCTO',2,'ufficio'),
    ('Locale A.T.',2,'ufficio'),
    ('Vice presidenza',2,'ufficio'),
    ('Presidenza',2,'ufficio'),
    ('Locale',2,'ufficio'),
    ('Ufficio DSGA',2,'ufficio'),
    ('Ufficio personale',2,'ufficio'),
    ('magazzino',2,'ufficio');



DELETE FROM dispositivo WHERE TRUE;
ALTER TABLE dispositivo AUTO_INCREMENT = 1;
INSERT INTO dispositivo (nome,tipo,codice_stanza) VALUES
    ('LAP1-WS01','fisso',42),
    ('LAP1-WS02','fisso',42),
    ('LAP1-WS03','fisso',42),
    ('LAP1-WS04','fisso',42),
    ('LAP1-WS05','fisso',42),
    ('LAP1-WS06','fisso',42),
    ('LAP1-WS07','fisso',42),
    ('LAP1-WS08','fisso',42),
    ('LAP1-WS09','fisso',42),
    ('LAP1-WS10','fisso',42),
    ('LAP1-WS11','fisso',42),
    ('LAP1-WS12','fisso',42),
    ('LAP1-WS13','fisso',42),
    ('LAP1-WS14','fisso',42),
    ('LAP1-WS15','fisso',42),
    ('LAP1-WS16','fisso',42),
    ('LAP1-WS17','fisso',42),
    ('LAP1-WS18','fisso',42),
    ('LAP1-WS19','fisso',42),
    ('LAP1-WS20','fisso',42),
    ('LAP1-WS21','fisso',42),
    ('LAP1-WS22','fisso',42),
    ('LAP1-WS23','fisso',42),
    ('LAP1-WS24','fisso',42),
    ('LAP1-WS25','fisso',42),
    ('LAP1-WS26','fisso',42),
    ('LAP1-WS27','fisso',42),
    ('LAP1-WS28','fisso',42),
    ('LAP1-WS29','fisso',42),
    ('LAP1-WS30','fisso',42),
    ('LAP1-WS31','fisso',42),


    ('LAP2-WS01','fisso',13),
    ('LAP2-WS02','fisso',13),
    ('LAP2-WS03','fisso',13),
    ('LAP2-WS04','fisso',13),
    ('LAP2-WS05','fisso',13),
    ('LAP2-WS06','fisso',13),
    ('LAP2-WS07','fisso',13),
    ('LAP2-WS08','fisso',13),
    ('LAP2-WS09','fisso',13),
    ('LAP2-WS10','fisso',13),
    ('LAP2-WS11','fisso',13),
    ('LAP2-WS12','fisso',13),
    ('LAP2-WS13','fisso',13),
    ('LAP2-WS14','fisso',13),
    ('LAP2-WS15','fisso',13),
    ('LAP2-WS16','fisso',13),
    ('LAP2-WS17','fisso',13),
    ('LAP2-WS18','fisso',13),
    ('LAP2-WS19','fisso',13),
    ('LAP2-WS20','fisso',13),
    ('LAP2-WS21','fisso',13),
    ('LAP2-WS22','fisso',13),
    ('LAP2-WS23','fisso',13),
    ('LAP2-WS24','fisso',13),
    ('LAP2-WS25','fisso',13),
    ('LAP2-WS26','fisso',13),
    ('LAP2-WS27','fisso',13),
    ('LAP2-WS28','fisso',13),
    ('LAP2-WS29','fisso',13),
    ('LAP2-WS30','fisso',13),

    ('LAS-WS01','fisso',10),
    ('LAS-WS02','fisso',10),
    ('LAS-WS03','fisso',10),
    ('LAS-WS04','fisso',10),
    ('LAS-WS05','fisso',10),
    ('LAS-WS06','fisso',10),
    ('LAS-WS07','fisso',10),
    ('LAS-WS08','fisso',10),
    ('LAS-WS09','fisso',10),
    ('LAS-WS10','fisso',10),
    ('LAS-WS11','fisso',10),
    ('LAS-WS12','fisso',10),
    ('LAS-WS13','fisso',10),
    ('LAS-WS14','fisso',10),
    ('LAS-WS15','fisso',10),
    ('LAS-WS16','fisso',10),
    ('LAS-WS17','fisso',10),
    ('LAS-WS18','fisso',10),
    ('LAS-WS19','fisso',10),
    ('LAS-WS20','fisso',10),
    ('LAS-WS21','fisso',10),
    ('LAS-WS22','fisso',10),
    ('LAS-WS23','fisso',10),
    ('LAS-WS24','fisso',10),
    ('LAS-WS25','fisso',10),
    ('LAS-WS26','fisso',10),
    ('LAS-WS27','fisso',10),
    ('LAS-WS28','fisso',10),
    ('LAS-WS29','fisso',10),
    ('LAS-WS30','fisso',10),


    ('LLM-WS01','fisso',12),
    ('LLM-WS02','fisso',12),
    ('LLM-WS03','fisso',12),
    ('LLM-WS04','fisso',12),
    ('LLM-WS05','fisso',12),
    ('LLM-WS06','fisso',12),
    ('LLM-WS07','fisso',12),
    ('LLM-WS08','fisso',12),
    ('LLM-WS09','fisso',12),
    ('LLM-WS10','fisso',12),
    ('LLM-WS11','fisso',12),
    ('LLM-WS12','fisso',12),
    ('LLM-WS13','fisso',12),
    ('LLM-WS14','fisso',12),
    ('LLM-WS15','fisso',12),
    ('LLM-WS16','fisso',12),
    ('LLM-WS17','fisso',12),
    ('LLM-WS18','fisso',12),
    ('LLM-WS19','fisso',12),
    ('LLM-WS20','fisso',12),
    ('LLM-WS21','fisso',12),
    ('LLM-WS22','fisso',12),
    ('LLM-WS23','fisso',12),
    ('LLM-WS24','fisso',12),
    ('LLM-WS25','fisso',12),
    ('LLM-WS26','fisso',12),
    ('LLM-WS27','fisso',12),
    ('LLM-WS28','fisso',12),
    ('LLM-WS29','fisso',12),

    ('OEN1-WS01','fisso',18),
    ('OEN1-WS02','fisso',18),
    ('OEN1-WS03','fisso',18),
    ('OEN1-WS04','fisso',18),
    ('OEN1-WS05','fisso',18),
    ('OEN1-WS06','fisso',18),
    ('OEN1-WS07','fisso',18),
    ('OEN1-WS08','fisso',18),
    ('OEN1-WS09','fisso',18),
    ('OEN1-WS10','fisso',18),
    ('OEN1-WS11','fisso',18),
    ('OEN1-WS12','fisso',18),
    ('OEN1-WS13','fisso',18),
    ('OEN1-WS14','fisso',18),
    ('OEN1-WS15','fisso',18),
    ('OEN1-WS16','fisso',18),
    ('OEN1-WS17','fisso',18),
    ('OEN1-WS18','fisso',18),
    ('OEN1-WS19','fisso',18),
    ('OEN1-WS20','fisso',18),
    ('OEN1-WS21','fisso',18),
    ('OEN1-WS22','fisso',18),
    ('OEN1-WS23','fisso',18),
    ('OEN1-WS24','fisso',18),
    ('OEN1-WS25','fisso',18),
    ('OEN1-WS26','fisso',18),
    ('OEN1-WS27','fisso',18),
    ('OEN1-WS28','fisso',18),
    ('OEN1-CAT01','fisso',18),
    ('OEN1-CAT02','fisso',18),
    ('WS01','fisso',3),
    ('WS01','fisso',1),
    ('WS01','fisso',32);

# insert degli alert dei tecnici
INSERT INTO alert_tecnico (tecnico, stanza, dispositivo)
VALUES ('diego.denunzio@itiszuccante.edu.it',1,NULL),
       ('diego.denunzio@itiszuccante.edu.it',2,NULL),
       ('diego.denunzio@itiszuccante.edu.it',3,NULL),
       ('diego.denunzio@itiszuccante.edu.it',NULL,1);


INSERT INTO collaboratore_piano (tecnico, piano)
VALUES ('fiorenzo.donofrio@itiszuccante.edu.it', 1),
       ('massimo.ballin@itiszuccante.edu.it', 0);


#Creazione view per i dispositivi
CREATE OR REPLACE VIEW dispositivi AS SELECT dispositivo.codice as id,dispositivo.nome AS nome, dispositivo.tipo AS tipo,
stanza.nome AS stanza FROM dispositivo JOIN stanza ON stanza.codice = dispositivo.codice_stanza;
#Creazione view per le stanze
CREATE OR REPLACE VIEW stanze AS SELECT * FROM stanza;


#Creazione degli utenti
CREATE USER admin;
CREATE USER admin@localhost;
SET PASSWORD FOR 'admin'@localhost = PASSWORD('password');
GRANT ALL ON *.* TO 'admin';


CREATE USER 'user'@localhost;
# SET PASSWORD FOR 'user'@localhost = PASSWORD('userpassword');
SET PASSWORD FOR 'user' = PASSWORD('userpassword');
GRANT SELECT, INSERT, UPDATE, DELETE ON *.* TO 'user';
#GRANT SELECT, INSERT, UPDATE, DELETE ON *.* TO 'user'@'localhost';
# REVOKE SELECT, INSERT, UPDATE, DELETE ON helpdesk.* FROM 'user'@localhost;


