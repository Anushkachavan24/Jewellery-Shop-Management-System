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
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `CID` int(11) NOT NULL,
  `CName` varchar(20) NOT NULL,
  `CCont` bigint(10) NOT NULL,
  `CAddr` varchar(50) NOT NULL,
  `CGID` varchar(12) NOT NULL,
  `EID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`CID`, `CName`, `CCont`, `CAddr`, `CGID`, `EID`) VALUES
(4007, 'Sharad Chandran', 9975461047, '10, Krishnaswamy Avenue, Mylapore, Mumbai', '13654', 1003),
(4009, 'Ramdin verma', 9887662711, '3rd Floor 36 I D A Mansion, 18 Vaju Kotak Marg', '19318', 1003),
(4010, 'Vikram Singh', 9814234234, '3 Rd Flr, Ador House, 6k Dubach Marg, Fort, Mumbai', '76885', 1002),
(4013, 'Abhijeet Gaikwad', 8928135665, '95 somwar peth', '99763', 1002),
(4014, 'Prakash', 9327476222, 'Bhilwada Nagar Sakri', '93238', 1001),
(4015, 'Veena', 9773423675, 'Thite Nagar Pune', '97349', 1001);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`CID`),
  ADD UNIQUE KEY `CGID` (`CGID`),
  ADD KEY `CID` (`CID`),
  ADD KEY `constraint3` (`EID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `CID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4017;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `customer`
--
ALTER TABLE `customer`
  ADD CONSTRAINT `constraint3` FOREIGN KEY (`EID`) REFERENCES `employee` (`EID`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
