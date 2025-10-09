DROP DATABASE if EXISTS db_employe_service;

CREATE DATABASE  db_employe_service;

USE db_employe_service;

CREATE TABLE dept (
  DEPTNO int(10) UNSIGNED NOT NULL,
  DNAME varchar(50) NOT NULL,
  LOC varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table emp
--

CREATE TABLE emp (
  EMPNO int(10) UNSIGNED NOT NULL,
  ENAME varchar(50) NOT NULL,
  JOB varchar(50) NOT NULL,
  MGR int(10) UNSIGNED DEFAULT NULL,
  HIREDATE date NOT NULL,
  SAL decimal(8,2) NOT NULL,
  COMM int(11) DEFAULT NULL,
  DEPTNO int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table dept
--
ALTER TABLE dept
  ADD CONSTRAINT pk_deptno PRIMARY KEY (DEPTNO);

--
-- Index pour la table emp
--
ALTER TABLE emp
  ADD PRIMARY KEY (EMPNO);
--  ADD KEY FK_departement (DEPTNO);


-- Contraintes pour la table emp
--
ALTER TABLE emp
  ADD CONSTRAINT FK_departement FOREIGN KEY (DEPTNO) REFERENCES dept (DEPTNO);
  
  
  
  INSERT INTO `dept` (`DEPTNO`, `DNAME`, `LOC`) VALUES
(10, 'ACCOUNTING', 'NEWYORK'),
(20, 'RESEARCH', 'DALLAS'),
(30, 'SALES', 'CHICAGO'),
(40, 'OPERATIONS', 'BOSTON');

--
-- Déchargement des données de la table `emp`
--

INSERT INTO `emp` (`EMPNO`, `ENAME`, `JOB`, `MGR`, `HIREDATE`, `SAL`, `COMM`, `DEPTNO`) VALUES
(7369, 'SMITH', 'CLERK', 7902, '1980-12-17', '800.00', NULL, 20),
(7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20', '1600.00', 300, 30),
(7521, 'WARD', 'SALESMAN', 7698, '1981-02-22', '1250.00', 500, 30),
(7566, 'JONES', 'MANAGER', 7839, '1981-04-02', '2975.00', NULL, 20),
(7654, 'MARTIN', 'SALESMAN', 7698, '1981-11-28', '1250.00', 1400, 30),
(7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01', '2850.00', NULL, 30),
(7782, 'CLARK', 'MANAGER', 7839, '1981-07-09', '2450.00', NULL, 10),
(7788, 'SCOTT', 'ANALYST', 7566, '1982-12-09', '3000.00', NULL, 20),
(7839, 'KING', 'PRESIDENT', NULL, '1981-11-17', '5000.00', NULL, 10),
(7844, 'TURNER', 'SALESMAN', 7698, '1981-09-08', '1500.00', 0, 30),
(7876, 'ADAMS', 'CLERK', 7788, '1983-01-12', '1100.00', NULL, 20),
(7900, 'JAMES', 'CLERK', 7698, '1981-12-03', '950.00', NULL, 30),
(7902, 'FORD', 'ANALYST', 7566, '1981-12-03', '3000.00', NULL, 20),
(7934, 'MILLER', 'CLERK', 7782, '1982-01-23', '1300.00', NULL, 10);

