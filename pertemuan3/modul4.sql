--menampilkan semua kolom dan semua data dari tabel produk--
SELECT * FROM Production.Product;

--menampilkan Name,Product Number, dan ListPrice--
SELECT Name, ProductNumber, ListPrice FROM Production.Product;

-- menampilkan data menggunakan alias kolom --
SELECT  Name AS [Nama Barang], ListPrice AS 'Harga Jual' FROM Production.Product;

--menampilkan HargaBaru = ListPrice *1.1
SELECT Name, ListPrice, (ListPrice * 1.1) AS HargaBaru FROM Production.Product;

--menampikan data dengan menggabungkan string
SELECT Name + '(' + ProductNumber +')' AS ProdukLengkap FROM Production.Product;

--filterisasi data
--Menampilkan produk yang berwarna 'red'
SELECT Name, Color, ListPrice FROM Production.Product WHERE color = 'red';

--menampilkan produk yang ListPricenya lebih dari 1000
SELECT Name, ListPrice FROM Production.Product WHERE ListPrice < 1000;

--menampilkan produk yang berwana BLACK dan listpricenya lebih dari 500
SELECT Name, Color, ListPrice FROM Production.Product WHERE color = 'black' AND ListPrice > 500;

--menampilkan produk yang berwarna red, blue, atau black
SELECT Name, Color FROM Production.Product WHERE Color IN ('red','blue','black');

--meanmpilkan produk yang namanya menganndung kata 'road'
SELECT Name, ProductNumber FROM Production.Product WHERE Name LIKE '%Bike%';

--agregasi dan pengelompokkan
--menghitung total baris
SELECT COUNT (*) AS TotalProduk FROM Production.Product; 

--menampilkan nama produk dan jumlahnya
SELECT Color, COUNT (*) AS TotalProduk FROM Production.Product GROUP BY Color;

--menampilkan ProductID, Jumlah OrderQty, dan rata2 UnitPrice
SELECT ProductID, SUM(OrderQty) AS TotalTerjual, AVG (UnitPrice) AS RataRataHarga FROM Sales.SalesOrderDetail GROUP BY ProductID;

SELECT * FROM Sales.SalesOrderDetail

--menampilkan data dengan grouping lebih dari satu kolom
SELECT Color, Size, COUNT(*) AS Jumlah FROM Production.Product GROUP BY Color, Size;

SELECT * FROM Production.Product

--Filter Hasil Agregasi
--menampilkan warna produk yang jumlahnya lebih dari 20
SELECT Color, COUNT(*) AS jumlah FROM Production.Product GROUP BY Color HAVING COUNT(*) > 2;

--menampilkan warna produk yang ListPricenya > 500 dan jumlahnya > 10
SELECT Color, COUNT(*) AS jumlah FROM Production.Product WHERE ListPrice > 500 GROUP BY Color HAVING COUNT(*) > 1;

--menampilkan ProductID yang jumlah OrderQty lebih dari 100
SELECT ProductID, SUM (OrderQty) AS RataRataBeli From Sales.SalesOrderDetail GROUP BY ProductID HAVING SUM (OrderQty) > 10;

--menampilkan SpeciaLOfferID yang rata2 OrderQty kurang dari 2 
SELECT SpecialOfferID, AVG(OrderQty) AS RataRataBeli FROM Sales.SalesOrderDetail GROUP BY SpecialOfferID HAVING AVG(OrderQty) > 2;

--menampilkan warna yang ListPricenya lebih dari 3000 menggunakan MAX
SELECT Color FROM Production.Product GROUP BY Color HAVING MAX(ListPrice) > 3000;

--Advanced Select dan Order By
--Menampilkan JobTitle tanpa duplikat
SELECT DISTINCT JobTitle FROM HumanResources.Employee;

SELECT JobTitle FROM HumanResources.Employee;

--menampilkan 5 nama produk termahal
SELECT TOP 5 Name, ListPrice FROM Production.Product ORDER BY ListPrice DESC;

--OFFSET FETCH
SELECT Name, ListPrice FROM Production.Product ORDER BY ListPrice DESC OFFSET 2 ROWS FETCH NEXT 4 ROWS ONLY;

SELECT Name, ListPrice FROM Production.Product ORDER BY ListPrice DESC

SELECT TOP 3 Color , SUM(ListPrice) AS TotalNilaiStok FROM Production.Product WHERE ListPrice > 0 GROUP BY Color ORDER BY TotalNilaiStok DESC;

--Tugas Mandiri 
SELECT * FROM Sales.SalesOrderDetail;
--1
SELECT ProductID, SUM(LineTotal) AS TotalUang FROM Sales.SalesOrderDetail GROUP BY ProductID
--2
SELECT ProductID,OrderQty,UnitPrice,LineTotal FROM Sales.SalesOrderDetail WHERE OrderQty >= 2;
--3
SELECT ProductID,SUM(LineTotal) AS TotalPendapatan FROM Sales.SalesOrderDetail WHERE OrderQty >= 2 GROUP BY ProductID;
--4
SELECT ProductID, SUM(LineTotal) AS TotalUang FROM Sales.SalesOrderDetail WHERE OrderQty >= 2 GROUP BY ProductID HAVING SUM(LineTotal) > 5000 ORDER BY TotalUang DESC;
--5
SELECT ProductID, LineTotal FROM Sales.SalesOrderDetail ORDER BY LineTotal DESC;
--6
SELECT ProductID, SUM(LineTotal) AS TotalUang FROM Sales.SalesOrderDetail WHERE OrderQty >= 2 GROUP BY ProductID HAVING SUM(LineTotal) > 50 ORDER BY TotalUang DESC OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;
