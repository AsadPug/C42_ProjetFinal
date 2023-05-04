DROP PROCEDURE IF EXISTS insert_inter;
DROP PROCEDURE IF EXISTS procedure_calibration;
DROP PROCEDURE IF EXISTS insertion_troncon;
DROP FUNCTION IF EXISTS employe_random

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
END;$$;	

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
