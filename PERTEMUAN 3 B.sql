-- Menampilkan semua data pada tabel product 
SELECT *
FROM Production.Product;

-- Menampilkan Nmae, ProductNumber, dan ListPrice
SELECT Name, ProductNumber, ListPrice
FROM Production.Product;

-- Menampilkan data menggunakan alias kolom
SELECT Name AS [Nama Barang], ListPrice AS 'Harga Jual'
FROM Production.Product;

-- Menampilkan Harga Baru = ListPricce * 1.1
SELECT Name, ListPrice, (ListPrice * 1.1) AS HargaBaru
FROM Production.Product;

-- Menampilkan data dengan menggabungkan String
SELECT Name + ' (' + ProductNumber + ')' AS ProdukLengkap
FROM Production.Product;

-- Filterisasi Data
-- Menampilkan Product yang berwarna blue
SELECT Name, Color, ListPrice
FROM Production.Product
WHERE Color = 'blue';

-- Menampilkan dara yang ListPricenya lebih dari 1000
SELECT Name, ListPrice
FROM Production.Product
WHERE ListPrice > 1000;

-- Menampilkan produk yang berwarna black dan harganya diatas 500
SELECT Name, Color, ListPrice
FROM Production.Product
WHERE Color = 'Black' AND ListPrice > 500;

-- Menampilkan produk yang berwarna red, blue, atau black
SELECT Name, Color
FROM Production.Product
WHERE Color IN ('Red', 'Blue', 'Black')
ORDER BY Color ASC;
-- Cara lain: WHERE Color = 'Red' OR Color = 'Blue' OR Color = 'Black'

-- menampilkan data yang namanya mengandung kata 'road'
SELECT Name, ProductNumber
FROM Production.Product
WHERE Name LIKE '%Road%';

-- Agregrast dan pengelompokan
-- menghitung total baris
SELECT Color, COUNT(*) AS TotalProduk
FROM Production.Product
GROUP BY Color;

-- menghitung jumlah orderQty dan rata2 unit price dari tabel sales
SELECT ProductID, SUM(OrderQty) AS TotalTerjual, AVG(UnitPrice) AS RataRataHarga
FROM Sales.SalesOrderDetail
GROUP BY ProductID;

-- Grouping lebih dari satu kelompok
SELECT Color, Size, COUNT(*) AS Jumlah
FROM Production.Product
GROUP BY Color, Size;

-- filter agregast memakai having
-- menampilkan warna dan jumlahnya tetapi lebih dari 2
SELECT Color, COUNT(*) AS Jumlah
FROM Production.Product
GROUP BY Color
HAVING COUNT(*) > 2;

-- MENAMPILKAN WARNA
-- YANG ListPricenya lebih dari 500 dan Jumlah warnanya lebih dari 1
SELECT Color, COUNT(*) AS Jumlah
FROM Production.Product
WHERE ListPrice > 500 -- Filter baris dulu (Step 2)
GROUP BY Color -- Kelompokkan sisa baris (Step 3)
HAVING COUNT(*) > 1; -- Filter hasil kelompok (Step 4)

-- menampilkan data yang jumlah penjualannya lebih dari 10
SELECT ProductID, SUM(OrderQty) AS TotalQty
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING SUM(OrderQty) > 10;

-- Menampilkan data rata2 qty nya lebih dari 2
SELECT SpecialOfferID, AVG(OrderQty) AS RataRataBeli
FROM Sales.SalesOrderDetail
GROUP BY SpecialOfferID
HAVING AVG(OrderQty) > 2;

-- Menampilkan produk yang harganya lebih dari 3000 memakai max
SELECT Color
FROM Production.Product
GROUP BY Color
HAVING MAX(ListPrice) > 3000;

SELECT Color, ListPrice
FROM Production.Product;

--Advance select dan order by
--menampilkan jobtittle dari tabel employee tapi tidak boleh ada duplikat
SELECT DISTINCT JobTitle
FROM HumanResources.Employee;

SELECT Name, ListPrice
FROM Production.Product
ORDER BY ListPrice DESC;

SELECT TOP 5 Name, ListPrice
FROM Production.Product
ORDER BY ListPrice DESC;

--OFFSET FETCH
SELECT Name, ListPrice
FROM Production.Product
ORDER BY ListPrice DESC
OFFSET 2 ROWS
FETCH NEXT 4 ROWS ONLY;

SELECT TOP 3 Color, SUM(ListPrice) AS TotalNilaiStok
FROM Production.Product
WHERE ListPrice > 0 -- Step 2: Filter sampah
GROUP BY Color -- Step 3: Kelompokkan
ORDER BY TotalNilaiStok DESC;-- Step 6: Urutkan