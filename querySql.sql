USE master
GO
IF (EXISTS(SELECT * FROM sys.sysdatabases WHERE name='QuanLySinhVien'))
DROP DATABASE QuanLySinhVien
go
create database QuanLySinhVien;
GO

USE QuanLySinhVien
GO
create table sinhvien (
	masv char(4) primary key,
	hoten nvarchar(30) not null,
	dienthoai nvarchar(12) not null,
	diachi nvarchar(30) not null
) 
go
create table monhoc (
	mamon char(4) primary key,
	tenmon nvarchar(30) not null,
	hocky nvarchar(12) not null
)
go
create table diem (
	masv char(4),
	mamon char(4),
	diemthi float,
	constraint pk_diem primary key (masv, mamon),
	constraint fk_masv_diem foreign key (masv) references sinhvien(masv),
	constraint fk_mamon_diem foreign key (mamon) references monhoc(mamon)
)
go

-- cau 2: Nhap du lieu cho 3 bang tren
insert into sinhvien values ('sv01', 'nguyen van a','0123456', 'hanoi')
insert into sinhvien values ('sv02', 'tran van b','0121212', 'hanam')
insert into sinhvien values ('sv03', N'Lê Ngọc Huyền','0212546', 'namdinh')

insert into monhoc values ('m001', 'lap trinh can ban', 'hoc ky1')
insert into monhoc values ('m002', N'Lập trình Windows', 'hoc ky 4')
insert into monhoc values ('m003', N'Cơ sở dữ liệu', 'hoc ky 4')

insert into diem values ('sv01', 'm002', 9)
insert into diem values ('sv02','m002', 4)
insert into diem values ('sv03', 'm003', 8)

--cau3:tao Database Diagram

--cau4: 
delete from diem
		where masv = (select masv from sinhvien where hoten = N'Lê Ngọc Huyền' )
		and mamon = (select mamon from monhoc where tenmon = N'Cơ sở dữ liệu' )


--PHAN 2
--cau5: 
select sinhvien.masv, hoten, diemthi from sinhvien inner join diem on sinhvien.masv = diem.masv
					   inner join monhoc on monhoc.mamon = diem.mamon
		 where tenmon = N'Lập trình Windows'


--cau6:
select * from monhoc where hocky = (select hocky from monhoc where tenmon = N'Cơ sở dữ liệu' )
					and tenmon <> N'Cơ sở dữ liệu'


--cau7:
select * from monhoc where mamon not in (select mamon from diem)




--cau8: 
select tenmon, hocky, MAX(diemthi) as 'diem cao nhat' from monhoc inner join diem on monhoc.mamon = diem.mamon
		 group by diem.mamon, tenmon, hocky