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
-- Table structure for table `bill_jewellery`
--

CREATE TABLE `bill_jewellery` (
  `BID` int(11) NOT NULL,
  `JID` int(11) NOT NULL,
  `JQuantity` int(11) NOT NULL,
  `Grams` float NOT NULL,
  `Gold` varchar(5) NOT NULL,
  `JRate` int(11) NOT NULL,
  `JAmount` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bill_jewellery`
--

INSERT INTO `bill_jewellery` (`BID`, `JID`, `JQuantity`, `Grams`, `Gold`, `JRate`, `JAmount`) VALUES
(5002, 3003, 3, 10, 'G24', 8000, 24000),
(5002, 3004, 3, 7, 'G22', 6000, 18000),
(5004, 3003, 3, 10, 'G24', 8000, 24000),
(5004, 3004, 3, 7, 'G22', 6000, 18000),
(5006, 3004, 2, 7, 'G22', 7000, 14000),
(5007, 3004, 2, 7, 'G22', 7000, 14000),
(5007, 3003, 2, 10, 'G24', 8000, 16000),
(5008, 3003, 2, 10, 'G24', 8000, 16000),
(5009, 3004, 2, 7, 'G22', 7000, 14000),
(5010, 3004, 2, 7, 'G22', 7000, 14000),
(5011, 3005, 1, 40, 'G22', 4800, 4800),
(5011, 3003, 2, 10, 'G24', 5000, 10000),
(5011, 3002, 1, 7, 'G24', 5000, 5000),
(5012, 3003, 2, 10, 'G24', 5000, 10000),
(5013, 3002, 2, 7, 'G24', 5000, 10000),
(5013, 3006, 1, 10, 'G22', 4800, 4800),
(5013, 3001, 1, 8, 'G22', 4800, 4800),
(5014, 3002, 2, 7, 'G24', 5000, 10000),
(5014, 3005, 1, 40, 'G22', 4800, 4800),
(5015, 3002, 1, 7, 'G24', 5000, 5000),
(5015, 3005, 1, 40, 'G22', 4800, 4800),
(5015, 3007, 1, 40, 'S925', 59, 59.3),
(5016, 3003, 2, 10, 'G22', 4800, 9600),
(5016, 3006, 1, 10, 'G22', 4800, 4800),
(5017, 3005, 2, 40, 'G22', 4800, 9600),
(5017, 3007, 1, 40, 'S925', 59, 59.3),
(5018, 3002, 2, 7, 'G24', 5000, 10000),
(5019, 3002, 2, 7, 'G24', 5000, 10000),
(5019, 3008, 2, 50, 'S925', 59, 118.6),
(5019, 3005, 1, 40, 'G22', 4800, 4800);

--
-- Triggers `bill_jewellery`
--
DELIMITER $$
CREATE TRIGGER `tr_amount` BEFORE INSERT ON `bill_jewellery` FOR EACH ROW Begin
set @amt= (NEW.JQuantity * (NEW.Grams * (select Rate from base where Pure=NEW.Gold)));

end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_bill` AFTER INSERT ON `bill_jewellery` FOR EACH ROW BEGIN

update bill set BQuantity= BQuantity + (NEW.JQuantity) where BID=NEW.BID;
update bill set BAmount= BAmount + (NEW.JAmount) where BID=NEW.BID;

update jewel set SQuantity= SQuantity - (NEW.JQuantity) where JID=NEW.JID;


END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bill_jewellery`
--
ALTER TABLE `bill_jewellery`
  ADD KEY `ID` (`JID`,`BID`),
  ADD KEY `constraint8` (`BID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bill_jewellery`
--
ALTER TABLE `bill_jewellery`
  ADD CONSTRAINT `constraint8` FOREIGN KEY (`BID`) REFERENCES `bill` (`BID`) ON DELETE CASCADE,
  ADD CONSTRAINT `constraint9` FOREIGN KEY (`JID`) REFERENCES `jewel` (`JID`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
