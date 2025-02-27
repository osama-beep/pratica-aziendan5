
USE master;
ALTER DATABASE Aziendan5 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
ALTER DATABASE Aziendan5 SET MULTI_USER;

IF EXISTS (SELECT name FROM sys.databases WHERE name = 'Aziendan5')
BEGIN
    DROP DATABASE Aziendan5;
END
GO

CREATE DATABASE Aziendan5;
GO

USE Aziendan5;
GO

IF OBJECT_ID('dbo.IMPIEGATO', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.IMPIEGATO;
END
IF OBJECT_ID('dbo.IMPIEGO', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.IMPIEGO;
END
GO

CREATE TABLE IMPIEGATO (
    IDImpiegato INT IDENTITY(1,1) PRIMARY KEY,
    Cognome NVARCHAR(50) NOT NULL,
    Nome NVARCHAR(50) NOT NULL,
    CodiceFiscale NVARCHAR(16) NOT NULL UNIQUE,
    Eta INT CHECK (Eta >= 0),
    RedditoMensile DECIMAL(10, 2) CHECK (RedditoMensile >= 0),
    DetrazioneFiscale BIT
);
GO

CREATE TABLE IMPIEGO (
    IDImpiego INT IDENTITY(1,1) PRIMARY KEY,
    TipoImpiego NVARCHAR(50) NOT NULL,
    Assunzione DATETIME NOT NULL,
    IDImpiegato INT FOREIGN KEY REFERENCES IMPIEGATO(IDImpiegato)
);
GO

INSERT INTO IMPIEGATO (Cognome, Nome, CodiceFiscale, Eta, RedditoMensile, DetrazioneFiscale) VALUES
('Rossi', 'Mario', 'RSSMRA80A01H501Z', 35, 1500.00, 1),
('Bianchi', 'Lucia', 'BNCUCA90B41H501Z', 28, 900.00, 1),
('Verdi', 'Luca', 'VRDLCA85C01H501Z', 42, 2000.00, 0),
('Gialli', 'Francesca', 'GLLFNC92D01H501Z', 30, 1100.00, 1),
('Neri', 'Marco', 'NRIMRC88E01H501Z', 45, 2500.00, 0),
('Marrone', 'Giulia', 'MRRGIU95F01H501Z', 27, 800.00, 1),
('Grigio', 'Andrea', 'GRGNDL87G01H501Z', 50, 2200.00, 0),
('Blu', 'Sara', 'BLUSRA82H01H501Z', 31, 1300.00, 1),
('Argento', 'Alessandro', 'ARGALS89I01H501Z', 29, 1200.00, 0),
('Oro', 'Laura', 'OROLRA91J01H501Z', 34, 1600.00, 1),
('Turchese', 'Paolo', 'TRCPLO84K01H501Z', 48, 2700.00, 0),
('Ciano', 'Elena', 'CNELEA86L01H501Z', 40, 1900.00, 1),
('Fucsia', 'Simone', 'FCSMNE83M01H501Z', 39, 1300.00, 0),
('Indaco', 'Martina', 'INDMRT81N01H501Z', 25, 850.00, 1),
('Lavanda', 'Daniele', 'LAVDNL88O01H501Z', 33, 1450.00, 1),
('Ciano', 'Francesco', 'CIFRNC77P01H501Z', 36, 1750.00, 0),
('Corallo', 'Giorgia', 'CRLGIA94Q01H501Z', 28, 950.00, 1),
('Nocciola', 'Tommaso', 'NCTTMS89R01H501Z', 37, 1050.00, 0),
('Pino', 'Carla', 'PNCRLA90S01H501Z', 41, 1350.00, 1),
('Ciliegio', 'Stefano', 'CLJSTF87T01H501Z', 29, 1150.00, 1),
('Mandorlo', 'Giovanni', 'MDRGNV80U01H501Z', 30, 800.00, 0);
GO

INSERT INTO IMPIEGO (TipoImpiego, Assunzione, IDImpiegato) VALUES
('Designer', CONVERT(DATETIME, '2005-05-10', 120), 1),
('Informatico', CONVERT(DATETIME, '2006-07-15', 120), 2),
('Ingegnere', CONVERT(DATETIME, '2010-03-20', 120), 3),
('Marketing', CONVERT(DATETIME, '2008-01-12', 120), 4),
('Project Manager', CONVERT(DATETIME, '2015-02-05', 120), 5),
('Sviluppatore', CONVERT(DATETIME, '2020-08-19', 120), 6),
('Analista', CONVERT(DATETIME, '2017-09-25', 120), 7),
('Ricercatore', CONVERT(DATETIME, '2019-10-30', 120), 8),
('Copywriter', CONVERT(DATETIME, '2007-11-11', 120), 9),
('Data Scientist', CONVERT(DATETIME, '2002-12-12', 120), 10),
('Tecnico', CONVERT(DATETIME, '2011-01-10', 120), 11),
('Consulente', CONVERT(DATETIME, '2013-03-03', 120), 12),
('Amministratore', CONVERT(DATETIME, '2014-04-04', 120), 13),
('Assistente', CONVERT(DATETIME, '2012-06-06', 120), 14),
('Responsabile Vendite', CONVERT(DATETIME, '2016-05-17', 120), 15),
('Formazione', CONVERT(DATETIME, '2021-07-21', 120), 16),
('Web Designer', CONVERT(DATETIME, '2023-08-18', 120), 17),
('System Administrator', CONVERT(DATETIME, '2020-09-09', 120), 18),
('Specialista SEO', CONVERT(DATETIME, '2018-10-10', 120), 19),
('Gestione Progetti', CONVERT(DATETIME, '2022-11-11', 120), 20);
GO



SELECT * FROM IMPIEGATO WHERE Eta > 29;

SELECT * FROM IMPIEGATO WHERE RedditoMensile >= 800;

SELECT * FROM IMPIEGATO WHERE DetrazioneFiscale = 1;

SELECT * FROM IMPIEGATO WHERE DetrazioneFiscale = 0;

SELECT * FROM IMPIEGATO WHERE Cognome LIKE 'G%' ORDER BY Cognome;

SELECT COUNT(*) AS TotaleImpiegati FROM IMPIEGATO;

SELECT SUM(RedditoMensile) AS TotaleRedditi FROM IMPIEGATO;

SELECT AVG(RedditoMensile) AS MediaRedditi FROM IMPIEGATO;

SELECT MAX(RedditoMensile) AS RedditoMaggiore FROM IMPIEGATO;

SELECT MIN(RedditoMensile) AS RedditoMinore FROM IMPIEGATO;

SELECT * FROM IMPIEGO WHERE Assunzione BETWEEN '2007-01-01' AND '2008-01-01';

DECLARE @TipoImpiego NVARCHAR(50) = 'Designer'; 
SELECT * FROM IMPIEGATO 
INNER JOIN IMPIEGO ON IMPIEGATO.IDImpiegato = IMPIEGO.IDImpiegato 
WHERE IMPIEGO.TipoImpiego = @TipoImpiego;

SELECT AVG(Eta) AS EtaMedia FROM IMPIEGATO;
GO


SELECT * FROM IMPIEGATO;
SELECT * FROM IMPIEGO;
