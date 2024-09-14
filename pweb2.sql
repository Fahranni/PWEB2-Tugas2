-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 14 Sep 2024 pada 04.06
-- Versi server: 10.4.28-MariaDB
-- Versi PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pweb2`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `courses`
--

CREATE TABLE `courses` (
  `id` int(10) NOT NULL,
  `code` varchar(10) NOT NULL,
  `matkul` varchar(30) NOT NULL,
  `sks` int(10) NOT NULL,
  `hours` int(10) NOT NULL,
  `meeting` int(10) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `courses`
--

INSERT INTO `courses` (`id`, `code`, `matkul`, `sks`, `hours`, `meeting`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, '001', 'Pemrograman', 2, 2, 2, NULL, '2022-09-12 10:21:41', '2024-09-08 10:21:41'),
(2, '002', 'Basis Data', 2, 2, 2, NULL, '2024-09-03 10:22:26', NULL),
(3, '003', 'Sistem Informasi Manajemen', 3, 3, 2, NULL, '2024-09-01 18:11:11', '2024-09-04 18:11:11'),
(4, '004', 'Algoritma Pemrograman', 3, 2, 3, NULL, '2021-09-20 18:11:11', NULL),
(5, '005', 'Matematika Diskrit', 2, 3, 2, NULL, '2023-07-09 18:13:37', '2024-08-31 18:13:37'),
(6, '006', 'Rekayasa Perangkat Lunak', 2, 2, 2, NULL, '2024-03-03 18:13:37', '2024-08-13 18:15:39');

-- --------------------------------------------------------

--
-- Struktur dari tabel `course_lecturers`
--

CREATE TABLE `course_lecturers` (
  `id` int(10) NOT NULL,
  `lecturer_id` int(10) NOT NULL,
  `course_id` int(10) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `course_lecturers`
--

INSERT INTO `course_lecturers` (`id`, `lecturer_id`, `course_id`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2024-09-13 07:53:33', '2024-09-02 07:53:11', '2024-09-13 07:53:33'),
(3, 3, 6, NULL, '2019-04-26 18:29:13', NULL),
(4, 4, 5, NULL, '2019-10-18 18:29:13', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `lecturers`
--

CREATE TABLE `lecturers` (
  `id` int(10) NOT NULL,
  `name` varchar(45) NOT NULL,
  `number_phone` varchar(20) NOT NULL,
  `address` varchar(255) NOT NULL,
  `signature` varchar(45) NOT NULL,
  `nidn` varchar(20) NOT NULL,
  `nip` int(20) NOT NULL,
  `user_id` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `lecturers`
--

INSERT INTO `lecturers` (`id`, `name`, `number_phone`, `address`, `signature`, `nidn`, `nip`, `user_id`) VALUES
(1, 'Bagus Kurnia', '087654321', 'Jalan pattimura', 'Bagus', '1090965423', 1789026241, '001'),
(2, 'Fajar Maulana', '086253419826', 'Jalan Manggisan', 'Fajar', '1782937516534', 132536, '002'),
(3, 'Alaya Malika', '087241527342', 'Jalan Pancimas', 'Alayya', '1525345234', 23526432, '003'),
(4, 'Faradina maya Fauziah', '081232666725', 'Jalan Tendean', 'fara', '17777826666', 13244444, '004'),
(5, 'Kiraina Hana', '08123826633478', 'Jalan kebon jeruk', 'Hana', '142566667777', 1728881, '005');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `course_lecturers`
--
ALTER TABLE `course_lecturers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `course_id` (`course_id`),
  ADD KEY `lecturer_id` (`lecturer_id`);

--
-- Indeks untuk tabel `lecturers`
--
ALTER TABLE `lecturers`
  ADD PRIMARY KEY (`id`);

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `course_lecturers`
--
ALTER TABLE `course_lecturers`
  ADD CONSTRAINT `course_lecturers_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`),
  ADD CONSTRAINT `course_lecturers_ibfk_2` FOREIGN KEY (`lecturer_id`) REFERENCES `lecturers` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
