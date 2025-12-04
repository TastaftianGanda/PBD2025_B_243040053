USE KampusDB;

--CROSS JOIN
--Menampilkan semua kombinasi  Mahasiswa dan Matakuliah
SELECT NamaMahasiswa FROM Mahasiswa
SELECT NamaMK FROM MataKuliah

SELECT M.NamaMahasiswa,MK.NamaMK
FROM Mahasiswa AS M
CROSS JOIN MataKuliah AS MK;

--menampilkan semua kombinasi dosen dan ruangan
SELECT D.NamaDosen, R.KodeRuangan
FROM Dosen D
CROSS JOIN Ruangan R

--LEFT JOIN
--Menampilkan semua mahasiswa termasuk yang belum mengambil KRS
SELECT M.NamaMahasiswa, K.MataKuliahID
FROM Mahasiswa M
LEFT JOIN KRS K ON M.MahasiswaID = K.MahasiswaID;

--Menampilkan semua mata kuliah, termasuk yang belum punya jadwal
SELECT MK.NamaMK, J.Hari
FROM MataKuliah MK 
LEFT JOIN JadwalKuliah J ON MK.MataKuliahID = J.MataKuliahID;

--RIGHT JOIN
--Menampilkan semua jadwal, walaupun tidak ada mata kuliah 
SELECT MK.NamaMK , J.Hari
FROM MataKuliah MK
RIGHT JOIN JadwalKuliah J ON MK.MataKuliahID = J.MataKuliahID;

--Menampilkan semua ruangan, apakah dipakai jadwal atau tidak
SELECT R.KodeRuangan, J.Hari 
FROM JadwalKuliah J 
RIGHT JOIN Ruangan R ON J.RuanganID = R.RuanganID;

--INNER JOIN
--Menampilkan nama mahasiswa dan matakuliahnya, tapi melalui tabel KRS
SELECT M.NamaMahasiswa, MK.NamaMK
FROM KRS K
INNER JOIN Mahasiswa M ON K.MahasiswaID = M.MahasiswaID
INNER JOIN MataKuliah MK ON K.MataKuliahID = MK.MataKuliahID

--menampilkan mata kuliah dan dosen pengampunya
SELECT MK.NamaMK, D.NamaDosen
FROM MataKuliah MK
JOIN Dosen D ON MK.DosenID = D.DosenID

--menampilkan jadwal lengkap
SELECT MK.NamaMK, D.NamaDosen, R.KodeRuangan, J.Hari
FROM JadwalKuliah J
INNER JOIN MataKuliah MK ON J.MataKuliahID = MK.MataKuliahID
INNER JOIN Dosen D ON J.DosenID = D.DosenID
INNER JOIN Ruangan R ON J.RuanganID = R.RuanganID;

--menampilkan nama mahasiswa, matkul, dan nilai akhirnya
SELECT M.NamaMahasiswa, MK.NamaMK, N.NilaiAkhir
FROM Nilai N 
INNER JOIN Mahasiswa M ON N.MahasiswaID = M.MahasiswaID
INNER JOIN MataKuliah MK ON N.MataKuliahID = MK.MataKuliahID;

--menampilkan dosen dan matakuliah yang dia ajar
SELECT D.NamaDosen, MK.NamaMK
FROM Dosen D
INNER JOIN MataKuliah MK ON D.DosenID = MK.DosenID;

--menampilkan nama mahasiswa dan nilai akhirnya
SELECT M.NamaMahasiswa, N.NilaiAkhir
FROM Mahasiswa M
INNER JOIN Nilai N ON M.MahasiswaID = N.MahasiswaID;

--SELF JOIN
--mencari pasangan mahasiswa dari prodi yang sama
SELECT A.NamaMahasiswa AS Mahasiswa1,
		B.NamaMahasiswa AS Mahasiswa2,
		A.Prodi
FROM Mahasiswa A
INNER JOIN Mahasiswa B ON A.Prodi = B.Prodi
WHERE A.MahasiswaID < B.MahasiswaID; --agar gaada pasangan yang sama

--Latihan 
--1
SELECT M.NamaMahasiswa, M.Prodi
FROM Mahasiswa M
INNER JOIN Nilai N ON M.MahasiswaID = N.MahasiswaID;

--2
SELECT D.NamaDosen, R.KodeRuangan
FROM Dosen D
INNER JOIN JadwalKuliah JK ON D.DosenID = JK.DosenID
INNER JOIN Ruangan R ON JK.RuanganID = R.RuanganID;

--3
SELECT M.NamaMahasiswa, MK.NamaMK, D.NamaDosen
FROM Mahasiswa M
INNER JOIN KRS K ON M.MahasiswaID = K.MahasiswaID
INNER JOIN MataKuliah MK ON K.MataKuliahID = MK.MataKuliahID
INNER JOIN Dosen D ON MK.DosenID = D.DosenID;

--4
SELECT MK.NamaMK, D.NamaDosen, JK.Hari
FROM JadwalKuliah JK
INNER JOIN MataKuliah MK ON JK.MataKuliahID = MK.MataKuliahID
INNER JOIN Dosen D ON JK.DosenID = D.DosenID;

--5
SELECT M.NamaMahasiswa, MK.NamaMK, D.NamaDosen, N.NilaiAkhir
FROM Nilai N
INNER JOIN Mahasiswa M ON N.MahasiswaID = M.MahasiswaID
INNER JOIN MataKuliah MK ON N.MataKuliahID = MK.MataKuliahID
INNER JOIN Dosen D ON MK.DosenID = D.DosenID;
