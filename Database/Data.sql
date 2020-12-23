﻿CREATE DATABASE dbQuanLyQuanCafe
GO

USE dbQuanLyQuanCafe
GO
---Bảng Loại tài khoản---
CREATE TABLE LoaiTaiKhoan
(
	MaLoaiTaiKhoan NVARCHAR(100) PRIMARY KEY, -- 1:Quản lý, 2:Nhân viên thu ngân, 3:Nhân viên kho, 4:Nhân viên phục vụ
	TenLoaiTaiKhoan NVARCHAR(100) NOT NULL
)
GO

CREATE TABLE NhanVien
(
	MaNhanVien NVARCHAR(100) PRIMARY KEY,
	TenNhanVien NVARCHAR(100) NOT NULL,
	TenDangNhap NVARCHAR(100) NOT NULL UNIQUE,
	MatKhau NVARCHAR(100) NOT NULL DEFAULT 123,
	MaLoaiTaiKhoan NVARCHAR(100) NOT NULL,
	GioiTinh NVARCHAR(50) NOT NULL,
	SDT NVARCHAR(50),
	DiaChi NVARCHAR(200),
	FOREIGN KEY (MaLoaiTaiKhoan) REFERENCES LoaiTaiKhoan(MaLoaiTaiKhoan)
	
)
GO

CREATE TABLE ViTri
(
	MaViTri NVARCHAR(100) PRIMARY KEY,
	TenViTri NVARCHAR(50) NOT NULL,
)
GO
CREATE TABLE Ban
(
	MaBan NVARCHAR(100) PRIMARY KEY,
	TenBan NVARCHAR (100) NOT NULL DEFAULT N'Bàn chưa đặt tên',
	MaViTri NVARCHAR(100) NOT NULL DEFAULT 1, --1 :Tầng 1, 2:Tầng 2, ... 
	TrangThai NVARCHAR(50) NOT NULL DEFAULT N'Trống' --Trống, Có người,
	FOREIGN KEY (MaViTri) REFERENCES ViTri(MaViTri)
)
GO

CREATE TABLE DanhMucDoUong
(
	MaDanhMuc NVARCHAR(100) PRIMARY KEY,
	TenDanhMuc NVARCHAR (100) NOT NULL DEFAULT N'Chưa đặt tên'
)
GO

CREATE TABLE DoUong
(
	MaDoUong NVARCHAR(100) PRIMARY KEY,
	TenDoUong NVARCHAR (100) NOT NULL DEFAULT N'Chưa đặt tên',
	MaDanhMuc NVARCHAR(100) NOT NULL,
	Gia INT NOT NULL DEFAULT 0,
	HinhMinhHoa NVARCHAR(100),
	FOREIGN KEY (MaDanhMuc) REFERENCES DanhMucDoUong(MaDanhMuc)
)
GO
CREATE TABLE LoaiKhachHang
(
	MaLoaiKhachHang NVARCHAR(100) PRIMARY KEY,
	TenLoaiKhachHang NVARCHAR(100) NOT NULL
)
GO
CREATE TABLE KhachHang
(
	MaKhachHang NVARCHAR(100) PRIMARY KEY,
	TenKhachHang NVARCHAR(100) NOT NULL,
	MaLoaiKhachHang NVARCHAR(100) NOT NULL,
	SoDienThoai NVARCHAR(100) NOT NULL UNIQUE,
	DiemTichLuy INT DEFAULT 0,
	DiaChi NVARCHAR(100) NOT NULL,	
	FOREIGN KEY (MaLoaiKhachHang) REFERENCES LoaiKhachHang(MaLoaiKhachHang)
)
GO

CREATE TABLE HoaDon
(
	MaHoaDon NVARCHAR(100) PRIMARY KEY,
	MaBan NVARCHAR(100) NOT NULL,
	MaNhanVien NVARCHAR(100),
	MaKhachHang NVARCHAR(100),
	NgayLap DATE,
	GioVao TIME, 
	GioRa TIME,
	TrangThai NVARCHAR(100) NOT NULL DEFAULT N'Chưa thanh toán', --(Mặc định là chưa thanh toán)
	GiamGia INT,
	TongTien INT,
	 
	FOREIGN KEY (MaBan) REFERENCES Ban(MaBan),
	FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien),
	FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang)
)
Go

CREATE TABLE ChiTietHoaDon
(
	MaCTHD NVARCHAR(100) PRIMARY KEY,
	MaHoaDon NVARCHAR(100) NOT NULL,
	MaDoUong NVARCHAR(100) NOT NULL,
	SoLuong INT NOT NULL DEFAULT 1, --Số lượng
	ThanhTien INT,
	FOREIGN KEY (MaHoaDon) REFERENCES HoaDon(MaHoaDon),
	FOREIGN KEY (MaDoUong) REFERENCES DoUong(MaDoUong)
)
GO

CREATE TABLE NhaCungCap
(
	MaNCC NVARCHAR(100) PRIMARY KEY,
	TenNCC NVARCHAR(100) NOT NULL,
	DiaChi NVARCHAR(100) NOT NULL,
)
GO

CREATE TABLE NguyenLieu
(
	MaNguyenLieu NVARCHAR(100) PRIMARY KEY,
	TenNguyenLieu NVARCHAR(100) NOT NULL,
	DonViTinh NVARCHAR(100) NOT NULL,
	SoLuongTon INT NOT NULL,
)
GO

CREATE TABLE CongThuc
(
	MaDoUong NVARCHAR(100) NOT NULL,
	MaNguyenLieu NVARCHAR(100) NOT NULL,
	SoLuong INT NOT NULL,
	PRIMARY KEY (MaDoUong, MaNguyenLieu),
	FOREIGN KEY (MaDoUOng) REFERENCES DoUong(MaDoUong),
	FOREIGN KEY (MaNguyenLieu) REFERENCES NguyenLieu(MaNguyenLieu)
)
GO


CREATE TABLE PhieuNhap
(
	MaPhieuNhap NVARCHAR(100) PRIMARY KEY,	
	MaNhanVien NVARCHAR(100) NOT NULL,
	MaNCC NVARCHAR(100) NOT NULL,	
	NgayLap DATE,
	TongTien INT,	
	FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien),
	FOREIGN KEY (MaNCC) REFERENCES NhaCungCap(MaNCC)
)
GO

