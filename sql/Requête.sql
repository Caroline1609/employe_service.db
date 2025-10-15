/* 1- Donner nom, job, numéro et salaire de tous les employés,
puis seulement des employés du département 10*/

SELECT ENAME AS Nom,
       JOB AS Poste,
       EMPNO AS Numero,
       SAL AS Salaire
FROM emp
WHERE DEPTNO = 10;


/* 2. Donner nom, job et salaire des employés de type MANAGER dont le salaire est supérieur à 2800*/

SELECT ENAME AS Nom,
       JOB AS Poste,
       SAL AS Salaire
FROM emp
WHERE JOB = 'MANAGER'
  AND SAL > 2800;

/* 3. Donner la liste des MANAGER n'appartenant pas au département 30*/

SELECT ENAME AS Nom,
       JOB AS Poste,
       DEPTNO AS Departement
FROM emp
WHERE JOB = 'MANAGER'
  AND DEPTNO <> 30;


/*4. Liste des employés de salaire compris entre 1200 et 1400*/

SELECT ENAME AS Nom,
       JOB AS Poste,
       SAL AS Salaire
FROM emp
WHERE SAL BETWEEN 1200 AND 1400;


/*5. Liste des employés des départements 10 et 30 classés dans l'ordre alphabétique*/

SELECT ENAME AS Nom,
       JOB AS Poste,
       DEPTNO AS Departement
FROM emp
WHERE DEPTNO IN (10, 30)
ORDER BY ENAME ASC;



/*6. Liste des employés du département 30 classés dans l'ordre des salaires croissants*/

SELECT ENAME AS Nom,
       JOB AS Poste,
       DEPTNO AS Departement,
       SAL AS Salaire       
FROM emp
WHERE DEPTNO = 30
ORDER BY SAL ASC;

/*7. Liste de tous les employés classés par emploi et salaires décroissants*/

SELECT ENAME AS Nom,
       JOB AS Poste,
       SAL AS Salaire
FROM emp
ORDER BY JOB ASC, SAL DESC;


/*8. Liste des différents emplois*/

SELECT DISTINCT JOB AS Poste
FROM emp;

/*9. Donner le nom du département où travaille ALLEN*/

SELECT emp.ENAME AS Nom,
       dept.DNAME AS Nom_complet_du_departement
FROM emp 
INNER JOIN dept ON emp.DEPTNO = dept.DEPTNO
WHERE emp.ENAME = 'ALLEN';


/*10. Liste des employés avec nom du département, nom, job, salaire classés par noms de départements et 
par salaires décroissants.*/

SELECT dept.DNAME AS "Nom de Departement",
			ENAME AS Nom,
			JOB AS Poste,
			SAL AS "Salaire mensuel"
FROM emp NATURAL JOIN dept
ORDER BY dept.DNAME ASC;
			
			
/* 11. Liste des employés vendeurs (SALESMAN) avec affichage de nom, salaire, commissions, salaire + commissions */

SELECT ENAME AS Nom,
       SAL AS Salaire,
       COMM AS Commission,
       (SAL + IFNULL(COMM, 0)) AS Salaire_total /* remplace la commission NULL (absence de commission) par 0. */
FROM emp
WHERE JOB = 'SALESMAN';



/* 12. Liste des employés du département 20: nom, job, date d'embauche sous forme 'VEN 28 FEV 1997' */

SELECT ENAME AS Nom,
       JOB AS Poste,
       DATE_FORMAT(HIREDATE, '%a %d %b %Y') AS Date_Embauche
FROM emp
WHERE DEPTNO = 20;


/* 13. Donner le salaire le plus élevé par département */

SELECT 
		DEPTNO,
		MAX(SAL) AS Salaire_max
FROM emp
GROUP BY DEPTNO;


/* 14. Donner département par département masse salariale, nombre d'employés, salaire moyen par type d'emploi. */

SELECT 
    dept.DNAME AS Departement,
    emp.JOB AS Type_emploi,
    SUM(SAL + IFNULL(COMM, 0)) AS Masse_salariale_totale,
    COUNT(emp.EMPNO) AS Nombre_employes,
    ROUND(AVG(SAL), 2) AS Salaire_moyen
FROM emp
INNER JOIN dept ON emp.DEPTNO = dept.DEPTNO
GROUP BY dept.DNAME, emp.JOB




/* 15. Même question mais on se limite aux sous-ensembles d'au moins 2 employés */

SELECT 
    dept.DNAME AS Departement,
    emp.JOB AS Type_emploi,
    SUM(SAL + IFNULL(COMM, 0)) AS Masse_salariale_totale,
    COUNT(emp.EMPNO) AS Nombre_employes,
    ROUND(AVG(SAL), 2) AS Salaire_moyen
FROM emp
INNER JOIN dept ON emp.DEPTNO = dept.DEPTNO
GROUP BY dept.DNAME, emp.JOB
HAVING COUNT(emp.EMPNO) >= 2;


/* 16. Liste des employés (Nom, département, salaire) de même emploi que JONES */

SELECT 
    ENAME AS Nom,
    DEPTNO AS Departement,
    SAL AS Salaire
FROM emp
WHERE JOB = (
    SELECT JOB
    FROM emp
    WHERE ENAME = 'JONES'
);


/* 17. Liste des employés (nom, salaire) dont le salaire est supérieur à la moyenne globale des salaires */

SELECT 
		ENAME AS Nom,
		SAL AS Salaire
