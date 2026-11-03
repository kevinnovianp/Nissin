-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 16, 2026 at 04:15 PM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `nissin`
--

-- --------------------------------------------------------

--
-- Table structure for table `carousels`
--

CREATE TABLE `carousels` (
  `id` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `img` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `carousels`
--

INSERT INTO `carousels` (`id`, `title`, `img`) VALUES
(1, 'Carousel 1', '6a9c5c0c25cb4.jpg'),
(2, 'Carousel 2', 'carousel-2.jpg'),
(3, 'Carousel 3', 'carousel-3.jpg'),
(4, 'Carousel 4', 'carousel-4.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `img` varchar(255) NOT NULL,
  `desc` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `img`, `desc`) VALUES
(1, 'chiller.png', 'Chiller & Freezer'),
(2, 'coffee.png', 'Coffee Machine'),
(3, 'cooking.png', 'Cooking Equipment'),
(4, 'dishwasher.png', 'Dishwasher'),
(5, 'holding.png', 'Food Holding Preparation'),
(6, 'processing.png', 'Food Processing Equipment'),
(7, 'ice.png', 'Ice Machine');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `img` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `model` varchar(100) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `desc_1` text DEFAULT NULL,
  `desc_2` text DEFAULT NULL,
  `intro_1` text DEFAULT NULL,
  `intro_2` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `img`, `name`, `model`, `category_id`, `desc_1`, `desc_2`, `intro_1`, `intro_2`) VALUES
(1, 'freezer1.jpg', 'Nissin NSN-BD-550', 'NSN-BD-550', 1, 'Chest Freezer 465 Liter.', 'Kapasitas besar pendinginan optimal.', 'Penyimpanan Frozen Food', 'Dirancang untuk dapur komersial.  chest freezer berkapasitas 465 liter dengan sistem compressor cooling system, dirancang untuk menjaga suhu penyimpanan pada rentang -18°C ~ -25°C. Cocok digunakan pada operasional dapur komersial yang membutuhkan ruang penyimpanan beku yang stabil dan konsisten.'),
(2, 'chiller1.jpg', 'Nissin UCG-1000', 'UCG-1000', 1, 'Upright Chiller 2 Pintu.', 'Temperatur 2°C hingga 8°C.', 'Pendingin Sayur & Buah', 'Menjaga kesegaran bahan baku makana komersial.'),
(3, 'coffee1.jpg', 'Nissin Espresso Classic', 'NEC-200', 2, 'Mesin kopi semi otomatis 2 group.', 'Tekanan pompa stabil 15 bar.', 'Mesin Espresso Profesional', 'Ideal untuk kedai kopi dengan trafik tinggi.'),
(4, 'coffee2.jpg', 'Nissin Drip Master', 'NDM-50', 2, 'Mesin kopi tetes otomatis.', 'Kapasitas 1.5 Liter per brew.', 'Kopi Hitam Otomatis', 'Praktis untuk kebutuhan sarapan hotel.'),
(5, 'stove1.jpg', 'Nissin 4-Burner Gas Range', 'NGR-4B', 3, 'Kompor gas komersial 4 tungku.', 'Dilengkapi oven di bagian bawah.', 'Kompor Heavy Duty', 'Dibuat dengan bahan stainless steel tebal.'),
(6, 'fryer1.jpg', 'Nissin Deep Fryer Eco', 'NDF-17L', 3, 'Deep fryer gas kapasitas 17 Liter.', 'Suhu konstan dan merata.', 'Gorengan Krispi Sempurna', 'Cocok untuk menggoreng ayam, kentang, dan donat.'),
(7, 'dish1.jpg', 'Nissin Hood Type Washer', 'NHW-60', 4, 'Mesin cuci piring tipe hood otomatis.', 'Siklus pencucian cepat 60 detik.', 'Sanitasi Piring Cepat', 'Efisien untuk restoran skala menengah besar.'),
(8, 'dish2.jpg', 'Nissin Under-counter Washer', 'NUW-40', 4, 'Mesin cuci piring bawah meja ringkas.', 'Hemat ruang dan air.', 'Solusi Kafe Minimalis', 'Dirancang muat di bawah meja bar kasir.'),
(9, 'warmer1.jpg', 'Nissin Food Warmer Display', 'NFW-3F', 5, 'Etalase penghangat makanan 3 tingkat.', 'Menjaga kehangatan gorengan tetap renyah.', 'Pajangan Makanan Hangat', 'Dilengkapi lampu pencahayaan menarik.'),
(10, 'table1.jpg', 'Nissin Prep Table Refrigerator', 'NPT-120', 5, 'Meja kerja dapur dengan pendingin.', 'Stainless steel food-grade.', 'Meja Preparasi Dapur', 'Menjaga bahan topping tetap dingin saat diracik.'),
(11, 'mixer1.jpg', 'Nissin Planetary Mixer 20L', 'NPM-20', 6, 'Mixer adonan roti kapasitas 20 liter.', '3 pilihan kecepatan putaran.', 'Mixer Adonan Kuat', 'Mampu mengaduk adonan kalis volume besar.'),
(12, 'slicer1.jpg', 'Nissin Meat Slicer Pro', 'NMS-250', 6, 'Mesin pengiris daging tipis otomatis.', 'Diameter pisau potong 250 mm.', 'Irisan Daging Presisi', 'Ketebalan irisan dapat diatur sesuai kebutuhan.'),
(13, 'ice1.jpg', 'Nissin Cube Ice Maker 50kg', 'NIM-50', 7, 'Lorem Ipsum', 'Produksi 50 kg es per hari.', 'Es Kristal Higienis', 'Dilengkapi bin penampung es internal.'),
(14, 'ice2.jpg', 'Nissin Flake Ice Maker', 'NIM-100F', 7, 'Mesin pembuat es serut untuk ikan.', 'Produksi es serut halus.', 'Pendingin Hasil Laut', 'Menjaga ikan tetap segar di supermarket.');

