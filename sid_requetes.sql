-- ================================================
-- SID – Béni Mellal-Khénifra : Matériaux (2005-2019)
-- Script SQL : Structure + Requêtes Analytiques
-- ================================================

-- 1. Requête de base : liste des produits par corps
SELECT dc.nom_corps, dm.activite, dm.produit, dm.variete
FROM dim_materiau dm JOIN dim_corps dc ON dm.id_corps = dc.id_corps
ORDER BY dc.nom_corps, dm.activite;

-- 2. Prix moyen par corps de travaux
SELECT dc.nom_corps, ROUND(AVG(fp.prix),2) AS prix_moyen
FROM fait_prix fp
JOIN dim_materiau dm ON fp.id_materiau = dm.id_materiau
JOIN dim_corps dc ON dm.id_corps = dc.id_corps
GROUP BY dc.nom_corps ORDER BY prix_moyen DESC;

-- 3. Évolution du prix moyen global par année (KPI Temporel)
SELECT annee, ROUND(AVG(prix),2) AS prix_moyen
FROM fait_prix GROUP BY annee ORDER BY annee;

-- 4. Jointure 3 tables : produits Gros œuvre avec prix 2019
SELECT dm.produit, dm.variete, fp.prix
FROM fait_prix fp
JOIN dim_materiau dm ON fp.id_materiau = dm.id_materiau
JOIN dim_corps dc    ON dm.id_corps    = dc.id_corps
WHERE dc.nom_corps = 'Gros œuvre' AND fp.annee = 2019
ORDER BY fp.prix DESC;

-- 5. Taux de croissance 2005-2019 par corps (CTE optimisé)
WITH debut AS (
    SELECT dm.id_corps, AVG(fp.prix) AS p2005
    FROM fait_prix fp JOIN dim_materiau dm ON fp.id_materiau = dm.id_materiau
    WHERE fp.annee = 2005 GROUP BY dm.id_corps
),
fin AS (
    SELECT dm.id_corps, AVG(fp.prix) AS p2019
    FROM fait_prix fp JOIN dim_materiau dm ON fp.id_materiau = dm.id_materiau
    WHERE fp.annee = 2019 GROUP BY dm.id_corps
)
SELECT dc.nom_corps,
       ROUND(d.p2005, 2) AS prix_2005,
       ROUND(f.p2019, 2) AS prix_2019,
       ROUND((f.p2019 - d.p2005)/d.p2005*100, 2) AS taux_croissance_pct
FROM debut d JOIN fin f ON d.id_corps = f.id_corps
JOIN dim_corps dc ON d.id_corps = dc.id_corps
ORDER BY taux_croissance_pct DESC;

-- 6. HAVING : corps dont le prix moyen 2019 dépasse 200 MAD
SELECT dc.nom_corps, ROUND(AVG(fp.prix),2) AS prix_moy
FROM fait_prix fp
JOIN dim_materiau dm ON fp.id_materiau = dm.id_materiau
JOIN dim_corps dc ON dm.id_corps = dc.id_corps
WHERE fp.annee = 2019
GROUP BY dc.nom_corps HAVING prix_moy > 200
ORDER BY prix_moy DESC;

-- 7. CASE WHEN : catégorisation des prix 2019
SELECT dm.produit,
       ROUND(fp.prix,2) AS prix_2019,
       CASE
           WHEN fp.prix < 10   THEN 'Très bas'
           WHEN fp.prix < 50   THEN 'Bas'
           WHEN fp.prix < 200  THEN 'Moyen'
           WHEN fp.prix < 1000 THEN 'Élevé'
           ELSE 'Très élevé'
       END AS categorie_prix
FROM fait_prix fp
JOIN dim_materiau dm ON fp.id_materiau = dm.id_materiau
WHERE fp.annee = 2019 ORDER BY fp.prix DESC;

-- 8. Sous-requête : produits au-dessus du prix moyen général 2019
SELECT dm.produit, dm.variete, ROUND(fp.prix,2) AS prix
FROM fait_prix fp
JOIN dim_materiau dm ON fp.id_materiau = dm.id_materiau
WHERE fp.annee = 2019
  AND fp.prix > (SELECT AVG(prix) FROM fait_prix WHERE annee = 2019)
ORDER BY fp.prix DESC;

-- 9. Procédure stockée simulée : détection anomalies prix nul
-- (SQLite ne supporte pas nativement les procédures, logique équivalente)
SELECT dm.produit, fp.annee, fp.prix
FROM fait_prix fp JOIN dim_materiau dm ON fp.id_materiau = dm.id_materiau
WHERE fp.prix IS NULL OR fp.prix <= 0;

-- 10. Vue récapitulative KPI globaux
SELECT * FROM vue_kpi_corps;