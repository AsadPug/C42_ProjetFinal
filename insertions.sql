TRUNCATE dispositif_lumineux CASCADE;
TRUNCATE vehicule CASCADE;
TRUNCATE profileur_laser CASCADE;
TRUNCATE calibration CASCADE;
TRUNCATE employe CASCADE;
TRUNCATE poste CASCADE;
TRUNCATE departement CASCADE;
TRUNCATE troncon CASCADE;
TRUNCATE inspection CASCADE;
TRUNCATE intersection CASCADE;
TRUNCATE troncon_inspection CASCADE;
TRUNCATE type_panneau CASCADE;
TRUNCATE panneau CASCADE;
TRUNCATE type_dispositif_particulier CASCADE;
TRUNCATE dispositif_particulier CASCADE;
TRUNCATE couleur CASCADE;
TRUNCATE forme CASCADE;
TRUNCATE lumiere CASCADE;


--Reset sequences
ALTER SEQUENCE identifiant_intersection RESTART WITH 1000000;
ALTER SEQUENCE numero_immatriculation RESTART WITH 111;
ALTER SEQUENCE numero_serie RESTART WITH 1000000000000000;
ALTER SEQUENCE numero_nom_fichier RESTART WITH 20;

--Abigail
INSERT INTO type_dispositif_particulier(type)
VALUES('accès fauteuil roulant'),
      ('signal audio pour piéton');

--Abigail
INSERT INTO vehicule(marque, modele, immatriculation)
	VALUES ('Volkswagen', 'Jetta','AAA' || NEXTVAL('numero_immatriculation')),
	('Dodge', 'Charger','AAA' || NEXTVAL('numero_immatriculation')),
	('Ford', 'Focus', 'AAA' || NEXTVAL('numero_immatriculation'));
	
--Kerian
INSERT INTO type_panneau(type)
	VALUES('arrêt'),
	('céder'),
	('limite de vitesse');
	
-- Thomas
INSERT INTO forme (forme)
  VALUES('ronde'),
        ('carrée'),
        ('losange'),
        ('flèche haut'),
        ('flèche droite'),
        ('flèche gauche'),
        ('flèche bas'),
        ('flèche haut-droite'),
        ('flèche haut-gauche'),
        ('flèche bas-droite'),
        ('flèche bas-gauche'),
        ('humain'),
        ('main'),
        ('vélo'),
        ('barre verticale'),
        ('barre horizontale');
        
-- Thomas
INSERT INTO couleur (hex, nom)
  VALUES('FF0000', 'rouge'),
        ('FFFF00', 'jaune'),
        ('00FF00', 'vert'),
        ('FFFFFF', 'blanc');
	
-- Thomas
INSERT INTO profileur_laser (marque, no_serie, date_fabrication, date_acquisition)
	VALUES ('Laser2000', NEXTVAL('numero_serie'), '2014-10-15', '2015-05-03'),
		('SuperDuperLaser', NEXTVAL('numero_serie'), '2012-09-21', '2014-07-20'),
		('Tanguy Laser.Co', NEXTVAL('numero_serie'), '2009-02-19', '2010-11-04');
			
-- Ahmed
INSERT INTO departement(nom)
	VALUES ('administration')
		 , ('ventes et représentation')
		 , ('achats')
		 , ('mécanique')
		 , ('électrique')
		 , ('informatique')
		 , ('recherche');

-- Ahmed
INSERT INTO poste(nom)
	VALUES ('professionnel')
		 , ('technicien')
		 , ('ingénieur')
		 , ('scientifique')
		 , ('manutentionnaire')
		 , ('soutient');

-- Ahmed
INSERT INTO employe(nas, nom, prenom, genre, date_embauche, salaire, poste, departement)
	VALUES (123456789, 'Sadek', 'Ahmed', 'h', '2018-02-13', 55.0
			, (SELECT id FROM poste WHERE nom = 'technicien')
			, (SELECT id FROM departement WHERE nom = 'informatique'));

-- Thomas
INSERT INTO employe(nas, nom, prenom, genre, date_embauche, salaire, poste, departement)
	VALUES ('912345678', 'Garneau', 'Thomas', 'h', '2020-05-24', 25.0
			, (SELECT id FROM poste WHERE nom = 'professionnel')
			, (SELECT id FROM departement WHERE nom = 'ventes et représentation'));
			
-- Kerian
INSERT INTO employe(nas, nom, prenom, genre, date_embauche, salaire, poste, departement)
	VALUES (384210428, 'Devillers', 'Kerian', 'h', '2022-09-17', 30.5,
			(SELECT id FROM poste WHERE nom = 'scientifique'),
			(SELECT id FROM departement WHERE nom = 'recherche'));		
			
