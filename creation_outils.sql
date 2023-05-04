DROP PROCEDURE IF EXISTS insert_inter;
DROP PROCEDURE IF EXISTS procedure_calibration;
DROP PROCEDURE IF EXISTS procedure_dispositif_lumineux;
DROP PROCEDURE IF EXISTS insertion_troncon;
DROP FUNCTION IF EXISTS employe_random, profileur_random, vehicule_random, troncon_random;
DROP FUNCTION IF EXISTS random_forme_lumiere;
DROP FUNCTION IF EXISTS random_couleur_lumiere;
DROP FUNCTION IF EXISTS random_mode_lumiere;

--Kerian
CREATE OR REPLACE PROCEDURE insert_inter(
	coordonees_inter intersection.coordonees%TYPE,
	pavage_inter intersection.pavage%TYPE
)
LANGUAGE SQL
AS $$
	INSERT INTO intersection(identifiant, coordonees, pavage)
		VALUES (NEXTVAL('identifiant_intersection'), coordonees_inter, pavage_inter);
$$;

--Kerian
CREATE OR REPLACE FUNCTION employe_random() RETURNS INT
LANGUAGE SQL
AS $$
	SELECT id FROM employe order by random() limit 1;
$$;

--Kerian
CREATE OR REPLACE FUNCTION profileur_random() RETURNS INT
LANGUAGE SQL
AS $$
	SELECT id FROM profileur_laser order by random() limit 1;
$$;

--Kerian
CREATE OR REPLACE FUNCTION vehicule_random() RETURNS INT
LANGUAGE SQL
AS $$
	SELECT id FROM vehicule order by random() limit 1;
$$;

--Kerian
CREATE OR REPLACE FUNCTION troncon_random() RETURNS INT
LANGUAGE SQL
AS $$
	SELECT id FROM troncon order by random() LIMIT 1;
$$;

--Kerian
CREATE OR REPLACE FUNCTION update_kilo_fin()
RETURNS TRIGGER AS $$
	BEGIN
		UPDATE inspection
		SET kilo_fin = kilo_fin + (SELECT longueur FROM troncon WHERE id = new.troncon)
		WHERE id = new.inspection;
		RETURN NEW;
	END;
$$
LANGUAGE PLPGSQL;

CREATE OR REPLACE TRIGGER update_kilo_fin AFTER INSERT OR UPDATE
	ON troncon_inspection
	FOR EACH ROW EXECUTE FUNCTION update_kilo_fin();

-- Thomas
CREATE PROCEDURE procedure_calibration(
	date_debut_calibration			TIMESTAMP, 
	date_fin_calibration			TIMESTAMP,  
	no_serie_profileur			profileur_laser.no_serie%TYPE,
	nas_employe				employe.nas%TYPE,
	valeur1					NUMERIC(8, 4), 
	valeur2					NUMERIC(8, 4), 
	valeur3					NUMERIC(8, 4)
)
LANGUAGE PLPGSQL
AS $$
BEGIN

	INSERT INTO calibration(date_debut, date_fin, employe, profileur, v1, v2, v3)
		VALUES (date_debut_calibration, date_fin_calibration, 
				(SELECT id FROM employe WHERE nas = nas_employe), 
				(SELECT id FROM profileur_laser WHERE no_serie = no_serie_profileur), valeur1, valeur2, valeur3);
END;
$$;	

-- Thomas
CREATE FUNCTION random_forme_lumiere()
RETURNS INTEGER
LANGUAGE PLPGSQL
AS
$$
BEGIN
	RETURN (SELECT id FROM forme ORDER BY RANDOM() LIMIT 1);
END;
$$;
	
-- Thomas
CREATE FUNCTION random_couleur_lumiere()
RETURNS INTEGER
LANGUAGE PLPGSQL
AS
$$
BEGIN
	RETURN (SELECT id FROM couleur ORDER BY RANDOM() LIMIT 1);
END;
$$;

-- Thomas
CREATE FUNCTION random_mode_lumiere()
RETURNS TYPE_MODE
LANGUAGE PLPGSQL
AS
$$
BEGIN

	RETURN ('{solide,clignotant,contrôlé,intelligente}'::text[])[ceil(random()*4)];
END;
$$;

-- Thomas
CREATE PROCEDURE procedure_dispositif_lumineux(
	_position				DECIMAL(5,2), 
	_troncon				INTEGER,  
	_orientation			TEXT
)
LANGUAGE PLPGSQL
AS $$
DECLARE 
	random_num INTEGER;
BEGIN

	random_num = FLOOR(RANDOM()*(5 - 1 + 1)) + 1;

	INSERT INTO dispositif_lumineux(position, troncon, orientation)
		VALUES (_position, (SELECT id FROM troncon WHERE id = _troncon), _orientation);
		
	FOR x IN 1..random_num LOOP
		INSERT INTO lumiere(forme, couleur, mode, dispositif)
			VALUES(random_forme_lumiere(), random_couleur_lumiere(), random_mode_lumiere(), (SELECT id FROM dispositif_lumineux ORDER BY id DESC LIMIT 1));
  	END LOOP;
END;
$$;


-- Ahmed
CREATE PROCEDURE insertion_troncon(
	  nomRue			VARCHAR(32)
	, inter_debut		POINT	
	, inter_fin			POINT	
	, long				DECIMAL(7, 1)
	, vitesse			INTEGER	
	, nbVoies			INTEGER	
	, type_pavage		pavage
)
LANGUAGE PLPGSQL
AS $$
BEGIN

	INSERT INTO troncon(nom, intersection_debut, intersection_fin, longueur, limite_vitesse, nbVoies, pavage)
		VALUES ( nomRue
			  , (SELECT id FROM intersection WHERE coordonees[0] = inter_debut[0])
			  , (SELECT id FROM intersection WHERE coordonees[0] =  inter_fin[0])
			  , long, vitesse, nbVoies, type_pavage);
END;$$;	
