-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 28, 2024 at 02:22 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bankas`
--

-- --------------------------------------------------------

--
-- Table structure for table `banko_saskaitos`
--

CREATE TABLE `banko_saskaitos` (
  `saskaitos_numeris` varchar(21) NOT NULL,
  `balansas` decimal(10,0) NOT NULL,
  `dienos_limitas` decimal(10,0) DEFAULT NULL,
  `savaites_limitas` decimal(10,0) DEFAULT NULL,
  `menesio_limitas` decimal(10,0) DEFAULT NULL,
  `saskaitos_tipas` enum('einamoji','indelio','taupomoji') NOT NULL,
  `valiuta` enum('eurai','svarai','doleriai','rubliai') NOT NULL,
  `fk_klientaskliento_ID` int(20) NOT NULL
) ;

--
-- Dumping data for table `banko_saskaitos`
--

INSERT INTO `banko_saskaitos` (`saskaitos_numeris`, `balansas`, `dienos_limitas`, `savaites_limitas`, `menesio_limitas`, `saskaitos_tipas`, `valiuta`, `fk_klientaskliento_ID`) VALUES
('BANKAS', 9999999999, NULL, NULL, NULL, 'einamoji', 'eurai', 30),
('LT012345678901214567', 14000, NULL, 4000, NULL, 'taupomoji', 'eurai', 19),
('LT123456237512345670', 10, 100, 1000, 10000, 'indelio', 'doleriai', 1),
('LT123456250012345674', 1000, NULL, NULL, NULL, 'taupomoji', 'rubliai', 3),
('LT123456289012345674', 100, 300, 1000, 3000, 'einamoji', 'rubliai', 3),
('LT123456289012345678', 1000, 200, 1500, 5000, 'einamoji', 'eurai', 1),
('LT123456289471345670', 420420, NULL, NULL, NULL, 'einamoji', 'eurai', 16),
('LT123456759052345678', 10000, 1000, NULL, 5000, 'einamoji', 'eurai', 6),
('LT123456782012345678', 10000, 1000, NULL, 5000, 'einamoji', 'eurai', 11),
('LT123456789012325678', 10000, 1000, NULL, 5000, 'einamoji', 'eurai', 20),
('LT345648901234527890', 8000, 1500, NULL, 4000, 'einamoji', 'eurai', 22),
('LT345678921234567890', 8000, 1500, NULL, 4000, 'einamoji', 'eurai', 7),
('LT345678951234567890', 8000, 1500, NULL, 4000, 'einamoji', 'eurai', 2),
('LT456789012345678901', 12000, NULL, 4000, NULL, 'taupomoji', 'eurai', 13),
('LT567890123256789012', 7000, 1200, NULL, 3000, 'einamoji', 'eurai', 24),
('LT567890123456786012', 7001, 1200, NULL, 3000, 'indelio', 'eurai', 3),
('LT567890123456789012', 7000, 1200, NULL, 3000, 'einamoji', 'eurai', 14),
('LT567890153456789012', 7000, 1200, NULL, 3000, 'einamoji', 'eurai', 8),
('LT678901234167893123', 15000, NULL, 5000, NULL, 'taupomoji', 'eurai', 25),
('LT678901234567890123', 15000, NULL, 5000, NULL, 'taupomoji', 'eurai', 8),
('LT678901234567897123', 15000, NULL, 5000, NULL, 'taupomoji', 'eurai', 15),
('LT789012345578901234', 9000, 1300, NULL, 4500, 'einamoji', 'eurai', 26),
('LT789012345648901234', 9000, 1300, NULL, 4500, 'einamoji', 'eurai', 9),
('LT789012345678901234', 9000, 1300, NULL, 4500, 'einamoji', 'eurai', 16),
('LT789012375678901234', 9000, 1300, 3000, 4500, 'einamoji', 'eurai', 4),
('LT890126456789012345', 11000, NULL, 3500, NULL, 'taupomoji', 'eurai', 9),
('LT901234567190163456', 6000, 1100, NULL, 2500, 'einamoji', 'eurai', 28),
('LT901234567890173456', 6000, 1100, NULL, 2500, 'einamoji', 'eurai', 18);

-- --------------------------------------------------------

--
-- Table structure for table `darbuotojai`
--

CREATE TABLE `darbuotojai` (
  `vardas` varchar(255) NOT NULL,
  `pavarde` varchar(255) NOT NULL,
  `darbuotojo_ID` int(20) NOT NULL,
  `telefono_numeris` varchar(12) NOT NULL,
  `elektroninis_pastas` varchar(50) DEFAULT NULL,
  `asmens_kodas` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

--
-- Dumping data for table `darbuotojai`
--

INSERT INTO `darbuotojai` (`vardas`, `pavarde`, `darbuotojo_ID`, `telefono_numeris`, `elektroninis_pastas`, `asmens_kodas`) VALUES
('Jonas', 'Jonaitis', 1, '861234568', 'jonas@icloud.com', '49368512907'),
('Elena', 'Elenaitė', 2, '861234569', 'elena@gmail.com', '59632487120'),
('Gabija', 'Gabijosdaitė', 3, '861234570', NULL, '67854192357'),
('Tomas', 'Tomauskas', 4, '861234571', 'tomas@icloud.com', '72643198054'),
('Greta', 'Gretutė', 5, '861234572', 'greta@gmail.com', '87541326908'),
('Mantas', 'Mantauskas', 6, '861234573', 'mantas@icloud.com', '95462137086'),
('Simona', 'Simonaitė', 7, '861234574', 'simona@gmail.com', '10879423561'),
('Darius', 'Dariauskas', 8, '861234575', 'darius@icloud.com', '11632549870'),
('Rasa', 'Rasaitė', 9, '861234576', 'rasa@gmail.com', '12478539602'),
('Andrius', 'Andriūnas', 10, '861234577', 'andrius@icloud.com', '13265748096'),
('Karolina', 'Karolinauskaitė', 11, '861234578', 'karolina@gmail.com', '14789236547'),
('Mindaugas', 'Mindaugaitis', 12, '861234579', 'mindaugas@icloud.com', '15386427980'),
('Rolandas', 'Rolandaitis', 13, '861234581', 'rolandas@icloud.com', '17485926308'),
('Giedrė', 'Giedraitė', 14, '861234582', 'giedre@gmail.com', '18632547901'),
('Laura', 'Laurauskaitė', 15, '861234584', 'laura@gmail.com', '20958417365'),
('Algirdas', 'Algirdaitis', 16, '861234585', 'algirdas@icloud.com', '21789536480'),
('Renata', 'Renatauskaitė', 17, '861234586', 'renata@gmail.com', '22875419638'),
('Aurimas', 'Aurimaitis', 18, '861234587', NULL, '23169854702'),
('Rūta', 'Rūtaitė', 19, '861234588', 'ruta@gmail.com', '24986317540'),
('Justas', 'Justaitis', 20, '861234589', 'justas@icloud.com', '25897413659');

-- --------------------------------------------------------

--
-- Table structure for table `indelis`
--

CREATE TABLE `indelis` (
  `indelio_ID` int(20) NOT NULL,
  `indelio_palukanu_norma` decimal(10,0) NOT NULL,
  `indelio_suma` decimal(10,0) NOT NULL,
  `indelio_laikotarpis` date NOT NULL,
  `indelio_tipas` enum('terminuotas','taupymo_saskaita') NOT NULL,
  `fk_pavedimasoperacijos_ID` int(20) NOT NULL,
  `fk_sutartissutarties_ID` int(20) NOT NULL
) ;

--
-- Dumping data for table `indelis`
--

INSERT INTO `indelis` (`indelio_ID`, `indelio_palukanu_norma`, `indelio_suma`, `indelio_laikotarpis`, `indelio_tipas`, `fk_pavedimasoperacijos_ID`, `fk_sutartissutarties_ID`) VALUES
(1, 2, 5000, '2025-04-01', 'terminuotas', 3, 4),
(2, 2, 10, '2026-04-01', 'taupymo_saskaita', 4, 5),
(3, 2, 1000, '2025-06-30', 'taupymo_saskaita', 7, 8),
(4, 10, 15, '2025-04-30', 'terminuotas', 8, 9),
(5, 2, 300, '2025-05-01', 'terminuotas', 13, 14),
(6, 1, 20, '2028-05-31', 'terminuotas', 14, 15),
(7, 2, 450, '2027-05-02', 'terminuotas', 17, 18),
(8, 5, 30, '2025-02-01', 'taupymo_saskaita', 18, 19),
(9, 1, 200, '2025-01-01', 'taupymo_saskaita', 23, 24),
(10, 3, 70, '2026-05-31', 'terminuotas', 24, 25),
(11, 2, 500, '2026-07-01', 'terminuotas', 28, 28),
(12, 6, 90, '2026-07-31', 'terminuotas', 29, 29);

-- --------------------------------------------------------

--
-- Table structure for table `klientai`
--

CREATE TABLE `klientai` (
  `kliento_ID` int(20) NOT NULL,
  `vardas` varchar(255) NOT NULL,
  `pavarde` varchar(255) NOT NULL,
  `asmens_kodas` varchar(11) NOT NULL,
  `gimimo_data` date NOT NULL,
  `adresas` varchar(255) NOT NULL,
  `menesio_pajamos` decimal(10,0) DEFAULT NULL,
  `telefono_numeris` varchar(12) NOT NULL,
  `elektroninis_pastas` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

--
-- Dumping data for table `klientai`
--

INSERT INTO `klientai` (`kliento_ID`, `vardas`, `pavarde`, `asmens_kodas`, `gimimo_data`, `adresas`, `menesio_pajamos`, `telefono_numeris`, `elektroninis_pastas`) VALUES
(1, 'Jonas', 'Jonaitis', '49368512907', '2024-04-16', 'Vilnius, Lietuva', 1000, '861234568', 'jonas@icloud.com'),
(2, 'Jonė', 'Elenaitė', '59632487120', '1995-01-13', 'Kaunas, Lietuva', 2000, '861234569', 'elena@gmail.com'),
(3, 'Gabija', 'Gabijosdaitė', '67854192357', '1985-11-30', 'Klaipėda, Lietuva', 1600, '861234570', ''),
(4, 'Tomas', 'Tomauskas', '72643198054', '1993-07-17', 'Šiauliai, Lietuva', 1700, '861234571', 'tomas@icloud.com'),
(6, 'Mantas', 'Mantauskas', '95462137086', '1987-09-05', 'Marijampolė, Lietuva', 1500, '861234573', 'mantas@icloud.com'),
(7, 'Simona', 'Simonaitė', '10879423561', '1991-12-14', 'Alytus, Lietuva', NULL, '861234574', 'simona@gmail.com'),
(8, 'Darius', 'Dariauskas', '11632549870', '1989-03-07', 'Utena, Lietuva', 2000, '861234575', 'darius@icloud.com'),
(9, 'Rasa', 'Rasaitė', '12478539602', '1994-06-23', 'Šiauliai, Lietuva', 1600, '861234576', 'rasa@gmail.com'),
(11, 'Karolina', 'Karolinauskaitė', '14789236547', '1990-02-28', 'Kaunas, Lietuva', 1900, '861234578', 'karolina@gmail.com'),
(13, 'Inga', 'Ingauskaitė', '16958734125', '1993-05-04', 'Klaipėda, Lietuva', 1800, '861234580', NULL),
(14, 'Rolandas', 'Rolandaitis', '17485926308', '1987-11-22', 'Šiauliai, Lietuva', 2000, '861234581', 'rolandas@icloud.com'),
(15, 'Giedrė', 'Giedraitė', '18632547901', '1991-01-12', 'Marijampolė, Lietuva', 1600, '861234582', 'giedre@gmail.com'),
(16, 'Marius', 'Mariūnas', '19148753629', '1989-04-29', 'Alytus, Lietuva', NULL, '861234583', 'marius@icloud.com'),
(18, 'Algirdas', 'Algirdaitis', '21789536480', '1986-12-06', 'Panevėžys, Lietuva', NULL, '861234585', 'algirdas@icloud.com'),
(19, 'Renata', 'Renatauskaitė', '22875419638', '1990-03-25', 'Kaunas, Lietuva', 1800, '861234586', 'renata@gmail.com'),
(20, 'Aurimas', 'Aurimaitis', '23169854702', '1988-06-13', 'Vilnius, Lietuva', 2000, '861234587', NULL),
(22, 'Justas', 'Justaitis', '25897413659', '1987-02-18', 'Šiauliai, Lietuva', 1700, '861234589', 'justas@icloud.com'),
(24, 'Kęstutis', 'Kęstutaitis', '27489635210', '1989-09-27', 'Alytus, Lietuva', 1500, '861234591', 'kestutis@icloud.com'),
(25, 'Martynas', 'Martynaitis', '27985631478', '1994-02-15', 'Utena, Lietuva', 1800, '861234592', 'martynas@gmail.com'),
(26, 'Greta', 'Gretutė', '28974153026', '1986-05-24', 'Vilnius, Lietuva', NULL, '861234593', 'greta@gmail.com'),
(27, 'Laura', 'Laurinavičiūtė', '29874561350', '1990-09-12', 'Kaunas, Lietuva', 2000, '861234594', 'laura@gmail.com'),
(28, 'Tomas', 'Tomaitis', '30198754632', '1988-01-03', 'Klaipėda, Lietuva', 1700, '861234595', 'tomas@gmail.com'),
(30, 'Bankas', 'Bankas', '0000000000', '2015-03-01', 'Adresas', 0, '0000000', '');

-- --------------------------------------------------------

--
-- Table structure for table `paskola`
--

CREATE TABLE `paskola` (
  `paskolos_ID` int(20) NOT NULL,
  `paskolos_palukanu_norma` decimal(10,0) NOT NULL,
  `paskolos_suma` decimal(10,0) NOT NULL,
  `paskolos_laikotarpis` date NOT NULL,
  `paskolos_tipas` enum('vartojimo_paskola','busto_paskola','verslo_paskola','studentu_paskola') NOT NULL,
  `fk_sutartissutarties_ID` int(20) NOT NULL,
  `fk_pavedimasoperacijos_ID` int(20) NOT NULL
) ;

--
-- Dumping data for table `paskola`
--

INSERT INTO `paskola` (`paskolos_ID`, `paskolos_palukanu_norma`, `paskolos_suma`, `paskolos_laikotarpis`, `paskolos_tipas`, `fk_sutartissutarties_ID`, `fk_pavedimasoperacijos_ID`) VALUES
(1, 5, 500, '2024-04-01', 'vartojimo_paskola', 2, 1),
(2, 15, 10000, '2025-04-01', 'busto_paskola', 3, 2),
(3, 3, 500, '2024-04-11', 'vartojimo_paskola', 6, 5),
(4, 20, 15500, '2026-04-01', 'verslo_paskola', 7, 6),
(5, 3, 500, '2024-04-30', 'vartojimo_paskola', 10, 9),
(6, 5, 1200, '2025-05-14', 'vartojimo_paskola', 11, 10),
(7, 6, 500, '2024-05-31', 'vartojimo_paskola', 12, 11),
(9, 2, 750, '2024-04-01', 'vartojimo_paskola', 13, 12),
(10, 8, 1220, '2024-06-30', 'vartojimo_paskola', 16, 15),
(11, 3, 1500, '2024-08-31', 'vartojimo_paskola', 17, 16),
(12, 5, 300, '2024-05-31', 'vartojimo_paskola', 20, 19),
(13, 5, 1500, '2024-06-30', 'vartojimo_paskola', 21, 20),
(14, 7, 1000, '2024-05-31', 'vartojimo_paskola', 22, 21),
(15, 2, 1000, '2024-04-30', 'vartojimo_paskola', 23, 22),
(16, 8, 1000, '2024-05-31', 'vartojimo_paskola', 26, 25),
(17, 5, 10000, '2025-04-01', 'busto_paskola', 27, 26),
(18, 6, 500, '2024-05-31', 'vartojimo_paskola', 30, 30);

-- --------------------------------------------------------

--
-- Table structure for table `paslaugos`
--

CREATE TABLE `paslaugos` (
  `pavadinimas` varchar(255) NOT NULL,
  `aprasymas` varchar(100) DEFAULT NULL,
  `galiojimo_pradzia` date NOT NULL,
  `galiojimo_pabaiga` date NOT NULL,
  `kaina` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

--
-- Dumping data for table `paslaugos`
--

INSERT INTO `paslaugos` (`pavadinimas`, `aprasymas`, `galiojimo_pradzia`, `galiojimo_pabaiga`, `kaina`) VALUES
('Banko paslauga', 'paslauga', '2024-04-01', '2024-04-04', 10000),
('Indelis1', 'Terminuotas', '2024-03-03', '2025-04-01', 2),
('Indelis10', 'Per mazas', '2024-03-24', '2026-05-31', 1),
('Indelis11', NULL, '2024-03-27', '2026-07-01', 2),
('Indelis12', 'Per mazas', '2024-03-28', '2026-07-31', 1),
('Indelis2', 'Per mazas', '2024-03-04', '2026-04-01', 3),
('Indelis3', NULL, '2024-03-07', '2025-06-30', 3),
('Indelis4', 'Per mazas', '2024-03-08', '2025-04-30', 2),
('Indelis5', NULL, '2024-03-13', '2025-05-01', 2),
('Indelis6', 'Per mazas', '2024-03-14', '2028-05-31', 1),
('Indelis7', NULL, '2024-03-17', '2027-05-02', 3),
('Indelis8', 'Per mazas', '2024-03-18', '2025-02-01', 1),
('Indelis9', NULL, '2024-03-23', '2025-01-01', 2),
('Paskola1', 'Vartojimo', '2024-03-01', '2024-04-01', 5),
('Paskola10', 'Per maza alga', '2024-03-16', '2024-08-31', 3),
('Paskola11', NULL, '2024-03-19', '2024-05-31', 4),
('Paskola12', 'Per mazas atlyginimas', '2024-03-20', '2024-06-30', 3),
('Paskola13', NULL, '2024-03-21', '2024-05-31', 5),
('Paskola14', 'Per mazas laikotarpis', '2024-03-22', '2024-04-30', 3),
('Paskola15', NULL, '2024-03-25', '2024-05-31', 5),
('Paskola16', 'Per mazi %', '2024-03-26', '2025-04-01', 3),
('Paskola17', NULL, '2024-03-29', '2024-05-31', 3),
('Paskola2', NULL, '2024-03-02', '2025-04-01', 5),
('Paskola3', NULL, '2024-03-05', '2026-04-11', 5),
('Paskola4', 'Per didele suma', '2024-03-06', '2026-04-01', 5),
('Paskola5', NULL, '2024-03-09', '2024-04-30', 5),
('Paskola6', 'Per dideli %', '2024-03-10', '2025-05-14', 5),
('Paskola7', NULL, '2024-03-11', '2024-05-31', 5),
('Paskola8', 'Per trumpas laikotarpis', '2024-03-12', '2024-04-01', 2),
('Paskola9', NULL, '2024-03-15', '2024-06-30', 5);

-- --------------------------------------------------------

--
-- Table structure for table `pateikiama`
--

CREATE TABLE `pateikiama` (
  `fk_uzsakyta_paslaugaid_uzsakyta_paslauga` int(11) NOT NULL,
  `fk_paslaugapavadinimas` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

--
-- Dumping data for table `pateikiama`
--

INSERT INTO `pateikiama` (`fk_uzsakyta_paslaugaid_uzsakyta_paslauga`, `fk_paslaugapavadinimas`) VALUES
(1, 'Paskola1'),
(2, 'Paskola2'),
(3, 'Indelis1'),
(4, 'Indelis2'),
(5, 'Paskola3'),
(6, 'Paskola4'),
(7, 'Indelis3'),
(8, 'Indelis4'),
(9, 'Paskola5'),
(10, 'Paskola6'),
(11, 'Paskola7'),
(12, 'Paskola8'),
(13, 'Indelis5'),
(14, 'Indelis6'),
(15, 'Paskola9'),
(16, 'Paskola10'),
(17, 'Indelis7'),
(18, 'Indelis8'),
(19, 'Paskola11'),
(20, 'Paskola12'),
(21, 'Paskola13'),
(22, 'Paskola14'),
(23, 'Indelis9'),
(24, 'Indelis10'),
(25, 'Paskola15'),
(26, 'Paskola16'),
(27, 'Indelis11'),
(28, 'Indelis12'),
(29, 'Paskola17'),
(30, 'Banko paslauga');

-- --------------------------------------------------------

--
-- Table structure for table `patvirtina`
--

CREATE TABLE `patvirtina` (
  `fk_sutartissutarties_ID` int(20) NOT NULL,
  `fk_darbuotojasdarbuotojo_ID` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

--
-- Dumping data for table `patvirtina`
--

INSERT INTO `patvirtina` (`fk_sutartissutarties_ID`, `fk_darbuotojasdarbuotojo_ID`) VALUES
(2, 3),
(3, 9),
(4, 6),
(5, 3),
(6, 4),
(7, 6),
(8, 7),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15),
(16, 16),
(17, 17),
(18, 18),
(19, 19),
(20, 1),
(21, 2),
(22, 3),
(23, 4),
(24, 5),
(25, 6),
(26, 7),
(27, 8),
(28, 9),
(29, 1),
(41, 1),
(42, 16),
(64, 14),
(101, 1),
(102, 4),
(103, 14),
(104, 16),
(105, 20),
(106, 12),
(107, 12);

-- --------------------------------------------------------

--
-- Table structure for table `pavedimai`
--

CREATE TABLE `pavedimai` (
  `operacijos_ID` int(20) NOT NULL,
  `data` date NOT NULL,
  `suma` decimal(10,0) NOT NULL,
  `gavejo_saskaitos_numeris` varchar(21) NOT NULL,
  `operacijos_mokestis` decimal(10,0) NOT NULL,
  `valiuta` char(8) NOT NULL,
  `operacijos_busena` enum('ivykdyta','neivykdyta') NOT NULL,
  `fk_banko_saskaitasaskaitos_numeris` varchar(21) NOT NULL
) ;

--
-- Dumping data for table `pavedimai`
--

INSERT INTO `pavedimai` (`operacijos_ID`, `data`, `suma`, `gavejo_saskaitos_numeris`, `operacijos_mokestis`, `valiuta`, `operacijos_busena`, `fk_banko_saskaitasaskaitos_numeris`) VALUES
(1, '2024-03-01', 500, 'LT123456289012345678', 1, 'eurai', 'ivykdyta', 'BANKAS'),
(2, '2024-03-02', 10000, 'LT123456289012345678', 2, 'eurai', 'neivykdyta', 'BANKAS'),
(3, '2024-03-03', -5000, 'BANKAS', 2, 'eurai', 'ivykdyta', 'LT123456789012325678'),
(4, '2024-03-04', -10, 'BANKAS', 1, 'eurai', 'neivykdyta', 'LT345678951234567890'),
(5, '2024-03-05', 500, 'LT567890123456786012', 1, 'eurai', 'ivykdyta', 'BANKAS'),
(6, '2024-03-06', 15500, 'LT789012375678901234', 3, 'eurai', 'neivykdyta', 'BANKAS'),
(7, '2024-03-07', -1000, 'BANKAS', 1, 'eurai', 'ivykdyta', 'LT789012375678901234'),
(8, '2024-03-08', -15, 'BANKAS', 1, 'eurai', 'neivykdyta', 'LT789012375678901234'),
(9, '2024-03-09', 500, 'LT789012375678901234', 1, 'eurai', 'ivykdyta', 'BANKAS'),
(10, '2024-03-10', 1200, 'LT789012375678901234', 2, 'eurai', 'neivykdyta', 'BANKAS'),
(11, '2024-03-11', 500, 'LT789012375678901234', 1, 'eurai', 'ivykdyta', 'BANKAS'),
(12, '2024-03-11', 750, 'LT789012375678901234', 1, 'eurai', 'neivykdyta', 'BANKAS'),
(13, '2024-03-13', -300, 'BANKAS', 1, 'eurai', 'ivykdyta', 'LT789012375678901234'),
(14, '2024-03-14', -20, 'BANKAS', 1, 'eurai', 'neivykdyta', 'LT789012375678901234'),
(15, '2024-03-15', 1220, 'LT345678921234567890', 2, 'eurai', 'ivykdyta', 'BANKAS'),
(16, '2024-03-16', 1500, 'LT345678921234567890', 2, 'eurai', 'neivykdyta', 'BANKAS'),
(17, '2024-03-17', -450, 'BANKAS', 1, 'eurai', 'ivykdyta', 'LT345678921234567890'),
(18, '2024-03-18', -30, 'BANKAS', 1, 'eurai', 'neivykdyta', 'LT678901234567897123'),
(19, '2024-03-19', 300, 'LT678901234567897123', 1, 'eurai', 'ivykdyta', 'BANKAS'),
(20, '2024-03-20', 1500, 'LT678901234567897123', 2, 'eurai', 'neivykdyta', 'BANKAS'),
(21, '2024-03-21', 1000, 'LT678901234567897123', 2, 'eurai', 'ivykdyta', 'BANKAS'),
(22, '2024-03-22', 1000, 'LT678901234567897123', 2, 'eurai', 'neivykdyta', 'BANKAS'),
(23, '2024-03-23', -200, 'BANKAS', 1, 'eurai', 'ivykdyta', 'LT678901234567897123'),
(24, '2024-03-24', -70, 'BANKAS', 1, 'eurai', 'neivykdyta', 'LT678901234567897123'),
(25, '2024-03-25', 1000, 'LT789012345678901234', 2, 'eurai', 'ivykdyta', 'BANKAS'),
(26, '2024-03-26', 10000, 'LT789012345678901234', 3, 'eurai', 'neivykdyta', 'BANKAS'),
(28, '2024-03-27', -500, 'BANKAS', 1, 'eurai', 'ivykdyta', 'LT789012345678901234'),
(29, '2024-03-28', -90, 'BANKAS', 1, 'eurai', 'neivykdyta', 'LT789012345678901234'),
(30, '2024-03-29', 500, 'LT789012345678901234', 3, 'eurai', 'ivykdyta', 'BANKAS'),
(31, '2024-03-01', -5, 'BANKAS', 1, 'eurai', 'ivykdyta', 'LT123456789012325678'),
(32, '2024-03-02', -5, 'BANKAS', 1, 'eurai', 'ivykdyta', 'LT123456789012325678'),
(33, '2024-03-02', -2, 'BANKAS', 1, 'eurai', 'ivykdyta', 'LT123456789012325678'),
(34, '2024-03-04', -3, 'BANKAS', 1, 'eurai', 'ivykdyta', 'LT345678951234567890'),
(35, '2024-03-05', -5, 'BANKAS', 1, 'eurai', 'ivykdyta', 'LT567890123456786012'),
(36, '2024-03-06', -5, 'BANKAS', 1, 'eurai', 'ivykdyta', 'LT789012375678901234'),
(37, '2024-03-07', -3, 'BANKAS', 1, 'eurai', 'ivykdyta', 'LT789012375678901234'),
(38, '2024-03-08', -2, 'BANKAS', 1, 'eurai', 'ivykdyta', 'LT789012375678901234'),
(39, '2024-03-09', -5, 'BANKAS', 1, 'eurai', 'ivykdyta', 'LT789012375678901234'),
(40, '2024-03-10', -5, 'BANKAS', 1, 'eurai', 'ivykdyta', 'LT789012375678901234'),
(41, '2024-03-11', -5, 'BANKAS', 1, 'eurai', 'ivykdyta', 'LT789012375678901234'),
(42, '2024-03-12', -5, 'BANKAS', 2, 'eurai', 'ivykdyta', 'LT789012375678901234'),
(43, '2024-03-13', -2, 'BANKAS', 2, 'eurai', 'ivykdyta', 'LT789012375678901234'),
(44, '2024-03-14', -1, 'BANKAS', 1, 'eurai', 'ivykdyta', 'LT789012375678901234'),
(45, '2024-03-15', -5, 'BANKAS', 1, 'eurai', 'ivykdyta', 'LT345678921234567890'),
(46, '2024-03-16', -3, 'BANKAS', 1, 'eurai', 'ivykdyta', 'LT345678921234567890'),
(47, '2024-03-17', -3, 'BANKAS', 1, 'eurai', 'ivykdyta', 'LT345678921234567890'),
(48, '2024-03-18', -1, 'BANKAS', 1, 'eurai', 'ivykdyta', 'LT678901234567897123'),
(49, '2024-03-19', -4, 'BANKAS', 1, 'eurai', 'ivykdyta', 'LT678901234567897123'),
(50, '2024-03-20', -3, 'BANKAS', 1, 'eurai', 'ivykdyta', 'LT678901234567897123'),
(51, '2024-03-21', -5, 'BANKAS', 1, 'eurai', 'ivykdyta', 'LT678901234567897123'),
(52, '2024-03-22', -3, 'BANKAS', 1, 'eurai', 'ivykdyta', 'LT678901234567897123'),
(53, '2024-03-23', -2, 'BANKAS', 1, 'eurai', 'ivykdyta', 'LT678901234567897123'),
(54, '2024-03-24', -1, 'BANKAS', 1, 'eurai', 'ivykdyta', 'LT678901234567897123'),
(55, '2024-03-27', -2, 'BANKAS', 1, 'eurai', 'ivykdyta', 'LT789012345678901234'),
(56, '2024-03-25', -5, 'BANKAS', 1, 'eurai', 'ivykdyta', 'LT789012345678901234'),
(57, '2024-03-26', -3, 'BANKAS', 1, 'eurai', 'ivykdyta', 'LT789012345678901234'),
(58, '2024-03-28', -1, 'BANKAS', 1, 'eurai', 'ivykdyta', 'LT789012345678901234'),
(59, '2024-03-29', -3, 'BANKAS', 1, 'eurai', 'ivykdyta', 'LT789012345678901234'),
(60, '2024-03-03', 1000, 'BANKAS', 1, 'eurai', 'ivykdyta', 'BANKAS');

-- --------------------------------------------------------

--
-- Table structure for table `sutartis`
--

CREATE TABLE `sutartis` (
  `sutarties_ID` int(20) NOT NULL,
  `kliento_ID` int(20) NOT NULL,
  `data` date NOT NULL,
  `sutarties_tipas` enum('paskola','indelis') NOT NULL,
  `busena` enum('patvirtinta','atsaukta') NOT NULL,
  `fk_banko_saskaitasaskaitos_numeris` varchar(21) NOT NULL
) ;

--
-- Dumping data for table `sutartis`
--

INSERT INTO `sutartis` (`sutarties_ID`, `kliento_ID`, `data`, `sutarties_tipas`, `busena`, `fk_banko_saskaitasaskaitos_numeris`) VALUES
(2, 1, '2011-10-02', 'indelis', 'patvirtinta', 'LT123456289012345678'),
(3, 2, '2013-10-26', 'paskola', 'atsaukta', 'LT123456289012345678'),
(4, 3, '2011-10-02', 'indelis', 'patvirtinta', 'LT123456289012345678'),
(5, 4, '1900-01-03', 'indelis', 'atsaukta', 'LT345678951234567890'),
(6, 5, '1900-01-09', 'paskola', 'patvirtinta', 'LT567890123456786012'),
(7, 6, '2024-03-06', 'paskola', 'atsaukta', 'LT789012375678901234'),
(8, 7, '2024-03-07', 'indelis', 'patvirtinta', 'LT789012375678901234'),
(9, 8, '2024-03-08', 'indelis', 'atsaukta', 'LT789012375678901234'),
(10, 9, '2024-03-09', 'paskola', 'patvirtinta', 'LT789012375678901234'),
(11, 10, '2024-03-10', 'paskola', 'atsaukta', 'LT789012375678901234'),
(12, 11, '2024-03-11', 'paskola', 'patvirtinta', 'LT789012375678901234'),
(13, 12, '2024-03-12', 'paskola', 'atsaukta', 'LT789012375678901234'),
(14, 13, '2024-03-13', 'indelis', 'patvirtinta', 'LT789012375678901234'),
(15, 14, '2024-03-14', 'indelis', 'atsaukta', 'LT789012375678901234'),
(16, 15, '2024-03-15', 'paskola', 'patvirtinta', 'LT345678921234567890'),
(17, 16, '2024-03-16', 'paskola', 'atsaukta', 'LT345678921234567890'),
(18, 17, '2024-03-17', 'indelis', 'patvirtinta', 'LT345678921234567890'),
(19, 18, '2024-03-18', 'indelis', 'atsaukta', 'LT678901234567897123'),
(20, 19, '2024-03-19', 'paskola', 'patvirtinta', 'LT678901234567897123'),
(21, 20, '2024-03-20', 'paskola', 'atsaukta', 'LT678901234567897123'),
(22, 21, '2024-03-21', 'paskola', 'patvirtinta', 'LT678901234567897123'),
(23, 22, '2024-03-22', 'paskola', 'atsaukta', 'LT678901234567897123'),
(24, 23, '2024-03-23', 'indelis', 'patvirtinta', 'LT678901234567897123'),
(25, 24, '2024-03-24', 'indelis', 'atsaukta', 'LT678901234567897123'),
(26, 25, '2024-03-25', 'paskola', 'patvirtinta', 'LT789012345678901234'),
(27, 26, '2024-03-26', 'paskola', 'atsaukta', 'LT789012345678901234'),
(28, 27, '2024-03-27', 'indelis', 'patvirtinta', 'LT789012345678901234'),
(29, 28, '2024-03-28', 'indelis', 'atsaukta', 'LT789012345678901234'),
(30, 29, '2024-03-29', 'paskola', 'patvirtinta', 'LT789012345678901234'),
(41, 3, '2024-04-10', 'paskola', 'patvirtinta', 'LT123456250012345674'),
(42, 3, '2024-04-15', 'indelis', 'atsaukta', 'LT123456250012345674'),
(57, 28, '2024-04-10', 'indelis', 'patvirtinta', 'BANKAS'),
(64, 16, '2024-04-23', 'indelis', 'atsaukta', 'LT123456289471345670'),
(101, 1, '2024-04-01', 'paskola', 'patvirtinta', 'LT123456237512345670'),
(102, 1, '2024-04-09', 'indelis', 'atsaukta', 'LT123456237512345670'),
(103, 1, '2024-04-11', 'paskola', 'patvirtinta', 'LT123456237512345670'),
(104, 1, '2024-04-07', 'indelis', 'atsaukta', 'LT123456237512345670'),
(105, 1, '2024-04-18', 'paskola', 'patvirtinta', 'LT123456237512345670'),
(106, 1, '2024-04-06', 'indelis', 'atsaukta', 'LT123456237512345670'),
(107, 1, '2024-04-11', 'paskola', 'patvirtinta', 'LT123456237512345670');

-- --------------------------------------------------------

--
-- Table structure for table `uzsakytos_paslaugos`
--

CREATE TABLE `uzsakytos_paslaugos` (
  `kiekis` int(11) NOT NULL,
  `kaina` decimal(10,0) NOT NULL,
  `id_uzsakyta_paslauga` int(11) NOT NULL,
  `fk_pavedimasoperacijos_ID` int(20) NOT NULL,
  `fk_sutartissutarties_ID` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

--
-- Dumping data for table `uzsakytos_paslaugos`
--

INSERT INTO `uzsakytos_paslaugos` (`kiekis`, `kaina`, `id_uzsakyta_paslauga`, `fk_pavedimasoperacijos_ID`, `fk_sutartissutarties_ID`) VALUES
(1, 5, 1, 31, 2),
(1, 5, 2, 32, 3),
(1, 2, 3, 33, 4),
(1, 3, 4, 34, 5),
(1, 5, 5, 35, 6),
(1, 5, 6, 36, 7),
(1, 3, 7, 37, 8),
(1, 2, 8, 38, 9),
(1, 5, 9, 39, 10),
(1, 5, 10, 40, 11),
(1, 5, 11, 41, 12),
(1, 2, 12, 42, 13),
(1, 2, 13, 43, 14),
(1, 1, 14, 44, 15),
(1, 5, 15, 45, 16),
(1, 3, 16, 46, 17),
(1, 3, 17, 47, 18),
(1, 1, 18, 48, 19),
(1, 4, 19, 49, 20),
(1, 3, 20, 50, 21),
(1, 5, 21, 51, 22),
(1, 3, 22, 52, 23),
(1, 2, 23, 53, 24),
(1, 1, 24, 54, 25),
(1, 5, 25, 55, 26),
(1, 3, 26, 56, 27),
(1, 2, 27, 57, 28),
(1, 1, 28, 58, 29),
(1, 3, 29, 59, 30),
(1, 1000, 30, 60, 57);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `banko_saskaitos`
--
ALTER TABLE `banko_saskaitos`
  ADD PRIMARY KEY (`saskaitos_numeris`),
  ADD KEY `Turi` (`fk_klientaskliento_ID`);

--
-- Indexes for table `darbuotojai`
--
ALTER TABLE `darbuotojai`
  ADD PRIMARY KEY (`darbuotojo_ID`);

--
-- Indexes for table `indelis`
--
ALTER TABLE `indelis`
  ADD PRIMARY KEY (`indelio_ID`),
  ADD UNIQUE KEY `fk_pavedimasoperacijos_ID` (`fk_pavedimasoperacijos_ID`),
  ADD UNIQUE KEY `fk_sutartissutarties_ID` (`fk_sutartissutarties_ID`);

--
-- Indexes for table `klientai`
--
ALTER TABLE `klientai`
  ADD PRIMARY KEY (`kliento_ID`);

--
-- Indexes for table `paskola`
--
ALTER TABLE `paskola`
  ADD PRIMARY KEY (`paskolos_ID`),
  ADD UNIQUE KEY `fk_sutartissutarties_ID` (`fk_sutartissutarties_ID`),
  ADD UNIQUE KEY `fk_pavedimasoperacijos_ID` (`fk_pavedimasoperacijos_ID`);

--
-- Indexes for table `paslaugos`
--
ALTER TABLE `paslaugos`
  ADD PRIMARY KEY (`pavadinimas`);

--
-- Indexes for table `pateikiama`
--
ALTER TABLE `pateikiama`
  ADD PRIMARY KEY (`fk_uzsakyta_paslaugaid_uzsakyta_paslauga`,`fk_paslaugapavadinimas`);

--
-- Indexes for table `patvirtina`
--
ALTER TABLE `patvirtina`
  ADD PRIMARY KEY (`fk_sutartissutarties_ID`,`fk_darbuotojasdarbuotojo_ID`);

--
-- Indexes for table `pavedimai`
--
ALTER TABLE `pavedimai`
  ADD PRIMARY KEY (`operacijos_ID`),
  ADD KEY `Pateikia` (`fk_banko_saskaitasaskaitos_numeris`);

--
-- Indexes for table `sutartis`
--
ALTER TABLE `sutartis`
  ADD PRIMARY KEY (`sutarties_ID`),
  ADD KEY `Priskiriama` (`fk_banko_saskaitasaskaitos_numeris`);

--
-- Indexes for table `uzsakytos_paslaugos`
--
ALTER TABLE `uzsakytos_paslaugos`
  ADD PRIMARY KEY (`id_uzsakyta_paslauga`),
  ADD UNIQUE KEY `fk_pavedimasoperacijos_ID` (`fk_pavedimasoperacijos_ID`),
  ADD KEY `Itraukiama_i` (`fk_sutartissutarties_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `darbuotojai`
