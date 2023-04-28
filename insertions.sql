
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
  VALUES("ronde"),
        ("carrée"),
        ("losange"),
        ("flèche haut"),
        ("flèche droite"),
        ("flèche gauche"),
        ("flèche bas"),
        ("flèche haut-droite"),
        ("flèche haut-gauche"),
        ("flèche bas-droite"),
        ("flèche bas-gauche"),
        ("humain"),
        ("main"),
        ("vélo"),
        ("barre verticale"),
        ("barre horizontale");
        
-- Thomas
INSERT INTO couleur (hex, nom)
  VALUES("FF0000", "rouge"),
        ("FFFF00", "jaune"),
        ("00FF00", "vert"),
        ("FFFFFF", "blanc");
        
        -- insertion 

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
	VALUES (912345678, 'Garneau', 'Thomas', 'h', CURRENT_DATE, 25.0
			, (SELECT id FROM poste WHERE nom = 'professionnel')
			, (SELECT id FROM departement WHERE nom = 'ventes et représentation'));
