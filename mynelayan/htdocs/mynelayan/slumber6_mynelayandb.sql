-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 12, 2023 at 09:36 PM
-- Server version: 10.3.39-MariaDB-cll-lve
-- PHP Version: 8.1.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `slumber6_mynelayandb`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_carts`
--

CREATE TABLE `tbl_carts` (
  `cart_id` int(5) NOT NULL,
  `catch_id` varchar(5) NOT NULL,
  `cart_qty` int(5) NOT NULL,
  `cart_price` float NOT NULL,
  `user_id` varchar(5) NOT NULL,
  `seller_id` varchar(5) NOT NULL,
  `cart_date` datetime(6) NOT NULL DEFAULT current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_carts`
--

INSERT INTO `tbl_carts` (`cart_id`, `catch_id`, `cart_qty`, `cart_price`, `user_id`, `seller_id`, `cart_date`) VALUES
(4, '20', 1, 10, '1', '8', '2023-07-11 21:20:20.193662');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_catches`
--

CREATE TABLE `tbl_catches` (
  `catch_id` int(5) NOT NULL,
  `user_id` int(5) NOT NULL,
  `catch_name` varchar(50) NOT NULL,
  `catch_type` varchar(15) NOT NULL,
  `catch_desc` varchar(200) NOT NULL,
  `catch_price` float NOT NULL,
  `catch_qty` int(5) NOT NULL,
  `catch_lat` varchar(15) NOT NULL,
  `catch_long` varchar(15) NOT NULL,
  `catch_state` varchar(30) NOT NULL,
  `catch_locality` varchar(50) NOT NULL,
  `catch_date` datetime(6) NOT NULL DEFAULT current_timestamp(6),
  `catch_status` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_catches`
--

