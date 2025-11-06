--membuat databse
CREATE DATABASE UNPAS;

USE UNPAS;

--membuat tabel Mahasiswa
CREATE TABLE Mahasiswa(
	npm CHAR(9),
	nama VARCHAR(100),
	jurusan VARCHAR(50),
);

--melihat struktur table
EXEC sp_help 'Mahasiswa';
EXEC sp_help 'Dosen';

--mengubah tabel memakai ALTER TABLE
--mengubah kolom
ALTER TABLE Mahasiswa
ADD alamat VARCHAR(100) NOT NULL;

--mengubah tipe data
ALTER TABLE Mahasiswa
ALTER COLUMN nama VARCHAR(50);

--menambah constraint unique
ALTER TABLE Mahasiswa
ADD CONSTRAINT UQ_npm_Mahasiswa UNIQUE (npm);

--membuat tabel dosen
CREATE TABLE Dosen(
	nama VARCHAR(50),
	nip CHAR(9),
	alamat VARCHAR(100),
	prodi VARCHAR(50),
);

--menghapus tabel
DROP TABLE Dosen;

--mengapus database
DROP DATABASE UNPAS;

--menambahkan not null pada kolom nip
ALTER TABLE Dosen
ALTER COLUMN nip VARCHAR(9) NOT NULL;

--menambah pk di kolom nip pada tabel dosen
ALTER TABLE Dosen
ADD CONSTRAINT PK_nip_Dosen PRIMARY KEY (nip);

--menghapus constraint unique pada kolom npm
ALTER TABLE Mahasiswa
DROP CONSTRAINT UQ_npm_Mahasiswa;

--menambahkan not null pada kolom npm
ALTER TABLE Mahasiswa
ALTER COLUMN npm CHAR(9) NOT NULL;

--menambahkan pk di kolom npm pada tabel mahasiswa
ALTER TABLE Mahasiswa
ADD CONSTRAINT PK_npm_Mahasiswa PRIMARY KEY(npm);

--menambahkan nip ke tabel mahasiswa
ALTER TABLE Mahasiswa
ADD nip_pembimbing CHAR(9);

--menambah foriegn key di tabel mahasiswa
ALTER TABLE Mahasiswa
ADD CONSTRAINT FK_mahasiswa_dosen 
FOREIGN KEY (nip_pembimbing)
REFERENCES Dosen(nip);