-- Abigail 
INSERT INTO employe(nas, nom, prenom, genre, date_embauche, salaire, poste, departement)
	VALUES (321354675, 'Fournier', 'Abigail', 'f', '2021-09-15', 22.5,
			(SELECT id FROM poste WHERE nom = 'technicien'),
			(SELECT id FROM departement WHERE nom = 'ventes et représentation'));		
			
			
--Kerian
CALL insert_inter((point(45.562579, -73.545979)), 'asphalte');
CALL insert_inter((point(45.565404, -73.554454)), 'asphalte');
CALL insert_inter((point(45.569219, -73.566320)), 'asphalte');
CALL insert_inter((point(45.560716, -73.573830)), 'asphalte');
CALL insert_inter((point(45.559928, -73.571194)), 'asphalte');
CALL insert_inter((point(45.559043, -73.568517)), 'asphalte');
CALL insert_inter((point(45.558126, -73.565556)), 'ciment');  
CALL insert_inter((point(45.557232, -73.562788)), 'ciment');
CALL insert_inter((point(45.555906, -73.558941)), 'ciment');
CALL insert_inter((point(45.554648, -73.554602)), 'asphalte');
CALL insert_inter((point(45.553693, -73.551639)), 'asphalte');

-- Thomas
CALL procedure_calibration('2016-06-22 19:10:25', '2016-06-23 12:11:05', '1000000000000000', '912345678', 156.0192, -645.9347, 110.6352);
CALL procedure_calibration('2014-08-12 00:27:15', '2014-08-18 03:47:07', '1000000000000001', '912345678', 235.7461, -190.5348, -374.9089);
CALL procedure_calibration('2018-07-28 03:18:52', '2018-07-30 07:12:14', '1000000000000001', '912345678', -844.9135, 871.2345, 734.6542);
CALL procedure_calibration('2021-06-20 08:06:11', '2021-06-21 21:28:31', '1000000000000001', '912345678', -801.0478, 337.0835, -560.3948);
CALL procedure_calibration('2009-04-22 13:03:25', '2009-04-25 11:55:38', '1000000000000002', '912345678', 337.0835, -801.0478, 518.4654);
CALL procedure_calibration('2012-12-02 09:49:29', '2012-12-06 05:18:42', '1000000000000002', '912345678', -719.4298, -453.3476, 957.8912);
CALL procedure_calibration('2015-03-25 20:58:47', '2015-03-28 14:39:09', '1000000000000002', '912345678', 249.0156, 680.6738, -797.2376);
CALL procedure_calibration('2018-05-02 18:19:35', '2018-05-06 18:07:17', '1000000000000002', '912345678', 682.7489, -926.7641, 520.6958);
CALL procedure_calibration('2019-02-12 02:01:03', '2019-02-18 10:23:26', '1000000000000002', '912345678', 942.7362, -817.2531, -613.7843);
CALL procedure_calibration('2021-09-18 07:55:41', '2021-09-24 16:56:33', '1000000000000002', '912345678', 172.8963, 172.8963, 172.8963);




