-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 29, 2022 at 06:53 AM
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
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `AID` varchar(10) NOT NULL,
  `Password` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`AID`, `Password`) VALUES
('admin101', 'admin101');

-- --------------------------------------------------------

--
-- Table structure for table `base`
--

CREATE TABLE `base` (
  `Pure` varchar(5) NOT NULL,
  `Rate` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `base`
--

INSERT INTO `base` (`Pure`, `Rate`) VALUES
('G22', 4800),
('G24', 5000),
('S925', 59.3);

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
(5016, 6, 14400, 3, '2022-10-29', 14832, 1001, 4015);

--
-- Triggers `bill`
--
DELIMITER $$
CREATE TRIGGER `tr_total` BEFORE UPDATE ON `bill` FOR EACH ROW set NEW.TAmount= (NEW.BAmount + (NEW.BAmount * (NEW.Tax/100)))
$$
DELIMITER ;

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
(5016, 3006, 1, 10, 'G22', 4800, 4800);

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

-- --------------------------------------------------------

--
-- Table structure for table `empcontact`
--

CREATE TABLE `empcontact` (
  `EID` int(10) NOT NULL,
  `Econt` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `empcontact`
--

INSERT INTO `empcontact` (`EID`, `Econt`) VALUES
(1058, 8287623491),
(1058, 9838213432);

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
(1002, 'Gurmit123', 'Gurmit Singh', '11/a14, Shanti Vihar, Opp Sec No 2, Mira Road', 'Bangles', 2, '9887-1342-3464', 50000, 'admin101'),
(1003, 'Arvind123', 'Arvind Kumar Yadav', '4 Goldfield Rd. \r\nHonolulu, HI 96815', 'Anklets', 1, '9822-2223-3334', 20000, 'admin101'),
(1056, 'Manisha123', 'Manisha', 'Gondur Road Dhule', 'Mangalsutra', 2, '98775', 90000, 'admin101'),
(1057, 'Bhagwat123', 'Bhagwat', 'Gurudwara Dhule', 'Bracelet', 2, '76889', 80000, 'admin101'),
(1058, 'Ishwari123', 'Ishwari', 'Thite Nagar Pune', 'Necklace', 1, '87329', 50000, 'admin101');

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
(3002, 'Earings', 'G24', 7, 214, 'admin101', 2001),
(3003, 'Bangles', 'G22', 10, 248, 'admin101', 2015),
(3004, 'Chain', 'G22', 7, 228, 'admin101', 2005),
(3005, 'Mangalsutra', 'G22', 40, 297, 'admin101', 2001),
(3006, 'Bracelet', 'G22', 10, 49, 'admin101', 2005),
(3007, 'Anklets', 'S925', 40, 199, 'admin101', 2014);

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
(2015, 'chandesh', 'Polyus Gold', '234234', '94, 2nd Floor, Nagdevi Street, Nagdevi', 3894553627, 'admin101');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`AID`),
  ADD UNIQUE KEY `passunique` (`Password`);

--
-- Indexes for table `base`
--
ALTER TABLE `base`
  ADD PRIMARY KEY (`Pure`);

--
-- Indexes for table `bill`
--
ALTER TABLE `bill`
  ADD PRIMARY KEY (`BID`),
  ADD KEY `BEID` (`EID`),
  ADD KEY `BCID` (`CID`);

--
-- Indexes for table `bill_jewellery`
--
ALTER TABLE `bill_jewellery`
  ADD KEY `ID` (`JID`,`BID`),
  ADD KEY `constraint8` (`BID`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`CID`),
  ADD UNIQUE KEY `CGID` (`CGID`),
  ADD KEY `CID` (`CID`),
  ADD KEY `constraint3` (`EID`);

--
-- Indexes for table `empcontact`
--
ALTER TABLE `empcontact`
  ADD PRIMARY KEY (`EID`,`Econt`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`EID`),
  ADD UNIQUE KEY `EPass` (`EPass`),
  ADD UNIQUE KEY `EGID` (`EGID`),
  ADD KEY `EAID` (`AID`);

--
-- Indexes for table `jewel`
--
ALTER TABLE `jewel`
  ADD PRIMARY KEY (`JID`),
  ADD KEY `constraint5` (`SID`),
  ADD KEY `constraint4` (`AID`);

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
-- AUTO_INCREMENT for table `bill`
--
ALTER TABLE `bill`
  MODIFY `BID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5056;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `CID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4017;

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `EID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1061;

--
-- AUTO_INCREMENT for table `jewel`
--
ALTER TABLE `jewel`
  MODIFY `JID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3009;

--
-- AUTO_INCREMENT for table `supplier`
--
ALTER TABLE `supplier`
  MODIFY `SID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2018;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bill`
--
ALTER TABLE `bill`
  ADD CONSTRAINT `constraint6` FOREIGN KEY (`EID`) REFERENCES `employee` (`EID`) ON DELETE CASCADE,
  ADD CONSTRAINT `constraint7` FOREIGN KEY (`CID`) REFERENCES `customer` (`CID`) ON DELETE CASCADE;

--
-- Constraints for table `bill_jewellery`
--
ALTER TABLE `bill_jewellery`
  ADD CONSTRAINT `constraint8` FOREIGN KEY (`BID`) REFERENCES `bill` (`BID`) ON DELETE CASCADE,
  ADD CONSTRAINT `constraint9` FOREIGN KEY (`JID`) REFERENCES `jewel` (`JID`) ON DELETE CASCADE;

--
-- Constraints for table `customer`
--
ALTER TABLE `customer`
  ADD CONSTRAINT `constraint3` FOREIGN KEY (`EID`) REFERENCES `employee` (`EID`) ON DELETE CASCADE;

--
-- Constraints for table `empcontact`
--
ALTER TABLE `empcontact`
  ADD CONSTRAINT `empcontact` FOREIGN KEY (`EID`) REFERENCES `employee` (`EID`) ON DELETE CASCADE;

--
-- Constraints for table `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `constraint1` FOREIGN KEY (`AID`) REFERENCES `admin` (`AID`) ON DELETE CASCADE;

--
-- Constraints for table `jewel`
--
ALTER TABLE `jewel`
  ADD CONSTRAINT `constraint4` FOREIGN KEY (`AID`) REFERENCES `admin` (`AID`) ON DELETE CASCADE,
  ADD CONSTRAINT `constraint5` FOREIGN KEY (`SID`) REFERENCES `supplier` (`SID`) ON DELETE CASCADE;

--
-- Constraints for table `supplier`
--
ALTER TABLE `supplier`
  ADD CONSTRAINT `constraint2` FOREIGN KEY (`AID`) REFERENCES `admin` (`AID`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
