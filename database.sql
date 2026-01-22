-- Creation des statut en enumeration

CREATE TYPE statut_cours AS ENUM ('non_commence', 'en_cours', 'termine');
CREATE TYPE statut_seance AS ENUM ('annule', 'prevu', 'en_cours');

--creation des tables dans la base de donnees

--table annee scolaire
CREATE TABLE annee_scolaire (
    id_annee_scolaire INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    start_year INTEGER NOT NULL,
    end_year INTEGER NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    CONSTRAINT valid_years CHECK (end_year = start_year + 1)
);


--table classe

CREATE TABLE classe (
    id_classe INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom_classe VARCHAR (100)
);

--table prof

CREATE TABLE prof(
    id_prof INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom_prof VARCHAR (100),
    nb_abs INTEGER DEFAULT 0
);

-- table matiere

CREATE TABLE matiere(
    id_matiere INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom_matiere VARCHAR (100),
    heure_totale INTEGER,
    id_classe INTEGER,
    CONSTRAINT fk_classe FOREIGN KEY (id_classe) REFERENCES classe (id_classe)
);

-- table cours (table ou admin lie prof et admin)
CREATE TABLE cours(
    id_cours INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    statut statut_cours DEFAULT 'non_commence',
    id_matiere INTEGER,
    id_prof INTEGER,
    cumul INTEGER,
    CONSTRAINT fk_matiere FOREIGN KEY (id_matiere) REFERENCES matiere(id_matiere),
    CONSTRAINT fk_prof FOREIGN KEY (id_prof) REFERENCES prof(id_prof)
);

-- table sceance
CREATE TABLE seance(
    id_seance INTEGER ALWAYS GENERATED AS IDENTITY PRIMARY KEY,
    id_cours INTEGER,
    date_seance DATE,
    heure_debut TIME,
    heure_fin TIME,
    statut statut_seance DEFAULT 'prevu',
    CONSTRAINT fk_cours FOREIGN KEY (id_cours) REFERENCES cours(id_cours)
);