CREATE TABLE ChiTietPhieuNhap
(
	MaCTPN NVARCHAR(100) PRIMARY KEY,
	MaPhieuNhap NVARCHAR(100) NOT NULL,
	MaNguyenLieu NVARCHAR(100) NOT NULL,
	DonGiaNhap INT NOT NULL,
	SoLuong INT NOT NULL DEFAULT 1,
	ThanhTien INT,
	FOREIGN KEY (MaPhieuNhap) REFERENCES PhieuNhap(MaPhieuNhap),
	FOREIGN KEY (MaNguyenLieu) REFERENCES NguyenLieu(MaNguyenLieu)
)
GO





---------------------------------------------------------------------------------------------------------------------------------
-----------------Loại tài khoản(Phân quyền)-------------
INSERT INTO LoaiTaiKhoan VALUES(N'1', N'Quản lý')
INSERT INTO LoaiTaiKhoan VALUES(N'2', N'Nhân viên thu ngân')
INSERT INTO LoaiTaiKhoan VALUES(N'3', N'Nhân viên kho')
INSERT INTO LoaiTaiKhoan VALUES(N'4', N'Nhân viên phục vụ')

----------------NhanVien--------------------------------
INSERT INTO NhanVien VALUES(N'NV100', N'admin', N'admin', N'1', 1, N'Nam', N'0979510945', N'TP HCM')
INSERT INTO NhanVien VALUES(N'NV101', N'Nguyễn Tiểu Phung', N'phung', N'1', 2, N'Nam', N'0979510946', N'Q12, TPHCM')
INSERT INTO NhanVien VALUES(N'NV102', N'Huỳnh Đức Anh Tuấn', N'tuan', N'1', 3, N'Nam', N'0979510953', N'Q2, TPHCM')



-----------------------Danh mục đồ uống-----------------
INSERT INTO DanhMucDoUong VALUES(N'CF', N'Coffee')
INSERT INTO DanhMucDoUong VALUES(N'ST', N'Sinh Tố')
INSERT INTO DanhMucDoUong VALUES(N'TR', N'Trà')
INSERT INTO DanhMucDoUong VALUES(N'TS', N'Trà Sữa')
INSERT INTO DanhMucDoUong VALUES(N'CC', N'Cacao')
INSERT INTO DanhMucDoUong VALUES(N'NE', N'Nước Ép')
INSERT INTO DanhMucDoUong VALUES(N'YA', N'Yaourt')
INSERT INTO DanhMucDoUong VALUES(N'NN', N'Nước Ngọt')
INSERT INTO DanhMucDoUong VALUES(N'KE', N'Kem')
---------------------DoUong-----------------
/*Coffee*/
INSERT INTO DoUong VALUES(N'CF100', N'Coffee Đen Nóng', N'CF',18000,N'caphedennong.jpg')
INSERT INTO DoUong VALUES(N'CF101', N'Coffee Đen Đá', N'CF',18000,N'caphedenda.jpg')
INSERT INTO DoUong VALUES(N'CF102', N'Coffee Sữa Nóng', N'CF',20000,N'caphesuanong.jpg')
INSERT INTO DoUong VALUES(N'CF103', N'Coffee Sữa Đá', N'CF',20000,N'caphesuada.jpg')
INSERT INTO DoUong VALUES(N'CF104', N'Coffee Macchiato', N'CF',30000,N'cafelattemacchiato.jpg')
INSERT INTO DoUong VALUES(N'CF105', N'Coffee Cappuchino', N'CF',32000,N'caphecapuchino.jpg')
INSERT INTO DoUong VALUES(N'CF106', N'Coffee Mocha', N'CF',32000,N'caphemocha.jpg')
INSERT INTO DoUong VALUES(N'CF107', N'Coffee Espresso', N'CF',36000,N'capheespresso.jpg')
INSERT INTO DoUong VALUES(N'CF108', N'Coffee Tiramisu', N'CF',36000,N'caphetiramisu.jpg')

/*Sinh tố*/
INSERT INTO DoUong VALUES(N'ST100', N'Sinh tố Mãng Cầu', N'ST',28000,N'sinhtomangcau.jpg')
INSERT INTO DoUong VALUES(N'ST101', N'Sinh tố Chanh Tuyết', N'ST',28000,N'sinhtochanhtuyet.jpg')
INSERT INTO DoUong VALUES(N'ST102', N'Sinh tố Sapoche', N'ST',30000,N'sinhtosapoche.jpg')
INSERT INTO DoUong VALUES(N'ST103', N'Sinh tố Dâu', N'ST',30000,N'sinhtodau.jpg')
INSERT INTO DoUong VALUES(N'ST104', N'Sinh tố Bơ', N'ST',28000,N'sinhtobo.jpg')
INSERT INTO DoUong VALUES(N'ST105', N'Sinh tố Việt Quất', N'ST',34000,N'sinhtovietquat.jpg')
INSERT INTO DoUong VALUES(N'ST106', N'Sinh tố Xoài', N'ST',34000,N'sinhtoxoai.jpg')

/*Trà*/
INSERT INTO DoUong VALUES(N'TR100', N'Trà Đường', N'TR',15000,N'traduong.jpg')
INSERT INTO DoUong VALUES(N'TR101', N'Trà Bạc Hà', N'TR',18000,N'trabacha.jpg')
INSERT INTO DoUong VALUES(N'TR102', N'Trà Hoa Cúc', N'TR',18000,N'trahoacuc.jpg')
INSERT INTO DoUong VALUES(N'TR103', N'Trà Gừng', N'TR',25000,N'tragung.jpg')
INSERT INTO DoUong VALUES(N'TR104', N'Trà Chanh', N'TR',25000,N'trachanh.jpg')
INSERT INTO DoUong VALUES(N'TR105', N'Trà Đào', N'TR',25000,N'tradao.jpg')
INSERT INTO DoUong VALUES(N'TR106', N'Trà Xanh', N'TR',25000,N'traxanh.jpg')

