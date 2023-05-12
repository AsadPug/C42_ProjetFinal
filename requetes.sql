-- =======================================================
-- Requête: Série 1, #2
-- Objectif : Donner le nombre de calibrations que chaque employé a fait.
-- Évaluation : Le prénom et le nom de chaque employé et le nombre de
-- calibrations qui ont été enregistrées à leur nom.
-- Réalisé par : Thomas Garneau
-- Aidé par : ...
-- =======================================================
SELECT * FROM employe_calibration;
-- =======================================================

-- =======================================================
-- Requête: Série 2, #4
-- Objectif : Identifier tous les tronçons de rue qui ont un dispositif de signalisation lumineux de
-- forme « humain », « main » ou « vélo » et en quelle quantité. Le résultat doit montrer
-- le nom de la rue du tronçon et le nombre de dispositifs lumineux de chaque forme
-- spécifiée. Le résultat ne devrait pas montrer de NULL (0 si aucune), ni les tronçons qui
-- n’ont aucun dispositif avec des lumières de ces formes.
-- Évaluation : 
-- Réalisé par : Thomas Garneau
-- Aidé par : ...
-- =======================================================
SELECT tro.nom AS "Nom de la rue du troncon",
		COALESCE(SUM(1) FILTER (WHERE lum.forme = (SELECT id FROM forme WHERE forme = 'humain')), 0) AS "Lumière avec la forme humain",
		COALESCE(SUM(1) FILTER (WHERE lum.forme = (SELECT id FROM forme WHERE forme = 'main')), 0) AS "Lumière avec la forme main",
		COALESCE(SUM(1) FILTER (WHERE lum.forme = (SELECT id FROM forme WHERE forme = 'vélo')), 0) AS "Lumière avec la forme vélo"
		FROM troncon AS tro 
		INNER JOIN dispositif_lumineux as dl ON tro.id = dl.troncon
		INNER JOIN lumiere as lum ON dl.id = lum.dispositif
		WHERE lum.forme = (SELECT id FROM forme WHERE forme = 'humain') OR
			  lum.forme = (SELECT id FROM forme WHERE forme = 'main') OR
			  lum.forme = (SELECT id FROM forme WHERE forme = 'vélo')
		GROUP BY tro.nom;
-- =======================================================

-- =======================================================
-- Requête: Série #3
-- Objectif : Identifier le tronçons de rue qui a le plus de panneau de
-- type « arrêt » et en quelle quantité. Le résultat doit montrer
-- le nom de la rue du tronçon et le nombre de panneau de ce type.
-- Évaluation : Le nom de rue du tronçon et le nombre de panneau de type « arrêt » 
-- Réalisé par : Thomas Garneau
-- Aidé par : ...
-- =======================================================
SELECT tro.nom AS "Nom de la rue du troncon",
		COUNT(pan.id) AS "Nombre de panneau darrêt"
		FROM troncon AS tro 
		INNER JOIN panneau as pan ON tro.id = pan.troncon
		INNER JOIN type_panneau as tp ON pan.id = (SELECT id FROM type_panneau WHERE type = 'arrêt')	
		GROUP BY tro.nom, tro.id, pan.id
		HAVING pan.position > 50
		ORDER BY tro.id ASC
		LIMIT 3;
-- =======================================================
