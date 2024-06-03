CREATE TABLE utente (
    email VARCHAR(255) PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    cognome VARCHAR(255) NOT NULL,
    token VARCHAR(255) NOT NULL,
    ban BOOLEAN NOT NULL DEFAULT FALSE,
    ruolo ENUM ('utente', 'admin', 'tecnico', 'collaboratore'),
    mansione TEXT,
    CONSTRAINT email_format CHECK (email LIKE '%@itiszuccante.edu.it' OR email LIKE '%@itiszuccante.gov.it')
);


CREATE TABLE piano(
    id INTEGER PRIMARY KEY,
    nome ENUM ('terra','primo','secondo')
);

CREATE TABLE stanza(
    codice INTEGER AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    piano INTEGER NOT NULL,
    tipo ENUM ('laboratorio','aula','bagno','ufficio','bar') NOT NULL,
    FOREIGN KEY (piano) REFERENCES piano(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE dispositivo(
    codice INTEGER AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    tipo ENUM('portatile','fisso') NOT NULL,
    codice_stanza INTEGER,
    FOREIGN KEY (codice_stanza) REFERENCES stanza(codice) ON DELETE SET NULL
);

CREATE TABLE tecnico_stanza(
    tecnico VARCHAR(255),
    stanza INTEGER,
    PRIMARY KEY (tecnico,stanza),
    FOREIGN KEY (tecnico) REFERENCES utente(email) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (stanza) REFERENCES stanza(codice) ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE TABLE collaboratore_piano(
    tecnico VARCHAR(255),
    piano INTEGER,
    PRIMARY KEY (tecnico,piano),
    FOREIGN KEY (tecnico) REFERENCES utente(email) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (piano) REFERENCES piano(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE segnalazione(
    id_utente VARCHAR(255),
    data DATETIME NOT NULL,
    descrizione TEXT NOT NULL,
    tipo ENUM('strutturale', 'tecnico') NOT NULL,
    stato ENUM('in corso', 'non assegnato', 'risolto') NOT NULL,
    id_dispositivo INTEGER,
    id_stanza INTEGER,
    PRIMARY KEY(id_utente, data),
    FOREIGN KEY (id_utente) REFERENCES utente(email) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_dispositivo) REFERENCES dispositivo(codice) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_stanza) REFERENCES stanza(codice) ON DELETE CASCADE ON UPDATE CASCADE
);
# DROP TABLE IF EXISTS alert_tecnico;
CREATE TABLE alert_tecnico(
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    tecnico VARCHAR(255),
    stanza INTEGER,
    dispositivo INTEGER,
    FOREIGN KEY (tecnico) REFERENCES utente(email),
    FOREIGN KEY (stanza) REFERENCES stanza(codice),
    FOREIGN KEY (dispositivo) REFERENCES dispositivo(codice)
);

DROP TABLE notifica;
CREATE TABLE notifica(
    data DATETIME NOT NULL,
    destinatario VARCHAR(255),
    descrizione TEXT NOT NULL,
    stato ENUM ('da leggere','letto') NOT NULL,
    PRIMARY KEY (data,destinatario),
    FOREIGN KEY (destinatario) REFERENCES utente(email) ON DELETE CASCADE
);

# DROP TABLE IF EXISTS segnalazione_tecnico;
CREATE TABLE segnalazione_tecnico (
    tecnico VARCHAR(255) NOT NULL,
    id_segnalazione INTEGER NOT NULL, #id_segnalazione equivale al calcolo della data e id_utente da stringa a ascii
    PRIMARY KEY (tecnico, id_segnalazione),
    FOREIGN KEY (tecnico) REFERENCES utente(email) ON DELETE CASCADE
);