/*Trà Sữa*/
INSERT INTO DoUong VALUES(N'TS100', N'Trà Sữa Macchiato', N'TS',25000,N'trasuamatchamacchiato.jpg')
INSERT INTO DoUong VALUES(N'TS101', N'Trà Sữa Trân Châu', N'TS',25000,N'trasuatranchau.jpg')
INSERT INTO DoUong VALUES(N'TS102', N'Trà Sữa Dâu', N'TS',25000,N'trasuadau.jpg')
INSERT INTO DoUong VALUES(N'TS103', N'Trà Sữa Socola Kem', N'TS',25000,N'trasuasocolakem.jpg')
INSERT INTO DoUong VALUES(N'TS104', N'Trà Sữa Matcha', N'TS',25000,N'trasuamatcha.jpg')
INSERT INTO DoUong VALUES(N'TS105', N'Trà Sữa Đào', N'TS',30000,N'trasuadao.jpg')
INSERT INTO DoUong VALUES(N'TS106', N'Trà Sữa Khoai Môn', N'TS',28000,N'trasuakhoaimon.jpg')
INSERT INTO DoUong VALUES(N'TS107', N'Trà Sữa Oreo', N'TS',26000,N'trasuaoreo.jpg')
INSERT INTO DoUong VALUES(N'TS108', N'Trà Sữa Sương Sáo', N'TS',25000,N'trasuasuongsao.jpg')


/*Cacao*/
INSERT INTO DoUong VALUES(N'CC100', N'Cacao Nóng', N'CC',25000,N'cacaonong.jpg')
INSERT INTO DoUong VALUES(N'CC101', N'Cacao Bạc Hà', N'CC',25000,N'cacaobacha.jpg')
INSERT INTO DoUong VALUES(N'CC102', N'Cacao Kem Sữa', N'CC',30000,N'cacaokemsua.jpg')
INSERT INTO DoUong VALUES(N'CC103', N'Cacao Sữa Đá', N'CC',30000,N'cacaosuada.jpg')


/*Nước ép*/
INSERT INTO DoUong VALUES(N'NE100', N'Nước Ép Dưa Hấu', N'NE',22000,N'nuocepduahau.jpg')
INSERT INTO DoUong VALUES(N'NE101', N'Nước Ép Thơm', N'NE',22000,N'nuocepthom.jpg')
INSERT INTO DoUong VALUES(N'NE102', N'Nước Ép Cà Rốt', N'NE',25000,N'nuocepcarot.jpg')
INSERT INTO DoUong VALUES(N'NE103', N'Nước Ép Cam', N'NE',25000,N'nuocepcam.jpg')
INSERT INTO DoUong VALUES(N'NE104', N'Nước Ép Chanh Dây', N'NE',25000,N'nuocepchanhday.jpg')
INSERT INTO DoUong VALUES(N'NE105', N'Nước Ép Kiwi', N'NE',25000,N'nuocepkiwi.jpg')

/*Yaourt*/
INSERT INTO DoUong VALUES(N'YA100', N'Yaourt Đá', N'YA',32000,N'yaourtda.jpg')
INSERT INTO DoUong VALUES(N'YA101', N'Yaourt Việt Quất', N'YA',35000,N'yaourtvietquat.jpg')
INSERT INTO DoUong VALUES(N'YA102', N'Yaourt Kiwi', N'YA',35000,N'yaourtkiwi.jpg')
INSERT INTO DoUong VALUES(N'YA103', N'Yaourt Cam', N'YA',38000,N'yaourtcam.jpg')
INSERT INTO DoUong VALUES(N'YA104', N'Yaourt Chanh Đá', N'YA',36000,N'yaourtchanhda.jpg')
INSERT INTO DoUong VALUES(N'YA105', N'Yaourt Coffee', N'YA',32000,N'yaourtcoffee.jpg')


/*Nước ngọt*/
INSERT INTO DoUong VALUES(N'NN100', N'Coca', N'NN',12000,N'coca.jpg')
INSERT INTO DoUong VALUES(N'NN101', N'Pepsi', 'NN',12000,N'pepsi.jpg')
INSERT INTO DoUong VALUES(N'NN102', N'Mirinda Soda Kem', N'NN',10000,N'mirinda.jpg')
INSERT INTO DoUong VALUES(N'NN103', N'Revive', N'NN',10000,N'revive.jpg')
INSERT INTO DoUong VALUES(N'NN104', N'Fanta Cam', N'NN',10000,N'fanta.jpg')
INSERT INTO DoUong VALUES(N'NN105', N'Sprite', N'NN',10000,N'sprite.jpg') 
INSERT INTO DoUong VALUES(N'NN106', N'Sting Dâu', N'NN',12000,N'sting.jpg')
INSERT INTO DoUong VALUES(N'NN107', N'Soda không đường', N'NN',15000,N'soda.jpg')
INSERT INTO DoUong VALUES(N'NN108', N'Seven Up', N'NN',12000,N'sevenup.jpg') 


/*Kem*/
INSERT INTO DoUong VALUES(N'KE100', N'Kem Bơ', N'KE',20000,N'kembo.jpg')
INSERT INTO DoUong VALUES(N'KE101', N'Kem Dâu', N'KE',20000,N'kemdau.jpg')
INSERT INTO DoUong VALUES(N'KE102', N'Kem Dừa', N'KE',20000,N'kemdua.jpg')
INSERT INTO DoUong VALUES(N'KE103', N'Kem Khoai Môn', N'KE',25000,N'kemkhoaimon.jpg')
INSERT INTO DoUong VALUES(N'KE104', N'Kem Socola', N'KE',25000,N'kemsocola.jpg')
INSERT INTO DoUong VALUES(N'KE105', N'Kem Thanh Long', N'KE',18000,N'kemthanhlong.jpg')
INSERT INTO DoUong VALUES(N'KE106', N'Kem Vani', N'KE',25000,N'kemvani.jpg')
INSERT INTO DoUong VALUES(N'KE107', N'Kem Mít', N'KE',18000,N'kemmit.jpg')
INSERT INTO DoUong VALUES(N'KE108', N'Kem Cuộn', N'KE',25000,N'kemcuon.jpg')


------ViTri------------
INSERT INTO ViTri VALUES(N'1' , N'Tầng 1')
INSERT INTO ViTri VALUES(N'2' , N'Tầng 2')
INSERT INTO ViTri VALUES(N'3' , N'Tầng 3')