-- Ahmed
CALL insertion_troncon( 'Rue Viau', 		point(45.562579, -73.545979), point(45.565404, -73.554454), 750, 50, 2, 'asphalte');
CALL insertion_troncon( 'Rue Viau', 		point(45.565404, -73.554454), point(45.562579, -73.545979), 750, 50, 2, 'asphalte');
CALL insertion_troncon( 'Rue Viau', 		point(45.565404, -73.554454), point(45.569219, -73.566320), 1000, 50, 2, 'asphalte');
CALL insertion_troncon( 'Rue Viau', 		point(45.569219, -73.566320), point(45.565404, -73.554454), 1000, 50, 2, 'asphalte');
CALL insertion_troncon( 'Boul. Rosemont', 	point(45.569219, -73.566320), point(45.560716, -73.573830), 1100, 50, 2, 'asphalte');
CALL insertion_troncon( 'Boul. Rosemont', 	point(45.560716, -73.573830), point(45.569219, -73.566320), 1100, 50, 2, 'asphalte');
CALL insertion_troncon( 'Boul. Pie-IX', 	point(45.560716, -73.573830), point(45.559928, -73.571194), 230,  30, 1, 'asphalte');
CALL insertion_troncon( 'Boul. Pie-IX', 	point(45.559928, -73.571194), point(45.560716, -73.573830), 230,  30, 1, 'asphalte');
CALL insertion_troncon( 'Boul. Pie-IX', 	point(45.559928, -73.571194), point(45.559043, -73.568517), 250,  30, 1, 'asphalte');
CALL insertion_troncon( 'Boul. Pie-IX', 	point(45.559043, -73.568517), point(45.559928, -73.571194), 250,  30, 1, 'asphalte');
CALL insertion_troncon( 'Boul. Pie-IX', 	point(45.559043, -73.568517), point(45.558126, -73.565556), 250,  30, 1, 'asphalte');
CALL insertion_troncon( 'Boul. Pie-IX', 	point(45.558126, -73.565556), point(45.559043, -73.568517), 250,  30, 1, 'asphalte');
CALL insertion_troncon( 'Boul. Pie-IX', 	point(45.558126, -73.565556), point(45.557232, -73.562788), 240,  30, 1, 'ciment');
CALL insertion_troncon( 'Boul. Pie-IX', 	point(45.557232, -73.562788), point(45.558126, -73.565556), 240,  30, 1, 'ciment');
CALL insertion_troncon( 'Boul. Pie-IX', 	point(45.557232, -73.562788), point(45.555906, -73.558941), 350,  30, 1, 'ciment');
CALL insertion_troncon( 'Boul. Pie-IX', 	point(45.555906, -73.558941), point(45.557232, -73.562788), 350,  30, 1, 'ciment');
CALL insertion_troncon( 'Boul. Pie-IX', 	point(45.555906, -73.558941), point(45.554648, -73.554602), 350,  30, 1, 'ciment');
CALL insertion_troncon( 'Boul. Pie-IX', 	point(45.554648, -73.554602), point(45.555906, -73.558941), 350,  30, 1, 'ciment');
CALL insertion_troncon( 'Boul. Pie-IX', 	point(45.554648, -73.554602), point(45.553693, -73.551639), 260,  30, 1, 'asphalte');
CALL insertion_troncon( 'Boul. Pie-IX', 	point(45.553693, -73.551639), point(45.554648, -73.554602), 260,  30, 1, 'asphalte');
CALL insertion_troncon( 'Ave. Pierre-de Coubertin', point(45.553693, -73.551639), point(45.562579, -73.545979), 1100,  50, 3, 'asphalte');
CALL insertion_troncon( 'Ave. Pierre-de Coubertin', point(45.562579, -73.545979), point(45.553693, -73.551639), 1100,  50, 3, 'asphalte');
CALL insertion_troncon( 'Rue Sherbrooke', 	point(45.565404, -73.554454), point(45.554648, -73.554602), 1200,  50, 3, 'asphalte');
CALL insertion_troncon( 'Rue Sherbrooke', 	point(45.554648, -73.554602), point(45.565404, -73.554454), 1200,  50, 3, 'asphalte');


-- Ahmed
CALL insertion_panneaux_et_dispos(100);

-- Thomas
CALL procedure_dispositif_lumineux(100.00, 1, 'horizontale');
CALL procedure_dispositif_lumineux(100.00, 2, 'verticale');
CALL procedure_dispositif_lumineux(100.00, 3, 'horizontale');
CALL procedure_dispositif_lumineux(100.00, 4, 'verticale');
CALL procedure_dispositif_lumineux(100.00, 5, 'horizontale');
CALL procedure_dispositif_lumineux(100.00, 6, 'autre');
CALL procedure_dispositif_lumineux(100.00, 7, 'verticale');
CALL procedure_dispositif_lumineux(100.00, 8, 'horizontale');
CALL procedure_dispositif_lumineux(100.00, 9, 'autre');
CALL procedure_dispositif_lumineux(100.00, 10, 'horizontale');
CALL procedure_dispositif_lumineux(100.00, 10, 'verticale');
CALL procedure_dispositif_lumineux(100.00, 10, 'horizontale');
CALL procedure_dispositif_lumineux(100.00, 11, 'verticale');
CALL procedure_dispositif_lumineux(100.00, 12, 'autre');
CALL procedure_dispositif_lumineux(100.00, 13, 'horizontale');
CALL procedure_dispositif_lumineux(100.00, 14, 'verticale');
CALL procedure_dispositif_lumineux(100.00, 15, 'autre');
CALL procedure_dispositif_lumineux(100.00, 16, 'verticale');
CALL procedure_dispositif_lumineux(100.00, 17, 'horizontale');
CALL procedure_dispositif_lumineux(100.00, 18, 'verticale');
CALL procedure_dispositif_lumineux(100.00, 18, 'horizontale');
CALL procedure_dispositif_lumineux(100.00, 19, 'verticale');
CALL procedure_dispositif_lumineux(100.00, 20, 'verticale');
CALL procedure_dispositif_lumineux(100.00, 21, 'horizontale');
CALL procedure_dispositif_lumineux(100.00, 22, 'horizontale');
CALL procedure_dispositif_lumineux(100.00, 23, 'verticale');
CALL procedure_dispositif_lumineux(100.00, 24, 'horizontale');

-- Abigail et Kerian
DO $$
BEGIN
	FOR inspection IN 1..100 LOOP
		CALL insertion_inspection();
	END LOOP;
END; $$


