USE KampusDB;

--SUBQUERY
--Menampilkan dosen yang mengajar mata kuliah 
SELECT NamaDosen
FROM Dosen
WHERE DosenID = (
	SELECT DosenID
	FROM MataKuliah 
	WHERE NamaMK = 'Basis Data'
)

SELECT NamaDosen
FROM Dosen
WHERE DosenID = 1;

--Menampilkan mahasiswa yang memiliki nilai A
SELECT NamaMahasiswa
FROM Mahasiswa
WHERE MahasiswaID IN(
	SELECT MahasiswaID
	FROM Nilai
	WHERE NilaiAkhir = 'A'
);

--Menampilkan daftar prodi yang mahasiswanya lebih dari 2
SELECT Prodi, TotalMhs
FROM(
	SELECT Prodi, COUNT(*) AS TotalMhs
	FROM Mahasiswa
	GROUP BY Prodi
)AS HitungMhs
WHERE TotalMhs > 2;

--Menampilkan mata kuliah yang diajar oleh dosen dari informatika
SELECT NamaMK
FROM MataKuliah
WHERE DosenID IN(
	SELECT DosenID
	FROM Dosen
	WHERE Prodi = 'Informatika'
);

--CTE
--CTE untuk daftar mahasiswa dari informatika
WITH MhsIF AS(
	SELECT *
	FROM Mahasiswa
	WHERE Prodi = 'Informatika'
)
SELECT NamaMahasiswa, Angkatan
FROM MhsIF

--SET OPERATORS
--UNION: Menggabungkan daftar nama dosen dan nama mahasiswa
SELECT NamaDosen AS Nama
FROM Dosen
UNION
SELECT NamaMahasiswa
FROM Mahasiswa

--UNION ALL : Menggabungkan ruangan yang kapasitasnya >40 dan <40
SELECT KodeRuangan, Kapasitas
FROM Ruangan
WHERE Kapasitas > 40
UNION ALL
SELECT KodeRuangan, Kapasitas
FROM Ruangan
WHERE Kapasitas < 40

--INTERSECT : Mahasiswa yang ada di tabel KRS dan di tabel nilai
SELECT MahasiswaID
FROM KRS

SELECT MahasiswaID
FROM Nilai

SELECT MahasiswaID
FROM KRS
INTERSECT
SELECT MahasiswaID
FROM Nilai;

--EXCEPT : Mahasiswa yang terdapat di tabel KRS tetapi belum memiliki nilai
SELECT MahasiswaID
FROM KRS
EXCEPT
SELECT MahasiswaID
FROM Nilai;

--ROLLUP
--ROLLUP jumlah mahasiswa per prodi dan total keseleruhan
SELECT Prodi, COUNT(*) AS TotalMahasiswa
FROM Mahasiswa
GROUP BY(Prodi)

SELECT Prodi, COUNT(*) AS TotalMahasiswa
FROM Mahasiswa
GROUP BY ROLLUP(Prodi)

--CUBE
--CUBE jumlah mahasiswa berdasarkan prodi dan angkatan
SELECT Prodi, Angkatan, COUNT(*) AS TotalMahasiswa
FROM Mahasiswa
GROUP BY CUBE(Prodi, Angkatan)

--GROUPING SETS
--Total mahasiswa berdasarkan prodi, angkatan, dan total keseleruhan
SELECT Prodi, Angkatan, COUNT(*) AS TotalMahasiswa
FROM Mahasiswa
GROUP BY GROUPING SETS(
	(Prodi), --subtotal per prodi
	(Angkatan), --subtotal per angkatan
	() -- total keseleruhan
)

--windows Function
--Menampilkan nama mahasiswa dengan total mahasiswa di prodi yang sama
SELECT NamaMahasiswa, Prodi, COUNT(*)
FROM Mahasiswa

SELECT
	NamaMahasiswa,
	Prodi,
	COUNT(*) OVER(PARTITION BY Prodi) AS TotalMahasiswaPerProdi
FROM Mahasiswa
