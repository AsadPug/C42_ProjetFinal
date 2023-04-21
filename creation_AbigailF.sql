CREATE TABLE inspection(
	id					SERIAL,
	date_debut 			DATE		NOT NULL,
	date_fin			DATE		NOT NULL,
	id_veh_insp			SERIAL		NOT NULL,
	id_prof_laser_insp	SERIAL		NOT NULL,
	chemin_fichier 		CHAR(1024)	NOT NULL,
	
	CONSTRAINT pk_ins PRIMARY KEY(id)
);

CREATE TABLE vehicule_inspection(
	id 					SERIAL,
	id_employe			SERIAL 		NOT NULL,
	id_vehicule			SERIAL		NOT NULL,
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
	id_profileur		SERIAL 		NOT NULL,
	id_employe			SERIAL 		NOT NULL,
	
	CONSTRAINT pk_pro_ins PRIMARY KEY(id)
);

CREATE TABLE troncon_inspection(
	id					SERIAL,
	id_troncon			SERIAL		NOT NULL,
	id_inspection 		SERIAL 		NOT NULL,
	
	CONSTRAINT pk_tro_ins PRIMARY KEY(id)
);