DROP TABLE IF EXISTS vehicule, calibration, profileur_laser, profileur_laser_calibration, employe, poste, departement, troncon, intersection, inspection, vehicule_inspection, profileur_laser_inspection, troncon_inspection; 

DROP TYPE IF EXISTS genre;
DROP TYPE IF EXISTS pavage;

CREATE TYPE genre AS ENUM('f', 'h', 'x');
CREATE TYPE pavage AS ENUM('asphalte', 'ciment', 'pavé brique', 'pavé pierre', 'non pavé', 'indéterminé');

CREATE TABLE inspection(
	id					SERIAL,
	date_debut 			DATE		NOT NULL,
	date_fin			DATE		NOT NULL,
	veh_insp			INTEGER		NOT NULL,
	prof_laser_insp		INTEGER		NOT NULL,
	chemin_fichier 		VARCHAR(1024)NOT NULL,
	
	CONSTRAINT pk_ins PRIMARY KEY(id)
);

CREATE TABLE vehicule_inspection(
	id 					SERIAL,
	employe				INTEGER 	NOT NULL,
	vehicule			INTEGER		NOT NULL,
	kilo_debut			INTEGER		NOT NULL,
	kilo_fin			INTEGER		NOT NULL,
	
	CONSTRAINT pk_veh_ins PRIMARY KEY(id),
	CONSTRAINT cc_veh_ins_kilo_d CHECK(
		kilo_debut BETWEEN 1 AND 500000
	),
	CONSTRAINT cc_veh_ins_kilo_f CHECK(
		kilo_fin BETWEEN 1 AND 500000
	)
);

CREATE TABLE profileur_laser_inspection(
	id 					SERIAL,
	profileur			INTEGER 	NOT NULL,
	employe				INTEGER 	NOT NULL,
	
	CONSTRAINT pk_pro_ins PRIMARY KEY(id)
);

CREATE TABLE troncon_inspection(
	id					SERIAL,
	troncon				INTEGER		NOT NULL,
	inspection 			INTEGER 	NOT NULL,
	
	CONSTRAINT pk_tro_ins PRIMARY KEY(id)
);

CREATE TABLE employe(
	id					SERIAL,
	nas					CHAR(9) 				NOT NULL,
	nom					VARCHAR(32)				NOT NULL,
	prenom					VARCHAR(32)				NOT NULL,
	genre					genre					NOT NULL,
	date_embauche				DATE					NOT NULL,
	salaire					DECIMAL(5, 2) 				NOT NULL DEFAULT 27.50,
	poste					VARCHAR(32)				NOT NULL,
	departement				VARCHAR(32)				NOT NULL,
	
	CONSTRAINT pk_employe_id PRIMARY KEY(id),
	CONSTRAINT cc_employe_date_embauche CHECK(date_embauche BETWEEN '2018-01-01' AND CURRENT_DATE),
	CONSTRAINT cc_employe_salaire CHECK(salaire BETWEEN 15.00 AND 250.00)
);

CREATE TABLE poste(
	id					SERIAL,
	nom					VARCHAR(32) 				NOT NULL,
	
	CONSTRAINT pk_poste_id PRIMARY KEY(id)
);

CREATE TABLE departement(
	id					SERIAL,
	nom					VARCHAR(32) 				NOT NULL,
	
	CONSTRAINT pk_departement_id PRIMARY KEY(id)
);

CREATE TABLE troncon(
	id					SERIAL,
	nom					VARCHAR(32)				NOT NULL,
	intersection_debut			INTEGER					NOT NULL,
	intersection_fin			INTEGER					NOT NULL,
	longueur				DECIMAL(7, 1) 				NOT NULL,
	limite_vitesse				INTEGER					NOT NULL,
	nbVoies					INTEGER					NOT NULL DEFAULT 1,
	
	CONSTRAINT pk_troncon_id PRIMARY KEY(id),
	CONSTRAINT cc_troncon_longueur CHECK(longueur BETWEEN 0.0 AND 100000.0),
	CONSTRAINT cc_troncon_limite_vitesse CHECK(limite_vitesse BETWEEN 25 AND 120),
	CONSTRAINT cc_troncon_nbVoies CHECK(nbVoies BETWEEN 1 AND 8)
);

CREATE TABLE intersection(
	id					SERIAL,
	identifiant				INTEGER					NOT NULL,
	coordonees				POINT 					NOT NULL,
	pavage					pavage					NOT NULL,
	
	CONSTRAINT pk_intersection_id PRIMARY KEY(id),
	CONSTRAINT cc_intersection_identifiant CHECK (identifiant BETWEEN 1000000 AND 9999999)
);

CREATE TABLE vehicule(
	id SERIAL,
	marque VARCHAR(32) NOT NULL,
	modele VARCHAR(32) NOT NULL,
	date_acquisition DATE,
	immatriculation CHAR(6) NOT NULL,
	
	CONSTRAINT pk_vehicule PRIMARY KEY(id)
);

CREATE TABLE profileur_laser(
	id SERIAL,
	marque VARCHAR(32) NOT NULL,
	no_serie CHAR(16) NOT NULL,
	date_fabrication DATE,
	date_acquisition DATE,
	
	CONSTRAINT pk_profileur_laser PRIMARY KEY(id)
);

CREATE TABLE calibration (
	id SERIAL,
	date_debut DATE NOT NULL, 
	date_fin DATE NOT NULL,
	employe_id INTEGER NOT NULL,
	v1 NUMERIC(8, 4) NOT NULL,
	v2 NUMERIC(8, 4) NOT NULL,
	v3 NUMERIC(8, 4) NOT NULL,
	
	CONSTRAINT pk_calibration PRIMARY KEY(id),
	CONSTRAINT cc_calibration_kilo_v CHECK(
		v1 BETWEEN -1000 AND 1000 AND 
		v2 BETWEEN -1000 AND 1000 AND 
		v3 BETWEEN -1000 AND 1000
	)
);

CREATE TABLE profileur_laser_calibration(
	id SERIAL,
	id_calibaration INTEGER NOT NULL,
	id_profileur INTEGER NOT NULL,
	
	CONSTRAINT pk_profileur_laser_calibration PRIMARY KEY(id)
);
