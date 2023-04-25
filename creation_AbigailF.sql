DROP TABLE IF EXISTS inspection, vehicule_inspection, profileur_laser_inspection, troncon_inspection;

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