------Ban--------------
INSERT INTO Ban VALUES(N'1100', N'Bàn A1',1,N'Trống')
INSERT INTO Ban VALUES(N'1101', N'Bàn A2',1,N'Trống')
INSERT INTO Ban VALUES(N'1102', N'Bàn A3',1,N'Trống')
INSERT INTO Ban VALUES(N'1103', N'Bàn A4',1,N'Trống')
INSERT INTO Ban VALUES(N'1104', N'Bàn A5',1,N'Trống')
INSERT INTO Ban VALUES(N'1105', N'Bàn A6',1,N'Trống')
INSERT INTO Ban VALUES(N'1106', N'Bàn A7',1,N'Trống')
INSERT INTO Ban VALUES(N'1107', N'Bàn A8',1,N'Trống')
INSERT INTO Ban VALUES(N'1108', N'Bàn A9',1,N'Trống')
INSERT INTO Ban VALUES(N'1109', N'Bàn A10',1,N'Trống')
INSERT INTO Ban VALUES(N'1110', N'Bàn A11',1,N'Trống')
INSERT INTO Ban VALUES(N'1111', N'Bàn A12',1,N'Trống')
INSERT INTO Ban VALUES(N'1112', N'Bàn A13',1,N'Trống')
INSERT INTO Ban VALUES(N'1113', N'Bàn A14',1,N'Trống')
INSERT INTO Ban VALUES(N'1114', N'Bàn A15',1,N'Trống')
INSERT INTO Ban VALUES(N'1115', N'Bàn A16',1,N'Trống')
INSERT INTO Ban VALUES(N'1116', N'Bàn A17',1,N'Trống')
INSERT INTO Ban VALUES(N'1117', N'Bàn A18',1,N'Trống')
INSERT INTO Ban VALUES(N'1118', N'Bàn A19',1,N'Trống')
INSERT INTO Ban VALUES(N'1119', N'Bàn A20',1,N'Trống')

INSERT INTO Ban VALUES(N'2100', N'Bàn B1',2,N'Trống')
INSERT INTO Ban VALUES(N'2101', N'Bàn B2',2,N'Trống')
INSERT INTO Ban VALUES(N'2102', N'Bàn B3',2,N'Trống')
INSERT INTO Ban VALUES(N'2103', N'Bàn B4',2,N'Trống')
INSERT INTO Ban VALUES(N'2104', N'Bàn B5',2,N'Trống')
INSERT INTO Ban VALUES(N'2105', N'Bàn B6',2,N'Trống')
INSERT INTO Ban VALUES(N'2106', N'Bàn B7',2,N'Trống')
INSERT INTO Ban VALUES(N'2107', N'Bàn B8',2,N'Trống')
INSERT INTO Ban VALUES(N'2108', N'Bàn B9',2,N'Trống')
INSERT INTO Ban VALUES(N'2109', N'Bàn B10',2,N'Trống')
INSERT INTO Ban VALUES(N'2110', N'Bàn B11',2,N'Trống')
INSERT INTO Ban VALUES(N'2111', N'Bàn B12',2,N'Trống')
INSERT INTO Ban VALUES(N'2112', N'Bàn B13',2,N'Trống')
INSERT INTO Ban VALUES(N'2113', N'Bàn B14',2,N'Trống')
INSERT INTO Ban VALUES(N'2114', N'Bàn B15',2,N'Trống')
INSERT INTO Ban VALUES(N'2115', N'Bàn B16',2,N'Trống')
INSERT INTO Ban VALUES(N'2116', N'Bàn B17',2,N'Trống')
INSERT INTO Ban VALUES(N'2117', N'Bàn B18',2,N'Trống')
INSERT INTO Ban VALUES(N'2118', N'Bàn B19',2,N'Trống')
INSERT INTO Ban VALUES(N'2119', N'Bàn B20',2,N'Trống')

INSERT INTO Ban VALUES(N'3100', N'Bàn C1',3,N'Trống')
INSERT INTO Ban VALUES(N'3101', N'Bàn C2',3,N'Trống')
INSERT INTO Ban VALUES(N'3102', N'Bàn C3',3,N'Trống')
INSERT INTO Ban VALUES(N'3103', N'Bàn C4',3,N'Trống')
INSERT INTO Ban VALUES(N'3104', N'Bàn C5',3,N'Trống')
INSERT INTO Ban VALUES(N'3105', N'Bàn C6',3,N'Trống')
INSERT INTO Ban VALUES(N'3106', N'Bàn C7',3,N'Trống')
INSERT INTO Ban VALUES(N'3107', N'Bàn C8',3,N'Trống')
INSERT INTO Ban VALUES(N'3108', N'Bàn C9',3,N'Trống')
INSERT INTO Ban VALUES(N'3109', N'Bàn C10',3,N'Trống')
INSERT INTO Ban VALUES(N'3110', N'Bàn C11',3,N'Trống')
INSERT INTO Ban VALUES(N'3111', N'Bàn C12',3,N'Trống')
INSERT INTO Ban VALUES(N'3112', N'Bàn C13',3,N'Trống')
INSERT INTO Ban VALUES(N'3113', N'Bàn C14',3,N'Trống')
INSERT INTO Ban VALUES(N'3114', N'Bàn C15',3,N'Trống')
INSERT INTO Ban VALUES(N'3115', N'Bàn C16',3,N'Trống')
INSERT INTO Ban VALUES(N'3116', N'Bàn C17',3,N'Trống')
INSERT INTO Ban VALUES(N'3117', N'Bàn C18',3,N'Trống')
INSERT INTO Ban VALUES(N'3118', N'Bàn C19',3,N'Trống')
INSERT INTO Ban VALUES(N'3119', N'Bàn C20',3,N'Trống')

------LoaiKhachHang----------------
INSERT INTO LoaiKhachHang VALUES(N'KVL', N'Khách vãng lai')
INSERT INTO LoaiKhachHang VALUES(N'KHTN', N'Khách hàng tiềm năng')
INSERT INTO LoaiKhachHang VALUES(N'KHTT', N'Khách hàng thân thiết')