FROM emp
WHERE SAL > (
	SELECT AVG(SAL)
	FROM emp
);


/* 18. Création d'une table PROJET avec comme colonnes numéro de projet (3 chiffres), nom de projet (5 caractères), budget. 
Entrez les valeurs suivantes:
101, ALPHA, 96000
102, BETA, 82000
103, GAMMA, 15000 */

DROP TABLE if EXISTS projet;

CREATE TABLE projet (
    NUM_PROJ INT NOT NULL PRIMARY KEY,
    NOM_PROJ CHAR(5) NOT NULL,
    BUDGET DECIMAL(10,2) NOT NULL
);


INSERT INTO projet (NUM_PROJ, NOM_PROJ, BUDGET)
VALUES
	(101, 'ALPHA', 96000),
	(102, 'BETA', 82000),
	(103, 'GAMMA', 15000);



/* 19. Ajouter l'attribut numéro de projet à la table EMP et affecter tous les vendeurs du département 30 au projet 101, 
et les autres au projet 102 */


ALTER TABLE emp
ADD NUM_PROJET INT;

ALTER TABLE emp
ADD CONSTRAINT FK_emp_projet FOREIGN KEY (NUM_PROJET) REFERENCES projet(NUM_PROJ);

UPDATE emp
SET NUM_PROJET = 101
WHERE JOB = 'SALESMAN' AND DEPTNO = 30;

UPDATE emp
SET NUM_PROJET = 102
WHERE NUM_PROJET IS NULL;


/* 20. Créer une vue comportant tous les employés avec nom, job, nom de département et nom de projet */

SELECT
    emp.ENAME AS "Nom des employés",
    emp.JOB AS Poste,
    dept.DNAME AS "Nom du département",
    projet.NOM_PROJ AS "Nom du projet"
FROM emp
INNER JOIN dept ON emp.DEPTNO = dept.DEPTNO
INNER JOIN projet ON emp.NUM_PROJET = projet.NUM_PROJ;


/* 21. À l'aide de la vue créée précédemment, lister tous les employés avec nom, job, nom de département et nom de projet 
triés sur nom de département et nom de projet */

SELECT
    emp.ENAME AS "Nom des employés",
    emp.JOB AS Poste,
    dept.DNAME AS "Nom du département",
    projet.NOM_PROJ AS "Nom du projet"
FROM emp
INNER JOIN dept ON emp.DEPTNO = dept.DEPTNO
INNER JOIN projet ON emp.NUM_PROJET = projet.NUM_PROJ;
ORDER BY NOM_DEPT, NOM_PROJET; 



/* 22. Donner le nom du projet associé à chaque manager */

SELECT
		projet.NOM_PROJ AS "Nom du projet",
		emp.ENAME AS "Nom du manager"
FROM projet
INNER JOIN emp ON projet.NUM_PROJ = emp.NUM_PROJET
WHERE JOB = 'MANAGER';


/*Deuxième partie*/

/* 1. Afficher la liste des managers des départements 20 et 30 */

SELECT 
		emp.ENAME AS "nom de l'employer",
		emp.JOB AS Poste,
		emp.DEPTNO AS "numéro du département"
FROM emp
WHERE JOB = 'MANAGER' 
AND DEPTNO IN (20, 30);
	
		
			
/* 2. Afficher la liste des employés qui ne sont pas manager et qui ont été embauchés en 81 */

SELECT 
    ENAME AS "Nom de l'employé",
    JOB AS "Poste",
    HIREDATE AS "Date d'embauche"
FROM emp
WHERE JOB <> 'MANAGER'
  AND YEAR(HIREDATE) = 1981;


/* 3. Afficher la liste des employés ayant une commission */

SELECT 
    ENAME AS "Nom de l'employé",
    COMM AS "Commission"
FROM emp
WHERE COMM IS NOT NULL 
  AND COMM <> 0;


/* 4. Afficher la liste des noms, numéros de département, jobs et date d'embauche triés par Numero de 
Département et JOB les derniers embauches d'abord. */





/* 5. Afficher la liste des employés travaillant à DALLAS */

/* 6. Afficher les noms et dates d'embauche des employés embauchés avant leur manager, avec le nom et 
date d'embauche du manager. */

/* 7. Lister les numéros des employés n'ayant pas de subordonné. */

/* 8. Afficher les noms et dates d'embauche des employés embauchés avant BLAKE. */

/* 9. Afficher les employés embauchés le même jour que FORD. */

/* 10. Lister les employés ayant le même manager que CLARK. */

/* 11. Lister les employés ayant même job et même manager que TURNER. */

/* 12. Lister les employés du département RESEARCH embauchés le même jour que quelqu'un du 
département SALES */

/* 13. Lister le nom des employés et également le nom du jour de la semaine correspondant à leur date 
d'embauche. */

/* 14. Donner, pour chaque employé, le nombre de mois qui s'est écoulé entre leur date d'embauche et la 
date actuelle. */

/* 15. Afficher la liste des employés ayant un M et un A dans leur nom. */

/* 16. Afficher la liste des employés ayant deux 'A' dans leur nom. */

/* 17. Afficher les employés embauchés avant tous les employés du département 10. */

/* 18. Sélectionner le métier où le salaire moyen est le plus faible. */

/* 19. Sélectionner le département ayant le plus d'employés. */

/* 20. Donner la répartition en pourcentage du nombre d'employés par département selon le modèle ci-dessous :
Département   Répartition en % 
-----------   ----------------
10            21.43 
20            35.71 
30            42.86 */


