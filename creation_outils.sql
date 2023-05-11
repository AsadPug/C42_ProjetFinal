DROP PROCEDURE IF EXISTS insert_inter;
DROP PROCEDURE IF EXISTS procedure_calibration;
DROP PROCEDURE IF EXISTS procedure_dispositif_lumineux;
DROP PROCEDURE IF EXISTS insertion_troncon;
DROP FUNCTION IF EXISTS employe_random, profileur_random, vehicule_random, troncon_random;
DROP FUNCTION IF EXISTS autre_employer_random(integer);
DROP FUNCTION IF EXISTS random_forme_lumiere;
DROP FUNCTION IF EXISTS random_couleur_lumiere;
DROP FUNCTION IF EXISTS random_mode_lumiere;
DROP FUNCTION IF EXISTS position_random;
DROP FUNCTION IF EXISTS id_random(text);
DROP FUNCTION IF EXISTS random_timestamp();
DROP FUNCTION IF EXISTS random_end_timestamp(TIMESTAMP);
DROP PROCEDURE IF EXISTS insertion_panneaux_et_dispos(integer);

-- Ahmed
CREATE OR REPLACE FUNCTION new_dispositif_random() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO dispositif_particulier(troncon, type, position)
    VALUES (id_random('troncon'), id_random('type_dispositif_particulier'), position_random());
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER dispositif_random
BEFORE INSERT ON panneau
FOR EACH ROW
EXECUTE FUNCTION new_dispositif_random();


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
--Abigail 
CREATE OR REPLACE FUNCTION autre_employe_random(employe integer) RETURNS INT
LANGUAGE SQL
AS $$
	SELECT id FROM employe AS emp 
		WHERE emp.id != employe 
		ORDER BY random() LIMIT 1 ;
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

CREATE OR REPLACE PROCEDURE insertion_troncon_inspection(id_inscpection INTEGER)
LANGUAGE PLPGSQL
AS $$
	BEGIN
		INSERT INTO troncon_inspection(troncon, inspection)
			VALUES(troncon_random(), id_inscpection);
	END;
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

CREATE TRIGGER update_kilo_fin AFTER INSERT OR UPDATE
	ON troncon_inspection
	FOR EACH ROW EXECUTE FUNCTION update_kilo_fin();

-- Thomas
CREATE OR REPLACE FUNCTION random_lumiere()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS
$$
DECLARE 
	random_num INTEGER;
BEGIN
	
	random_num = FLOOR(RANDOM()*(5 - 1 + 1)) + 1;

	FOR x IN 1..random_num LOOP
		INSERT INTO lumiere(forme, couleur, mode, dispositif)
			VALUES(random_forme_lumiere(), random_couleur_lumiere(), random_mode_lumiere(), (SELECT id FROM dispositif_lumineux ORDER BY id DESC LIMIT 1));
  	END LOOP;
	RETURN NEW;
END;
$$;
	
CREATE TRIGGER new_lumieres
AFTER INSERT ON dispositif_lumineux
FOR EACH ROW
EXECUTE PROCEDURE random_lumiere();

