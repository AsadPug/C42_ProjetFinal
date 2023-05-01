
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

