CREATE OR REPLACE PROCEDURE insert_inter(
	coordonees_inter intersection.coordonees%TYPE,
	pavage_inter intersection.pavage%TYPE
)
LANGUAGE SQL
AS $$
	INSERT INTO intersection(identifiant, coordonees, pavage)
		VALUES (NEXTVAL('identifiant_intersection'), coordonees_inter, pavage_inter);
$$;