--
ALTER TABLE `darbuotojai`
  MODIFY `darbuotojo_ID` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `indelis`
--
ALTER TABLE `indelis`
  MODIFY `indelio_ID` int(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `klientai`
--
ALTER TABLE `klientai`
  MODIFY `kliento_ID` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `paskola`
--
ALTER TABLE `paskola`
  MODIFY `paskolos_ID` int(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pavedimai`
--
ALTER TABLE `pavedimai`
  MODIFY `operacijos_ID` int(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sutartis`
--
ALTER TABLE `sutartis`
  MODIFY `sutarties_ID` int(20) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `banko_saskaitos`
--
ALTER TABLE `banko_saskaitos`
  ADD CONSTRAINT `Turi` FOREIGN KEY (`fk_klientaskliento_ID`) REFERENCES `klientai` (`kliento_ID`);

--
-- Constraints for table `indelis`
--
ALTER TABLE `indelis`
  ADD CONSTRAINT `Atliekama` FOREIGN KEY (`fk_pavedimasoperacijos_ID`) REFERENCES `pavedimai` (`operacijos_ID`),
  ADD CONSTRAINT `Ideda` FOREIGN KEY (`fk_sutartissutarties_ID`) REFERENCES `sutartis` (`sutarties_ID`);

--
-- Constraints for table `paskola`
--
ALTER TABLE `paskola`
  ADD CONSTRAINT `Atlieka` FOREIGN KEY (`fk_pavedimasoperacijos_ID`) REFERENCES `pavedimai` (`operacijos_ID`),
  ADD CONSTRAINT `Suteikia` FOREIGN KEY (`fk_sutartissutarties_ID`) REFERENCES `sutartis` (`sutarties_ID`);

--
-- Constraints for table `pateikiama`
--
ALTER TABLE `pateikiama`
  ADD CONSTRAINT `Pateikiama` FOREIGN KEY (`fk_uzsakyta_paslaugaid_uzsakyta_paslauga`) REFERENCES `uzsakytos_paslaugos` (`id_uzsakyta_paslauga`);

--
-- Constraints for table `patvirtina`
--
ALTER TABLE `patvirtina`
  ADD CONSTRAINT `Patvirtina` FOREIGN KEY (`fk_sutartissutarties_ID`) REFERENCES `sutartis` (`sutarties_ID`);

--
-- Constraints for table `pavedimai`
--
ALTER TABLE `pavedimai`
  ADD CONSTRAINT `Pateikia` FOREIGN KEY (`fk_banko_saskaitasaskaitos_numeris`) REFERENCES `banko_saskaitos` (`saskaitos_numeris`);

--
-- Constraints for table `sutartis`
--
ALTER TABLE `sutartis`
  ADD CONSTRAINT `Priskiriama` FOREIGN KEY (`fk_banko_saskaitasaskaitos_numeris`) REFERENCES `banko_saskaitos` (`saskaitos_numeris`);

--
-- Constraints for table `uzsakytos_paslaugos`
--
ALTER TABLE `uzsakytos_paslaugos`
  ADD CONSTRAINT `Apmokama` FOREIGN KEY (`fk_pavedimasoperacijos_ID`) REFERENCES `pavedimai` (`operacijos_ID`),
  ADD CONSTRAINT `Itraukiama_i` FOREIGN KEY (`fk_sutartissutarties_ID`) REFERENCES `sutartis` (`sutarties_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
