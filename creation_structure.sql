--Suppression des vues
DROP VIEW IF EXISTS employe_calibration;
DROP VIEW IF EXISTS nombre_conducteur_inspection;
DROP VIEW IF EXISTS employe_departement_poste;
DROP VIEW IF EXISTS calibration_plus_recente;

ALTER TABLE IF EXISTS employe DROP CONSTRAINT IF EXISTS fk_employe_poste;
ALTER TABLE IF EXISTS employe DROP CONSTRAINT IF EXISTS fk_employe_departement;
ALTER TABLE IF EXISTS calibration DROP CONSTRAINT IF EXISTS fk_calibration_profileur;
ALTER TABLE IF EXISTS calibration DROP CONSTRAINT IF EXISTS fk_calibration_employe;

-- Suppression de contraintes
ALTER TABLE IF EXISTS lumiere 							DROP CONSTRAINT IF EXISTS fk_lum_forme;
ALTER TABLE IF EXISTS lumiere 							DROP CONSTRAINT IF EXISTS fk_lum_couleur;
ALTER TABLE IF EXISTS lumiere							DROP CONSTRAINT IF EXISTS fk_lum_dispositif;
ALTER TABLE IF EXISTS panneau 							DROP CONSTRAINT IF EXISTS fk_pan_troncon;
ALTER TABLE IF EXISTS panneau 							DROP CONSTRAINT IF EXISTS fk_pan_panneau;
ALTER TABLE IF EXISTS dispositif_particulier 			DROP CONSTRAINT IF EXISTS fk_dis_par_troncon;
ALTER TABLE IF EXISTS dispositif_particulier 			DROP CONSTRAINT IF EXISTS fk_dis_par_panneau;
ALTER TABLE IF EXISTS dispositif_lumineux 				DROP CONSTRAINT IF EXISTS fk_dl_tro;
ALTER TABLE IF EXISTS inspection						DROP CONSTRAINT IF EXISTS fk_inspection_vehicule;
ALTER TABLE IF EXISTS inspection						DROP CONSTRAINT IF EXISTS fk_inspection_profileur_laser;
ALTER TABLE IF EXISTS inspection						DROP CONSTRAINT IF EXISTS fk_inspection_conducteur;
ALTER TABLE IF EXISTS inspection						DROP CONSTRAINT IF EXISTS fk_inspection_inspecteur;



-- Suppression de tables

DROP TABLE IF EXISTS type_panneau;
DROP TABLE IF EXISTS panneau;
DROP TABLE IF EXISTS type_dispositif_particulier;
DROP TABLE IF EXISTS dispositif_particulier;
DROP TABLE IF EXISTS couleur;
DROP TABLE IF EXISTS forme;
DROP TABLE IF EXISTS lumiere;
DROP TABLE IF EXISTS dispositif_lumineux;
DROP TABLE IF EXISTS vehicule, calibration, profileur_laser, employe, poste, departement, troncon, intersection, inspection, troncon_inspection; 

-- Suppression de enums

DROP TYPE IF EXISTS TYPE_MODE CASCADE;
DROP TYPE IF EXISTS TYPE_ORIENTAION CASCADE;
DROP TYPE IF EXISTS genre CASCADE;
DROP TYPE IF EXISTS pavage CASCADE;

--Suppression sequences
DROP SEQUENCE IF EXISTS identifiant_intersection;
DROP SEQUENCE IF EXISTS numero_immatriculation;
DROP SEQUENCE IF EXISTS numero_serie;
DROP SEQUENCE IF EXISTS numero_nom_fichier;

--Suppression des index
DROP INDEX IF EXISTS chercher_lumiere_forme;
DROP INDEX IF EXISTS chercher_conducteur;
DROP INDEX IF EXISTS chercher_inspection_troncon;
DROP INDEX IF EXISTS id_employe;

-- Thomas
CREATE TYPE genre AS ENUM('f', 'h', 'x');
CREATE TYPE pavage AS ENUM('asphalte', 'ciment', 'pavé brique', 'pavé pierre', 'non pavé', 'indéterminé');

-- Ahmed
CREATE TYPE TYPE_MODE 		AS ENUM ('solide', 'clignotant', 'contrôlé', 'intelligente');

-- Ahmed
CREATE TYPE TYPE_ORIENTAION AS ENUM ('horizontale', 'verticale', 'autre');

--Kerian
CREATE SEQUENCE identifiant_intersection START WITH 1000000;


--Abigail 
CREATE SEQUENCE numero_immatriculation START WITH 111 INCREMENT BY 1;

-- Thomas
CREATE SEQUENCE numero_serie START WITH 1000000000000000 INCREMENT BY 1;