-- --------------------------------------------------------

--
-- Table structure for table `product_features`
--

CREATE TABLE `product_features` (
  `id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `desc` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `product_features`
--

INSERT INTO `product_features` (`id`, `product_id`, `title`, `desc`) VALUES
(1, 1, 'Compressor Cooling System', 'Sistem pendinginan menggunakan kompresor handal untuk menjaga stabilitas suhu.'),
(2, 1, 'Manual Defrosting', 'Proses pencairan bunga es dilakukan secara berkala secara manual.'),
(3, 1, '70 mm Lid Insulation', 'Ketebalan penutup hingga 70 mm untuk menahan suhu dingin maksimal.'),
(4, 1, 'White Wire Basket', 'Dilengkapi dengan 1 keranjang kawat putih untuk mempermudah organisasi produk.'),
(5, 1, 'Defrost Drain System', 'Terdapat saluran pembuangan khusus untuk mengalirkan air sisa pencairan es.'),
(6, 2, 'No-Frost Fan Cooling', 'Sistem pendinginan dengan kipas memastikan suhu merata tanpa bunga es.'),
(7, 2, 'Adjustable Wire Shelves', 'Rak penyimpanan dapat diubah ketinggiannya sesuai ukuran wadah makanan.'),
(8, 2, 'Tempered Glass Door', 'Pintu kaca ganda yang kokoh, anti-embun, dan memaksimalkan visibilitas.'),
(9, 2, 'Eco LED Lighting', 'Pencahayaan internal LED yang terang benderang namun tetap hemat energi.'),
(10, 2, 'Digital Thermostat', 'Kontrol suhu digital presisi yang mudah dipantau dari luar unit.'),
(11, 3, 'Dual Group Head', 'Memungkinkan pembuatan 2 cangkir kopi espresso secara bersamaan untuk trafik padat.'),
(12, 3, 'Copper Boiler Exchanger', 'Boiler tembaga premium memastikan kestabilan suhu uap air secara konstan.'),
(13, 3, 'Dual Steam Wand', 'Dua tongkat uap untuk melakukan frothing susu dengan cepat secara simultan.'),
(14, 3, 'Direct Water Line', 'Sistem otomatisasi pengisian air langsung tanpa perlu mengisi manual.'),
(15, 3, 'Ergonomic Filter Holder', 'Gagang portafilter ergonomis nyaman digenggam oleh barista seharian.'),
(16, 4, 'Fast Batch Brewing', 'Mampu mengekstrak 1.5 Liter kopi hitam hanya dalam waktu kurang dari 6 menit.'),
(17, 4, 'Non-stick Warmer Plate', 'Piringan pemanas menjaga kopi tetap hangat di dalam carafe tanpa gosong.'),
(18, 4, 'Anti-drip Valve', 'Katup anti-tetes menghentikan aliran air saat teko kaca diangkat dari dudukan.'),
(19, 4, 'Removable Filter Cone', 'Keranjang saringan mudah dilepas pasang untuk proses pembersihan cepat.'),
(20, 4, 'Compact Office Design', 'Desain ringkas elegan yang tidak memakan banyak tempat di meja saji.'),
(21, 5, 'Heavy Duty Cast Iron Grates', 'Tatakan tungku cor besi tebal yang kuat menahan beban panci/wajan besar.'),
(22, 5, 'Integrated Lower Oven', 'Memiliki oven pemanggang di bagian bawah untuk efisiensi ruang dapur.'),
(23, 5, 'Thermocouple Safety', 'Sistem keamanan otomatis menghentikan aliran gas jika api tidak sengaja mati.'),
(24, 5, 'Full Stainless Steel Body', 'Konstruksi baja tahan karat AISI 304 yang tahan korosi dan mudah diseka.'),
(25, 5, 'Adjustable Feet', 'Ketinggian kaki meja kompor dapat disesuaikan untuk lantai dapur tidak rata.'),
(26, 6, 'Cold Zone Design', 'Area dingin di dasar tangki mencegah remah makanan gosong agar minyak tahan lama.'),
(27, 6, 'Hi-flow Drain Valve', 'Saluran pembuangan minyak besar mempermudah proses penggantian dan penyaringan minyak.'),
(28, 6, 'Overheat Protection', 'Termostat pengaman otomatis memutus aliran gas jika suhu minyak melebihi batas wajar.'),
(29, 6, 'Twin Frying Baskets', 'Dilengkapi dua keranjang goreng berlapis krom dengan gagang isolasi panas.'),
(30, 6, 'Rapid Heat Recovery', 'Sistem burner bertenaga mengembalikan suhu minyak dengan cepat saat bahan makanan masuk.'),
(31, 7, 'High Temperature Sanitizing', 'Membilas dengan air bersuhu 85°C untuk membunuh kuman dan bakteri pada piring.'),
(32, 7, 'Microfilter System', 'Saringan berlapis menangkap sisa kotoran agar tidak menyumbat pompa air.'),
(33, 7, 'Hood Actuated Auto Start', 'Proses mencuci otomatis berjalan sesaat setelah tudung penutup ditarik ke bawah.'),
(34, 7, 'Dual Wash Arms', 'Lengan penyemprot atas dan bawah berputar memberikan pembersihan menyeluruh.'),
(35, 7, 'Eco Water Saving', 'Mengonsumsi air hanya 2.5 liter per siklus, sangat hemat dibanding cuci manual.');

-- --------------------------------------------------------

--
-- Table structure for table `product_specs_main`
--

CREATE TABLE `product_specs_main` (
  `id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `product_specs_main`
--

INSERT INTO `product_specs_main` (`id`, `product_id`, `title`, `value`) VALUES
(1, 1, 'Capacity', '465 Liter'),
(2, 1, 'Temperature Range', '-18°C to -25°C'),
(3, 1, 'Power Supply', '220V / 50Hz / 1PH'),
(4, 1, 'Power Output', '180 Watts'),
(5, 1, 'Dimension', '1.530 x 600 x 850 mm'),
(6, 2, 'Capacity', '1000 Liter'),
(7, 2, 'Temperature Range', '2°C to 8°C'),
(8, 2, 'Power Supply', '220V / 50Hz / 1PH'),
(9, 2, 'Power Output', '350 Watts'),
(10, 2, 'Dimension', '1.200 x 750 x 1.950 mm'),
(11, 3, 'Group Head', '2 Groups'),
(12, 3, 'Boiler Capacity', '11 Liters'),
(13, 3, 'Pump Pressure', '15 Bar Rotary Pump'),
(14, 3, 'Power Output', '3700 Watts'),
(15, 3, 'Dimension', '750 x 550 x 530 mm'),
(16, 4, 'Brewing Capacity', '1.5 Liters per batch'),
(17, 4, 'Brewing Time', '5 to 6 minutes'),
(18, 4, 'Power Supply', '220V / 50Hz'),
(19, 4, 'Power Output', '1200 Watts'),
(20, 4, 'Dimension', '220 x 380 x 460 mm'),
(21, 5, 'Total Burners', '4 Open Burners + 1 Oven'),
(22, 5, 'Gas Power Output', '4 x 5.5 kW (Burners) + 6.0 kW (Oven)'),
(23, 5, 'Gas Connection', 'LPG or Natural Gas (NG)'),
(24, 5, 'Oven Temperature', '100°C to 300°C'),
(25, 5, 'Dimension', '800 x 700 x 900 mm'),
(26, 6, 'Oil Capacity', '17 Liters'),
(27, 6, 'Temperature Range', '90°C to 190°C'),
(28, 6, 'Heat Source', 'Gas (LPG)'),
(29, 6, 'Burner Power', '12 kW'),
(30, 6, 'Dimension', '350 x 700 x 1.100 mm'),
(31, 7, 'Capacity / Hour', 'Up to 60 Racks/Hour'),
(32, 7, 'Washing Cycle', '60 / 90 / 120 Seconds'),
(33, 7, 'Water Consumption', '2.5 Liters per cycle'),
(34, 7, 'Total Power', '4000W / 380V 3PH'),
(35, 7, 'Dimension', '650 x 750 x 1.480 mm');

-- --------------------------------------------------------

--
-- Table structure for table `product_specs_other`
--

CREATE TABLE `product_specs_other` (
  `id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `product_specs_other`
--

INSERT INTO `product_specs_other` (`id`, `product_id`, `title`, `value`) VALUES
(1, 1, 'Cooling System', 'Compressor Static Cooling'),
(2, 1, 'Basket Included', '1 Pcs / White Wire'),
(3, 1, 'Defrosting Type', 'Manual Defrost'),
(4, 1, 'Refrigerant', 'R600a'),
(5, 1, 'Insulation Thickness', '70 mm'),
(6, 2, 'Cooling System', 'Fan Cooling No-Frost'),
(7, 2, 'Shelves Included', '4 Pcs Adjustable Wire Shelves'),
(8, 2, 'Door Type', 'Double Layer Tempered Glass'),
(9, 2, 'Refrigerant', 'R134a'),
(10, 2, 'Internal Lighting', 'Vertical LED Bar'),
(11, 3, 'Boiler Type', 'Copper Boiler Single with Heat Exchanger'),
(12, 3, 'Water Connection', 'Direct Water Line Connection'),
(13, 3, 'Steam Wand', '2 Stainless Steel Wands'),
(14, 3, 'Body Material', 'Stainless Steel & ABS Side Panels'),
(15, 3, 'Cup Warmer', 'Passive Stainless Steel Plate'),
(16, 4, 'Carafe Type', 'Glass Carafe with Ergonomic Handle'),
(17, 4, 'Filter Basket', 'Removable Plastic Cone Filter'),
(18, 4, 'Housing Material', 'Brushed Stainless Steel'),
(19, 4, 'Heating Plate', 'PTFE Non-stick Coated'),
(20, 4, 'Control System', 'One-touch Button with Light Indicator'),
(21, 5, 'Top Grate Material', 'Heavy Duty Cast Iron'),
(22, 5, 'Safety Device', 'Thermocouple Safety Valve'),
(23, 5, 'Oven GN Capacity', 'GN 2/1 Size Compatible'),
(24, 5, 'Body Structure', 'AISI 304 Stainless Steel'),
(25, 5, 'Leg Support', 'Adjustable Bullet Feet'),
(26, 6, 'Frying Baskets', '2 Small Wire Baskets Included'),
(27, 6, 'Tank Material', 'Stainless Steel 304 pressed tank'),
(28, 6, 'Oil Drain Valve', '1 Inch High-flow Valve'),
(29, 6, 'Safety Thermostat', 'Auto Cut-off at 230°C'),
(30, 6, 'Ignition System', 'Piezo Electronic Ignition'),
(31, 7, 'Wash Tank Capacity', '30 Liters'),
(32, 7, 'Boiler Capacity', '7 Liters'),
(33, 7, 'Wash Temp / Rinse Temp', '60°C / 85°C (Sanitizing)'),
(34, 7, 'Rack Size', '500 x 500 mm'),
(35, 7, 'Wash Pump Power', '0.75 kW');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `carousels`
--
ALTER TABLE `carousels`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `product_features`
--
ALTER TABLE `product_features`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `product_specs_main`
--
ALTER TABLE `product_specs_main`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `product_specs_other`
--
ALTER TABLE `product_specs_other`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `carousels`
--
ALTER TABLE `carousels`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `product_features`
--
ALTER TABLE `product_features`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `product_specs_main`
--
ALTER TABLE `product_specs_main`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `product_specs_other`
--
ALTER TABLE `product_specs_other`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `product_features`
--
ALTER TABLE `product_features`
  ADD CONSTRAINT `product_features_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_specs_main`
--
ALTER TABLE `product_specs_main`
  ADD CONSTRAINT `product_specs_main_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_specs_other`
--
ALTER TABLE `product_specs_other`
  ADD CONSTRAINT `product_specs_other_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
