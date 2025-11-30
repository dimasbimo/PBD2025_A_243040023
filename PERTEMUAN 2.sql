/* Buat Database baru */
CREATE DATABASE TokoRetailDB;
GO
/* Gunakan database Tersebut */
USE TokoRetailDB;

/* Buat table kategori */
CREATE TABLE KategoriProduk (
	KategoriID INT IDENTITY(1,1) PRIMARY KEY,
	NamaKategori VARCHAR(100) NOT NULL UNIQUE
);

/* Buat tabel produk */
CREATE TABLE Produk (
	ProdukID INT IDENTITY(1001, 1) PRIMARY KEY,
	SKU VARCHAR(20) NOT NULL UNIQUE,
	NamaProduk VARCHAR(150) NOT NULL,
	Harga DECIMAL(10, 2) NOT NULL,
	Stok INT NOT NULL,
	KategoriID INT NULL, -- Boleh NULL jika belum dikategorikan

	CONSTRAINT CHK_HargaPositif CHECK (Harga >= 0),
	CONSTRAINT CHK_StokPositif CHECK (Stok >= 0),
	CONSTRAINT FK_Produk_Kategori
		FOREIGN KEY (KategoriID)
		REFERENCES KategoriProduk(KategoriID)
);

/* Buat tabel Pelanggan */
CREATE TABLE Pelanggan (
	PelangganID INT IDENTITY(1,1) PRIMARY KEY,
	NamaDepan VARCHAR(50) NOT NULL,
	NamaBelakang VARCHAR(50) NULL,
	Email VARCHAR(100) NOT NULL UNIQUE,
	NoTelepon VARCHAR(20) NULL,
	TanggalDaftar DATE DEFAULT GETDATE()
);
GO

/* Buat tabel Pesanan Header */
CREATE TABLE PesananHeader (
	PesananID INT IDENTITY(50001, 1) PRIMARY KEY,
	PelangganID INT NOT NULL,
	TanggalPesanan DATETIME2 DEFAULT GETDATE(),
	StatusPesanan VARCHAR(20) NOT NULL,

	CONSTRAINT CHK_StatusPesanan CHECK (StatusPesanan IN ('Baru', 'Proses',
	'Selesai', 'Batal')),
	CONSTRAINT FK_Pesanan_Pelanggan
		FOREIGN KEY (PelangganID)
		REFERENCES Pelanggan(PelangganID)
		-- ON DELETE NO ACTION (Default)
);
GO

/* Buat tabel Pesanan Detail */
CREATE TABLE PesananDetail (
	PesananDetailID INT IDENTITY(1,1) PRIMARY KEY,
	PesananID INT NOT NULL,
	ProdukID INT NOT NULL,
	Jumlah INT NOT NULL,
	HargaSatuan DECIMAL(10, 2) NOT NULL, -- Harga saat barang itu dibeli

	CONSTRAINT CHK_JumlahPositif CHECK (Jumlah > 0),
	CONSTRAINT FK_Detail_Header
		FOREIGN KEY (PesananID)
		REFERENCES PesananHeader(PesananID)
		ON DELETE CASCADE, -- Jika Header dihapus, detail ikut terhapus

	CONSTRAINT FK_Detail_Produk
		FOREIGN KEY (ProdukID)
		REFERENCES Produk(ProdukID)
);

/* 1. Memasukkan data Pelanggan */ -- Sintaks eksplisit (Best Practice)
INSERT INTO Pelanggan (NamaDepan, NamaBelakang, Email, NoTelepon)
VALUES
('Budi', 'Santoso', 'budi.santoso@email.com', '081234567890'),
('Citra', 'Lestari', 'citra.lestari@email.com', NULL); -- NoTelepon boleh Null

/* 2. Memasukkan data Kategori (Multi-row) */
INSERT INTO KategoriProduk (NamaKategori)
VALUES
('Elektronik'),
('Pakaian'),
('Buku');

/* 3. Verifikasi Data */
PRINT 'Data Pelanggan:';
SELECT * FROM Pelanggan;
PRINT 'Data Kategori:';
SELECT * FROM KategoriProduk;

/* Masukkan data Produk yang merujuk ke KategoriID */
INSERT INTO Produk (SKU, NamaProduk, Harga, Stok, KategoriID)
VALUES
('ELEC-001', 'Laptop Pro 14 inch', 15000000.00, 50, 1), -- KategoriID 1 = Elektronik
('PAK-001', 'Kaos Polos Putih', 75000.00, 200, 2), -- KategoriID 2 = Pakaian
('BUK-001', 'Dasar-Dasar SQL', 120000.00, 100, 3); -- KategoriID 3 = Buku

/* Verifikasi Data */
SELECT *
FROM Produk

INSERT INTO pelanggan (NamaDepan, Email)
VALUES ('Budi', 'Budi.Santoso@gmail.com');

/* Cek data SEBELUM di-update */
PRINT 'Data Citra SEBELUM Update:';
SELECT * FROM Pelanggan WHERE PelangganID = 2;

BEGIN TRANSACTION; -- Mulai zona aman

UPDATE Pelanggan
SET NoTelepon = '085566778899'
WHERE PelangganID = 2; -- Klausa WHERE sangat penting!

/* Cek data SETELAH di-update (masih di dalam transaksi) */
PRINT 'Data Citra SETELAH Update (Belum di-COMMIT):';
SELECT * FROM Pelanggan WHERE PelangganID = 2;

-- Jika sudah yakin, jadikan permanen
COMMIT TRANSACTION;
-- Jika ragu, ganti COMMIT dengan ROLLBACK

PRINT 'Data Citra setelah di-COMMIT:';
SELECT * FROM Pelanggan WHERE PelangganID = 2;