-- Ahmed
CREATE SEQUENCE numero_nom_fichier START WITH 20 INCREMENT BY 1;

--Abigail 
CREATE TABLE inspection(
	id						SERIAL,
	date_debut 				TIMESTAMP	NOT NULL,
	date_fin				TIMESTAMP	NOT NULL,
	chemin_fichier 			VARCHAR(1024)NOT NULL,
	conducteur				INTEGER 	NOT NULL,
	vehicule				INTEGER		NOT NULL,
	kilo_debut				NUMERIC(8,2)NOT NULL,
	kilo_fin				NUMERIC(8,2)NOT NULL,
	inspecteur				INTEGER 	NOT NULL,
	profileur_laser			INTEGER 	NOT NULL,
	
	
	CONSTRAINT pk_ins PRIMARY KEY(id),
	CONSTRAINT cc_veh_ins_kilo_d CHECK(
		kilo_debut BETWEEN 1 AND 500000
	),
	CONSTRAINT cc_veh_ins_kilo_f CHECK(
		kilo_fin BETWEEN 1 AND 500000
	)
);

--Abigail
CREATE TABLE troncon_inspection(
	id						SERIAL,
	troncon					INTEGER		NOT NULL,
	inspection 				INTEGER 	NOT NULL,
	
	CONSTRAINT pk_tro_ins PRIMARY KEY(id)
);

-- Thomas
CREATE TABLE employe(
	id					SERIAL,
	nas					CHAR(9) 		NOT NULL UNIQUE,
	nom					VARCHAR(32)		NOT NULL,
	prenom				VARCHAR(32)		NOT NULL,
	genre				genre			NOT NULL,
	date_embauche		DATE			NOT NULL,
	salaire				NUMERIC(5, 2) 	NOT NULL DEFAULT 27.50,
	poste				INTEGER			NOT NULL,
	departement			INTEGER		NOT NULL,
	
	CONSTRAINT pk_employe_id PRIMARY KEY(id),
	CONSTRAINT cc_employe_date_embauche CHECK(date_embauche BETWEEN '2018-01-01' AND CURRENT_DATE),
	CONSTRAINT cc_employe_salaire CHECK(salaire BETWEEN 15.00 AND 250.00)
);

-- Thomas
CREATE TABLE poste(
	id					SERIAL,
	nom					VARCHAR(32) 	NOT NULL,
	
	CONSTRAINT pk_poste_id PRIMARY KEY(id)
);

--Thomas
CREATE TABLE departement(
	id					SERIAL,
	nom					VARCHAR(32) 	NOT NULL,
	
	CONSTRAINT pk_departement_id PRIMARY KEY(id)
);

--Thomas
CREATE TABLE troncon(
	id					SERIAL,
	nom					VARCHAR(32)			NOT NULL,
	intersection_debut			INTEGER		NOT NULL,
	intersection_fin			INTEGER		NOT NULL,
	longueur				DECIMAL(7, 1)	NOT NULL,
	limite_vitesse				INTEGER		NOT NULL,
	nbVoies					INTEGER			NOT NULL DEFAULT 1,
	pavage					pavage			NOT NULL,
	
	CONSTRAINT pk_troncon_id PRIMARY KEY(id),
	CONSTRAINT cc_troncon_longueur CHECK(longueur BETWEEN 0.0 AND 100000.0),
	CONSTRAINT cc_troncon_limite_vitesse CHECK(limite_vitesse BETWEEN 25 AND 120),
	CONSTRAINT cc_troncon_nbVoies CHECK(nbVoies BETWEEN 1 AND 8)
);

--Thomas
CREATE TABLE intersection(
	id					SERIAL,
	identifiant				INTEGER 	NOT NULL UNIQUE,
	coordonees				POINT 		NOT NULL,
	pavage					pavage		NOT NULL,
	
	CONSTRAINT cc_intersection_identifiant CHECK(identifiant BETWEEN 1000000 AND 9999999),
	CONSTRAINT pk_intersection_id PRIMARY KEY(id)
);

--Kerian
CREATE TABLE vehicule(
	id 					SERIAL,
	marque 				VARCHAR(32)		NOT NULL,
	modele 				VARCHAR(32) 	NOT NULL,
	date_acquisition 	DATE,
	immatriculation 	CHAR(6) 		NOT NULL,
	
	CONSTRAINT pk_vehicule PRIMARY KEY(id),
	CONSTRAINT uc_vehicule_immatriculation UNIQUE(immatriculation)
);
--Kerian
CREATE TABLE profileur_laser(
	id 					SERIAL,
	marque 					VARCHAR(32) 	NOT NULL,
	no_serie 				CHAR(16) 		NOT NULL,
	date_fabrication 			DATE,
	date_acquisition 			DATE,
	
	CONSTRAINT pk_profileur_laser PRIMARY KEY(id),
	CONSTRAINT uc_profileur_laser_no_serie UNIQUE(no_serie)
);