INSERT INTO `tbl_catches` (`catch_id`, `user_id`, `catch_name`, `catch_type`, `catch_desc`, `catch_price`, `catch_qty`, `catch_lat`, `catch_long`, `catch_state`, `catch_locality`, `catch_date`, `catch_status`) VALUES
(1, 1, 'Bawal Putih', 'Fish', 'Large Size', 4.5, 14, '6.4473983', '100.4420283', 'Kedah', 'Changlun', '2023-05-21 13:02:48.617686', 'New'),
(4, 1, 'Lampam Jawa', 'Fish', 'Fresh', 9, 18, '6.39641', '100.3057317', 'Kedah', 'Kodiang', '2023-05-24 12:39:17.457619', 'New'),
(5, 1, 'Sea Bass', 'Fish', ' Medium size', 19, 17, '6.39641', '100.3057317', 'Kedah', 'Kodiang', '2023-05-24 12:52:57.387199', 'New'),
(6, 1, 'Cat FIsh', 'Fish', 'Medium size', 6.5, 12, '6.40609', '100.2001283', 'Perlis', 'Kangar', '2023-05-25 09:47:03.220457', 'New'),
(7, 1, 'Pacu', 'Fish', 'big size 5 kg per', 8, 14, '6.40609', '100.2001283', 'Perlis', 'Kangar', '2023-06-07 10:58:36.511873', 'New'),
(8, 1, 'Sumpit', 'Fish', 'Medium size', 7.5, 12, '6.40609', '100.2001283', 'Perlis', 'Kangar', '2023-06-07 10:59:07.144213', 'New'),
(9, 1, 'Kepar', 'Fish', 'Small size', 2.5, 20, '6.40609', '100.2001283', 'Perlis', 'Kangar', '2023-06-07 10:59:33.865237', 'New'),
(10, 1, 'Hampala Barb', 'Fish', 'Medium size', 12.5, 15, '6.4552417', '100.401965', 'Kedah', 'Changlun', '2023-06-07 11:36:49.410741', 'New'),
(11, 1, 'Patin', 'Fish', 'Medium size', 25, 12, '6.4552417', '100.401965', 'Kedah', 'Changlun', '2023-06-07 11:38:22.715201', 'New'),
(12, 7, 'Patin Buah', 'Fish', 'Large size ', 25, 8, '6.087355', '100.3127', 'Kedah', 'Kuala Kedah', '2023-06-14 10:30:19.570812', 'New'),
(13, 7, 'Haruan', 'Fish', 'Medium Size', 15, 7, '6.087355', '100.3127', 'Kedah', 'Kuala Kedah', '2023-06-14 10:31:26.672507', 'New'),
(14, 7, 'Hangus', 'Fish', 'Large size', 15, 9, '6.087355', '100.3127', 'Kedah', 'Kuala Kedah', '2023-06-14 10:32:52.834155', 'New'),
(15, 7, 'Ketam Bunga', 'Crab', 'Mid size', 15, 13, '6.087355', '100.3127', 'Kedah', 'Kuala Kedah', '2023-06-14 10:35:32.203187', 'New'),
(16, 7, 'Nipah', 'Crab', 'Large size', 12, 22, '6.087355', '100.3127', 'Kedah', 'Kuala Kedah', '2023-06-14 10:37:32.074789', 'New'),
(17, 7, 'Sotong', 'Squid', 'Fresh and medium size', 25, 5, '6.087355', '100.3127', 'Kedah', 'Kuala Kedah', '2023-06-14 10:43:05.348491', 'New'),
(18, 7, 'Tiram laut', 'Oysters', 'Medium size', 45, 11, '6.087355', '100.3127', 'Kedah', 'Kuala Kedah', '2023-06-14 10:47:48.374602', 'New'),
(19, 7, 'Lobster', 'Lobsters', 'Fresh and alive', 80, 13, '6.087355', '100.3127', 'Kedah', 'Kuala Kedah', '2023-06-14 10:49:10.756390', 'New'),
(20, 8, 'Scallops', 'Fish', 'By kilos. Got 20 KG', 10, 15, '6.087355', '100.3127', 'Kedah', 'Kuala Kedah', '2023-06-14 11:00:27.922594', 'New'),
(21, 8, 'Octopus', 'Octopus', 'Medium size sell by catch lot', 25, 11, '6.087355', '100.3127', 'Kedah', 'Kuala Kedah', '2023-06-14 11:02:27.152934', 'New'),
(22, 8, 'Mud Crab', 'Crab', 'Sells by KG', 50, 16, '6.087355', '100.3127', 'Kedah', 'Kuala Kedah', '2023-06-14 11:04:22.017716', 'New'),
(23, 8, 'Ketam Bakau', 'Fish', 'Big size sell by unit', 15, 14, '6.087355', '100.3127', 'Kedah', 'Kuala Kedah', '2023-06-14 11:08:13.123142', 'New'),
(24, 8, 'Bayan', 'Fish', 'Big size sells by lot', 150, 9, '6.087355', '100.3127', 'Kedah', 'Kuala Kedah', '2023-06-14 11:09:18.507919', 'New'),
(25, 8, 'Selayang', 'Fish', 'Sells by kilos', 12, 6, '6.087355', '100.3127', 'Kedah', 'Kuala Kedah', '2023-06-14 11:11:43.438568', 'New'),
(26, 8, 'Parang', 'Fish', 'Big size sells by kilo', 15, 14, '6.087355', '100.3127', 'Kedah', 'Kuala Kedah', '2023-06-14 11:14:39.505361', 'New'),
(27, 8, 'Tenggiri', 'Fish', 'Sells by kilo', 15, 14, '6.087355', '100.3127', 'Kedah', 'Kuala Kedah', '2023-06-14 11:15:47.867861', 'New'),
(28, 8, 'Tongkol', 'Fish', 'Sells by kilo', 15, 10, '6.087355', '100.3127', 'Kedah', 'Kuala Kedah', '2023-06-14 11:17:00.139523', 'New'),
(29, 9, 'Talang', 'Fish', 'Large size 1kg each', 15, 25, '6.4502267', '100.4958833', 'Kedah', 'Changlun', '2023-07-12 21:27:45.454440', 'New');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_orderdetails`
--

CREATE TABLE `tbl_orderdetails` (
  `orderdetail_id` int(5) NOT NULL,
  `order_bill` varchar(8) NOT NULL,
  `catch_id` varchar(5) NOT NULL,
  `orderdetail_qty` int(5) NOT NULL,
  `orderdetail_paid` float NOT NULL,
  `buyer_id` varchar(5) NOT NULL,
  `seller_id` varchar(5) NOT NULL,
  `orderdetail_date` datetime(6) NOT NULL DEFAULT current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tbl_orderdetails`
--

