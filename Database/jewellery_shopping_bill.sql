-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 29, 2022 at 12:50 PM
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
-- Table structure for table `bill`
--

CREATE TABLE `bill` (
  `BID` int(11) NOT NULL,
  `BQuantity` int(11) NOT NULL,
  `BAmount` float NOT NULL,
  `Tax` int(11) NOT NULL,
  `PDate` date NOT NULL,
  `TAmount` float NOT NULL,
  `EID` int(11) NOT NULL,
  `CID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bill`
--

INSERT INTO `bill` (`BID`, `BQuantity`, `BAmount`, `Tax`, `PDate`, `TAmount`, `EID`, `CID`) VALUES
(5002, 12, 42000, 3, '2022-10-26', 43260, 1002, 4007),
(5004, 12, 42000, 3, '2022-10-26', 43260, 1002, 4009),
(5006, 4, 14000, 3, '2022-10-27', 14420, 1002, 4007),
(5007, 8, 30000, 3, '2022-10-27', 30900, 1002, 4007),
(5008, 4, 16000, 3, '2022-10-27', 16480, 1002, 4010),
(5009, 4, 14000, 3, '2022-10-27', 14420, 1002, 4009),
(5010, 4, 14000, 3, '2022-10-27', 14420, 1002, 4007),
(5011, 8, 19800, 3, '2022-10-28', 20394, 1001, 4010),
(5012, 4, 10000, 3, '2022-10-28', 10300, 1001, 4013),
(5013, 12, 19718.6, 3, '2022-10-28', 20310.2, 1001, 4014),
(5014, 6, 14800, 3, '2022-10-28', 15244, 1001, 4010),
(5015, 6, 9859.3, 3, '2022-10-29', 10155.1, 1001, 4015),
(5016, 6, 14400, 3, '2022-10-29', 14832, 1001, 4015),
(5017, 6, 9659.3, 3, '2022-10-29', 9949.08, 1001, 4009),
(5018, 4, 10000, 3, '2022-10-29', 10300, 1056, 4010),
(5019, 10, 14918.6, 3, '2022-10-29', 15366.2, 1056, 4010);

--
-- Triggers `bill`
--
DELIMITER $$
CREATE TRIGGER `tr_total` BEFORE UPDATE ON `bill` FOR EACH ROW set NEW.TAmount= (NEW.BAmount + (NEW.BAmount * (NEW.Tax/100)))
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bill`
--
ALTER TABLE `bill`
  ADD PRIMARY KEY (`BID`),
  ADD KEY `BEID` (`EID`),
  ADD KEY `BCID` (`CID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bill`
--
ALTER TABLE `bill`
  MODIFY `BID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5056;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bill`
--
ALTER TABLE `bill`
  ADD CONSTRAINT `constraint6` FOREIGN KEY (`EID`) REFERENCES `employee` (`EID`) ON DELETE CASCADE,
  ADD CONSTRAINT `constraint7` FOREIGN KEY (`CID`) REFERENCES `customer` (`CID`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
