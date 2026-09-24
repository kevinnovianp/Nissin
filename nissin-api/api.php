<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: access, Content-Type, Authorization, X-Requested-With");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Content-Type: application/json; charset=UTF-8");

// Handle preflight request CORS dari Angular
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit(0);
}

require_once 'config.php';

$action = $_GET['action'] ?? '';
$method = $_SERVER['REQUEST_METHOD'];
$id = null;
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['id'])) {
    $id = (int)$_POST['id']; 
} elseif (isset($_GET['id'])) {
    $id = (int)$_GET['id']; 
}

// Helper untuk Upload File Gambar
function uploadImage($file, $subDir) {
    $baseDir = "uploads/";
    $targetDir = $baseDir . rtrim($subDir, '/') . '/';

    if (!is_dir($targetDir)) {
        mkdir($targetDir, 0777, true);
    }

    $fileExt = pathinfo($file['name'], PATHINFO_EXTENSION);
    $fileName = uniqid() . '.' . $fileExt;
    $targetFile = $targetDir . $fileName;
    
    if (move_uploaded_file($file['tmp_name'], $targetFile)) {
        return $fileName;
    }
    return null;
}

// Helper untuk Menghapus File Gambar Lama dari Penyimpanan Server
function deleteOldImage($fileName, $subDir) {
    if (!empty($fileName)) {
        $filePath = "uploads/" . rtrim($subDir, '/') . '/' . $fileName;
        if (file_exists($filePath)) {
            unlink($filePath); // Menghapus file secara fisik dari server
        }
    }
}

// Helper untuk Loop Data JSON Array Dinamis Produk
function saveProductRelationalData($conn, $productId, $jsonString, $tableName, $valueColumnName) {
    $dataArray = json_decode($jsonString, true);
    if (!empty($dataArray) && is_array($dataArray)) {
        resetTableAutoIncrement($conn, $tableName);
        foreach ($dataArray as $item) {
            $title = $item['title'] ?? '';
            $value = $item['value'] ?? $item['desc'] ?? ''; 
            
            if (!empty($title)) {
                $stmt = $conn->prepare("INSERT INTO $tableName (product_id, title, `$valueColumnName`) VALUES (?, ?, ?)");
                $stmt->bind_param("iss", $productId, $title, $value);
                $stmt->execute();
            }
        }
    }
}

// Helper untuk mereset AUTO_INCREMENT berdasarkan (Jumlah Baris Saat Ini + 1)
function resetTableAutoIncrement($conn, $tableName) {
    // 1. Hitung jumlah total baris yang ada saat ini
    $res = $conn->query("SELECT COUNT(*) as total FROM `$tableName`");
    $row = $res->fetch_assoc();
    $totalRows = (int)$row['total'];
    
    // 2. Set nilai AUTO_INCREMENT baru menjadi Jumlah Baris + 1
    $nextId = $totalRows + 1;
    $conn->query("ALTER TABLE `$tableName` AUTO_INCREMENT = $nextId");
}