------KhachHang--------------------
INSERT INTO KhachHang VALUES(N'KH100', N'Khách vãng lai',  N'KVL', N'none', 0, N'none')
INSERT INTO KhachHang VALUES(N'KH101', N'Nông Ngọc Hoàng', N'KHTN', N'0654147985', 1, N'H.Củ Chi, TPHCM')
INSERT INTO KhachHang VALUES(N'KH102', N'Phan Đức Tài', N'KHTN', N'0452125987', 3, N'H.Bình Chánh, TPHCM')
INSERT INTO KhachHang VALUES(N'KH103', N'Đinh Hoàng Hiếu', N'KHTN', N'0625146369', 4, N'H.Dầu Tiếng, Bình Dương')
INSERT INTO KhachHang VALUES(N'KH104', N'Phạm Văn Quân', N'KHTT', N'0625146368', 0, N'Q.Tân Phú, TPHCM')
INSERT INTO KhachHang VALUES(N'KH105', N'Phan Tấn Trung', N'KHTT', N'0982436460', 1, N'Q.Tân Bình, TPHCM')
INSERT INTO KhachHang VALUES(N'KH106', N'Nguyễn Thị Thuỳ Hương', N'KHTT', N'0397511287', 1, N'Q.12, TPHCM')
INSERT INTO KhachHang VALUES(N'KH107', N'Nguyễn Thị Trà My', N'KHTT', N'039754518', 1, N'Q.1, TPHCM')
INSERT INTO KhachHang VALUES(N'KH108', N'Trần Văn Giàu', N'KHTT', N'0986733535', 2, N'Q.12, TPHCM')
INSERT INTO KhachHang VALUES(N'KH109', N'Nguyễn Minh Trí', N'KHTT', N'0916239586', 1, N'Q.1, TPHCM')
INSERT INTO KhachHang VALUES(N'KH110', N'Phạm Hồng Minh', N'KHTT', N'0934138041', 2, N'Q.Tân Phú, TPHCM')
INSERT INTO KhachHang VALUES(N'KH111', N'Phan Hoàng Gia', N'KHTT', N'0983413614', 3, N'Q.5, TPHCM')
INSERT INTO KhachHang VALUES(N'KH112', N'Lê Hồng Phúc', N'KHTT', N'0986777435', 1, N'Q.6, TPHCM')
INSERT INTO KhachHang VALUES(N'KH113', N'Nguyễn Minh Đăng', N'KHTN', N'0937754154', 0, N'H.Bình Chánh, TPHCM')
INSERT INTO KhachHang VALUES(N'KH114', N'Hồ Đức Thành', N'KHTN', N'0986755444', 1, N'Q.11, TPHCM')
INSERT INTO KhachHang VALUES(N'KH115', N'Lê Giang', N'KHTN', N'0396511287', 2, N'H.Bình Chánh, TPHCM')
INSERT INTO KhachHang VALUES(N'KH116', N'Lâm Thị Loan', N'KHTN', N'0395117331', 1, N'H.Bình Chánh, TPHCM')
INSERT INTO KhachHang VALUES(N'KH117', N'Nguyễn Thị Hồng Gấm', N'KHTN', N'0986422345', 0, N'H.Bình Chánh, TPHCM')
INSERT INTO KhachHang VALUES(N'KH118', N'Nguyễn Thị Hương', N'KHTN', N'0937168586', 1, N'H.Bình Chánh, TPHCM')
INSERT INTO KhachHang VALUES(N'KH119', N'Phạm Lê Gia Bảo', N'KHTN', N'0982444365', 1, N'H.Bình Chánh, TPHCM')

------HoaDon----------------------
------NhaCungCap------------------
INSERT INTO NhaCungCap VALUES(N'NCC100', N'Công ty TNHH Xuân Thịnh', N'22-24 Hoa Phượng, Phường 2, Quận Phú Nhuận, TPHCM')
INSERT INTO NhaCungCap VALUES(N'NCC101', N'Công ty TNHH Vua an toàn', N'67/49 Lê Đức Thọ, Phường 7, Gò Vấp, TPHCM')
INSERT INTO NhaCungCap VALUES(N'NCC102', N'Công ty Cà Phê Việt', N'971 Trần Xuân Soạn, Phường Tân Hưng, Quận 7, TPHCM')
INSERT INTO NhaCungCap VALUES(N'NCC103', N'Siêu thị Lê Gia', N'29 Huỳnh Thiện Lộc, Hoà Thanh, Tân Phú, TPHCM')
INSERT INTO NhaCungCap VALUES(N'NCC104', N'Siêu thị Thảo Vy', N'71/23/10/13 Đừơng số 1, KDC Nam Hùng Vương, P.An Lạc ,Q.Bình Tân, TPHCM')
INSERT INTO NhaCungCap VALUES(N'NCC105', N'Siêu thị VinBar', N'758/28/26 xô viết nghệ tĩnh, P.25, Q.Bình Thạnh, TPHCM')
INSERT INTO NhaCungCap VALUES(N'NCC106', N'Siêu thị Bách Hóa Xanh', N'14/26 Nguyễn Tri Phương, P.An Bình, TP.Dĩ An, Bình Dương')

