-- Partie par: Ahmed Sadek
--------------------------------------

-- Suppression de contraintes
ALTER TABLE IF EXISTS lumiere 							DROP CONSTRAINT IF EXISTS fk_lum_forme;
ALTER TABLE IF EXISTS lumiere 							DROP CONSTRAINT IF EXISTS fk_lum_couleur;
-- ALTER TABLE IF EXISTS panneau 						DROP CONSTRAINT IF EXISTS fk_pan_troncon;
ALTER TABLE IF EXISTS panneau 							DROP CONSTRAINT IF EXISTS fk_pan_panneau;
-- ALTER TABLE IF EXISTS dispositif_particulier 		DROP CONSTRAINT IF EXISTS fk_dis_par_troncon;
ALTER TABLE IF EXISTS dispositif_particulier 			DROP CONSTRAINT IF EXISTS fk_dis_par_panneau;
-- ALTER TABLE IF EXISTS dispositif_lumineux 			DROP CONSTRAINT IF EXISTS fk_dl_tro;
ALTER TABLE IF EXISTS dl_lumiere 						DROP CONSTRAINT IF EXISTS fk_dl_lum_dis;
ALTER TABLE IF EXISTS dl_lumiere 						DROP CONSTRAINT IF EXISTS fk_dl_lum_lum;


-- Suppression de tables

DROP TABLE IF EXISTS type_panneau;
DROP TABLE IF EXISTS panneau;
DROP TABLE IF EXISTS type_dispositif_particulier;
DROP TABLE IF EXISTS dispositif_particulier;
DROP TABLE IF EXISTS couleur;
DROP TABLE IF EXISTS forme;
DROP TABLE IF EXISTS lumiere;
DROP TABLE IF EXISTS dispositif_lumineux;
DROP TABLE IF EXISTS dl_lumiere;

-- Suppression de enums

DROP TYPE IF EXISTS TYPE_MODE;
DROP TYPE IF EXISTS TYPE_ORIENTAION;

-- Création de enums

CREATE TYPE TYPE_MODE 		AS ENUM ('solide', 'clignotant', 'contôlé', 'intelligente');
CREATE TYPE TYPE_ORIENTAION AS ENUM ('horizontale', 'verticale', 'autre');

-- Création de tables

CREATE TABLE type_panneau(
	  id			SERIAL
	, type			VARCHAR(64)		NOT NULL
	
	, CONSTRAINT 	pk_type_pan			PRIMARY KEY(id)
);

CREATE TABLE panneau(
	  id			SERIAL
	, troncon		INTEGER				NOT NULL
	, type		 	INTEGER				NOT NULL
	, position		DECIMAL(5,2)		NOT NULL
	
	, CONSTRAINT 	pk_pan					PRIMARY KEY(id)
	, CONSTRAINT	cc_pan_pourcentage 		CHECK(position <= 100.00)
);

CREATE TABLE type_dispositif_particulier(
	  id			SERIAL
	, type			VARCHAR(64)		NOT NULL
	
	, CONSTRAINT 	pk_type_dis_par		PRIMARY KEY(id)
);


CREATE TABLE dispositif_particulier(
	  id			SERIAL
	, troncon		INTEGER				NOT NULL
	, type		 	INTEGER				NOT NULL
	, position		DECIMAL(5,2)		NOT NULL
	
	, CONSTRAINT 	pk_dis_par			PRIMARY KEY(id)
	, CONSTRAINT	cc_dp_pourcentage 	CHECK(position <= 100.00)
);

CREATE TABLE lumiere(
	  id			SERIAL
	, forme			INTEGER				NOT NULL
	, couleur 		INTEGER				NOT NULL
	, mode			TYPE_MODE			NOT NULL

	
	, CONSTRAINT 	pk_lum		PRIMARY KEY(id)
);


CREATE TABLE dispositif_lumineux(
	  id			SERIAL
	, troncon		INTEGER				NOT NULL
	, position		DECIMAL(5,2)		NOT NULL
	, orientation	TYPE_ORIENTAION		NOT NULL
	
	, CONSTRAINT 	pk_dis_lum			PRIMARY KEY(id)
	, CONSTRAINT	cc_dl_pourcentage 	CHECK(position <= 100.00)
);

CREATE TABLE dl_lumiere(
	  id				SERIAL
	, dispositif		INTEGER				NOT NULL
	, lumiere			INTEGER		NOT NULL
	
	, CONSTRAINT 	pk_dl_lum			PRIMARY KEY(id)
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

-- Ajout de clés étrangères

-- panneau
-- ALTER TABLE panneau 	ADD CONSTRAINT fk_pan_troncon		FOREIGN KEY(troncon) 	REFERENCES troncon(id);
ALTER TABLE panneau 	ADD CONSTRAINT fk_pan_panneau		FOREIGN KEY(type)		REFERENCES type_panneau(id);

-- dispositif_particulier
-- ALTER TABLE dispositif_particulier 	ADD CONSTRAINT fk_dis_par_troncon	FOREIGN KEY(troncon)	REFERENCES troncon(id);
ALTER TABLE dispositif_particulier 	ADD CONSTRAINT fk_dis_par_panneau	FOREIGN KEY(type)	REFERENCES type_dispositif_particulier(id);

-- dispositif_lumineux
ALTER TABLE lumiere ADD CONSTRAINT fk_lum_forme		FOREIGN KEY(forme)		REFERENCES forme(id);
ALTER TABLE lumiere ADD CONSTRAINT fk_lum_couleur	FOREIGN KEY(couleur) 	REFERENCES couleur(id);

-- ALTER TABLE dispositif_lumineux ADD CONSTRAINT fk_dl_tro	FOREIGN KEY(troncon) REFERENCES troncon(id);

ALTER TABLE dl_lumiere ADD CONSTRAINT fk_dl_lum_dis		FOREIGN KEY(dispositif)	REFERENCES dispositif_lumineux(id);
ALTER TABLE dl_lumiere ADD CONSTRAINT fk_dl_lum_lum		FOREIGN KEY(lumiere)	REFERENCES lumiere(id);

--------------------------------------


