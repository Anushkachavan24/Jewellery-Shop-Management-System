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
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `EID` int(11) NOT NULL,
  `EPass` varchar(11) NOT NULL,
  `EName` varchar(20) NOT NULL,
  `EAddr` varchar(50) NOT NULL,
  `Section` varchar(20) NOT NULL,
  `Shift` int(11) NOT NULL,
  `EGID` varchar(20) NOT NULL,
  `Salary` int(11) NOT NULL,
  `AID` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`EID`, `EPass`, `EName`, `EAddr`, `Section`, `Shift`, `EGID`, `Salary`, `AID`) VALUES
(1001, 'Mansi@123', 'Mansi Pathak', '112, Samman Bazar', 'Ring', 2, '8643-3773-2344', 90000, 'admin101'),
(1002, 'Gurmit@345', 'Gurmit Singh', '11/a14, Shanti Vihar, Opp Sec No 2, Mira Road', 'Bangles', 2, '9887-1342-3464', 50000, 'admin101'),
(1003, 'Arvind123', 'Arvind Kumar Yadav', '4 Goldfield Rd. \r\nHonolulu, HI 96815', 'Anklets', 1, '9822-2223-3334', 20000, 'admin101'),
(1056, 'Manisha@876', 'Manisha', 'Gondur Road Dhule', 'Mangalsutra', 2, '98775', 90000, 'admin101'),
(1057, 'Bhagwat123', 'Bhagwat', 'Gurudwara Dhule', 'Bracelet', 2, '76889', 80000, 'admin101'),
(1058, 'Ishwari@572', 'Ishwari', 'Thite Nagar Pune', 'Necklace', 1, '87329', 50000, 'admin101');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`EID`),
  ADD UNIQUE KEY `EPass` (`EPass`),
  ADD UNIQUE KEY `EGID` (`EGID`),
  ADD KEY `EAID` (`AID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `EID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1061;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `constraint1` FOREIGN KEY (`AID`) REFERENCES `admin` (`AID`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
