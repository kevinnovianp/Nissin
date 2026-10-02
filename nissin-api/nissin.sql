-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 02, 2026 at 03:08 PM
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
(1, 'Carousel 1', '6abfab72a477a.png'),
(2, 'Carousel 2', '6abfab87e4db1.png'),
(3, 'Carousel 3', '6abfab943e9da.png'),
(4, 'Carousel 4', '6abfab9df1ca4.jpg'),
(5, 'Carousel 5', '6abfabab59718.jpg'),
(6, 'Carousel 6', '6abfabb9a1c42.jpg'),
(7, 'Carousel 7', '6abfabc9a345e.jpg'),
(8, 'Carousel 8', '6abfabd72e389.jpg');

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
(1, '6aaaad82570b1.png', 'Freezer'),
(2, '6aaaadd4e2ecd.png', 'Chiller'),
(3, '6aaaadf1f0add.png', 'Ice Machine'),
(4, '6aaaae44c1336.png', 'Showcase'),
(5, '6aaaae882f30f.png', 'Cooking Equipment');

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
(1, '6aaab2c15514a.png', 'BD-550 Chest Freezer Basic', 'BD-550', 1, 'Freezer berkapasitas besar yang andal dan hemat energi.', 'Sangat ideal untuk menjaga kesegaran bahan makanan bisnis kuliner Anda', 'Menyimpan stok makanan dalam jumlah besar kini tidak perlu khawatir kekurangan ruang atau penurunan kualitas fisik.', 'Apakah Anda sedang mencari perangkat pembeku yang tangguh untuk mendukung kelancaran bisnis kuliner Anda? BD-550 Chest Freezer Basic siap menjadi andalan lewat kombinasi kapasitasnya yang lapang, teknologi pendinginan merata, serta desain yang kokoh dan tahan lama'),
(2, '6aaab4bbc64c1.png', 'BD-650 Chest Freezer Basic', 'BD-650', 1, 'Kapasitas ekstra luas 650 Liter dan sistem pendinginan kilat.', 'Freezer premium desain ergonomis yang hemat daya listrik', 'Kombinasi teknologi pendinginan merata dengan konfigurasi pintu ganda yang praktis.', 'Menghadapi lonjakan stok bahan baku atau bisnis kuliner yang kian berkembang menuntut ruang penyimpanan makanan yang tidak hanya luas, tetapi juga andal. Hadir sebagai jawaban atas kebutuhan industri Horeka, BD-650 Chest Freezer Basic menawarkan ruang pembekuan super lapang dengan efisiensi daya yang dirancang khusus untuk penggunaan terus-menerus tanpa henti.'),
(3, '6aaab6aaef18c.png', 'BD-700D Chest Freezer Supersize Series', 'BD-700D', 1, 'Freezer jumbo berkapasitas 700 Liter.', 'Disertai teknologi pendinginan ekstra kuat, dirancang khusus sebagai solusi penyimpanan utama untuk bisnis katering, hotel, dan industri kuliner skala masif.', 'Pembeku andalan dua pintu yang tangguh, andal, dan sanggup menjaga kesegaran stok beku dalam volume super besar.', 'Di tengah tuntutan bisnis kuliner yang terus berekspansi, ketersediaan ruang penyimpanan bahan baku dalam skala besar menjadi kunci kelancaran operasional. Menjawab tantangan tersebut, BD-700D Chest Freezer Supersize Series hadir menawarkan ruang penyimpanan super lapang dan keandalan sistem pendinginan komersial untuk memastikan daging, seafood, hingga frozen food Anda tetap dalam kualitas premium tanpa kompromi.'),
(4, '6aab49044c61c.png', 'Undercounter Chiller LRCP-120 RBG', 'LRCP-120', 2, 'Chiller berbahan stainless steel premium.', 'Pendingin 2 pintu bersistem Air Cooling yang tangguh.', 'Integrasi cerdas antara meja kerja heavy-duty di bagian atas dan kabinet pendingin bersuhu presisi di bagian bawah.', 'Keterbatasan ruang kini bukan lagi hambatan untuk menjaga kualitas kesegaran sayur, buah, produk susu, hingga bahan mentah tetap prima. Undercounter Chiller LRCP-120 RBG dirancang dengan standar material industri dan teknologi pendinginan merata tanpa bunga es, menjadikannya investasi esensial bagi kafe, restoran, hotel, hingga usaha catering Anda.'),
(5, '6aab4b1309226.png', 'SFCP-70 Upright Freezer RBG', 'SFCP-70', 1, 'Freezer vertikal satu pintu berbahan stainless steel premium.', 'Kapasitas penyimpanan besar dengan efisiensi ruang optimal untuk dapur profesional.', 'Freezer bersistem pendinginan dinamis yang andal, kokoh, dan memudahkan pengaturan stok makanan secara higienis.', 'Menjaga kesegaran daging, seafood, hingga produk olahan beku dalam jangka panjang membutuhkan performa pendinginan yang stabil dan merata. SFCP-70 Upright Freezer RBG hadir dengan standar material industri tahan karat dan teknologi pembekuan tingkat tinggi, menjadikannya pilihan investasi terbaik untuk restoran, hotel, bisnis katering, hingga laboratorium kuliner Anda.'),
(6, '6aab4ccf7b6db.png', 'AC-500 Ice Cube Machine RBG', 'AC-500', 3, 'Berbahan stainless steel premium.', 'Pembuat es kristal berbentuk kubik secara cepat, efisien, dan higienis.', 'Berkemampuan memproduksi ratusan kilogram es batu kristal per hari secara konsisten.', 'Jangan biarkan kelancaran operasional kafe atau restoran Anda terhambat oleh ketergantungan pada pasokan es batu luar yang belum tentu terjamin kebersihannya. AC-500 Ice Cube Machine RBG siap menjadi pusat produksi es mandiri di dapur komersial Anda, memadukan sistem cetak otomatis yang cepat, penyimpanan ice bin yang andal, serta material food-grade untuk menjaga kualitas higienitas setiap balok es yang dihasilkan.'),
(7, '6aac1daac6230.png', 'BT-120 Ice Cube Machine RBG', 'BT-120', 3, 'Pembuat es batu otomatis tipe undercounter yang ringkas.', 'Mesin portabel berbahan stainless steel.', 'Efisiensi pemanfaatan ruang lantai (floor space) sangat menentukan kenyamanan alur kerja staf dapur.', 'Menyediakan es batu yang jernih dan higienis secara mandiri kini tidak lagi membutuhkan perangkat berukuran raksasa. BT-120 Ice Cube Machine RBG siap menjadi mitra operasional andalan yang bekerja secara otomatis penuh, mengombinasikan kecepatan cetak es, efisiensi konsumsi daya, serta ketahanan material standar komersial untuk menunjang kualitas setiap sajian minuman Anda.'),
(8, '6aac1fd0cff5c.png', 'SDC1210 Open Top Counter Chiller Showcase RBG', 'SDC1210', 4, 'Pendingin meja berkonsep tanpa pintu kaca.', 'Visualisasi produk yang maksimal melalui desain konter horizontal tanpa sekat pintu.', 'Menggabungkan kemudahan akses langsung pelanggan (grab-and-go) dengan teknologi pendinginan merata standar komersial Crown Horeca.', 'Mengintegrasikan estetika modern dan fungsionalitas pendinginan tingkat tinggi kini lebih mudah. SDC1210 Open Top Counter Chiller Showcase dirancang khusus untuk diletakkan di atas meja konter (countertop), memberikan kestabilan suhu dingin yang konstan berkat sistem tirai udara dinamis (air curtain system) yang mencegah udara panas luar merusak kualitas makanan segar Anda.'),
(9, '6aac24e6aae0f.png', 'NSN-IHF100Z-T-H9', 'T-H9', 5, 'Cocok untuk dapur industri skala besar.', 'Perangkat pemanas induksi premium bersistem kontrol pintar.', 'Pemanasan magnetik yang agresif dan efisiensi termal tinggi.', 'Menciptakan lingkungan kerja dapur yang bersih, minim risiko kebakaran, dan hemat energi kini dapat diwujudkan dengan mudah. NSN-IHF100Z-T-H9 dirancang dengan standar bodi tahan benturan serta sistem sensor otomatis, menjadikannya pilihan utama bagi hotel, restoran, katering, hingga dapur pusat (central kitchen) yang membutuhkan produktivitas memasak intensif setiap hari.');

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
(1, 1, 'Fast Freezing Technology', 'Sistem pendinginan super cepat yang mampu membekukan bahan makanan dalam waktu singkat guna mengunci kesegaran dan menjaga kandungan nutrisi di dalamnya tetap optimal.'),
(2, 1, 'Eco-Friendly Saving Energy', 'Dirancang dengan sistem kompresor yang efisien untuk menghasilkan performa pembekuan maksimal, namun tetap hemat konsumsi daya listrik (Low Watt) untuk menekan biaya operasional.'),
(3, 1, 'Ergonomic & Heavy Duty Design', 'Penjelasan: Konstruksi bodi yang kokoh dengan material berkualitas tinggi serta dilengkapi roda kokoh pada bagian bawah, memudahkan unit untuk dipindahkan atau diatur tata letaknya sesuai kebutuhan ruangan.'),
(4, 1, 'Penjelasan: Konstruksi bodi yang kokoh dengan material berkualitas tinggi serta dilengkapi roda koko', 'Dilengkapi dengan fitur Lock and Key (kunci pengaman) pada pintu freezer untuk menjaga keamanan stok bahan makanan berharga dari akses yang tidak diinginkan.'),
(5, 1, 'Smart Internal Temperature Monitoring', 'Integrasi komponen Digital Thermometer dan lampu internal (Internal Lamp) yang memudahkan pengguna memantau suhu secara akurat sekaligus melihat isi freezer dengan jelas.'),
(6, 2, 'Dual Solid Door Configuration', 'Desain penutup dengan dua pintu terpisah yang membantu meminimalkan hilangnya udara dingin saat salah satu pintu dibuka, sehingga suhu internal tetap stabil dan konsumsi energi lebih efisien.'),
(7, 2, 'Rapid Cooling System', 'Didukung oleh teknologi kompresor canggih dan refrigeran ramah lingkungan untuk menurunkan suhu secara cepat hingga -22°C, memastikan pembekuan bahan makanan merata sampai ke bagian dalam.'),
(8, 2, 'Ergonomic Heavy-Duty Wheels', 'Dilengkapi roda penyangga yang kokoh pada bagian bawah bodi untuk mempermudah proses pemindahan atau penataan ulang posisi freezer berkapasitas besar ini di ruang usaha Anda.'),
(9, 2, 'Integrated Digital Thermometer', 'Memiliki panel indikator suhu digital yang akurat pada bagian luar unit, memberikan kemudahan bagi pengguna untuk memantau kondisi temperatur internal secara sekilas tanpa membuka pintu.'),
(10, 2, 'Secure Lock & Key Protection', 'Integrasi fitur kunci pengaman internal pada handel pintu untuk mengamankan persediaan bahan makanan atau produk komersial berharga Anda dari akses yang tidak terjadwal.'),
(11, 3, 'Supersize Massive Capacity', 'Menyediakan ruang interior ekstra luas dan tanpa sekat kompartemen yang rumit, memungkinkan penyimpanan bahan makanan berdimensi besar seperti potongan daging utuh atau stok karton frozen food dalam jumlah melimpah.'),
(12, 3, 'Dual Door Energy Efficiency', 'Dual Door Energy EfficiencyPenjelasan: Menggunakan konfigurasi pintu ganda (double solid lid) yang membagi akses pembukaan, efektif menahan paparan udara luar agar suhu beku di dalam tetap stabil dan memangkas beban kerja kompresor.'),
(13, 3, 'Industrial-Grade Fast Freezing', 'Dibekali dengan kompresor kelas komersial yang mampu menurunkan suhu secara agresif dan konsisten, mengunci kualitas kesegaran makanan secara cepat guna mencegah perkembangbiakan bakteri.'),
(14, 3, 'Anti-Corrosive White Inner Lining', 'Lapisan dinding bagian dalam dilapisi material khusus antikorosi yang kuat dan higienis, mencegah terbentuknya noda karat akibat kelembapan tinggi serta sangat mudah dibersihkan.'),
(15, 4, 'Dual Function Countertop', 'Bagian atas unit berfungsi sebagai meja persiapan (preparation table) yang luas dan kokoh, memadukan tempat mengolah bahan makanan sekaligus ruang penyimpanan dingin tepat di bawahnya.'),
(16, 4, 'Advanced Air Cooling System', 'Menggunakan sistem pendinginan sirkulasi udara (ventilated air cooling) yang menyebarkan suhu dingin secara merata ke setiap sudut kabinet tanpa menimbulkan penumpukan bunga es.'),
(17, 4, 'Smart Intelligent Computer Board Control', 'Dilengkapi kontroler digital pintar yang mampu memantau temperatur dengan akurasi tinggi hingga 0.1°C serta memiliki fungsi diagnosis mandiri jika terjadi anomali pada sistem.'),
(18, 4, 'Eco-Friendly R290 Refrigerant & High Insulation', 'Menggunakan bahan pendingin ramah lingkungan R290 yang dipadukan dengan lapisan isolasi densitas tinggi setebal 60mm untuk menjaga kestabilan suhu dingin secara optimal dan menghemat listrik.'),
(19, 4, 'Hygienic Stainless Steel Construction', 'Stainless Steel 201 berkualitas yang tahan karat, memenuhi standar sanitasi makanan, serta sangat mudah dibersihkan dari noda minyak atau sisa bahan masakan.'),
(20, 5, 'Vertical Space-Saving Design', 'Desain bodi vertikal meninggi yang memaksimalkan kapasitas penyimpanan internal tanpa menyita banyak ruang lantai di area dapur Anda yang padat.'),
(21, 5, 'Ventilated Dynamic Cooling System', 'Menggunakan sistem distribusi udara dingin berbasis kipas dinamis yang memastikan suhu beku tersebar merata ke setiap rak sekaligus mencegah penumpukan bunga es secara berlebih.'),
(22, 5, 'Hygienic Multi-Tier Adjustable Shelves', 'Dilengkapi dengan beberapa baris susunan rak kokoh yang dapat diatur ketinggiannya, memberikan fleksibilitas penuh untuk menyusun wadah makanan berukuran besar secara rapi.'),
(23, 5, 'Microprocessor Digital Thermostat', 'Mengadopsi panel kontrol digital pintar yang memantau dan mempertahankan kestabilan temperatur internal secara presisi untuk mencegah fluktuasi suhu yang merusak bahan baku.'),
(24, 5, 'Commercial-Grade Stainless Steel Body', 'Konstruksi bodi luar dan dalam yang sepenuhnya dibalut material stainless steel tebal berkekuatan tinggi, menjamin unit tahan karat, kokoh, serta sangat mudah disanitasi.'),
(25, 6, 'Fully Automatic Ice Production', 'Sistem kerja otomatis mulai dari pengisian air, proses pembekuan cetakan kubus, hingga pelepasan es batu ke dalam tangki penyimpanan tanpa memerlukan intervensi manual yang rumit.'),
(26, 6, 'High-Efficiency Rapid Freezing Evaporator', 'Didukung evaporator canggih yang mampu mengoptimalkan perpindahan suhu dingin secara agresif, membuat siklus pencetakan es batu berjalan lebih singkat dan padat.'),
(27, 6, 'Hygienic Food-Grade Ice Bin', 'Kabinet penampung es internal dilapisi oleh material isolasi berkualitas tinggi bersertifikasi food-grade untuk mencegah es mencair dengan cepat sekaligus menjamin kebersihannya.'),
(28, 6, 'Premium Stainless Steel Outer Shell', 'Bodi luar dilapisi material stainless steel kokoh kelas komersial yang tahan karat, memberikan tampilan profesional serta sangat mudah dibersihkan dari kotoran dapur.'),
(29, 6, 'Smart Smart Sensors Control', 'Dilengkapi sensor otomatis yang mendeteksi volume air masuk serta sensor pembatas yang akan menghentikan produksi es secara mandiri ketika ice bin sudah terisi penuh guna menghindari luberan.'),
(30, 7, 'Compact Undercounter Space-Saving', 'Desain dimensi bodi yang ringkas dan ergonomis, memungkinkannya dipasang di bawah meja konter dapur atau bar guna menghemat ruang lantai yang terbatas.'),
(31, 7, 'Fully Automatic Smart Production Cycle', 'Siklus kerja otomatis penuh mulai dari pengisian air mandiri, pencetakan es batu kristal keras, hingga deteksi otomatis berhenti beroperasi saat bak penampung penuh.'),
(32, 7, 'Air-Cooled Rapid Freezing System', 'Didukung oleh sistem pendingin udara (air-cooled) yang efisien untuk mendinginkan kompresor secara cepat, memastikan produksi es tetap stabil sepanjang hari.'),
(33, 7, 'LED Digital Smart Control Display', 'Dilengkapi panel kontrol digital berbasis LED yang ramah pengguna, memudahkan Anda mengatur ketebalan es, memantau status operasional, serta melihat indikator peringatan.'),
(34, 7, 'Durable Stainless Steel Architecture', 'Seluruh bodi luar dibangun menggunakan material stainless steel premium yang kokoh, memberikan perlindungan antikorosi maksimal sekaligus mudah dibersihkan dari noda.'),
(35, 8, 'Grab-and-Go Open Top Design', 'Konsep display terbuka di bagian atas tanpa pintu kaca penghalang, memicu pembelian impulsif karena memberikan kemudahan akses maksimal bagi pelanggan untuk mengambil produk secara langsung.'),
(36, 8, 'Advanced Air Curtain Cooling System', 'Menggunakan teknologi hembusan tirai udara (air curtain) yang konsisten di bagian atas bukaan untuk mengisolasi suhu dingin di dalam kabinet, menjaga suhu internal tetap terjaga optimal meskipun tanpa penutup.'),
(37, 8, 'Smart Electronic Digital Controller', 'Dilengkapi pengatur suhu digital pintar yang menampilkan indikator temperatur secara presisi, memudahkan staf mengawasi serta menjaga kesegaran bahan pangan sensitif seperti buah potong atau sushi.'),
(38, 8, 'Brilliant Panoramic LED Lighting', 'Integrasi lampu LED internal berintensitas tinggi yang hemat energi, memberikan pencahayaan merata dan terang benderang untuk meningkatkan daya tarik estetika visual makanan yang dipajang.'),
(39, 8, 'Automatic Off-Cycle Defrosting', 'Didukung oleh fitur pencairan bunga es otomatis bersistem off-cycle, memastikan sirkulasi udara dingin di dalam unit tetap lancar tanpa risiko penyumbatan es pada evaporator.'),
(40, 9, 'High-Frequency Induction Heating', 'Menggunakan teknologi elektromagnetik frekuensi tinggi yang menyalurkan panas langsung ke dasar alat masak secara instan, meminimalkan energi panas yang terbuang ke udara sekitar.'),
(41, 9, 'Intelligent Thermostat Control', 'Dilengkapi panel kontrol digital pintar untuk mengatur tingkat daya dan suhu secara presisi, memberikan konsistensi kematangan yang sempurna pada setiap masakan.'),
(42, 9, 'Heavy-Duty Micro-Crystalline Glass Top', 'Permukaan atas dilapisi kaca kristal mikro berkualitas tinggi yang tahan terhadap suhu ekstrem, goresan, serta beban berat dari panci/wajan berukuran besar.'),
(43, 9, 'Multi-Protection Safety Sensors', 'Integrasi fitur keselamatan otomatis yang langsung memutus arus listrik jika mendeteksi panas berlebih (overheating), tegangan tidak stabil, atau saat unit ditinggalkan tanpa alat masak di atasnya.'),
(44, 9, 'Stainless Steel Industrial Housing', 'Seluruh kerangka bodi luar dibangun menggunakan material stainless steel tebal standar komersial yang kokoh, antikorosi, serta sangat mudah disanitasi setelah digunakan.');

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
(1, 1, 'Kapasitas Penyimpanan', '550 Liter'),
(2, 1, 'Range Temperatur', '30°C s/d -22°C'),
(3, 1, 'Konsumsi Daya', '170 Watt'),
(4, 1, 'Dimensi Produk', '1530 x 755 x 840 mm'),
(5, 1, 'Tegangan Listrik', '220 Volt / 50 Hz'),
(6, 2, 'Kapasitas Penyimpanan', '650 Liter'),
(7, 2, 'Rentang Temperatur', '-18°C s/d -22°C'),
(8, 2, 'Konsumsi Daya', '275 Watt'),
(9, 2, 'Tegangan Listrik', '220 Volt / 50 Hz'),
(10, 2, 'Dimensi Produk', '1655 x 740 x 850 mm'),
(11, 3, 'Kapasitas Penyimpanan', '700 Liter'),
(12, 3, 'Rentang Temperatur', '20°C s/d -22°C'),
(13, 3, 'Konsumsi Daya', '280 Watt'),
(14, 3, 'Dimensi Produk', '1800 x 740 x 850 mm'),
(15, 4, 'Kapasitas Penyimpanan', '250 Liter'),
(16, 4, 'Konsumsi Daya', '270 Watt'),
(17, 4, 'Tegangan Listrik', '220 Volt / 50 Hz'),
(18, 4, 'Rentang Temperatur', '-6°C s/d +15°C'),
(19, 4, 'Dimensi Produk', '1200 x 760 x 800 mm'),
(20, 5, 'Kapasitas Penyimpanan', '700 Liter'),
(21, 5, 'Rentang Temperatur', '-18°C s/d -22°C'),
(22, 5, 'Konsumsi Daya', '450 - 550 Watt'),
(23, 5, 'Tegangan Listrik', '220 Volt / 50 Hz'),
(24, 5, 'Sistem Defrost', 'Automatic Defrost / No-Frost'),
(25, 6, 'Kapasitas Produksi', '500 Kg / 24 Jam'),
(26, 6, 'Kapasitas Tangki', '200 Kg'),
(27, 6, 'Jenis Es', 'Es Batu Kotak / Kristal'),
(28, 6, 'Konsumsi Daya', '1100 - 2000 Watt'),
(29, 6, 'Tegangan Listrik', '220 Volt / 50 Hz'),
(30, 7, 'Jenis Es', 'Clear Cube Ice'),
(31, 7, 'Kapasitas Produksi', '54 - 55 Kg / 24 Jam'),
(32, 7, 'Kapasitas Tangki', '20 - 30 Kg'),
(33, 7, 'Konsumsi Daya', '380 - 450 Watt'),
(34, 7, 'Tegangan Listrik', '220 Volt / 50 Hz'),
(35, 8, 'Jenis Perangkat', 'Open Top Counter / Multideck Showcase Chiller'),
(36, 8, 'Rentang Temperatur', '+2°C s/d +10°C'),
(37, 8, 'Sistem Pendinginan', 'Ventilated / Dynamic Air Cooling'),
(38, 8, 'Dimensi Produk', '1200 x 750 x 850-1000 mm'),
(39, 8, 'Konsumsi Daya', '450 - 650 Watt'),
(40, 9, 'Jenis Perangkat', 'Commercial Induction Stove'),
(41, 9, 'Konsumsi Daya', '3500 - 5000 Watt'),
(42, 9, 'Tegangan Listrik', '220 - 240 Volt / 50 Hz'),
(43, 9, 'Rentang Suhu', '60°C s/d 240°C'),
(44, 9, 'Tingkat Pengaturan Daya', 'Multi-level Adjustment');

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
(1, 1, 'Berat Bersih Unit', '75 Kg'),
(2, 1, 'Jumlah Pintu', '1 Pintu (Top Loading Lid)'),
(3, 1, 'Jumlah Rak / Keranjang', '1 Rak Gantung'),
(4, 1, 'Garansi Kompresor', '3 Tahun'),
(5, 1, 'Garansi Sparepart', '1 Tahun'),
(6, 2, 'Jenis Refrigeran', 'R290 / R600A'),
(7, 2, 'Jumlah Pintu', '2 Pintu (Dual Top Loading Lid)'),
(8, 2, 'Garansi Kompresor', '3 Tahun'),
(9, 2, 'Garansi Sparepart', '1 Tahun'),
(10, 3, 'Sistem Defrost', 'Manual'),
(11, 3, 'Fitur Keamanan', 'Secure Key Lock'),
(12, 3, 'Garansi', '3 Tahun'),
(13, 4, 'Sistem Pendinginan', 'Air Cooling (Ventilated)'),
(14, 4, 'Material Bodi', 'Stainless Steel 201'),
(15, 4, 'Jumlah Pintu', '2 Pintu Ayun (Double Solid Door)'),
(16, 4, 'Jenis Refrigeran', 'R290 (Ramah Lingkungan)'),
(17, 5, 'Tipe Pintu', 'Single Solid Door Upright'),
(18, 5, 'Material Kabinet', 'Full Stainless Steel'),
(19, 5, 'Kaki Penopang', 'Castors with Brake'),
(20, 5, 'Fitur Keamanan', 'Integrated Door Lock'),
(21, 5, 'Garansi', '3 Tahun'),
(22, 6, 'Material Konstruksi', 'Full Stainless Steel & ABS Engineering Plastic'),
(23, 6, 'Sistem Pendinginan', 'Air dan Water Cooled'),
(24, 6, 'Jenis Bahan Pendingin', 'R404A / R290 (Ramah Lingkungan)'),
(25, 6, 'Fitur Panel Indikator', 'Digital Control Indicator'),
(26, 6, 'Garansi', '3 Tahun'),
(27, 7, 'Sistem Pendinginan Kondensor', 'Air-Cooled'),
(28, 7, 'Siklus Waktu Produksi', '12 s/d 15 menit / siklus cetak'),
(29, 7, 'Material Konstruksi', 'Premium Stainless Steel & ABS Plastic'),
(30, 7, 'Fitur Tambahan', 'Adjustable Feet'),
(31, 7, 'Garansi', '3 Tahun'),
(32, 8, 'Tegangan Listrik', '220 - 240 Volt / 50 Hz'),
(33, 8, 'Jenis Bahan Pendingin', 'R404A / R290 (Ramah Lingkungan)'),
(34, 8, 'Material Kabinet', 'Stainless Steel, Tempered Glass, & ABS Polyurethane'),
(35, 8, 'Fitur Penutup Tambahan', 'Night Curtain'),
(36, 8, 'Garansi', '3 Tahun'),
(37, 9, 'Material Permukaan Atas', 'High-Strength Micro-Crystalline Glass'),
(38, 9, 'Material Rangka Bodi', 'Stainless Steel 201 / 304 Premium'),
(39, 9, 'Fitur Pengaman Tambahan', 'Auto-Shut Off & Over-Current Protection'),
(40, 9, 'Sistem Pendinginan Internal', 'Dual High-Speed Exhaust Fan'),
(41, 9, 'Garansi', '3 Tahun');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `product_features`
--
ALTER TABLE `product_features`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `product_specs_main`
--
ALTER TABLE `product_specs_main`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `product_specs_other`
--
ALTER TABLE `product_specs_other`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

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
