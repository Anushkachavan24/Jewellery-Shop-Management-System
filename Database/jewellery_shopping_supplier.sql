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
-- Table structure for table `supplier`
--

CREATE TABLE `supplier` (
  `SID` int(11) NOT NULL,
  `SName` varchar(20) NOT NULL,
  `Company` varchar(20) NOT NULL,
  `Compcode` varchar(11) NOT NULL,
  `SAddr` varchar(50) NOT NULL,
  `SCont` bigint(10) NOT NULL,
  `AID` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `supplier`
--

INSERT INTO `supplier` (`SID`, `SName`, `Company`, `Compcode`, `SAddr`, `SCont`, `AID`) VALUES
(2001, 'Matrin Garande', 'Shining diamonds', 'shine343', 'No 2, Lovan Bldg, Baban Gully, Madanpura', 2147483647, 'admin101'),
(2005, 'Candance R. Hines', 'Shapithe', 'Yaicei7a', 'Worli Naka, Govind Smruti Bldg, 83c, Dr Annie Base', 8038631619, 'admin101'),
(2014, 'devinder chadda', 'Newmont Goldcorpv', '123123', 'Baner Pune', 9887982344, 'admin101'),
(2015, 'chandesh', 'Polyus', '234234', '94, 2nd Floor, Nagdevi Street, Nagdevi', 9894553627, 'admin101');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`SID`),
  ADD UNIQUE KEY `Compcode` (`Compcode`),
  ADD KEY `SAID` (`AID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `supplier`
--
ALTER TABLE `supplier`
  MODIFY `SID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2018;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `supplier`
--
ALTER TABLE `supplier`
  ADD CONSTRAINT `constraint2` FOREIGN KEY (`AID`) REFERENCES `admin` (`AID`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