------NguyenLieu------------------
INSERT INTO NguyenLieu VALUES(N'NL100', N'Bột Cacao', N'gram', 20000)
INSERT INTO NguyenLieu VALUES(N'NL101', N'Bột cà phê', N'gram', 20000)
INSERT INTO NguyenLieu VALUES(N'NL102', N'Heavy Cream', N'ml', 20000)
INSERT INTO NguyenLieu VALUES(N'NL103', N'Coca', N'lon', 120)
INSERT INTO NguyenLieu VALUES(N'NL104', N'Pepsi', N'lon', 120)
INSERT INTO NguyenLieu VALUES(N'NL105', N'Mirinda Soda Kem', N'lon', 100)
INSERT INTO NguyenLieu VALUES(N'NL106', N'Revive', N'lon', 100)
INSERT INTO NguyenLieu VALUES(N'NL107', N'Fanta Cam', N'lon', 100)
INSERT INTO NguyenLieu VALUES(N'NL108', N'Sprite', N'lon', 100)
INSERT INTO NguyenLieu VALUES(N'NL109', N'Sting Dâu', N'lon', 100)
INSERT INTO NguyenLieu VALUES(N'NL110', N'Soda không đường', N'lon', 100)
INSERT INTO NguyenLieu VALUES(N'NL111', N'Seven Up', N'lon', 100)
INSERT INTO NguyenLieu VALUES(N'NL112', N'Trà túi lọc', N'gói', 300)
INSERT INTO NguyenLieu VALUES(N'NL113', N'Sữa chua', N'hộp', 200)
INSERT INTO NguyenLieu VALUES(N'NL114', N'Siro bạc hà', N'ml', 1000)
INSERT INTO NguyenLieu VALUES(N'NL115', N'Siro việt quất', N'ml', 1000)
INSERT INTO NguyenLieu VALUES(N'NL116', N'Siro kiwi', N'ml', 1000)
INSERT INTO NguyenLieu VALUES(N'NL117', N'Siro cam', N'ml', 1200)
INSERT INTO NguyenLieu VALUES(N'NL118', N'Siro chanh', N'ml', 1200)
INSERT INTO NguyenLieu VALUES(N'NL119', N'Đường', N'gram', 5000)
INSERT INTO NguyenLieu VALUES(N'NL120', N'Sữa tươi', N'ml', 2000)
INSERT INTO NguyenLieu VALUES(N'NL121', N'Bột mocha', N'gram', 1000)
INSERT INTO NguyenLieu VALUES(N'NL122', N'Cream Cheese', N'ml', 2000)
INSERT INTO NguyenLieu VALUES(N'NL123', N'Bơ', N'trái', 80)
INSERT INTO NguyenLieu VALUES(N'NL124', N'Dâu', N'trái', 100)
INSERT INTO NguyenLieu VALUES(N'NL125', N'Dừa', N'trái', 90)
INSERT INTO NguyenLieu VALUES(N'NL126', N'Khoai môn', N'củ', 1000)
INSERT INTO NguyenLieu VALUES(N'NL127', N'Thanh long', N'trái', 90)
INSERT INTO NguyenLieu VALUES(N'NL128', N'Mít', N'trái', 90)
INSERT INTO NguyenLieu VALUES(N'NL129', N'Dưa hấu', N'trái', 60)
INSERT INTO NguyenLieu VALUES(N'NL130', N'Thơm', N'trái', 85)
INSERT INTO NguyenLieu VALUES(N'NL131', N'Cà rốt', N'củ', 85)
INSERT INTO NguyenLieu VALUES(N'NL132', N'Cam', N'trái', 50)
INSERT INTO NguyenLieu VALUES(N'NL133', N'Chanh dây', N'trái', 45)
INSERT INTO NguyenLieu VALUES(N'NL134', N'Kiwi', N'trái', 80)
INSERT INTO NguyenLieu VALUES(N'NL135', N'Mãng cầu', N'trái', 90)
INSERT INTO NguyenLieu VALUES(N'NL136', N'Chanh', N'trái', 150)
INSERT INTO NguyenLieu VALUES(N'NL137', N'Sapoche', N'trái', 120)
INSERT INTO NguyenLieu VALUES(N'NL138', N'Việt quất', N'trái', 600)
INSERT INTO NguyenLieu VALUES(N'NL139', N'Xoài', N'trái', 150)
INSERT INTO NguyenLieu VALUES(N'NL140', N'Gừng', N'củ', 80)
INSERT INTO NguyenLieu VALUES(N'NL141', N'Đào', N'trái', 100)
INSERT INTO NguyenLieu VALUES(N'NL142', N'Lá trà xanh', N'gram', 2000)
INSERT INTO NguyenLieu VALUES(N'NL143', N'Hoa cúc', N'gram', 1000)
INSERT INTO NguyenLieu VALUES(N'NL144', N'Siro đào', N'ml', 1000)
INSERT INTO NguyenLieu VALUES(N'NL145', N'Bột trà xanh', N'gram', 3000)
INSERT INTO NguyenLieu VALUES(N'NL146', N'Bột nếp', N'gram', 5000)
INSERT INTO NguyenLieu VALUES(N'NL147', N'Bột socola', N'gram', 3000)
INSERT INTO NguyenLieu VALUES(N'NL148', N'Bột sương sáo', N'gram', 2000)
INSERT INTO NguyenLieu VALUES(N'NL149', N'Siro dâu', N'ml', 1000)
INSERT INTO NguyenLieu VALUES(N'NL150', N'Bánh Oreo', N'cái', 120)
INSERT INTO NguyenLieu VALUES(N'NL151', N'Sữa đặc', N'ml', 2200)
INSERT INTO NguyenLieu VALUES(N'NL152', N'Bột vani', N'gram', 2000)
--------------CongThuc-----------------------------------------------

INSERT INTO CongThuc VALUES(N'CC100', N'NL100', 20)
INSERT INTO CongThuc VALUES(N'CC100', N'NL119', 12)

INSERT INTO CongThuc VALUES(N'CC101', N'NL100', 20)
INSERT INTO CongThuc VALUES(N'CC101', N'NL119', 12)
INSERT INTO CongThuc VALUES(N'CC101', N'NL114', 10)

INSERT INTO CongThuc VALUES(N'CC102', N'NL100', 20)
INSERT INTO CongThuc VALUES(N'CC102', N'NL102', 15)
INSERT INTO CongThuc VALUES(N'CC102', N'NL119', 12)
INSERT INTO CongThuc VALUES(N'CC102', N'NL151', 10)

INSERT INTO CongThuc VALUES(N'CC103', N'NL100', 20)
INSERT INTO CongThuc VALUES(N'CC103', N'NL119', 12)
INSERT INTO CongThuc VALUES(N'CC103', N'NL151', 10)

INSERT INTO CongThuc VALUES(N'CF100', N'NL101', 20)
INSERT INTO CongThuc VALUES(N'CF100', N'NL119', 15)

INSERT INTO CongThuc VALUES(N'CF101', N'NL101', 20)
INSERT INTO CongThuc VALUES(N'CF101', N'NL119', 15)

INSERT INTO CongThuc VALUES(N'CF102', N'NL101', 20)
INSERT INTO CongThuc VALUES(N'CF102', N'NL119', 15)
INSERT INTO CongThuc VALUES(N'CF102', N'NL151', 12)

INSERT INTO CongThuc VALUES(N'CF103', N'NL101', 20)
INSERT INTO CongThuc VALUES(N'CF103', N'NL119', 15)
INSERT INTO CongThuc VALUES(N'CF103', N'NL151', 12)

INSERT INTO CongThuc VALUES(N'CF104', N'NL101', 20)
INSERT INTO CongThuc VALUES(N'CF104', N'NL119', 15)
INSERT INTO CongThuc VALUES(N'CF104', N'NL120', 20)

INSERT INTO CongThuc VALUES(N'CF105', N'NL101', 20)
INSERT INTO CongThuc VALUES(N'CF105', N'NL119', 15)
INSERT INTO CongThuc VALUES(N'CF105', N'NL120', 25)
INSERT INTO CongThuc VALUES(N'CF105', N'NL100', 7)

