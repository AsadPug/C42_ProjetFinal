--Abigail
INSERT INTO type_dispositif_particulier(type)
VALUES('accès fauteuil roulant'),
      ('signal audio pour piéton');

--Abigail
INSERT INTO type_dispositif_particulier(type)
VALUES('signal audio pour piéton');

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
	VALUES ('Laser2000', '1998965734919827', '2014-10-15', '2015-05-03'),
		('SuperDuperLaser', '2096482365198463', '2012-09-21', '2014-07-20'),
		('Tanguy Laser.Co', '7592736401847263', '2009-02-19', '2010-11-04');
			
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
	VALUES (123456789, 'Sadek', 'Ahmed', 'h', CURRENT_DATE, 55.0
			, (SELECT id FROM poste WHERE nom = 'technicien')
			, (SELECT id FROM departement WHERE nom = 'informatique'));

-- Thomas
INSERT INTO employe(nas, nom, prenom, genre, date_embauche, salaire, poste, departement)
	VALUES ('912345678', 'Garneau', 'Thomas', 'h', CURRENT_DATE, 25.0
			, (SELECT id FROM poste WHERE nom = 'professionnel')
			, (SELECT id FROM departement WHERE nom = 'ventes et représentation'));
			
-- Kerian
INSERT INTO employe(nas, nom, prenom, genre, date_embauche, salaire, poste, departement)
	VALUES (384210428, 'Devillers', 'Kerian', 'h', CURRENT_DATE, 30.5,
			(SELECT id FROM poste WHERE nom = 'scientifique'),
			(SELECT id FROM departement WHERE nom = 'recherche'));		
			
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
CALL procedure_calibration('2016-06-22 19:10:25', '2016-06-23 12:11:05', '1998965734919827', '912345678', 156.0192, -645.9347, 110.6352);
CALL procedure_calibration('2014-08-12 00:27:15', '2014-08-18 03:47:07', '2096482365198463', '912345678', 235.7461, -190.5348, -374.9089);
CALL procedure_calibration('2018-07-28 03:18:52', '2018-07-30 07:12:14', '2096482365198463', '912345678', -844.9135, 871.2345, 734.6542);
CALL procedure_calibration('2021-06-20 08:06:11', '2021-06-21 21:28:31', '2096482365198463', '912345678', -801.0478, 337.0835, -560.3948);
CALL procedure_calibration('2009-04-22 13:03:25', '2009-04-25 11:55:38', '7592736401847263', '912345678', 337.0835, -801.0478, 518.4654);
CALL procedure_calibration('2012-12-02 09:49:29', '2012-12-06 05:18:42', '7592736401847263', '912345678', -719.4298, -453.3476, 957.8912);
CALL procedure_calibration('2015-03-25 20:58:47', '2015-03-28 14:39:09', '7592736401847263', '912345678', 249.0156, 680.6738, -797.2376);
CALL procedure_calibration('2018-05-02 18:19:35', '2018-05-06 18:07:17', '7592736401847263', '912345678', 682.7489, -926.7641, 520.6958);
CALL procedure_calibration('2019-02-12 02:01:03', '2019-02-18 10:23:26', '7592736401847263', '912345678', 942.7362, -817.2531, -613.7843);
CALL procedure_calibration('2021-09-18 07:55:41-05', '2021-09-24 16:56:33-04', '7592736401847263', '912345678', 172.8963, 172.8963, 172.8963);
