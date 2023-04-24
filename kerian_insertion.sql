DROP TABLE IF EXISTS vehicule, calibration, profileur_laser, profileur_laser_calibration; 

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
