-- =======================================================
-- Requête: Série 1, #1
-- Objectif : Donner la liste des employés : nom, prénom, poste, nom du département,
-- ancienneté (en année et mois), leur salaire annuel (considérant qu’ils travaillent 
-- 35 heures par semaine et 52 semainespar année) et leur salaire annuel augmenté de 15%.
-- Évaluation : ...
-- Réalisé par : Ahmed Sadek
-- Aidé par : ...
-- =======================================================
SELECT    nom_employe AS "Nom de employe"
		, prenom_employe AS "Prenom de employe"
		, poste_employe AS "Poste de employe"
		, departement_employe AS "Nom du département"
		, EXTRACT(YEAR FROM age(CURRENT_DATE, date_embauche_employe)) || ' ans et ' ||
		  EXTRACT(MONTH FROM age(CURRENT_DATE, date_embauche_employe)) || ' mois' AS "Ancienneté"
		, salaire_employe * 35 * 52 AS "Salaire annuel"
		, (salaire_employe * 35 * 52) * 1.15 AS "Salaire annuel augmenté de 15%"
		
FROM employe_departement_poste;
-- =======================================================

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
-- Requête: Série 1, #3
-- Objectif : Donner le nombre d’inspections que chaque employé a fait.
-- Réalisé par : Abigail Fournier
-- Aidé par : ...
-- =======================================================
SELECT emp.prenom || ' ' || emp.nom as "Nom", SUM(n_emp_ins.n_ins) as "Nombre d inspection"
	FROM(SELECT ins.inspecteur as employe, COUNT(*) as n_ins
			 FROM inspection as ins
			 GROUP BY ins.inspecteur
		 UNION ALL
		 SELECT * 
		 	 FROM nombre_conducteur_inspection) as n_emp_ins
	INNER JOIN employe AS emp
			ON n_emp_ins.employe = emp.id
	GROUP BY emp.nom, emp.prenom;
-- =======================================================

-- =======================================================
-- Requête: Série 1, #4
-- Objectif : Donner le nombre d’inspections où chaque employé était conducteur.
-- Réalisé par : Kerian Devillers
-- Aidé par : ...
-- =======================================================
SELECT emp.prenom || ' ' || emp.nom AS "Nom", COUNT(*) AS "Nombre de fois conducteur"
	FROM inspection AS ins
		INNER JOIN employe AS emp
			ON ins.conducteur = emp.id 
	GROUP BY emp.nom, emp.prenom;
-- =======================================================


-- =======================================================
-- Requête: Série 2, #1
-- Objectif : Pour chaque véhicule, combien de kilomètres de tronçons 
-- ont été parcourus pour réaliser les inspections.
--
-- Note: Nous avons un trigger qui rajoute la distance d'un troncons au kilo_fin
-- d'une inspection lorsque qu'une valeure est ajouté a troncon_inspection. Cela 
-- rend cette requête beaucoup plus simple puisque nous pouvons assumer que
-- kilo_fin - kilo_debut va toujours être égale a la somme de tout les tronçons de
-- l'inspection
--
-- Réalisé par : Abigail Fournier
-- Aidé par : ...
-- =======================================================
SELECT vehicule, SUM(kilo_fin - kilo_debut) as "Nombre de kilomètres parcouru pour les inspection"
	FROM inspection
	GROUP BY vehicule;
-- =======================================================

-- =======================================================
-- Requête: Série 2, #2
-- Objectif : Pour chacune des inspections, on désire savoir quels ont été les frais 
-- associés (vous devez tenir compte du temps passé pour les deux employés lors de 
-- l’inspection et des coûts d’exploitation du véhicule à 4.79$ par kilomètre.).
-- Évaluation : ...
-- Réalisé par : Ahmed Sadek
-- Aidé par : ...
-- =======================================================
SELECT 	ins.id AS "Inspection", 
		ROUND(
	  	heures_totales(ins.date_debut, ins.date_fin) * conducteur.salaire + 
	  	heures_totales(ins.date_debut, ins.date_fin) * inspecteur.salaire + 
	  	(kilo_fin - kilo_debut) * 4.79
	  	, 2) || '$' AS "Frais associés"
FROM inspection AS ins
INNER JOIN employe AS conducteur
	ON ins.conducteur = conducteur.id
INNER JOIN employe AS inspecteur
	ON ins.inspecteur = inspecteur.id;
-- =======================================================

