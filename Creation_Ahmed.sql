-- Partie par: Ahmed Sadek
--------------------------------------

-- Suppression de contraintes
ALTER TABLE IF EXISTS dispositif_lumineux 				DROP CONSTRAINT IF EXISTS fk_dis_lum_forme;
ALTER TABLE IF EXISTS dispositif_lumineux 				DROP CONSTRAINT IF EXISTS fk_dis_lum_couleur;
-- ALTER TABLE IF EXISTS troncon_panneau 					DROP CONSTRAINT IF EXISTS fk_tron_pan_troncon;
ALTER TABLE IF EXISTS troncon_panneau 					DROP CONSTRAINT IF EXISTS fk_tron_pan_panneau;
-- ALTER TABLE IF EXISTS troncon_dispositif_particulier 	DROP CONSTRAINT IF EXISTS fk_tron_dis_par_troncon;
ALTER TABLE IF EXISTS troncon_dispositif_particulier 		DROP CONSTRAINT IF EXISTS fk_tron_dis_par_panneau;
-- ALTER TABLE IF EXISTS troncon_dispositif_lumineux 		DROP CONSTRAINT IF EXISTS pk_tron_dis_lum_troncon;
ALTER TABLE IF EXISTS troncon_dispositif_lumineux 		DROP CONSTRAINT IF EXISTS fk_tron_dis_lum_troncon;


-- Suppression de tables

DROP TABLE IF EXISTS panneau;
DROP TABLE IF EXISTS dispositif_particulier;
DROP TABLE IF EXISTS couleur;
DROP TABLE IF EXISTS forme;
DROP TABLE IF EXISTS dispositif_lumineux;
DROP TABLE IF EXISTS troncon_panneau;
DROP TABLE IF EXISTS troncon_dispositif_particulier;
DROP TABLE IF EXISTS troncon_dispositif_lumineux;

-- Suppression de enums

DROP TYPE IF EXISTS TYPE_MODE;
DROP TYPE IF EXISTS TYPE_ORIENTAION;

-- Création de enums

CREATE TYPE TYPE_MODE 		AS ENUM ('solide', 'clignotant', 'contôlé', 'intelligente');
CREATE TYPE TYPE_ORIENTAION AS ENUM ('horizontale', 'verticale', 'autre');

-- Création de tables

CREATE TABLE panneau(
	  id			SERIAL
	, type			VARCHAR(64)		NOT NULL
	
	, CONSTRAINT 	pk_pan			PRIMARY KEY(id)
);

CREATE TABLE dispositif_particulier(
	  id			SERIAL
	, type			VARCHAR(64)		NOT NULL
	
	, CONSTRAINT 	pk_dis_par		PRIMARY KEY(id)
);

CREATE TABLE couleur(
	  id			SERIAL
	, couleur		VARCHAR(64)		NOT NULL
	
	, CONSTRAINT 	pk_coul			PRIMARY KEY(id)
);

CREATE TABLE forme(
	  id			SERIAL
	, frome			VARCHAR(64)		NOT NULL
	
	, CONSTRAINT 	pk_forme		PRIMARY KEY(id)
);

CREATE TABLE dispositif_lumineux(
	  id			SERIAL
	, forme			INTEGER				NOT NULL
	, couleur 		INTEGER				NOT NULL
	, mode			TYPE_MODE			NOT NULL
	, orientation	TYPE_ORIENTAION		NOT NULL
	
	, CONSTRAINT 	pk_dis_lum		PRIMARY KEY(id)
);

CREATE TABLE troncon_panneau(
	  id			SERIAL
	, troncon		INTEGER				NOT NULL
	, panneau 		INTEGER				NOT NULL
	, position		DECIMAL(5,2)		NOT NULL
	
	, CONSTRAINT 	pk_tron_pan					PRIMARY KEY(id)
	, CONSTRAINT	cc_tron_pan_pourcentage 	CHECK(position <= 100.00)
);

CREATE TABLE troncon_dispositif_particulier(
	  id			SERIAL
	, troncon		INTEGER				NOT NULL
	, dispositif 	INTEGER				NOT NULL
	, position		DECIMAL(5,2)		NOT NULL
	
	, CONSTRAINT 	pk_tron_dis_par			PRIMARY KEY(id)
	, CONSTRAINT	cc_tron_dp_pourcentage 	CHECK(position <= 100.00)
);

CREATE TABLE troncon_dispositif_lumineux(
	  id			SERIAL
	, troncon		INTEGER				NOT NULL
	, dispositif 	INTEGER				NOT NULL
	, position		DECIMAL(5,2)		NOT NULL
	
	, CONSTRAINT 	pk_tron_dis_lum			PRIMARY KEY(id)
	, CONSTRAINT	cc_tron_dl_pourcentage 	CHECK(position <= 100.00)
);

-- Ajout de clés étrangères

-- dispositif_lumineux
ALTER TABLE dispositif_lumineux ADD CONSTRAINT fk_dis_lum_forme		FOREIGN KEY(forme)		REFERENCES forme(id);
ALTER TABLE dispositif_lumineux ADD CONSTRAINT fk_dis_lum_couleur	FOREIGN KEY(couleur) 	REFERENCES couleur(id);

-- troncon_panneau
-- ALTER TABLE troncon_panneau 	ADD CONSTRAINT fk_tron_pan_troncon		FOREIGN KEY(troncon) 	REFERENCES troncon(id);
ALTER TABLE troncon_panneau 	ADD CONSTRAINT fk_tron_pan_panneau		FOREIGN KEY(panneau)	REFERENCES panneau(id);

-- troncon_dispositif_particulier
-- ALTER TABLE troncon_dispositif_particulier 	ADD CONSTRAINT fk_tron_dis_par_troncon	FOREIGN KEY(troncon)	REFERENCES troncon(id);
ALTER TABLE troncon_dispositif_particulier ADD CONSTRAINT fk_tron_dis_par_panneau	FOREIGN KEY(dispositif)	REFERENCES dispositif_particulier(id);

-- troncon_dispositif_lumineux
-- ALTER TABLE troncon_dispositif_lumineux 	ADD CONSTRAINT pk_tron_dis_lum_troncon	FOREIGN KEY(troncon)	REFERENCES troncon(id);
ALTER TABLE troncon_dispositif_lumineux ADD CONSTRAINT fk_tron_dis_lum_troncon	FOREIGN KEY(dispositif)	REFERENCES dispositif_lumineux(id);

--------------------------------------