--Kerian
CREATE TABLE calibration (
	id 					SERIAL,
	date_debut 			TIMESTAMP 			NOT NULL, 
	date_fin 			TIMESTAMP 			NOT NULL,
	employe 			INTEGER 			NOT NULL,
	v1 					NUMERIC(8, 4) 		NOT NULL,
	v2 					NUMERIC(8, 4) 		NOT NULL,
	v3 					NUMERIC(8, 4) 		NOT NULL,
	profileur  INTEGER           NOT NULL,
	CONSTRAINT pk_calibration PRIMARY KEY(id),
	CONSTRAINT cc_calibration_kilo_v CHECK(
		v1 BETWEEN -1000 AND 1000 AND 
		v2 BETWEEN -1000 AND 1000 AND 
		v3 BETWEEN -1000 AND 1000
	)
);


-- Ahmed
CREATE TABLE type_panneau(
	  id			SERIAL
	, type			VARCHAR(64)		NOT NULL
	
	, CONSTRAINT 	pk_type_pan		PRIMARY KEY(id)
	, CONSTRAINT	uc_type_pan		UNIQUE(type)
);

-- Ahmed
CREATE TABLE panneau(
	  id			SERIAL
	, troncon		INTEGER				NOT NULL
	, type		 	INTEGER				NOT NULL
	, position		DECIMAL(5,2)		NOT NULL
	
	, CONSTRAINT 	pk_pan					PRIMARY KEY(id)
	, CONSTRAINT	cc_pan_pourcentage 		CHECK(position <= 100.00)
);

-- Ahmed
CREATE TABLE type_dispositif_particulier(
	  id			SERIAL
	, type			VARCHAR(64)		NOT NULL
	
	, CONSTRAINT 	pk_type_dis_par		PRIMARY KEY(id)
	, CONSTRAINT	uc_type_dis_par		UNIQUE(type)
);

-- Ahmed
CREATE TABLE dispositif_particulier(
	  id			SERIAL
	, troncon		INTEGER				NOT NULL
	, type		 	INTEGER				NOT NULL
	, position		DECIMAL(5,2)		NOT NULL
	
	, CONSTRAINT 	pk_dis_par			PRIMARY KEY(id)
	, CONSTRAINT	cc_dp_pourcentage 	CHECK(position <= 100.00)
);

-- Ahmed
CREATE TABLE lumiere(
	  id			SERIAL
	, forme			INTEGER				NOT NULL
	, couleur 		INTEGER				NOT NULL
	, mode			TYPE_MODE			NOT NULL
	, dispositif	INTEGER				NOT NULL

	, CONSTRAINT 	pk_lum		PRIMARY KEY(id)
);

-- Ahmed
CREATE TABLE dispositif_lumineux(
	  id			SERIAL
	, troncon		INTEGER			NOT NULL
	, position		DECIMAL(5,2)		NOT NULL
	, orientation		TYPE_ORIENTAION		NOT NULL
	
	, CONSTRAINT 	pk_dis_lum		PRIMARY KEY(id)
	, CONSTRAINT	cc_dl_pourcentage 	CHECK(position <= 100.00)
);


-- Ahmed
CREATE TABLE couleur(
	  id			SERIAL
	, hex			VARCHAR(6)		NOT NULL
	, nom			VARCHAR(64)		NOT NULL
	
	, CONSTRAINT 	pk_coul			PRIMARY KEY(id)
	, CONSTRAINT 	cc_couleur_hex 		CHECK(hex ~* '^[a-f0-9]{2}[a-f0-9]{2}[a-f0-9]{2}$')
	, CONSTRAINT	uc_hex			UNIQUE(hex)
	, CONSTRAINT	uc_nom			UNIQUE(nom)
);

-- Ahmed
CREATE TABLE forme(
	  id			SERIAL
	, forme			VARCHAR(64)		NOT NULL
	
	, CONSTRAINT 	pk_forme	PRIMARY KEY(id)
	, CONSTRAINT	uc_forme	UNIQUE(forme)
	
);


--Thomas
ALTER TABLE employe
	ADD CONSTRAINT fk_employe_poste FOREIGN KEY (poste) REFERENCES poste(id);
	
--Thomas
ALTER TABLE employe
	ADD CONSTRAINT fk_employe_departement FOREIGN KEY (departement) REFERENCES departement(id);