-- =======================================================
-- Requête: Série 2, #3
-- Objectif : On veut la liste des profileurs laser ayant besoin d’être calibrés. La formule suivante permet de valider cette information. Si cet énoncé est vrai, une calibration est requise :
--√|𝑣1𝑣2 – 1| ≤ 1
--𝑣2 𝜋2
-- Réalisé par : Kerian Devillers
-- Aidé par : ...
-- =======================================================
SELECT pl.id 
	FROM profileur_laser AS pl
		INNER JOIN calibration AS cal
			ON pl.id = cal.profileur
	WHERE SQRT(ABS(((cal.v1 * cal.v2) / (cal.v3 ^2)) - 1)) <= (1 / (PI()^2)) 
		 AND cal.id = (SELECT id
					  	FROM calibration
					  	ORDER BY date_fin DESC
						LIMIT  1);
-- =======================================================

-- =======================================================
-- Requête: Série 2, #4
-- Objectif : Identifier tous les tronçons de rue qui ont un dispositif de signalisation lumineux de
-- forme « humain », « main » ou « vélo » et en quelle quantité. Le résultat doit montrer
-- le nom de la rue du tronçon et le nombre de dispositifs lumineux de chaque forme
-- spécifiée. Le résultat ne devrait pas montrer de NULL (0 si aucune), ni les tronçons qui
-- n’ont aucun dispositif avec des lumières de ces formes.
-- Évaluation : Le nombre de lumières de chaque type incluant "humain", "main", "vélo" selon chaque 
-- nom de rue.
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
		LIMIT 1;
-- =======================================================

-- =======================================================
-- Requête: Série 3
-- Objectif: Donner le nom et le prenom du conducteur qui a conduit la 
-- même voiture pour le plus grand nombre d'inspection si et seulement si le 
-- conducteur à conduit ce vehicule pour plus de 10 inspections. Donne également le
-- d'inspection que ce conducteur a conduit se vehicule.
-- Réalisé par : Abigail Fournier
-- Aidé par : ...
-- =======================================================
SELECT n_veh_ins.nom as "nom du conducteur",
	n_veh_ins.count as "nombre d inspection avec le meme vehicule"
	FROM   (SELECT veh.immatriculation,
			emp.prenom || ' ' || emp.nom as nom, COUNT(*)
				FROM vehicule as veh
				INNER JOIN inspection as ins ON veh.id = ins.vehicule
				INNER JOIN employe as emp ON ins.conducteur = emp.id
				GROUP BY veh.immatriculation,emp.prenom,  emp.nom
				HAVING COUNT(*)>10)as n_veh_ins
	ORDER BY "nombre d inspection avec le meme vehicule" DESC
	LIMIT 1;
-- =======================================================

-- =======================================================
-- Requête: Série #3
-- Objectif : Donner le nom et salaire de l'employé qui as les salaire le plus bas 
-- tout en ayant fait au moins une inspection en tant qu'inspecteur et au moins 25 en tant que conducteur 
-- Réalisé par : Kerian Devillers
-- Aidé par : ...
-- =======================================================
SELECT emp.prenom || ' ' || emp.nom AS "Nom employé", emp.salaire
	FROM employe AS emp
		INNER JOIN inspection AS ins
			ON emp.id = ins.conducteur
	WHERE emp.id = (SELECT inspection.inspecteur FROM inspection WHERE inspection.inspecteur = emp.id LIMIT 1)
	GROUP BY emp.nom, emp.prenom, emp.salaire
	HAVING COUNT(*) > 25
	ORDER BY emp.salaire
	LIMIT 1;
-- =======================================================

-- =======================================================
-- Requête: Série 3
-- Objectif : Donner le nom des 3 premières tronçons ayant un nombre 
-- d'inspections qui est juste en dessous du moyen d'inspections par tronçon.
-- Donner également le nombre d'inspections pour chaqu'un de ses tronçon.
-- Fournissez également le
-- Évaluation : ...
-- Réalisé par : Ahmed Sadek
-- Aidé par : ...
-- =======================================================
SELECT    tro_ins.troncon AS "Id du troncon"
		, tro.nom AS "Nom de la rue"
		, COUNT(*) AS "Nombre intersections par troncon"
FROM troncon_inspection AS "tro_ins"
INNER JOIN inspection AS "ins"
	ON tro_ins.inspection = ins.id
INNER JOIN troncon AS "tro"
	ON tro_ins.troncon = tro.id
GROUP BY tro_ins.troncon, tro.nom
	HAVING COUNT(*) < (SELECT AVG("nbr inspections par troncon") 
							FROM (SELECT COUNT(*) AS "nbr inspections par troncon"
									FROM troncon_inspection AS "tro_ins"
									INNER JOIN inspection AS "ins"
										ON tro_ins.inspection = ins.id
									INNER JOIN troncon AS "tro"
										ON tro_ins.troncon = tro.id
									GROUP BY tro_ins.troncon
									ORDER BY tro_ins.troncon ASC) AS moyen)
ORDER BY tro_ins.troncon DESC
LIMIT 3;
-- =======================================================
