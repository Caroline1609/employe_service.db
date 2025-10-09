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

 
/*11. Liste des employés vendeur*/