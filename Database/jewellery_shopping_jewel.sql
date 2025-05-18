-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 29, 2022 at 12:51 PM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 7.4.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `jewellery_shopping`
--

-- --------------------------------------------------------

--
-- Table structure for table `jewel`
--

CREATE TABLE `jewel` (
  `JID` int(11) NOT NULL,
  `TOJ` varchar(20) NOT NULL,
  `Gold` varchar(5) NOT NULL,
  `Grams` float NOT NULL,
  `SQuantity` int(11) NOT NULL,
  `AID` varchar(10) NOT NULL,
  `SID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `jewel`
--

INSERT INTO `jewel` (`JID`, `TOJ`, `Gold`, `Grams`, `SQuantity`, `AID`, `SID`) VALUES
(3001, 'Ring', 'G22', 8, 96, 'admin101', 2001),
(3002, 'Earings', 'G24', 7, 210, 'admin101', 2001),
(3003, 'Bangles', 'G22', 10, 248, 'admin101', 2015),
(3004, 'Chain', 'G22', 7, 228, 'admin101', 2005),
(3005, 'Mangalsutra', 'G22', 40, 294, 'admin101', 2001),
(3006, 'Bracelet', 'G22', 10, 49, 'admin101', 2005),
(3007, 'Anklets', 'S925', 40, 198, 'admin101', 2014),
(3008, 'Bangles', 'S925', 50, 68, 'admin101', 2005);

--
-- Triggers `jewel`
--
DELIMITER $$
CREATE TRIGGER `tr_quantity` BEFORE UPDATE ON `jewel` FOR EACH ROW IF (NEW.SQuantity < 0) THEN
SIGNAL SQLSTATE '80000'
SET MESSAGE_TEXT='stock empty contact supplier';
END IF
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `jewel`
--
ALTER TABLE `jewel`
  ADD PRIMARY KEY (`JID`),
  ADD KEY `constraint5` (`SID`),
  ADD KEY `constraint4` (`AID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `jewel`
--
ALTER TABLE `jewel`
  MODIFY `JID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3009;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `jewel`
--
ALTER TABLE `jewel`
  ADD CONSTRAINT `constraint4` FOREIGN KEY (`AID`) REFERENCES `admin` (`AID`) ON DELETE CASCADE,
  ADD CONSTRAINT `constraint5` FOREIGN KEY (`SID`) REFERENCES `supplier` (`SID`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