INSERT INTO CongThuc VALUES(N'CF106', N'NL101', 20)
INSERT INTO CongThuc VALUES(N'CF106', N'NL119', 15)
INSERT INTO CongThuc VALUES(N'CF106', N'NL120', 20)
INSERT INTO CongThuc VALUES(N'CF106', N'NL147', 10)

INSERT INTO CongThuc VALUES(N'CF107', N'NL101', 20)
INSERT INTO CongThuc VALUES(N'CF107', N'NL119', 15)
INSERT INTO CongThuc VALUES(N'CF107', N'NL120', 18)

INSERT INTO CongThuc VALUES(N'CF108', N'NL101', 20)
INSERT INTO CongThuc VALUES(N'CF108', N'NL119', 15)
INSERT INTO CongThuc VALUES(N'CF108', N'NL120', 20)
INSERT INTO CongThuc VALUES(N'CF108', N'NL122', 13)

INSERT INTO CongThuc VALUES(N'KE100', N'NL102', 25)
INSERT INTO CongThuc VALUES(N'KE100', N'NL123', 1)

INSERT INTO CongThuc VALUES(N'KE101', N'NL102', 25)
INSERT INTO CongThuc VALUES(N'KE101', N'NL124', 5)

INSERT INTO CongThuc VALUES(N'KE102', N'NL102', 25)
INSERT INTO CongThuc VALUES(N'KE102', N'NL125', 1)

INSERT INTO CongThuc VALUES(N'KE103', N'NL102', 25)
INSERT INTO CongThuc VALUES(N'KE103', N'NL126', 1)

INSERT INTO CongThuc VALUES(N'KE104', N'NL102', 25)
INSERT INTO CongThuc VALUES(N'KE104', N'NL147', 10)

INSERT INTO CongThuc VALUES(N'KE105', N'NL102', 25)
INSERT INTO CongThuc VALUES(N'KE105', N'NL127', 1)

INSERT INTO CongThuc VALUES(N'KE106', N'NL102', 25)
INSERT INTO CongThuc VALUES(N'KE106', N'NL152', 8)

INSERT INTO CongThuc VALUES(N'KE107', N'NL102', 25)
INSERT INTO CongThuc VALUES(N'KE107', N'NL128', 1)

INSERT INTO CongThuc VALUES(N'KE108', N'NL102', 25)
INSERT INTO CongThuc VALUES(N'KE108', N'NL120', 10)

INSERT INTO CongThuc VALUES(N'NE100', N'NL129', 1)
INSERT INTO CongThuc VALUES(N'NE100', N'NL119', 5)

INSERT INTO CongThuc VALUES(N'NE101', N'NL130', 1)
INSERT INTO CongThuc VALUES(N'NE101', N'NL119', 5)

INSERT INTO CongThuc VALUES(N'NE102', N'NL131', 1)
INSERT INTO CongThuc VALUES(N'NE102', N'NL119', 5)

INSERT INTO CongThuc VALUES(N'NE103', N'NL132', 2)
INSERT INTO CongThuc VALUES(N'NE103', N'NL119', 5)

INSERT INTO CongThuc VALUES(N'NE104', N'NL133', 2)
INSERT INTO CongThuc VALUES(N'NE104', N'NL119', 5)

INSERT INTO CongThuc VALUES(N'NE105', N'NL134', 2)
INSERT INTO CongThuc VALUES(N'NE105', N'NL119', 5)

INSERT INTO CongThuc VALUES(N'NN100', N'NL103', 1)

INSERT INTO CongThuc VALUES(N'NN101', N'NL104', 1)

INSERT INTO CongThuc VALUES(N'NN102', N'NL105', 1)

INSERT INTO CongThuc VALUES(N'NN103', N'NL106', 1)

INSERT INTO CongThuc VALUES(N'NN104', N'NL107', 1)

INSERT INTO CongThuc VALUES(N'NN105', N'NL108', 1)

INSERT INTO CongThuc VALUES(N'NN106', N'NL109', 1)

INSERT INTO CongThuc VALUES(N'NN107', N'NL110', 1)

INSERT INTO CongThuc VALUES(N'NN108', N'NL111', 1)

INSERT INTO CongThuc VALUES(N'ST100', N'NL135', 1)
INSERT INTO CongThuc VALUES(N'ST100', N'NL119', 5)
INSERT INTO CongThuc VALUES(N'ST100', N'NL120', 20)

INSERT INTO CongThuc VALUES(N'ST101', N'NL136', 2)
INSERT INTO CongThuc VALUES(N'ST101', N'NL119', 5)
INSERT INTO CongThuc VALUES(N'ST101', N'NL151', 10)

INSERT INTO CongThuc VALUES(N'ST102', N'NL137', 1)
INSERT INTO CongThuc VALUES(N'ST102', N'NL119', 5)
INSERT INTO CongThuc VALUES(N'ST102', N'NL120', 20)

INSERT INTO CongThuc VALUES(N'ST103', N'NL124', 6)
INSERT INTO CongThuc VALUES(N'ST103', N'NL119', 5)
INSERT INTO CongThuc VALUES(N'ST103', N'NL120', 20)

INSERT INTO CongThuc VALUES(N'ST104', N'NL123', 1)
INSERT INTO CongThuc VALUES(N'ST104', N'NL119', 5)
INSERT INTO CongThuc VALUES(N'ST104', N'NL120', 20)

INSERT INTO CongThuc VALUES(N'ST105', N'NL138', 5)
INSERT INTO CongThuc VALUES(N'ST105', N'NL119', 5)
INSERT INTO CongThuc VALUES(N'ST105', N'NL120', 20)

INSERT INTO CongThuc VALUES(N'ST106', N'NL135', 1)
INSERT INTO CongThuc VALUES(N'ST106', N'NL119', 5)
INSERT INTO CongThuc VALUES(N'ST106', N'NL120', 20)

INSERT INTO CongThuc VALUES(N'TR100', N'NL112', 1)
INSERT INTO CongThuc VALUES(N'TR100', N'NL119', 10)

INSERT INTO CongThuc VALUES(N'TR101', N'NL112', 1)
INSERT INTO CongThuc VALUES(N'TR101', N'NL119', 8)
INSERT INTO CongThuc VALUES(N'TR101', N'NL114', 5)