// ================= 1. ENDPOINT: CATEGORIES =================
if ($action == 'categories') {
    if ($method == 'GET') {
        $result = $conn->query("SELECT * FROM categories ORDER BY id ASC");
        $categories = [];
        while ($row = $result->fetch_assoc()) {
            $categories[] = [
                "id" => (int)$row['id'],
                "img" => $row['img'],
                "desc" => $row['desc']
            ];
        }
        echo json_encode($categories);
        exit;
    }
    
    // --- UPDATE CATEGORY ---
    elseif ($method == 'POST' && ($id || isset($_POST['id']))) {
        // Konsolidasikan ID yang didapat agar pasti presisi
        $current_id = $id ? $id : (int)$_POST['id'];
        $desc = $_POST['desc'] ?? '';
        
        if (isset($_FILES['img']) && $_FILES['img']['error'] == 0) {
            $oldRes = $conn->query("SELECT img FROM categories WHERE id = $current_id");
            $oldData = $oldRes->fetch_assoc();

            $img = uploadImage($_FILES['img'], 'categories');
            $stmt = $conn->prepare("UPDATE categories SET `desc` = ?, `img` = ? WHERE id = ?");
            $stmt->bind_param("ssi", $desc, $img, $current_id);
            $stmt->execute();

            if ($oldData) deleteOldImage($oldData['img'], 'categories');
        } else {
            $stmt = $conn->prepare("UPDATE categories SET `desc` = ? WHERE id = ?");
            $stmt->bind_param("si", $desc, $current_id);
            $stmt->execute();
        }
        echo json_encode(["status" => "updated", "message" => "Data category berhasil diperbarui"]);
        exit;
    }

    // --- ADD CATEGORY ---
    elseif ($method == 'POST') {
        $desc = $_POST['desc'] ?? '';
        $img = isset($_FILES['img']) ? uploadImage($_FILES['img'], 'categories') : '';
        
        resetTableAutoIncrement($conn, 'categories');
        $stmt = $conn->prepare("INSERT INTO categories (`img`, `desc`) VALUES (?, ?)");
        $stmt->bind_param("ss", $img, $desc);
        $stmt->execute();
        echo json_encode(["status" => "success", "id" => $conn->insert_id]);
        exit;
    }
    
    // --- DELETE CATEGORY ---
    elseif ($method == 'DELETE' && $id) {
        // Proteksi sisi backend (validasi jika masih ada produk terkait)
        $check = $conn->query("SELECT id FROM products WHERE category_id = $id LIMIT 1");
        if ($check->num_rows > 0) {
            http_response_code(400);
            echo json_encode(["message" => "Gagal hapus, kategori ini memiliki produk di dalamnya."]);
            exit;
        }
        $oldRes = $conn->query("SELECT img FROM categories WHERE id = $id");
        $oldData = $oldRes->fetch_assoc();

        $conn->query("DELETE FROM categories WHERE id = $id");
        if ($oldData) deleteOldImage($oldData['img'], 'categories');

        echo json_encode(["status" => "deleted"]);
        exit;
    }
}