INSERT INTO `tbl_orderdetails` (`orderdetail_id`, `order_bill`, `catch_id`, `orderdetail_qty`, `orderdetail_paid`, `buyer_id`, `seller_id`, `orderdetail_date`) VALUES
(1, 'clphhyrr', '14', 1, 15, '1', '7', '2023-07-11 21:28:03.589441'),
(2, 'clphhyrr', '17', 1, 25, '1', '7', '2023-07-11 21:28:03.621934'),
(3, 'clphhyrr', '26', 1, 15, '1', '8', '2023-07-11 21:28:03.635618'),
(4, 'clphhyrr', '20', 1, 10, '1', '8', '2023-07-11 21:28:03.646959'),
(5, '6wjp88dm', '9', 1, 2.5, '7', '1', '2023-07-12 11:45:02.443864'),
(6, '6wjp88dm', '8', 1, 7.5, '7', '1', '2023-07-12 11:45:02.608546'),
(7, '6wjp88dm', '20', 1, 10, '7', '8', '2023-07-12 11:45:02.779272'),
(8, '6wjp88dm', '28', 1, 15, '7', '8', '2023-07-12 11:45:02.877577');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_orders`
--

CREATE TABLE `tbl_orders` (
  `order_id` int(5) NOT NULL,
  `order_bill` varchar(8) NOT NULL,
  `order_paid` float NOT NULL,
  `buyer_id` varchar(5) NOT NULL,
  `seller_id` varchar(5) NOT NULL,
  `order_date` datetime(6) NOT NULL DEFAULT current_timestamp(6),
  `order_status` varchar(20) NOT NULL,
  `order_lat` varchar(12) NOT NULL,
  `order_lng` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tbl_orders`
--

INSERT INTO `tbl_orders` (`order_id`, `order_bill`, `order_paid`, `buyer_id`, `seller_id`, `order_date`, `order_status`, `order_lat`, `order_lng`) VALUES
(1, 'clphhyrr', 40, '1', '7', '2023-07-11 21:28:03.632231', 'Processing', '', ''),
(2, 'clphhyrr', 25, '1', '8', '2023-07-11 21:28:03.645079', 'Completed', '', ''),
(3, '6wjp88dm', 10, '7', '1', '2023-07-12 11:45:02.744910', 'Completed', '6.3460101662', '100.40912546'),
(4, '6wjp88dm', 25, '7', '8', '2023-07-12 11:45:02.867325', 'New', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_users`
--

CREATE TABLE `tbl_users` (
  `user_id` int(5) NOT NULL,
  `user_email` varchar(50) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `user_phone` varchar(12) NOT NULL,
  `user_password` varchar(40) NOT NULL,
  `user_otp` varchar(5) NOT NULL,
  `user_credit` int(10) NOT NULL,
  `user_datereg` datetime(6) NOT NULL DEFAULT current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_users`
--

INSERT INTO `tbl_users` (`user_id`, `user_email`, `user_name`, `user_phone`, `user_password`, `user_otp`, `user_credit`, `user_datereg`) VALUES
(1, 'slumberjer@gmail.com', 'Ahmad Harith', '0195959017', 'bec75d2e4e2acf4f4ab038144c0d862505e52d07', '1', 0, '2023-05-08 09:52:37.317804'),
(6, 'azham@abc.com', 'Azman bin Hamdan', '0195959499', 'bec75d2e4e2acf4f4ab038144c0d862505e52d07', '1', 0, '2023-05-15 12:02:34.119230'),
(7, 'abukasim@email.com', 'Abu Kassim', '0134443322', 'bec75d2e4e2acf4f4ab038144c0d862505e52d07', '1', 0, '2023-06-14 10:20:03.195368'),
(8, 'azman@email.com', 'Azman Adnan', '0194443321', 'bec75d2e4e2acf4f4ab038144c0d862505e52d07', '1', 0, '2023-06-14 10:56:21.706508'),
(9, 'tofay88402@niback.com', 'To Fay Lim', '0195556677', 'bec75d2e4e2acf4f4ab038144c0d862505e52d07', '1', 0, '2023-07-12 12:13:14.710631');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_carts`
--
ALTER TABLE `tbl_carts`
  ADD PRIMARY KEY (`cart_id`);

--
-- Indexes for table `tbl_catches`
--
ALTER TABLE `tbl_catches`
  ADD PRIMARY KEY (`catch_id`);

--
-- Indexes for table `tbl_orderdetails`
--
ALTER TABLE `tbl_orderdetails`
  ADD PRIMARY KEY (`orderdetail_id`);

--
-- Indexes for table `tbl_orders`
--
ALTER TABLE `tbl_orders`
  ADD PRIMARY KEY (`order_id`);

--
-- Indexes for table `tbl_users`
--
ALTER TABLE `tbl_users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_email` (`user_email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_carts`
--
ALTER TABLE `tbl_carts`
  MODIFY `cart_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `tbl_catches`
--
ALTER TABLE `tbl_catches`
  MODIFY `catch_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `tbl_orderdetails`
--
ALTER TABLE `tbl_orderdetails`
  MODIFY `orderdetail_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `tbl_orders`
--
ALTER TABLE `tbl_orders`
  MODIFY `order_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tbl_users`
--
ALTER TABLE `tbl_users`
  MODIFY `user_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
