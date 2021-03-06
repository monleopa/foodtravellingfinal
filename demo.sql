-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th1 01, 2019 lúc 05:54 PM
-- Phiên bản máy phục vụ: 10.1.36-MariaDB
-- Phiên bản PHP: 7.2.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `demo`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `category`
--

CREATE TABLE `category` (
  `category_id` int(10) NOT NULL,
  `category_name` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `comment`
--

CREATE TABLE `comment` (
  `comment_id` int(50) NOT NULL,
  `comment_content` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `comment_post_id` int(50) NOT NULL,
  `comment_user_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `comment`
--

INSERT INTO `comment` (`comment_id`, `comment_content`, `comment_post_id`, `comment_user_id`) VALUES
(1, 'hello', 23, '1'),
(2, 'hm', 23, '1'),
(3, 'helllo hihi', 23, '1'),
(8, 'ngon khong ?', 32, '1'),
(17, 'Không gian đẹp, buổi tối lung linh. Đồ ăn ngon. Nếu thích có thể chèo thuyền ra sông thả đèn hoa đăng rất thú vị. Một nơi để chụp hình sống ảo rất tốt :)))', 33, '1'),
(27, 'văn thơ lai láng quá anh ơi', 33, '31'),
(30, 'đẹp quá chị ơi, cho em đi theo với :v', 33, '3');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `liked`
--

CREATE TABLE `liked` (
  `user_id` int(50) NOT NULL,
  `post_id` int(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `liked`
--

INSERT INTO `liked` (`user_id`, `post_id`) VALUES
(1, 23),
(1, 26),
(1, 29),
(1, 31),
(1, 33),
(1, 34),
(1, 35),
(2, 23),
(2, 24),
(2, 26),
(2, 32),
(2, 33),
(3, 23),
(3, 26),
(3, 29),
(3, 30),
(3, 31),
(3, 33),
(3, 34),
(31, 23),
(31, 29),
(31, 32),
(31, 33);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `post`
--

CREATE TABLE `post` (
  `post_id` int(50) NOT NULL,
  `post_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NOT NULL,
  `post_location` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `post_filename` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `post_content` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `post_image` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `post_category` int(5) NOT NULL,
  `user_id` int(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `post`
--

INSERT INTO `post` (`post_id`, `post_name`, `post_location`, `post_filename`, `post_content`, `post_image`, `post_category`, `user_id`) VALUES
(23, 'Phở Bò', 'Nam Định', 'recipe3315-635754951948774481.jpg', 'Rất ngon nhé !!!', 'C:\\Users\\User\\Documents\\NetBeansProjects\\Example\\web\\PostImages\\recipe3315-635754951948774481.jpg', 1, 1),
(24, 'Bánh Cuốn', 'Số 1 - Quang Trung - Hà Nội', '127_cr_5100540b7e113.jpg', 'Bánh rất ngon, giá lại hạ giẻ. Ăn nóng hổi.', 'C:\\Users\\User\\Documents\\NetBeansProjects\\Example\\web\\PostImages\\127_cr_5100540b7e113.jpg', 1, 2),
(29, 'Bai bien Hai Tien', 'Sam Son', 'download.jpg', 'Beautifull', 'C:\\Users\\User\\Documents\\NetBeansProjects\\Example\\web\\PostImages\\download.jpg', 2, 30),
(30, 'Vinpearl land', 'Nha Trang', 'vinpearl-land-nha-trang-ticket-4-pm.jpg', 'Lien he 0971366898 de co duoc khach san dep va giai hop ly nhat.', 'C:\\Users\\User\\Documents\\NetBeansProjects\\Example\\web\\PostImages\\vinpearl-land-nha-trang-ticket-4-pm.jpg', 2, 2),
(31, 'Tam Dao', 'Vinh Phuc', 'du-lich-tam-dao-4-400x400.jpg', 'So Beautifull !', 'C:\\Users\\User\\Documents\\NetBeansProjects\\Example\\web\\PostImages\\du-lich-tam-dao-4-400x400.jpg', 2, 29),
(32, 'Bánh Xèo', '91 Be Van Dan - Ha Dong - Ha Noi', 'photo.jpg', 'Very Good !!!', 'C:\\Users\\User\\Documents\\NetBeansProjects\\Example\\web\\PostImages\\photo.jpg', 1, 31),
(33, 'Hội An', 'Phố cổ Hội An - Quảng Nam', 'hoi-an-600x600.jpg', 'So So So Beautifull !', 'C:\\Users\\User\\Documents\\NetBeansProjects\\Example\\web\\PostImages\\hoi-an-600x600.jpg', 1, 31);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `relationship`
--

CREATE TABLE `relationship` (
  `rela_id` int(50) NOT NULL,
  `follower_id` int(50) NOT NULL,
  `following_id` int(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `relationship`
--

INSERT INTO `relationship` (`rela_id`, `follower_id`, `following_id`) VALUES
(13, 29, 29),
(14, 1, 2),
(15, 1, 1),
(17, 30, 30),
(18, 31, 1),
(19, 2, 2),
(21, 2, 31),
(22, 3, 3),
(24, 31, 2),
(25, 47, 47),
(26, 47, 31),
(27, 1, 29),
(28, 3, 31),
(31, 1, 31),
(32, 48, 48);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `report`
--

CREATE TABLE `report` (
  `report_id` int(11) NOT NULL,
  `report_content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `post_id` int(11) NOT NULL,
  `report_status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `report`
--

INSERT INTO `report` (`report_id`, `report_content`, `user_id`, `user_name`, `post_id`, `report_status`) VALUES
(13, 'khong ngon', 31, 'hongnhung', 24, 0),
(14, 'k hay', 2, 'Nguyễn Bá Phương', 33, 0);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `user`
--

CREATE TABLE `user` (
  `user_id` int(40) NOT NULL,
  `user_name` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_password` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `admin` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `user`
--

INSERT INTO `user` (`user_id`, `user_name`, `user_password`, `email`, `admin`) VALUES
(1, 'Đức Anh', '81dc9bdb52d04dc20036dbd8313ed055', 'ducanh7897@gmail.com', 1),
(2, 'Nguyễn Bá Phương', '81dc9bdb52d04dc20036dbd8313ed055', 'baphuong@gmail.com', 2),
(3, 'Cong Son', '81dc9bdb52d04dc20036dbd8313ed055', 'congson@gmail.com', 2),
(29, 'philinhlinh', '81dc9bdb52d04dc20036dbd8313ed055', 'philinh@gmail.com', 2),
(30, 'duonglinhtrang', '81dc9bdb52d04dc20036dbd8313ed055', 'tranglinh@gmail.com', 2),
(31, 'Hồng Nhung', '81dc9bdb52d04dc20036dbd8313ed055', 'hongnhung@gmail.com', 2),
(47, 'tan dung', '81dc9bdb52d04dc20036dbd8313ed055', 'tandung@gmail.com', 2),
(48, 'Đức', '81dc9bdb52d04dc20036dbd8313ed055', 'tony@gmail.com', 2);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`category_id`);

--
-- Chỉ mục cho bảng `comment`
--
ALTER TABLE `comment`
  ADD PRIMARY KEY (`comment_id`);

--
-- Chỉ mục cho bảng `liked`
--
ALTER TABLE `liked`
  ADD PRIMARY KEY (`user_id`,`post_id`);

--
-- Chỉ mục cho bảng `post`
--
ALTER TABLE `post`
  ADD PRIMARY KEY (`post_id`);

--
-- Chỉ mục cho bảng `relationship`
--
ALTER TABLE `relationship`
  ADD PRIMARY KEY (`rela_id`);

--
-- Chỉ mục cho bảng `report`
--
ALTER TABLE `report`
  ADD PRIMARY KEY (`report_id`);

--
-- Chỉ mục cho bảng `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `comment`
--
ALTER TABLE `comment`
  MODIFY `comment_id` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT cho bảng `post`
--
ALTER TABLE `post`
  MODIFY `post_id` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT cho bảng `relationship`
--
ALTER TABLE `relationship`
  MODIFY `rela_id` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT cho bảng `report`
--
ALTER TABLE `report`
  MODIFY `report_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT cho bảng `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(40) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