// ================= 2. ENDPOINT: PRODUCTS =================
if ($action == 'products') {
    if ($method == 'GET') {
        if ($id) {
            // DETAIL TUNGGAL
            $stmt = $conn->prepare("SELECT * FROM products WHERE id = ?");
            $stmt->bind_param("i", $id);
            $stmt->execute();
            $product = $stmt->get_result()->fetch_assoc();
            
            if ($product) {
                $sm_res = $conn->query("SELECT title, value FROM product_specs_main WHERE product_id = $id");
                $specs_main = []; while ($sm = $sm_res->fetch_assoc()) { $specs_main[] = $sm; }

                $so_res = $conn->query("SELECT title, value FROM product_specs_other WHERE product_id = $id");
                $specs_other = []; while ($so = $so_res->fetch_assoc()) { $specs_other[] = $so; }

                $f_res = $conn->query("SELECT title, `desc` FROM product_features WHERE product_id = $id");
                $features = []; while ($f = $f_res->fetch_assoc()) { $features[] = $f; }

                echo json_encode([
                    "id" => (int)$product['id'],
                    "img" => $product['img'],
                    "name" => $product['name'],
                    "model" => $product['model'],
                    "category_id" => (int)$product['category_id'],
                    "desc_1" => $product['desc_1'],
                    "desc_2" => $product['desc_2'],
                    "intro_1" => $product['intro_1'],
                    "intro_2" => $product['intro_2'],
                    "specs_main" => $specs_main,
                    "specs_other" => $specs_other,
                    "features" => $features
                ]);
            } else {
                http_response_code(404);
                echo json_encode(["message" => "Produk tidak ditemukan."]);
            }
        } else {
            // LIST ALL / FILTER BY CATEGORY / GET LATEST PRODUCTS
            $sql = "SELECT * FROM products";
            $params = [];
            $types = "";

            if (isset($_GET['category_id'])) {
                $cat_id = (int)$_GET['category_id'];
                $sql .= " WHERE category_id = ?";
                $params[] = $cat_id;
                $types .= "i";
            }

            if ((isset($_GET['latest']) && $_GET['latest'] === 'true') || isset($_GET['limit'])) {
                $sql .= " ORDER BY id DESC";
                if (isset($_GET['latest']) && $_GET['latest'] === 'true') {
                    $sql .= " LIMIT 5";
                } else {
                    $sql .= " LIMIT ?";
                    $params[] = (int)$_GET['limit'];
                    $types .= "i";
                }
            } else {
                $sql .= " ORDER BY id ASC";
            }

            $stmt = $conn->prepare($sql);
            if (!empty($params)) {
                $stmt->bind_param($types, ...$params);
            }
            $stmt->execute();
            $result = $stmt->get_result();
            $products = [];
            while ($product = $result->fetch_assoc()) {
                $p_id = $product['id'];
                
                $sm_res = $conn->query("SELECT title, value FROM product_specs_main WHERE product_id = $p_id");
                $specs_main = []; while ($sm = $sm_res->fetch_assoc()) { $specs_main[] = $sm; }

                $so_res = $conn->query("SELECT title, value FROM product_specs_other WHERE product_id = $p_id");
                $specs_other = []; while ($so = $so_res->fetch_assoc()) { $specs_other[] = $so; }

                $f_res = $conn->query("SELECT title, `desc` FROM product_features WHERE product_id = $p_id");
                $features = []; while ($f = $f_res->fetch_assoc()) { $features[] = $f; }

                $products[] = [
                    "id" => (int)$product['id'],
                    "img" => $product['img'],
                    "name" => $product['name'],
                    "model" => $product['model'],
                    "category_id" => (int)$product['category_id'],
                    "desc_1" => $product['desc_1'],
                    "desc_2" => $product['desc_2'],
                    "intro_1" => $product['intro_1'],
                    "intro_2" => $product['intro_2'],
                    "specs_main" => $specs_main,
                    "specs_other" => $specs_other,
                    "features" => $features
                ];
            }
            echo json_encode($products);
        }
    }
    
    // ADD PRODUCT
    elseif ($method == 'POST' && !$id) {
        $name = $_POST['name'] ?? '';
        $model = $_POST['model'] ?? '';
        $category_id = (int)($_POST['category_id'] ?? 0);
        $desc_1 = $_POST['desc_1'] ?? null;
        $desc_2 = $_POST['desc_2'] ?? null;
        $intro_1 = $_POST['intro_1'] ?? null;
        $intro_2 = $_POST['intro_2'] ?? null;
        $img = isset($_FILES['img']) ? uploadImage($_FILES['img'], 'products') : '';

        resetTableAutoIncrement($conn, 'products');
        $stmt = $conn->prepare("INSERT INTO products (img, name, model, category_id, desc_1, desc_2, intro_1, intro_2) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
        $stmt->bind_param("sssissss", $img, $name, $model, $category_id, $desc_1, $desc_2, $intro_1, $intro_2);
        $stmt->execute();
        $p_id = $conn->insert_id;

        saveProductRelationalData($conn, $p_id, $_POST['features'] ?? '[]', 'product_features', 'desc');
        saveProductRelationalData($conn, $p_id, $_POST['specs_main'] ?? '[]', 'product_specs_main', 'value');
        saveProductRelationalData($conn, $p_id, $_POST['specs_other'] ?? '[]', 'product_specs_other', 'value');

        echo json_encode(["status" => "success"]);
    }
    
    // UPDATE PRODUCT
    elseif ($method == 'POST' && $id) {
        $name = $_POST['name'] ?? '';
        $model = $_POST['model'] ?? '';
        $category_id = (int)($_POST['category_id'] ?? 0);
        $desc_1 = $_POST['desc_1'] ?? null;
        $desc_2 = $_POST['desc_2'] ?? null;
        $intro_1 = $_POST['intro_1'] ?? null;
        $intro_2 = $_POST['intro_2'] ?? null;

        if (isset($_FILES['img']) && $_FILES['img']['error'] == 0) {
            $oldRes = $conn->query("SELECT img FROM products WHERE id = $id");
            $oldData = $oldRes->fetch_assoc();

            $img = uploadImage($_FILES['img'], 'products');
            $stmt = $conn->prepare("UPDATE products SET name=?, model=?, category_id=?, desc_1=?, desc_2=?, intro_1=?, intro_2=?, img=? WHERE id=?");
            $stmt->bind_param("sssissssi", $name, $model, $category_id, $desc_1, $desc_2, $intro_1, $intro_2, $img, $id);
            $stmt->execute();

            if ($oldData) {deleteOldImage($oldData['img'], 'products');}
        } else {
            $stmt = $conn->prepare("UPDATE products SET name=?, model=?, category_id=?, desc_1=?, desc_2=?, intro_1=?, intro_2=? WHERE id=?");
            $stmt->bind_param("ssissssi", $name, $model, $category_id, $desc_1, $desc_2, $intro_1, $intro_2, $id);
            $stmt->execute();
        }

        // Refresh Data Relasional Multi-Tabel
        $conn->query("DELETE FROM product_features WHERE product_id = $id");
        $conn->query("DELETE FROM product_specs_main WHERE product_id = $id");
        $conn->query("DELETE FROM product_specs_other WHERE product_id = $id");
        saveProductRelationalData($conn, $id, $_POST['features'] ?? '[]', 'product_features', 'desc');
        saveProductRelationalData($conn, $id, $_POST['specs_main'] ?? '[]', 'product_specs_main', 'value');
        saveProductRelationalData($conn, $id, $_POST['specs_other'] ?? '[]', 'product_specs_other', 'value');
        echo json_encode(["status" => "updated"]);
    }
    
    // DELETE PRODUCT
    elseif ($method == 'DELETE' && $id) {
        $oldRes = $conn->query("SELECT img FROM products WHERE id = $id");
        $oldData = $oldRes->fetch_assoc();
        // Hapus anak tabel relasi dahulu karena FK constraint cascade/restrict
        $conn->query("DELETE FROM product_features WHERE product_id = $id");
        $conn->query("DELETE FROM product_specs_main WHERE product_id = $id");
        $conn->query("DELETE FROM product_specs_other WHERE product_id = $id");
        $conn->query("DELETE FROM products WHERE id = $id");

        if ($oldData) deleteOldImage($oldData['img'], 'products');
        echo json_encode(["status" => "deleted"]);
    }
}

// ================= 3. ENDPOINT: CAROUSELS =================
if ($action == 'carousels') {
    if ($method == 'GET') {
        $result = $conn->query("SELECT * FROM carousels ORDER BY id ASC");
        $carousels = [];
        if ($result) {
            while ($row = $result->fetch_assoc()) {
                $carousels[] = ["id" => (int)$row['id'],"img" => $row['img'],"title" => $row['title'] ?? ''];
            }
        }
        echo json_encode($carousels);
    }
    // ADD CAROUSEL
    elseif ($method == 'POST' && !$id) {
        $title = $_POST['title'] ?? null;
        $img = isset($_FILES['img']) ? uploadImage($_FILES['img'], 'carousels') : '';

        resetTableAutoIncrement($conn, 'carousels');
        $stmt = $conn->prepare("INSERT INTO carousels (title, img) VALUES (?, ?)");
        $stmt->bind_param("ss", $title, $img);
        $stmt->execute();
        echo json_encode(["status" => "success", "id" => $conn->insert_id]);
    }
    // UPDATE CAROUSEL
    elseif ($method == 'POST' && $id) {
        $title = $_POST['title'] ?? null;
        if (isset($_FILES['img']) && $_FILES['img']['error'] == 0) {
            $oldRes = $conn->query("SELECT img FROM carousels WHERE id = $id");
            $oldData = $oldRes->fetch_assoc();

            $img = uploadImage($_FILES['img'], 'carousels');
            $stmt = $conn->prepare("UPDATE carousels SET title = ?, img = ? WHERE id = ?");
            $stmt->bind_param("ssi", $title, $img, $id);
            $stmt->execute();

            if ($oldData) deleteOldImage($oldData['img'], 'carousels');
        } else {
            $stmt = $conn->prepare("UPDATE carousels SET title = ? WHERE id = ?");
            $stmt->bind_param("si", $title, $id);
            $stmt->execute();
        }
        echo json_encode(["status" => "updated"]);
    }
    // DELETE CAROUSEL
    elseif ($method == 'DELETE' && $id) {
        $oldRes = $conn->query("SELECT img FROM carousels WHERE id = $id");
        $oldData = $oldRes->fetch_assoc();
        $conn->query("DELETE FROM carousels WHERE id = $id");
        if ($oldData) deleteOldImage($oldData['img'], 'carousels');
        echo json_encode(["status" => "deleted"]);
    }
}

// ================= 4. ENDPOINT BARU: EXPORT ALL CATALOG TO TXT =================
if ($action == 'generate-file') {
    if ($method == 'GET') {
        // Matikan error reporting agar biner teks tidak terpolusi warning
        error_reporting(0);
        ini_set('display_errors', 0);
        
        // Ambil data semua kategori
        $cat_res = $conn->query("SELECT * FROM categories ORDER BY id ASC");
        
        // Inisialisasi isi teks katalog
        $txt_content = "========================================================\n";
        $txt_content .= "         RINGKASAN KATALOG KATEGORI & PRODUK            \n";
        $txt_content .= "========================================================\n\n";

        while ($cat = $cat_res->fetch_assoc()) {
            $cat_id = $cat['id'];
            $txt_content .= "KATEGORI [ID: " . $cat['id'] . "]: " . strtoupper($cat['desc']) . "\n";
            $txt_content .= "--------------------------------------------------------\n";

            // Ambil data produk anak yang berelasi
            $prod_res = $conn->query("SELECT * FROM products WHERE category_id = $cat_id");
            
            if ($prod_res->num_rows == 0) {
                $txt_content .= "  (Belum ada produk di dalam kategori ini)\n";
            } else {
                while ($product = $prod_res->fetch_assoc()) {
                    $p_id = $product['id'];
                    $txt_content .= "  • Nama Produk : " . $product['name'] . "\n";
                    $txt_content .= "    Model/Seri  : " . $product['model'] . "\n";
                    $txt_content .= "    Deskripsi   : " . ($product['desc_1'] ? $product['desc_1'] : '-') . "\n";

                    // Load Data Dinamis 1: Features
                    $f_res = $conn->query("SELECT title, `desc` FROM product_features WHERE product_id = $p_id");
                    if ($f_res->num_rows > 0) {
                        $txt_content .= "    > Fitur Unggulan:\n";
                        while ($f = $f_res->fetch_assoc()) {
                            $txt_content .= "      - " . $f['title'] . ": " . $f['desc'] . "\n";
                        }
                    }

                    // Load Data Dinamis 2: Specs Main
                    $sm_res = $conn->query("SELECT title, value FROM product_specs_main WHERE product_id = $p_id");
                    if ($sm_res->num_rows > 0) {
                        $txt_content .= "    > Spesifikasi Utama:\n";
                        while ($sm = $sm_res->fetch_assoc()) {
                            $txt_content .= "      - " . $sm['title'] . ": " . $sm['value'] . "\n";
                        }
                    }

                    // Load Data Dinamis 3: Specs Other
                    $so_res = $conn->query("SELECT title, value FROM product_specs_other WHERE product_id = $p_id");
                    if ($so_res->num_rows > 0) {
                        $txt_content .= "    > Spesifikasi Lainnya:\n";
                        while ($so = $so_res->fetch_assoc()) {
                            $txt_content .= "      - " . $so['title'] . ": " . $so['value'] . "\n";
                        }
                    }
                    $txt_content .= "  ----------------------------------------------------  \n";
                }
            }
            $txt_content .= "\n\n"; // Beri jarak antar kategori
        }

        // Tambahkan disclaimer informasional wajib di bagian paling bawah teks
        $txt_content .= "========================================================\n";
        $txt_content .= "Catatan: Dokumen ini dibuat otomatis oleh sistem katalog.\n";
        $txt_content .= "Informasi di atas bersifat referensi produk saja.\n";
        $txt_content .= "========================================================\n";

        // Bersihkan output buffer PHP sebelum mengirim data teks
        if (ob_get_contents()) ob_end_clean();

        // ================= KODE PERBAIKAN UTAMA: WAJIB AMANKAN CORS DI SINI =================
        header("Access-Control-Allow-Origin: *");
        header("Access-Control-Allow-Headers: access, Content-Type, Authorization, X-Requested-With");
        header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
        // ====================================================================================

        // Kirim response dengan format berkas TXT ke browser
        header('Content-Type: text/plain; charset=utf-8');
        header('Content-Disposition: attachment; filename="ringkasan-katalog-produk.txt"');
        header('Cache-Control: no-cache, must-revalidate');
        header('Pragma: no-cache');
        header('Content-Length: ' . strlen($txt_content));

        echo $txt_content;
        exit;
    }
}

$conn->close();
?>