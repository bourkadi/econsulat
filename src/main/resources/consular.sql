-- phpMyAdmin SQL Dump
-- version 4.5.3.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 17, 2018 at 09:59 PM
-- Server version: 5.7.21-0ubuntu0.17.10.1
-- PHP Version: 7.1.15-0ubuntu0.17.10.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `consular`
--

-- --------------------------------------------------------

--
-- Table structure for table `attestation`
--

CREATE TABLE `attestation` (
  `idattestation` int(11) NOT NULL,
  `createdDate` int(11) NOT NULL,
  `content` text NOT NULL,
  `user` int(11) NOT NULL COMMENT 'creator of the attestation\n',
  `person` int(11) NOT NULL,
  `attestation_type` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=dec8 COMMENT='A service given to the citizen';

-- --------------------------------------------------------

--
-- Table structure for table `attestation_type`
--

CREATE TABLE `attestation_type` (
  `idattestation_type` int(11) NOT NULL,
  `type` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `attestation_type`
--

INSERT INTO `attestation_type` (`idattestation_type`, `type`) VALUES
(1, 'Attestation de Célibat'),
(2, 'Act de Naissance'),
(3, 'Déclaration sur l\'honneur');

-- --------------------------------------------------------

--
-- Table structure for table `consulate`
--

CREATE TABLE `consulate` (
  `idconsulat` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `longName` varchar(45) DEFAULT NULL,
  `country` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `consulate`
--

INSERT INTO `consulate` (`idconsulat`, `name`, `longName`, `country`) VALUES
(3, 'DUBAI', 'LE CONSULAT GENERAL DU MAROC A DUBAI', 1),
(4, 'ABU DHABI', 'AMBASSADE DU ROYUAME A ABU DHABI', 1);

-- --------------------------------------------------------

--
-- Table structure for table `country`
--

CREATE TABLE `country` (
  `idcountry` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `longName` varchar(45) DEFAULT NULL,
  `continent` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A country table, contains many consulates, ';

--
-- Dumping data for table `country`
--

INSERT INTO `country` (`idcountry`, `name`, `longName`, `continent`) VALUES
(1, 'UAE', 'United Arab Emirates', 'ASIA'),
(2, 'France', 'La République Française', 'Europe');

-- --------------------------------------------------------

--
-- Table structure for table `person`
--

CREATE TABLE `person` (
  `idperson` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `lastName` varchar(45) NOT NULL,
  `birthdate` date DEFAULT NULL,
  `cnie` varchar(45) NOT NULL COMMENT 'CNIE or ETAT CIVIL',
  `ic` varchar(45) NOT NULL COMMENT 'IC, le numéro consulaire, imported from the CONSULAIRE app or just created',
  `consulate` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A citizen, mostly imported from the CONSULAIRE app';

--
-- Dumping data for table `person`
--

INSERT INTO `person` (`idperson`, `name`, `lastName`, `birthdate`, `cnie`, `ic`, `consulate`) VALUES
(1, 'amine', 'bourkadi', '2017-03-07', 'jddnen', 'bfdbde', 3);

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `idrole` int(11) NOT NULL,
  `role` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='roles of the users, defines ACL';

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`idrole`, `role`) VALUES
(1, 'ADMIN'),
(2, 'SAISI');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `iduser` int(11) NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `createdDate` int(11) NOT NULL,
  `consulate` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='user of the system, attached to an entity, mostly a consulat';

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`iduser`, `username`, `password`, `createdDate`, `consulate`) VALUES
(1, 'amine', 'amine', 12345, 3);

-- --------------------------------------------------------

--
-- Table structure for table `user_has_role`
--

CREATE TABLE `user_has_role` (
  `iduser` int(11) NOT NULL,
  `role_idrole` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_has_role`
--

INSERT INTO `user_has_role` (`iduser`, `role_idrole`) VALUES
(1, 1),
(1, 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attestation`
--
ALTER TABLE `attestation`
  ADD PRIMARY KEY (`idattestation`),
  ADD KEY `fk_attestation_user1_idx` (`user`),
  ADD KEY `fk_attestation_person1_idx` (`person`),
  ADD KEY `fk_attestation_attestation_type1_idx` (`attestation_type`);
ALTER TABLE `attestation` ADD FULLTEXT KEY `fl_attestaton_content` (`content`);

--
-- Indexes for table `attestation_type`
--
ALTER TABLE `attestation_type`
  ADD PRIMARY KEY (`idattestation_type`);

--
-- Indexes for table `consulate`
--
ALTER TABLE `consulate`
  ADD PRIMARY KEY (`idconsulat`),
  ADD KEY `fk_consulat_country1_idx` (`country`);

--
-- Indexes for table `country`
--
ALTER TABLE `country`
  ADD PRIMARY KEY (`idcountry`);

--
-- Indexes for table `person`
--
ALTER TABLE `person`
  ADD PRIMARY KEY (`idperson`),
  ADD KEY `fk_person_consulate1_idx` (`consulate`);
ALTER TABLE `person` ADD FULLTEXT KEY `fl_person_name` (`name`,`lastName`);
ALTER TABLE `person` ADD FULLTEXT KEY `fl_person_cnie` (`cnie`);
ALTER TABLE `person` ADD FULLTEXT KEY `fl_person_ic` (`ic`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`idrole`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`iduser`),
  ADD KEY `fk_user_consulat1_idx` (`consulate`);

--
-- Indexes for table `user_has_role`
--
ALTER TABLE `user_has_role`
  ADD PRIMARY KEY (`iduser`,`role_idrole`),
  ADD KEY `fk_user_has_role_role1_idx` (`role_idrole`),
  ADD KEY `fk_user_has_role_user_idx` (`iduser`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `attestation`
--
ALTER TABLE `attestation`
  MODIFY `idattestation` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `attestation_type`
--
ALTER TABLE `attestation_type`
  MODIFY `idattestation_type` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `consulate`
--
ALTER TABLE `consulate`
  MODIFY `idconsulat` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `country`
--
ALTER TABLE `country`
  MODIFY `idcountry` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `person`
--
ALTER TABLE `person`
  MODIFY `idperson` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `idrole` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `iduser` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `attestation`
--
ALTER TABLE `attestation`
  ADD CONSTRAINT `fk_attestation_attestation_type1` FOREIGN KEY (`attestation_type`) REFERENCES `attestation_type` (`idattestation_type`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_attestation_person1` FOREIGN KEY (`person`) REFERENCES `person` (`idperson`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_attestation_user1` FOREIGN KEY (`user`) REFERENCES `user` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `consulate`
--
ALTER TABLE `consulate`
  ADD CONSTRAINT `fk_consulat_country1` FOREIGN KEY (`country`) REFERENCES `country` (`idcountry`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `person`
--
ALTER TABLE `person`
  ADD CONSTRAINT `fk_person_consulate1` FOREIGN KEY (`consulate`) REFERENCES `consulate` (`idconsulat`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `fk_user_consulat1` FOREIGN KEY (`consulate`) REFERENCES `consulate` (`idconsulat`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `user_has_role`
--
ALTER TABLE `user_has_role`
  ADD CONSTRAINT `fk_user_has_role_role1` FOREIGN KEY (`role_idrole`) REFERENCES `role` (`idrole`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_user_has_role_user` FOREIGN KEY (`iduser`) REFERENCES `user` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