-- Thomas
CREATE OR REPLACE PROCEDURE procedure_calibration(
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
CREATE OR REPLACE FUNCTION random_forme_lumiere()
RETURNS INTEGER
LANGUAGE PLPGSQL
AS
$$
BEGIN
	RETURN (SELECT id FROM forme ORDER BY RANDOM() LIMIT 1);
END;
$$;
	
-- Thomas
CREATE OR REPLACE FUNCTION random_couleur_lumiere()
RETURNS INTEGER
LANGUAGE PLPGSQL
AS
$$
BEGIN
	RETURN (SELECT id FROM couleur ORDER BY RANDOM() LIMIT 1);
END;
$$;

-- Thomas
CREATE OR REPLACE FUNCTION random_mode_lumiere()
RETURNS TYPE_MODE
LANGUAGE PLPGSQL
AS
$$
BEGIN

	RETURN ('{solide,clignotant,contrôlé,intelligente}'::text[])[ceil(random()*4)];
END;
$$;

-- Thomas
CREATE OR REPLACE PROCEDURE procedure_dispositif_lumineux(
	_position				DECIMAL(5,2), 
	_troncon				INTEGER,  
	_orientation				dispositif_lumineux.orientation%TYPE
)
LANGUAGE PLPGSQL
AS $$
BEGIN

	INSERT INTO dispositif_lumineux(position, troncon, orientation)
		VALUES (_position, (SELECT id FROM troncon WHERE id = _troncon), _orientation);
		
END;
$$;


-- Abigail
CREATE OR REPLACE FUNCTION random_timestamp()
RETURNS TIMESTAMP
LANGUAGE PLPGSQL
AS $$
BEGIN
  RETURN TIMESTAMP '2000-01-01 00:00:00' +
       random() * (TIMESTAMP '2023-04-05 00:00:00' -
                   TIMESTAMP '2000-01-01 00:00:00');
END;
$$;

-- Abigail
CREATE OR REPLACE FUNCTION random_end_timestamp(initial_timestamp TIMESTAMP)
RETURNS TIMESTAMP
LANGUAGE PLPGSQL
AS $$
BEGIN
  RETURN initial_timestamp +
       random() * (TIMESTAMP '2023-05-05 00:00:00' -
                   TIMESTAMP '2023-04-05 00:00:00' );
END;
$$;

-- Abigail
CREATE OR REPLACE PROCEDURE insertion_inspection()
LANGUAGE plpgsql
AS $$
DECLARE
	random_date_debut TIMESTAMP;
	random_conducteur INTEGER;
	random_kilo_debut INTEGER;
	
BEGIN
	random_date_debut = random_timestamp();
	random_conducteur = employe_random();
	random_kilo_debut = random() * 400000 + 1;
	
	INSERT INTO inspection(
		date_debut, date_fin, chemin_fichier, conducteur, vehicule,
		kilo_debut, kilo_fin, inspecteur, profileur_laser
	)
    VALUES (
		random_date_debut, random_end_timestamp(random_date_debut), nom_fichier((random_date_debut AT TIME ZONE 'EST')::TIMESTAMPTZ) , random_conducteur, vehicule_random(),
		random_kilo_debut, random_kilo_debut, autre_employe_random(random_conducteur), profileur_random()
	);
END;
$$;

-- Abigail
CREATE OR REPLACE FUNCTION update_troncon_inspection()
RETURNS TRIGGER LANGUAGE PLPGSQL AS $$
	BEGIN
		FOR i IN 1..10 LOOP
			CALL insertion_troncon_inspection(NEW.id);
		END LOOP;
		RETURN NEW;
	END;
$$;


CREATE TRIGGER update_troncon_inspection 
	AFTER INSERT ON inspection
	FOR EACH ROW EXECUTE FUNCTION update_troncon_inspection();

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


-- Ahmed
CREATE OR REPLACE FUNCTION position_random()
RETURNS INTEGER
LANGUAGE PLPGSQL
AS $$
BEGIN
  RETURN floor(random() * 100) + 1;
END;
$$;

-- Ahmed
CREATE OR REPLACE FUNCTION id_random(table_name TEXT)
RETURNS INTEGER
LANGUAGE PLPGSQL
AS $$
DECLARE
  max_id integer;
  min_id integer;
BEGIN
  EXECUTE format('SELECT MIN(%I), MAX(%I) FROM %I', 'id', 'id', table_name) INTO min_id, max_id;
  RETURN floor(random() * (max_id - min_id + 1)) + min_id;
END;$$;

-- Ahmed
CREATE OR REPLACE PROCEDURE insertion_panneaux_et_dispos(nombre_panneaux INTEGER)
LANGUAGE PLPGSQL
AS $$
BEGIN
  FOR i IN 1..nombre_panneaux LOOP
    INSERT INTO panneau(troncon, type, position)
    VALUES (id_random('troncon'), id_random('type_panneau'), position_random());
  END LOOP;
END;
$$;


-- Ahmed Thomas Kerian
CREATE OR REPLACE FUNCTION nom_fichier(date_debut_inspection TIMESTAMPTZ)
RETURNS CHAR(30)
LANGUAGE PLPGSQL
AS $$
	BEGIN
		RETURN 'PZ2_' || LPAD(NEXTVAL('numero_nom_fichier')::text, 8, '0') || '_' || TO_CHAR(date_debut_inspection, 'YYMMDDHHMMSS') || '.' ||('{xdat,jdat,bdat,kdat}'::text[])[CEIL(random()*4)];
	END
$$;