INSERT INTO CongThuc VALUES(N'TR102', N'NL112', 1)
INSERT INTO CongThuc VALUES(N'TR102', N'NL119', 8)
INSERT INTO CongThuc VALUES(N'TR102', N'NL143', 5)

INSERT INTO CongThuc VALUES(N'TR103', N'NL112', 1)
INSERT INTO CongThuc VALUES(N'TR103', N'NL119', 10)
INSERT INTO CongThuc VALUES(N'TR103', N'NL140', 1)

INSERT INTO CongThuc VALUES(N'TR104', N'NL112', 1)
INSERT INTO CongThuc VALUES(N'TR104', N'NL119', 8)
INSERT INTO CongThuc VALUES(N'TR104', N'NL136', 1)

INSERT INTO CongThuc VALUES(N'TR105', N'NL112', 1)
INSERT INTO CongThuc VALUES(N'TR105', N'NL119', 8)
INSERT INTO CongThuc VALUES(N'TR105', N'NL141', 1)

INSERT INTO CongThuc VALUES(N'TR106', N'NL112', 1)
INSERT INTO CongThuc VALUES(N'TR106', N'NL119', 8)
INSERT INTO CongThuc VALUES(N'TR106', N'NL142', 5)

INSERT INTO CongThuc VALUES(N'TS100', N'NL112', 1)
INSERT INTO CongThuc VALUES(N'TS100', N'NL119', 10)
INSERT INTO CongThuc VALUES(N'TS100', N'NL120', 20)
INSERT INTO CongThuc VALUES(N'TS100', N'NL146', 12)
INSERT INTO CongThuc VALUES(N'TS100', N'NL145', 10)

INSERT INTO CongThuc VALUES(N'TS101', N'NL112', 1)
INSERT INTO CongThuc VALUES(N'TS101', N'NL119', 10)
INSERT INTO CongThuc VALUES(N'TS101', N'NL120', 20)
INSERT INTO CongThuc VALUES(N'TS101', N'NL146', 12)

INSERT INTO CongThuc VALUES(N'TS102', N'NL112', 1)
INSERT INTO CongThuc VALUES(N'TS102', N'NL119', 10)
INSERT INTO CongThuc VALUES(N'TS102', N'NL120', 20)
INSERT INTO CongThuc VALUES(N'TS102', N'NL146', 12)
INSERT INTO CongThuc VALUES(N'TS102', N'NL149', 8)

INSERT INTO CongThuc VALUES(N'TS103', N'NL112', 1)
INSERT INTO CongThuc VALUES(N'TS103', N'NL119', 10)
INSERT INTO CongThuc VALUES(N'TS103', N'NL120', 20)
INSERT INTO CongThuc VALUES(N'TS103', N'NL146', 12)
INSERT INTO CongThuc VALUES(N'TS103', N'NL147', 8)
INSERT INTO CongThuc VALUES(N'TS103', N'NL102', 10)

INSERT INTO CongThuc VALUES(N'TS104', N'NL112', 1)
INSERT INTO CongThuc VALUES(N'TS104', N'NL119', 10)
INSERT INTO CongThuc VALUES(N'TS104', N'NL120', 20)
INSERT INTO CongThuc VALUES(N'TS104', N'NL146', 12)
INSERT INTO CongThuc VALUES(N'TS104', N'NL145', 8)

INSERT INTO CongThuc VALUES(N'TS105', N'NL112', 1)
INSERT INTO CongThuc VALUES(N'TS105', N'NL119', 10)
INSERT INTO CongThuc VALUES(N'TS105', N'NL120', 20)
INSERT INTO CongThuc VALUES(N'TS105', N'NL146', 12)
INSERT INTO CongThuc VALUES(N'TS105', N'NL141', 1)

INSERT INTO CongThuc VALUES(N'TS106', N'NL112', 1)
INSERT INTO CongThuc VALUES(N'TS106', N'NL119', 10)
INSERT INTO CongThuc VALUES(N'TS106', N'NL120', 20)
INSERT INTO CongThuc VALUES(N'TS106', N'NL146', 12)
INSERT INTO CongThuc VALUES(N'TS106', N'NL126', 1)

INSERT INTO CongThuc VALUES(N'TS107', N'NL112', 1)
INSERT INTO CongThuc VALUES(N'TS107', N'NL119', 10)
INSERT INTO CongThuc VALUES(N'TS107', N'NL120', 20)
INSERT INTO CongThuc VALUES(N'TS107', N'NL146', 12)
INSERT INTO CongThuc VALUES(N'TS107', N'NL150', 3)

INSERT INTO CongThuc VALUES(N'TS108', N'NL112', 1)
INSERT INTO CongThuc VALUES(N'TS108', N'NL119', 10)
INSERT INTO CongThuc VALUES(N'TS108', N'NL120', 20)
INSERT INTO CongThuc VALUES(N'TS108', N'NL146', 12)
INSERT INTO CongThuc VALUES(N'TS108', N'NL148', 10)

INSERT INTO CongThuc VALUES(N'YA100', N'NL113', 1)
INSERT INTO CongThuc VALUES(N'YA100', N'NL151', 20)

INSERT INTO CongThuc VALUES(N'YA101', N'NL113', 1)
INSERT INTO CongThuc VALUES(N'YA101', N'NL151', 20)
INSERT INTO CongThuc VALUES(N'YA101', N'NL138', 5)

INSERT INTO CongThuc VALUES(N'YA102', N'NL113', 1)
INSERT INTO CongThuc VALUES(N'YA102', N'NL151', 20)
INSERT INTO CongThuc VALUES(N'YA102', N'NL134', 1)

INSERT INTO CongThuc VALUES(N'YA103', N'NL113', 1)
INSERT INTO CongThuc VALUES(N'YA103', N'NL151', 20)
INSERT INTO CongThuc VALUES(N'YA103', N'NL132', 1)

INSERT INTO CongThuc VALUES(N'YA104', N'NL113', 1)
INSERT INTO CongThuc VALUES(N'YA104', N'NL151', 20)
INSERT INTO CongThuc VALUES(N'YA104', N'NL136', 1)

INSERT INTO CongThuc VALUES(N'YA105', N'NL113', 1)
INSERT INTO CongThuc VALUES(N'YA105', N'NL151', 20)
INSERT INTO CongThuc VALUES(N'YA105', N'NL101', 8)