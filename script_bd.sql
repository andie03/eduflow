
-- enumeration type
CREATE TYPE statut_matiere AS ENUM ('pas_encore_commence','en_cours','termine');
CREATE TYPE statut_cours AS ENUM ('en_cours','annule','en_retard');

-- classe
CREATE TABLE classe (
    id_classe INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom_classe VARCHAR(100) NOT NULL
);

-- prof
CREATE TABLE prof (
    id_prof INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom_prof VARCHAR(100) NOT NULL,
    rating NUMERIC(3,2) DEFAULT 0
);

-- matiere
CREATE TABLE matiere (
    id_matiere INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom_matiere VARCHAR(100) NOT NULL,
    statut statut_matiere DEFAULT 'pas_encore_commence',
    heure_totale INTEGER NOT NULL,
    id_prof INTEGER,
    id_classe INTEGER,
    CONSTRAINT fk_classe FOREIGN KEY (id_classe) REFERENCES classe(id_classe),
    CONSTRAINT fk_prof FOREIGN KEY (id_prof) REFERENCES prof(id_prof)
);

--cours
CREATE TABLE cours (
    id_cours INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    date_cours DATE NOT NULL,
    heure_debut TIME NOT NULL,
    heure_fin TIME NOT NULL,
    statut statut_cours DEFAULT 'en_cours',
    id_prof INTEGER,
    id_classe INTEGER,
    id_matiere INTEGER,
    CONSTRAINT fk_prof FOREIGN KEY(id_prof) REFERENCES prof(id_prof),
    CONSTRAINT fk_classe FOREIGN KEY(id_classe) REFERENCES classe(id_classe),
    CONSTRAINT fk_matiere FOREIGN KEY(id_matiere) REFERENCES matiere(id_matiere)
);

--avancement de chaque cours
CREATE TABLE progression (
    id_progression INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_matiere INTEGER REFERENCES matiere(id_matiere),
    id_classe INTEGER REFERENCES classe(id_classe),
    id_prof INTEGER REFERENCES prof(id_prof),
    date_update DATE DEFAULT CURRENT_DATE,
    avancement NUMERIC(5,2) CHECK (avancement BETWEEN 0 AND 100),
    statut statut_matiere DEFAULT 'pas_encore_commence'
);

--abs des profs
CREATE TABLE absence_prof (
    id_absence INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_prof INTEGER REFERENCES prof(id_prof),
    id_cours INTEGER REFERENCES cours(id_cours),
    motif TEXT,
    date_absence DATE NOT NULL
);