--Kerian
ALTER TABLE calibration
	ADD CONSTRAINT fk_calibration_profileur FOREIGN KEY (profileur) REFERENCES profileur_laser(id);
--Kerian
ALTER TABLE calibration
	ADD CONSTRAINT fk_calibration_employe FOREIGN KEY (employe) REFERENCES employe(id);

--Abigail	
ALTER TABLE inspection
	ADD CONSTRAINT fk_inspection_vehicule FOREIGN KEY (vehicule) REFERENCES vehicule(id);
	
--Abigail	
ALTER TABLE inspection
	ADD CONSTRAINT fk_inspection_conducteur FOREIGN KEY (conducteur) REFERENCES employe(id);
	
--Abigail	
ALTER TABLE inspection
	ADD CONSTRAINT fk_inspection_profileur_laser FOREIGN KEY (profileur_laser) REFERENCES profileur_laser(id);
	
--Abigail	
ALTER TABLE inspection
	ADD CONSTRAINT fk_inspection_inspecteur FOREIGN KEY (inspecteur) REFERENCES employe(id);
	
--Abigail	
ALTER TABLE troncon_inspection
	ADD CONSTRAINT fk_troncon_inspection_troncon FOREIGN KEY (troncon) REFERENCES troncon(id);
	
--Abigail	
ALTER TABLE troncon_inspection
	ADD CONSTRAINT fk_troncon_inspection_inspection FOREIGN KEY (inspection) REFERENCES inspection(id);
	
-- Ahmed
ALTER TABLE panneau 	ADD CONSTRAINT fk_pan_troncon		FOREIGN KEY(troncon) 	REFERENCES troncon(id);

-- Ahmed
ALTER TABLE panneau 	ADD CONSTRAINT fk_pan_panneau		FOREIGN KEY(type)		REFERENCES type_panneau(id);

-- Ahmed
ALTER TABLE dispositif_particulier 	ADD CONSTRAINT fk_dis_par_troncon	FOREIGN KEY(troncon)	REFERENCES troncon(id);

-- Ahmed
ALTER TABLE dispositif_particulier 	ADD CONSTRAINT fk_dis_par_panneau	FOREIGN KEY(type)	REFERENCES type_dispositif_particulier(id);

-- Ahmed
ALTER TABLE lumiere ADD CONSTRAINT fk_lum_forme			FOREIGN KEY(forme)		REFERENCES forme(id);

-- Ahmed
ALTER TABLE lumiere ADD CONSTRAINT fk_lum_couleur		FOREIGN KEY(couleur) 	REFERENCES couleur(id);

-- Ahmed
ALTER TABLE lumiere ADD CONSTRAINT fk_lum_dispositif	FOREIGN KEY(dispositif) 	REFERENCES dispositif_lumineux(id);

-- Ahmed
ALTER TABLE dispositif_lumineux ADD CONSTRAINT fk_dl_tro	FOREIGN KEY(troncon) REFERENCES troncon(id);
	

-- Thomas
CREATE INDEX chercher_lumiere_forme
	ON lumiere(forme);
	
-- Abigail
CREATE INDEX chercher_conducteur
	ON inspection(conducteur);
	
-- Ahmed
CREATE INDEX chercher_inspection_troncon
	ON troncon_inspection(inspection);

-- Kerian
CREATE INDEX id_employer
	ON employe(id);

-- Thomas
CREATE VIEW employe_calibration AS
		SELECT emp.prenom || ' ' ||emp.nom AS "Nom de lemployé", 
		COUNT(cal.id) AS "Nombre de calibrations effectuées" 
		FROM calibration AS cal 
		FULL JOIN employe as emp ON emp.id = cal.employe 
		GROUP BY emp.prenom, emp.nom;

-- Abigail 
CREATE VIEW nombre_conducteur_inspection AS
	 SELECT con.conducteur, COUNT(*)
		 FROM inspection as con
		 GROUP BY con.conducteur;
		  
-- Ahmed 
CREATE VIEW employe_departement_poste AS
	SELECT   emp.nom AS "nom_employe"
		   , emp.prenom AS "prenom_employe"
		   , poste.nom AS "poste_employe"
		   , dep.nom AS "departement_employe"
		   , date_embauche AS "date_embauche_employe"
		   , salaire AS "salaire_employe"
	FROM employe AS "emp"
	INNER JOIN departement AS "dep"
		ON emp.departement = dep.id
	INNER JOIN poste
		ON emp.poste = poste.id;

-- Kerian 
CREATE OR REPLACE VIEW calibration_plus_recente AS
	SELECT id
		FROM calibration
		ORDER BY date_fin DESC
		LIMIT  1;
