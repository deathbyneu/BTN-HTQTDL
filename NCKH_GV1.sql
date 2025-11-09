CREATE DATABASE QUANLY_NCKH_GV
GO
USE QUANLY_NCKH_GV
GO

--NHÓM BẢNG ĐỀ TÀI
--BẢNG 1: CẤP ĐỀ TÀI
CREATE TABLE CAP_DETAI(
	MACAP CHAR(10) PRIMARY KEY NOT NULL,
	TENCAP NVARCHAR(100) NOT NULL
)
--BẢNG 2: LĨNH VỰC
CREATE TABLE LINHVUC(
	MALINHVUC CHAR(10) PRIMARY KEY NOT NULL,
	TENLINHVUC NVARCHAR(100) NOT NULL
)
--BẢNG 3: ĐỀ TÀI
CREATE TABLE DETAI(
	MADETAI CHAR(10) PRIMARY KEY,
	TENDETAI NVARCHAR(100) NOT NULL,
	MACAP CHAR(10) NOT NULL REFERENCES CAP_DETAI(MACAP),
	MALINHVUC CHAR(10) NOT NULL REFERENCES LINHVUC(MALINHVUC),
	NAM_TH CHAR(4),
	MOTA_DETAI NVARCHAR(MAX)
)
--BẢNG 4: KẾT QUẢ
CREATE TABLE KETQUA(
	MADETAI CHAR(10) NOT NULL REFERENCES DETAI(MADETAI),
	TIENDO NVARCHAR(50) NOT NULL,
	KQNC NVARCHAR(MAX),
	PRIMARY KEY (MADETAI)
)
--BẢNG 5: CHI PHÍ
CREATE TABLE CHIPHI(
	MACHI CHAR(10) PRIMARY KEY,
	MADETAI CHAR(10) NOT NULL REFERENCES DETAI(MADETAI),
	NGAYCHI DATE NOT NULL,
	SOTIENCHI INT NOT NULL,
	NOIDUNG_CHI NVARCHAR(100) NOT NULL,
	MOTA_CHI NVARCHAR(MAX)
)

--NHÓM BẢNG GIẢNG VIÊN

--BẢNG 6: TRƯỜNG
CREATE TABLE TRUONG(
	MATRUONG CHAR(10) PRIMARY KEY,
	TENTRUONG NVARCHAR(100) NOT NULL,
	HIEUTRUONG NVARCHAR(100) NOT NULL,
	DIACHI_TRUONG NVARCHAR(100),
	SOLUONG_GV_TRUONG INT --SỐ LƯỢNG GV THAM GIA NCKH, KHÔNG PHẢI TOÀN BỘ GV
)
--BẢNG 7: KHOA
CREATE TABLE KHOA(
	MAKHOA CHAR(10) PRIMARY KEY,
	TENKHOA NVARCHAR(100) NOT NULL,
	TRUONGKHOA NVARCHAR(100) NOT NULL,
	MATRUONG CHAR(10) NOT NULL REFERENCES TRUONG(MATRUONG),
	DIACHI_KHOA NVARCHAR(100),
	SDT_KHOA VARCHAR(10),
	EMAIL_KHOA VARCHAR(50),
	SOLUONG_GV_KHOA INT --SỐ LƯỢNG GV THAM GIA NCKH, KHÔNG PHẢI TOÀN BỘ GV
)
--BẢNG 8: GIẢNG VIÊN
CREATE TABLE GIANGVIEN(
	MAGV CHAR(10) PRIMARY KEY,
	TENGV NVARCHAR(100) NOT NULL,
	MAKHOA CHAR(10) REFERENCES KHOA(MAKHOA),
	SDT_GV VARCHAR(10),
	EMAIL_GV VARCHAR(50)
)
--BẢNG 9: NHÓM ĐỀ TÀI
CREATE TABLE NHOM_DETAI(
	MANHOM CHAR(10) PRIMARY KEY,
	TENNHOM NVARCHAR(100) NOT NULL,
	MADETAI CHAR(10) NOT NULL REFERENCES DETAI(MADETAI),
	TRUONGNHOM CHAR(10) NOT NULL REFERENCES GIANGVIEN(MAGV),
	SOLUONG_GV_NHOM INT --SỐ LƯỢNG GV TRONG NHÓM
)
--BẢNG 10: THÀNH VIÊN NHÓM
CREATE TABLE THANHVIEN_NHOM(
	MANHOM CHAR(10) NOT NULL REFERENCES NHOM_DETAI(MANHOM),
	MAGV CHAR(10) NOT NULL REFERENCES GIANGVIEN(MAGV),
	VAITRO NVARCHAR(50), 
	NGAYTHAMGIA DATE,
	PRIMARY KEY(MANHOM, MAGV)
)

--NHÓM BẢNG HỘI ĐỒNG
--BẢNG 11: HỘI ĐỒNG
CREATE TABLE HOIDONG(
	MAHOIDONG CHAR(10) PRIMARY KEY,
	TENHOIDONG NVARCHAR(100) NOT NULL,
	SOLUONG_HOIDONG INT
)
--BẢNG 12: THÀNH VIÊN HỘI ĐỒNG
CREATE TABLE THANHVIEN_HD(
	MATHANHVIEN CHAR(10) PRIMARY KEY,
	TENTHANHVIEN NVARCHAR(100) NOT NULL,
	MAHOIDONG CHAR(10) REFERENCES HOIDONG(MAHOIDONG)
)
--BẢNG 13: ĐÁNH GIÁ (CỦA CÁC THÀNH VIÊN)
CREATE TABLE DANHGIA(
	MATHANHVIEN CHAR(10) REFERENCES THANHVIEN_HD(MATHANHVIEN),
	MADETAI CHAR(10) REFERENCES DETAI(MADETAI),
	DIEM FLOAT,
	NHANXET NVARCHAR(MAX),
	PRIMARY KEY(MATHANHVIEN, MADETAI)
)
--BẢNG 14: KẾT QUẢ ĐÁNH GIÁ
CREATE TABLE KETQUA_DANHGIA(
	MADETAI CHAR(10) REFERENCES DETAI(MADETAI),
	DIEM_TB FLOAT,
	PRIMARY KEY(MADETAI)
)
GO

--THÊM BẢN GHI

INSERT INTO CAP_DETAI (MACAP, TENCAP) VALUES 
('CKHOA', N'CẤP KHOA'),
('CTRUONG', N'CẤP TRƯỜNG'),
('CDAIHOC', N'CẤP ĐẠI HỌC'),
('CTPHO', N'CẤP THÀNH PHỐ')

INSERT INTO LINHVUC (MALINHVUC, TENLINHVUC) VALUES 
('AI', N'TRÍ TUỆ NHÂN TẠO'),
('DL', N'KHOA HỌC DỮ LIỆU'),
('HTTT', N'HỆ THỐNG THÔNG TIN'),
('QTKD', N'QUẢN TRỊ KINH DOANH')

INSERT INTO DETAI (MADETAI, TENDETAI, MACAP, MALINHVUC, NAM_TH, MOTA_DETAI) VALUES 
('DT01', N'NGHIÊN CỨU VỀ HỌC MÁY LƯỢNG TỬ', 'CKHOA', 'AI', '2025', N'Ứng dụng mô hình lượng tử trong học máy.'),
('DT02', N'XÂY DỰNG MÔ HÌNH PHÂN TÍCH DỮ LIỆU LỚN', 'CTRUONG', 'DL', '2025', N'Nghiên cứu xử lý dữ liệu lớn trong các hệ thống kinh doanh.'),
('DT03', N'PHÁT TRIỂN HỆ THỐNG TRÍ TUỆ NHÂN TẠO TỰ HỌC', 'CDAIHOC', 'AI', '2025', N'AI có khả năng tự thích nghi và cải thiện kết quả học.'),
('DT04', N'TỰ ĐỘNG HÓA PHÂN TÍCH THỊ TRƯỜNG', 'CKHOA', 'QTKD', '2025', N'Ứng dụng phân tích dữ liệu trong chiến lược kinh doanh.'),
('DT05', N'MÔ HÌNH DỰ BÁO KINH TẾ VĨ MÔ', 'CTPHO', 'HTTT', '2025', N'Sử dụng dữ liệu lịch sử để dự báo các chỉ số kinh tế.'),
('DT06', N'TỐI ƯU HÓA MẠNG NƠ-RON SÂU TRONG HỌC TĂNG CƯỜNG', 'CDAIHOC', 'AI', '2025', N'Nghiên cứu cải thiện hiệu suất của Deep Reinforcement Learning bằng phương pháp tối ưu hóa mạng nơ-ron.'),
('DT07', N'PHÂN TÍCH HÀNH VI NGƯỜI DÙNG TRÊN NỀN TẢNG MẠNG XÃ HỘI', 'CTRUONG', 'DL', '2025', N'Sử dụng kỹ thuật khai phá dữ liệu để dự đoán hành vi và xu hướng người dùng mạng xã hội.'),
('DT08', N'HỆ THỐNG HỖ TRỢ RA QUYẾT ĐỊNH TRONG QUẢN TRỊ DOANH NGHIỆP', 'CTPHO', 'HTTT', '2025', N'Ứng dụng hệ thống thông tin quản lý và mô hình dữ liệu để hỗ trợ lãnh đạo ra quyết định hiệu quả.')

INSERT INTO KETQUA (MADETAI, TIENDO, KQNC) VALUES
('DT01', N'ĐANG TIẾN HÀNH', N'Đã hoàn thiện mô hình học lượng tử mẫu.'),
('DT02', N'HOÀN THÀNH', N'Phát triển thành công hệ thống phân tích dữ liệu lớn.'),
('DT03', N'HOÀN THÀNH', N'Xây dựng AI có khả năng tự cải thiện mô hình học.'),
('DT04', N'ĐANG TIẾN HÀNH', N'Đang thử nghiệm mô hình tự động hóa phân tích thị trường.'),
('DT05', N'HOÀN THÀNH', N'Mô hình dự báo đã được kiểm chứng với dữ liệu 5 năm.'),
('DT06', N'HOÀN THÀNH', N'Tối ưu hóa thành công mạng nơ-ron trong bài toán Reinforcement Learning.'),
('DT07', N'ĐANG TIẾN HÀNH', N'Hoàn thiện giai đoạn thu thập và xử lý dữ liệu hành vi.'),
('DT08', N'HOÀN THÀNH', N'Hệ thống hỗ trợ ra quyết định đã được triển khai thử nghiệm.')

INSERT INTO CHIPHI (MACHI, MADETAI, NGAYCHI, SOTIENCHI, NOIDUNG_CHI, MOTA_CHI) VALUES
--CHI CỦA ĐỀ TÀI 01
('CHI01', 'DT01', '2025-10-30', 100000, N'MUA PHẦN CỨNG', NULL),
('CHI02', 'DT01', '2025-11-10', 200000, N'MUA PHẦN MỀM HỖ TRỢ', N'Phần mềm mô phỏng lượng tử'),
--CHI CỦA ĐỀ TÀI 02
('CHI03', 'DT02', '2025-08-15', 500000, N'MUA MÁY CHỦ', N'Dùng xử lý dữ liệu lớn'),
('CHI04', 'DT02', '2025-09-20', 100000, N'MUA BỘ LƯU TRỮ', NULL),
--CHI CỦA ĐỀ TÀI 03
('CHI05', 'DT03', '2025-07-30', 300000, N'MUA GPU', N'Training mô hình AI tự học'),
--CHI CỦA ĐỀ TÀI 05
('CHI06', 'DT05', '2025-09-01', 150000, N'MUA DỮ LIỆU KINH TẾ', N'Nguồn dữ liệu từ Tổng cục Thống kê'),
('CHI07', 'DT05', '2025-09-25', 80000, N'CHI IN ẤN BÁO CÁO', NULL),
--CHI CỦA ĐỀ TÀI 06
('CHI08', 'DT06', '2025-10-05', 120000, N'MUA BẢN QUYỀN PHẦN MỀM', N'Sử dụng TensorFlow bản thương mại'),
--CHI CỦA ĐỀ TÀI 07
('CHI09', 'DT07', '2025-08-05', 90000, N'THUÊ DỊCH VỤ THU THẬP DỮ LIỆU', NULL),
('CHI10', 'DT07', '2025-10-10', 60000, N'MUA DUNG LƯỢNG LƯU TRỮ ĐÁM MÂY', NULL),
--CHI CỦA ĐỀ TÀI 08
('CHI11', 'DT08', '2025-09-12', 200000, N'CHI PHÍ TRIỂN KHAI HỆ THỐNG', N'Thử nghiệm hệ thống trong doanh nghiệp thực tế');

INSERT INTO TRUONG (MATRUONG, TENTRUONG, HIEUTRUONG, DIACHI_TRUONG, SOLUONG_GV_TRUONG) VALUES
('COB', N'TRƯỜNG KINH DOANH', N'PGS.TS. NGUYỄN ANH DŨNG', N'207 GIẢI PHÓNG, PHƯỜNG BẠCH MAI, HÀ NỘI', NULL),
('NCT', N'TRƯỜNG CÔNG NGHỆ', N'PGS.TS. PHẠM MINH HẢI', N'207 GIẢI PHÓNG, PHƯỜNG BẠCH MAI, HÀ NỘI', NULL),
('CEPM', N'TRƯỜNG KINH TẾ VÀ QUẢN LÝ CÔNG', N'PGS.TS. LÊ THỊ THU HƯƠNG', N'207 GIẢI PHÓNG, PHƯỜNG BẠCH MAI, HÀ NỘI', NULL)

INSERT INTO KHOA (MAKHOA, TENKHOA, TRUONGKHOA, MATRUONG, DIACHI_KHOA, SDT_KHOA, EMAIL_KHOA, SOLUONG_GV_KHOA) VALUES
--CÁC KHOA THUỘC TRƯỜNG COB - TRƯỜNG KINH DOANH
('FBM', N'KHOA QUẢN TRỊ KINH DOANH', N'TS. PHẠM MINH HÙNG', 'COB', N'P.1004, TÒA NHÀ A1, ĐH KINH TẾ QUỐC DÂN', '0111111111', 'FBM@NEU.EDU.VN', NULL),
('FOM', N'KHOA MARKETING', N'TS. NGUYỄN THỊ THANH NGA', 'COB', N'TẦNG 13, TÒA NHÀ A1, ĐH KINH TẾ QUỐC DÂN', '0111111122', 'FOM@NEU.EDU.VN', NULL),
('FOI', N'KHOA BẢO HIỂM', N'TS. VŨ QUỐC TUẤN', 'COB', N'P.1412-P.1414, TÒA NHÀ A1, ĐH KINH TẾ QUỐC DÂN', '0111111133', 'FOI@NEU.EDU.VN', NULL),
--CÁC KHOA THUỘC TRƯỜNG NCT - TRƯỜNG CÔNG NGHỆ
('FIT', N'KHOA CÔNG NGHỆ THÔNG TIN', N'TS. NGUYỄN THÙY LINH', 'NCT', N'P.1310-P.1312, TÒA NHÀ A1, ĐH KINH TẾ QUỐC DÂN', '0111111144', 'FIT@NEU.EDU.VN', NULL),
('FDA', N'KHOA KHOA HỌC DỮ LIỆU VÀ TRÍ TUỆ NHÂN TẠO', N'TS. LÊ MINH QUÂN', 'NCT', N'P.1604, TÒA NHÀ A1, ĐH KINH TẾ QUỐC DÂN', '0111111155', 'FDA@NEU.EDU.VN', NULL),
('MIS', N'KHOA HỆ THỐNG THÔNG TIN QUẢN LÝ', N'TS. PHAN HỮU NGỌC', 'NCT', N'P.1308-P.1309, TÒA NHÀ A1, ĐH KINH TẾ QUỐC DÂN', '0111111166', 'MIS@NEU.EDU.VN', NULL),
('FSF', N'KHOA KHOA HỌC CƠ SỞ', N'TS. TRẦN VĂN NAM', 'NCT', N'P.1404, TÒA NHÀ A1, ĐH KINH TẾ QUỐC DÂN', '0111111177', 'FSF@NEU.EDU.VN', NULL),
--CÁC KHOA THUỘC TRƯỜNG CEPM - TRƯỜNG KINH TẾ VÀ QUẢN LÝ CÔNG
('FOL', N'KHOA LUẬT', N'TS. NGUYỄN THỊ LAN', 'CEPM', N'P.1009-P.1010, TÒA NHÀ A1, ĐH KINH TẾ QUỐC DÂN', '0111111188', 'FOL@NEU.EDU.VN', NULL),
('FOE', N'KHOA KINH TẾ HỌC', N'TS. TRẦN VĂN HOÀNG', 'CEPM', N'TẦNG 8, TÒA NHÀ A1, ĐH KINH TẾ QUỐC DÂN', '0111111199', 'FOE@NEU.EDU.VN', NULL),
('FOMS', N'KHOA KHOA HỌC QUẢN LÝ', N'TS. LÊ THỊ HOA', 'CEPM', N'P.612C, TÒA NHÀ A1, ĐH KINH TẾ QUỐC DÂN', '0111111100', 'FOMS@NEU.EDU.VN', NULL)

INSERT INTO GIANGVIEN(MAGV, TENGV, MAKHOA, SDT_GV, EMAIL_GV) VALUES
('GV01', N'NGUYỄN THÙY LINH', 'FIT', '0911111110', 'LINHNT@NEU.EDU.VN'),
('GV02', N'TRẦN ANH DŨNG', 'FIT', '0911111111', 'DUNGA@NEU.EDU.VN'),
('GV03', N'LÊ THỊ THU', 'FDA', '0911111112', 'THULT@NEU.EDU.VN'),
('GV04', N'PHẠM HỒNG NHUNG', 'FDA', '0911111113', 'NHUNGP@NEU.EDU.VN'),
('GV05', N'ĐẶNG MINH TUẤN', 'MIS', '0911111114', 'TUANDM@NEU.EDU.VN'),
('GV06', N'NGUYỄN VĂN AN', 'FSF', '0911111115', 'ANNV@NEU.EDU.VN'),
('GV07', N'LÊ HẢI YẾN', 'FBM', '0911111116', 'YENL@NEU.EDU.VN'),
('GV08', N'PHẠM HOÀNG LONG', 'FBM', '0911111117', 'LONGPH@NEU.EDU.VN'),
('GV09', N'ĐỖ THANH NGA', 'FOM', '0911111118', 'NGADT@NEU.EDU.VN'),
('GV10', N'PHAN HỒNG HÀ', 'FOI', '0911111119', 'HAPH@NEU.EDU.VN'),
('GV11', N'NGUYỄN VĂN HIẾU', 'FOL', '0911111120', 'HIEUNV@NEU.EDU.VN'),
('GV12', N'LÊ THANH TÙNG', 'FOE', '0911111121', 'TUNGLT@NEU.EDU.VN'),
('GV13', N'TRẦN HỒNG MINH', 'FOMS', '0911111122', 'MINHTH@NEU.EDU.VN'),
('GV14', N'VŨ LAN HƯƠNG', 'FIT', '0911111123', 'HUONGVL@NEU.EDU.VN'),
('GV15', N'ĐINH NGỌC MAI', 'FDA', '0911111124', 'MAIDN@NEU.EDU.VN'),
('GV16', N'TRƯƠNG QUANG VINH', 'MIS', '0911111125', 'VINHTQ@NEU.EDU.VN'),
('GV17', N'PHẠM NGỌC BÍCH', 'FBM', '0911111126', 'BICHPN@NEU.EDU.VN'),
('GV18', N'ĐẶNG KHẮC HÙNG', 'FOE', '0911111127', 'HUNGD@NEU.EDU.VN'),
('GV19', N'LÊ VĂN TRỌNG', 'FOMS', '0911111128', 'TRONGLV@NEU.EDU.VN'),
('GV20', N'TRẦN THỊ HẠNH', 'FOL', '0911111129', 'HANHTT@NEU.EDU.VN');

INSERT INTO NHOM_DETAI(MANHOM, TENNHOM, MADETAI, TRUONGNHOM, SOLUONG_GV_NHOM) VALUES
('GR01', N'NHÓM HỌC MÁY LƯỢNG TỬ', 'DT01', 'GV01', NULL),
('GR02', N'NHÓM DỮ LIỆU LỚN', 'DT02', 'GV03', NULL),
('GR03', N'NHÓM HỆ THỐNG THÔNG MINH', 'DT03', 'GV05', NULL),
('GR04', N'NHÓM TỰ ĐỘNG HÓA PHÂN TÍCH', 'DT04', 'GV07', NULL),
('GR05', N'NHÓM MÔ HÌNH DỰ BÁO', 'DT05', 'GV09', NULL),
('GR06', N'NHÓM HỌC TĂNG CƯỜNG SÂU', 'DT06', 'GV05', NULL),
('GR07', N'NHÓM PHÂN TÍCH HÀNH VI NGƯỜI DÙNG', 'DT07', 'GV07', NULL),
('GR08', N'NHÓM HỖ TRỢ QUYẾT ĐỊNH DOANH NGHIỆP', 'DT08', 'GV09', NULL);

--CÁC THÀNH VIÊN TRONG NHÓM PHẢI THUỘC KHOA LIÊN QUAN ĐẾN ĐỀ TÀI
INSERT INTO THANHVIEN_NHOM(MANHOM, MAGV, VAITRO, NGAYTHAMGIA) VALUES
--THÀNH VIÊN NHÓM 1
('GR01','GV01',N'TRƯỞNG NHÓM','2025-04-15'),
('GR01','GV02',N'THÀNH VIÊN','2025-04-16'),
('GR01','GV14',N'THÀNH VIÊN','2025-04-16'),
--THÀNH VIÊN NHÓM 2
('GR02','GV03',N'TRƯỞNG NHÓM','2025-04-15'),
('GR02','GV04',N'THÀNH VIÊN','2025-04-16'),
('GR02','GV15',N'THÀNH VIÊN','2025-04-16'),
('GR02','GV06',N'THÀNH VIÊN','2025-04-16'),
--THÀNH VIÊN NHÓM 3
('GR03','GV05',N'TRƯỞNG NHÓM','2025-04-15'),
('GR03','GV16',N'THÀNH VIÊN','2025-04-16'),
('GR03','GV08',N'THÀNH VIÊN','2025-04-16'),
('GR03','GV17',N'THÀNH VIÊN','2025-04-16'),
--THÀNH VIÊN NHÓM 4
('GR04','GV07',N'TRƯỞNG NHÓM','2025-04-15'),
('GR04','GV10',N'THÀNH VIÊN','2025-04-16'),
('GR04','GV12',N'THÀNH VIÊN','2025-04-16'),
--THÀNH VIÊN NHÓM 5
('GR05','GV09',N'TRƯỞNG NHÓM','2025-04-15'),
('GR05','GV11',N'THÀNH VIÊN','2025-04-16'),
('GR05','GV13',N'THÀNH VIÊN','2025-04-16'),
('GR05','GV18',N'THÀNH VIÊN','2025-04-16'),
--THÀNH VIÊN NHÓM 6
('GR06','GV05',N'TRƯỞNG NHÓM','2025-04-15'),
('GR06','GV14',N'THÀNH VIÊN','2025-04-16'),
('GR06','GV16',N'THÀNH VIÊN','2025-04-16'),
('GR06','GV02',N'THÀNH VIÊN','2025-04-16'),
--THÀNH VIÊN NHÓM 7
('GR07','GV07',N'TRƯỞNG NHÓM','2025-04-15'),
('GR07','GV08',N'THÀNH VIÊN','2025-04-16'),
('GR07','GV03',N'THÀNH VIÊN','2025-04-16'),
('GR07','GV17',N'THÀNH VIÊN','2025-04-16'),
--THÀNH VIÊN NHÓM 8
('GR08','GV09',N'TRƯỞNG NHÓM','2025-04-15'),
('GR08','GV13',N'THÀNH VIÊN','2025-04-16'),
('GR08','GV19',N'THÀNH VIÊN','2025-04-16'),
('GR08','GV18',N'THÀNH VIÊN','2025-04-16');

INSERT INTO HOIDONG(MAHOIDONG, TENHOIDONG, SOLUONG_HOIDONG) VALUES
('HD01', N'HỘI ĐỒNG TRƯỜNG CÔNG NGHỆ', NULL),
('HD02', N'HỘI ĐỒNG TRƯỜNG KINH DOANH', NULL),
('HD03', N'HỘI ĐỒNG TRƯỜNG KINH TẾ VÀ QUẢN LÝ CÔNG', NULL),
('HD04', N'HỘI ĐỒNG THÀNH PHỐ', NULL)

INSERT INTO THANHVIEN_HD(MATHANHVIEN, TENTHANHVIEN, MAHOIDONG) VALUES
('TV01', N'ĐINH TRỌNG TÀI', 'HD01'),
('TV02', N'LÊ MINH KHANG', 'HD01'),
('TV03', N'TRẦN HẢI ANH', 'HD01'),
('TV04', N'PHẠM THỊ LAN', 'HD02'),
('TV05', N'VŨ HOÀNG NAM', 'HD02'),
('TV06', N'NGUYỄN THỊ HƯƠNG', 'HD02'),
('TV07', N'TRẦN VĂN LONG', 'HD03'),
('TV08', N'LÊ THỊ NGỌC', 'HD03'),
('TV09', N'PHẠM ĐÌNH TRUNG', 'HD03'),
('TV10', N'NGUYỄN THỊ MINH THU', 'HD04'),
('TV11', N'TRẦN QUANG DŨNG', 'HD04'),
('TV12', N'LÊ VĂN PHÚC', 'HD04');

--CHỈ NHỮNG ĐỀ TÀI ĐÃ HOÀN THÀNH MỚI ĐƯỢC ĐÁNH GIÁ
--CÁC ĐỀ TÀI SẼ ĐƯỢC ĐÁNH GIÁ BỞI CÁC HỘI ĐỒNG TƯƠNG ỨNG, DỰA TRÊN CẤP ĐỀ TÀI VÀ LĨNH VỰC
INSERT INTO DANHGIA(MATHANHVIEN, MADETAI, DIEM, NHANXET) VALUES
--ĐÁNH GIÁ ĐỀ TÀI 02
('TV04', 'DT02', 8.5, N'Đề tài phù hợp với hướng nghiên cứu dữ liệu lớn'),
('TV05', 'DT02', 8.0, N'Cần hoàn thiện thêm mô hình phân tích'),
('TV06', 'DT02', 8.7, N'Ứng dụng tốt trong kinh doanh thực tiễn'),
--ĐÁNH GIÁ ĐỀ TÀI 03
('TV01', 'DT03', 9.0, N'Hệ thống AI có khả năng tự học tốt'),
('TV02', 'DT03', 8.8, N'Cần cải thiện độ chính xác của mô hình'),
('TV03', 'DT03', 9.2, N'Có tiềm năng xuất bản quốc tế'),
--ĐÁNH GIÁ ĐỀ TÀI 05
('TV10', 'DT05', 8.9, N'Mô hình dự báo có độ chính xác cao'),
('TV11', 'DT05', 8.5, N'Cần thêm dữ liệu kinh tế thực tế'),
('TV12', 'DT05', 9.0, N'Có giá trị ứng dụng trong hoạch định chính sách'),
--ĐÁNH GIÁ ĐỀ TÀI 06
('TV01', 'DT06', 9.3, N'Nghiên cứu sâu về mạng nơ-ron tối ưu hóa'),
('TV02', 'DT06', 9.0, N'Kết quả thử nghiệm tốt, đề nghị triển khai thêm'),
('TV03', 'DT06', 9.4, N'Có tiềm năng phát triển sản phẩm ứng dụng thực tế'),
--ĐÁNH GIÁ ĐỀ TÀI 08
('TV10', 'DT08', 8.8, N'Hệ thống hỗ trợ quyết định hiệu quả'),
('TV11', 'DT08', 9.0, N'Cần mở rộng phạm vi thử nghiệm doanh nghiệp'),
('TV12', 'DT08', 9.1, N'Đề tài có tính thực tiễn và khả năng nhân rộng');

INSERT INTO KETQUA_DANHGIA(MADETAI, DIEM_TB) VALUES
('DT01', NULL),
('DT02', NULL),
('DT03', NULL),
('DT04', NULL),
('DT05', NULL),
('DT06', NULL),
('DT07', NULL),
('DT08', NULL)
GO

--CÁC THỦ TỤC
-- Thêm một Lĩnh vực mới
CREATE PROCEDURE sp_InsertLinhVuc
    @MALINHVUC CHAR(10),
    @TENLINHVUC NVARCHAR(100)
AS
BEGIN
    -- Kiểm tra Lĩnh vực đã tồn tại chưa
    IF EXISTS (SELECT 1 FROM LINHVUC WHERE MALINHVUC = @MALINHVUC)
    BEGIN
        PRINT(N'Mã Lĩnh vực đã tồn tại.', 16, 1)
        RETURN
    END

    -- Kiểm tra tên có bị trùng không (Tùy chọn)
    IF EXISTS (SELECT 1 FROM LINHVUC WHERE TENLINHVUC = @TENLINHVUC)
    BEGIN
        PRINT(N'Tên Lĩnh vực đã tồn tại.', 16, 1)
        RETURN
    END

    INSERT INTO LINHVUC (MALINHVUC, TENLINHVUC)
    VALUES (@MALINHVUC, @TENLINHVUC)
END
GO
-- Sửa thông tin Lĩnh vực
CREATE PROCEDURE sp_UpdateLinhVuc
    @MALINHVUC CHAR(10),
    @TENLINHVUC NVARCHAR(100)
AS
BEGIN
    -- Kiểm tra Lĩnh vực có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM LINHVUC WHERE MALINHVUC = @MALINHVUC)
    BEGIN
        PRINT(N'Mã Lĩnh vực không tồn tại.', 16, 1)
        RETURN
    END

    UPDATE LINHVUC
    SET TENLINHVUC = @TENLINHVUC
    WHERE MALINHVUC = @MALINHVUC
END
GO
-- Xóa Lĩnh vực (Kiểm tra ràng buộc DETAI)
CREATE PROCEDURE sp_DeleteLinhVuc
    @MALINHVUC CHAR(10)
AS
BEGIN
    -- Kiểm tra ràng buộc: Đề tài (DETAI)
    IF EXISTS (SELECT 1 FROM DETAI WHERE MALINHVUC = @MALINHVUC)
    BEGIN
        PRINT(N'Không thể xóa. Có đề tài thuộc lĩnh vực này.', 16, 1)
        RETURN
    END

    DELETE FROM LINHVUC
    WHERE MALINHVUC = @MALINHVUC
END
GO
-- Thêm Đề tài mới
CREATE PROCEDURE sp_InsertDeTai
    @MADETAI CHAR(10),
    @TENDETAI NVARCHAR(100),
    @MACAP CHAR(10),
    @MALINHVUC CHAR(10),
    @NAM_TH CHAR(4),
    @MOTA_DETAI NVARCHAR(MAX)
AS
BEGIN
    -- Kiểm tra ràng buộc: CAP_DETAI
    IF NOT EXISTS (SELECT 1 FROM CAP_DETAI WHERE MACAP = @MACAP)
    BEGIN
        PRINT(N'Mã Cấp Đề tài không tồn tại.', 16, 1)
        RETURN
    END

    -- Kiểm tra ràng buộc: LINHVUC
    IF NOT EXISTS (SELECT 1 FROM LINHVUC WHERE MALINHVUC = @MALINHVUC)
    BEGIN
        PRINT(N'Mã Lĩnh vực không tồn tại.', 16, 1)
        RETURN
    END

    INSERT INTO DETAI (MADETAI, TENDETAI, MACAP, MALINHVUC, NAM_TH, MOTA_DETAI)
    VALUES (@MADETAI, @TENDETAI, @MACAP, @MALINHVUC, @NAM_TH, @MOTA_DETAI)
END
GO
-- Sửa thông tin Đề tài
CREATE PROCEDURE sp_UpdateDeTai
    @MADETAI CHAR(10),
    @TENDETAI NVARCHAR(100),
    @MACAP CHAR(10),
    @MALINHVUC CHAR(10),
    @NAM_TH CHAR(4),
    @MOTA_DETAI NVARCHAR(MAX)
AS
BEGIN
    -- Kiểm tra Đề tài có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM DETAI WHERE MADETAI = @MADETAI)
    BEGIN
        PRINT(N'Mã Đề tài không tồn tại.', 16, 1)
        RETURN
    END

    -- Kiểm tra ràng buộc: CAP_DETAI (nếu thay đổi)
    IF NOT EXISTS (SELECT 1 FROM CAP_DETAI WHERE MACAP = @MACAP)
    BEGIN
        PRINT(N'Mã Cấp Đề tài không tồn tại.', 16, 1)
        RETURN
    END

    -- Kiểm tra ràng buộc: LINHVUC (nếu thay đổi)
    IF NOT EXISTS (SELECT 1 FROM LINHVUC WHERE MALINHVUC = @MALINHVUC)
    BEGIN
        PRINT(N'Mã Lĩnh vực không tồn tại.', 16, 1)
        RETURN
    END

    UPDATE DETAI
    SET TENDETAI = @TENDETAI,
        MACAP = @MACAP,
        MALINHVUC = @MALINHVUC,
        NAM_TH = @NAM_TH,
        MOTA_DETAI = @MOTA_DETAI
    WHERE MADETAI = @MADETAI
END
GO
-- Xóa Đề tài (Kiểm tra ràng buộc tất cả các bảng liên quan)
CREATE PROCEDURE sp_DeleteDeTai
    @MADETAI CHAR(10)
AS
BEGIN
    -- Kiểm tra ràng buộc: KETQUA
    IF EXISTS (SELECT 1 FROM KETQUA WHERE MADETAI = @MADETAI)
    BEGIN
        PRINT(N'Không thể xóa. Đề tài có Kết quả nghiên cứu.', 16, 1)
        RETURN
    END

    -- Kiểm tra ràng buộc: CHIPHI
    IF EXISTS (SELECT 1 FROM CHIPHI WHERE MADETAI = @MADETAI)
    BEGIN
        PRINT(N'Không thể xóa. Đề tài có Chi phí.', 16, 1)
        RETURN
    END

    -- Kiểm tra ràng buộc: NHOM_DETAI
    IF EXISTS (SELECT 1 FROM NHOM_DETAI WHERE MADETAI = @MADETAI)
    BEGIN
        PRINT(N'Không thể xóa. Đề tài có Nhóm thực hiện.', 16, 1)
        RETURN
    END

    -- Kiểm tra ràng buộc: DANHGIA
    IF EXISTS (SELECT 1 FROM DANHGIA WHERE MADETAI = @MADETAI)
    BEGIN
        PRINT(N'Không thể xóa. Đề tài đã có Đánh giá.', 16, 1)
        RETURN
    END

    -- Kiểm tra ràng buộc: KETQUA_DANHGIA
    IF EXISTS (SELECT 1 FROM KETQUA_DANHGIA WHERE MADETAI = @MADETAI)
    BEGIN
        PRINT(N'Không thể xóa. Đề tài có Kết quả Đánh giá.', 16, 1)
        RETURN
    END

    DELETE FROM DETAI
    WHERE MADETAI = @MADETAI
END
GO
-- Thêm Kết quả cho Đề tài
CREATE PROCEDURE sp_InsertKetQua
    @MADETAI CHAR(10),
    @TIENDO NVARCHAR(50),
    @KQNC NVARCHAR(MAX)
AS
BEGIN
    -- Kiểm tra ràng buộc: DETAI
    IF NOT EXISTS (SELECT 1 FROM DETAI WHERE MADETAI = @MADETAI)
    BEGIN
        PRINT(N'Mã Đề tài không tồn tại.', 16, 1)
        RETURN
    END

    -- Kiểm tra Kết quả đã tồn tại chưa (vì MADETAI là Primary Key)
    IF EXISTS (SELECT 1 FROM KETQUA WHERE MADETAI = @MADETAI)
    BEGIN
        PRINT(N'Đề tài này đã có Kết quả. Vui lòng sử dụng thủ tục Sửa.', 16, 1)
        RETURN
    END

    INSERT INTO KETQUA (MADETAI, TIENDO, KQNC)
    VALUES (@MADETAI, @TIENDO, @KQNC)
END
GO
-- Sửa Kết quả Đề tài
CREATE PROCEDURE sp_UpdateKetQua
    @MADETAI CHAR(10),
    @TIENDO NVARCHAR(50),
    @KQNC NVARCHAR(MAX)
AS
BEGIN
    -- Kiểm tra Kết quả có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM KETQUA WHERE MADETAI = @MADETAI)
    BEGIN
        PRINT(N'Đề tài này chưa có Kết quả để sửa. Vui lòng sử dụng thủ tục Thêm.', 16, 1)
        RETURN
    END

    UPDATE KETQUA
    SET TIENDO = @TIENDO,
        KQNC = @KQNC
    WHERE MADETAI = @MADETAI
END
GO
-- Xóa Kết quả Đề tài
CREATE PROCEDURE sp_DeleteKetQua
    @MADETAI CHAR(10)
AS
BEGIN
    -- Kiểm tra Kết quả có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM KETQUA WHERE MADETAI = @MADETAI)
    BEGIN
        PRINT(N'Đề tài này không có Kết quả để xóa.', 16, 1)
        RETURN
    END

    DELETE FROM KETQUA
    WHERE MADETAI = @MADETAI
END
GO
-- Thêm Chi phí mới
CREATE PROCEDURE sp_InsertChiPhi
    @MACHI CHAR(10),
    @MADETAI CHAR(10),
    @NGAYCHI DATE,
    @SOTIENCHI INT,
    @NOIDUNG_CHI NVARCHAR(100),
    @MOTA_CHI NVARCHAR(MAX)
AS
BEGIN
    -- Kiểm tra ràng buộc: DETAI
    IF NOT EXISTS (SELECT 1 FROM DETAI WHERE MADETAI = @MADETAI)
    BEGIN
        PRINT(N'Mã Đề tài không tồn tại.', 16, 1)
        RETURN
    END

    -- Kiểm tra Mã Chi phí đã tồn tại chưa
    IF EXISTS (SELECT 1 FROM CHIPHI WHERE MACHI = @MACHI)
    BEGIN
        PRINT(N'Mã Chi phí đã tồn tại.', 16, 1)
        RETURN
    END

    INSERT INTO CHIPHI (MACHI, MADETAI, NGAYCHI, SOTIENCHI, NOIDUNG_CHI, MOTA_CHI)
    VALUES (@MACHI, @MADETAI, @NGAYCHI, @SOTIENCHI, @NOIDUNG_CHI, @MOTA_CHI)
END
GO
-- Sửa Chi phí
CREATE PROCEDURE sp_UpdateChiPhi
    @MACHI CHAR(10),
    @MADETAI CHAR(10),
    @NGAYCHI DATE,
    @SOTIENCHI INT,
    @NOIDUNG_CHI NVARCHAR(100),
    @MOTA_CHI NVARCHAR(MAX)
AS
BEGIN
    -- Kiểm tra Chi phí có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM CHIPHI WHERE MACHI = @MACHI)
    BEGIN
        PRINT(N'Mã Chi phí không tồn tại.', 16, 1)
        RETURN
    END

    -- Kiểm tra ràng buộc: DETAI (nếu có thay đổi MADETAI)
    IF NOT EXISTS (SELECT 1 FROM DETAI WHERE MADETAI = @MADETAI)
    BEGIN
        PRINT(N'Mã Đề tài không tồn tại.', 16, 1)
        RETURN
    END

    UPDATE CHIPHI
    SET MADETAI = @MADETAI,
        NGAYCHI = @NGAYCHI,
        SOTIENCHI = @SOTIENCHI,
        NOIDUNG_CHI = @NOIDUNG_CHI,
        MOTA_CHI = @MOTA_CHI
    WHERE MACHI = @MACHI
END
GO
-- Xóa Chi phí
CREATE PROCEDURE sp_DeleteChiPhi
    @MACHI CHAR(10)
AS
BEGIN
    -- Kiểm tra Chi phí có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM CHIPHI WHERE MACHI = @MACHI)
    BEGIN
        PRINT(N'Mã Chi phí không tồn tại.', 16, 1)
        RETURN
    END

    DELETE FROM CHIPHI
    WHERE MACHI = @MACHI
END
GO
-- Thêm Giảng viên mới
CREATE PROCEDURE sp_InsertGiangVien
    @MAGV CHAR(10),
    @TENGV NVARCHAR(100),
    @MAKHOA CHAR(10),
    @SDT_GV VARCHAR(10),
    @EMAIL_GV VARCHAR(50)
AS
BEGIN
    -- Kiểm tra ràng buộc: KHOA
    IF NOT EXISTS (SELECT 1 FROM KHOA WHERE MAKHOA = @MAKHOA)
    BEGIN
        PRINT(N'Mã Khoa không tồn tại.', 16, 1)
        RETURN
    END

    -- Kiểm tra Mã Giảng viên đã tồn tại chưa
    IF EXISTS (SELECT 1 FROM GIANGVIEN WHERE MAGV = @MAGV)
    BEGIN
        PRINT(N'Mã Giảng viên đã tồn tại.', 16, 1)
        RETURN
    END

    INSERT INTO GIANGVIEN (MAGV, TENGV, MAKHOA, SDT_GV, EMAIL_GV)
    VALUES (@MAGV, @TENGV, @MAKHOA, @SDT_GV, @EMAIL_GV)
END
GO
-- Sửa thông tin Giảng viên
CREATE PROCEDURE sp_UpdateGiangVien
    @MAGV CHAR(10),
    @TENGV NVARCHAR(100),
    @MAKHOA CHAR(10),
    @SDT_GV VARCHAR(10),
    @EMAIL_GV VARCHAR(50)
AS
BEGIN
    -- Kiểm tra Giảng viên có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM GIANGVIEN WHERE MAGV = @MAGV)
    BEGIN
        PRINT(N'Mã Giảng viên không tồn tại.', 16, 1)
        RETURN
    END

    -- Kiểm tra ràng buộc: KHOA (nếu có thay đổi MAKHOA)
    IF NOT EXISTS (SELECT 1 FROM KHOA WHERE MAKHOA = @MAKHOA)
    BEGIN
        PRINT(N'Mã Khoa không tồn tại.', 16, 1)
        RETURN
    END

    UPDATE GIANGVIEN
    SET TENGV = @TENGV,
        MAKHOA = @MAKHOA,
        SDT_GV = @SDT_GV,
        EMAIL_GV = @EMAIL_GV
    WHERE MAGV = @MAGV
END
GO
-- Xóa Giảng viên (Kiểm tra ràng buộc NHOM_DETAI và THANHVIEN_NHOM)
CREATE PROCEDURE sp_DeleteGiangVien
    @MAGV CHAR(10)
AS
BEGIN
    -- Kiểm tra ràng buộc: Giảng viên có là TRƯỞNG NHÓM của đề tài nào không
    IF EXISTS (SELECT 1 FROM NHOM_DETAI WHERE TRUONGNHOM = @MAGV)
    BEGIN
        PRINT(N'Không thể xóa. Giảng viên đang là Trưởng nhóm Đề tài.', 16, 1)
        RETURN
    END

    -- Kiểm tra ràng buộc: Giảng viên có là THÀNH VIÊN NHÓM của đề tài nào không
    IF EXISTS (SELECT 1 FROM THANHVIEN_NHOM WHERE MAGV = @MAGV)
    BEGIN
        PRINT(N'Không thể xóa. Giảng viên đang là Thành viên Nhóm Đề tài.', 16, 1)
        RETURN
    END

    -- Kiểm tra ràng buộc: Giảng viên có là THÀNH VIÊN HỘI ĐỒNG không
    -- Lưu ý: Bạn cần kiểm tra xem MAGV có trong TENTHANHVIEN của THANHVIEN_HD không (dựa trên dữ liệu mẫu thì TVHD không liên kết trực tiếp với GV)
    -- Nếu TENTHANHVIEN không chứa MAGV, ta chỉ cần xóa GV.

    DELETE FROM GIANGVIEN
    WHERE MAGV = @MAGV
END
GO
-- Thêm Nhóm Đề tài mới
CREATE PROCEDURE sp_InsertNhomDeTai
    @MANHOM CHAR(10),
    @TENNHOM NVARCHAR(100),
    @MADETAI CHAR(10),
    @TRUONGNHOM CHAR(10),
    @SOLUONG_GV_NHOM INT
AS
BEGIN
    -- Kiểm tra ràng buộc: DETAI
    IF NOT EXISTS (SELECT 1 FROM DETAI WHERE MADETAI = @MADETAI)
    BEGIN
        PRINT(N'Mã Đề tài không tồn tại.', 16, 1)
        RETURN
    END

    -- Kiểm tra ràng buộc: GIANGVIEN (Trưởng nhóm)
    IF NOT EXISTS (SELECT 1 FROM GIANGVIEN WHERE MAGV = @TRUONGNHOM)
    BEGIN
        PRINT(N'Mã Trưởng nhóm không tồn tại.', 16, 1)
        RETURN
    END

    -- Kiểm tra Đề tài đã có nhóm chưa (Nếu mỗi Đề tài chỉ có 1 nhóm)
    IF EXISTS (SELECT 1 FROM NHOM_DETAI WHERE MADETAI = @MADETAI)
    BEGIN
        PRINT(N'Đề tài này đã có Nhóm thực hiện.', 16, 1)
        RETURN
    END

    INSERT INTO NHOM_DETAI (MANHOM, TENNHOM, MADETAI, TRUONGNHOM, SOLUONG_GV_NHOM)
    VALUES (@MANHOM, @TENNHOM, @MADETAI, @TRUONGNHOM, @SOLUONG_GV_NHOM)
END
GO
-- Sửa thông tin Nhóm Đề tài
CREATE PROCEDURE sp_UpdateNhomDeTai
    @MANHOM CHAR(10),
    @TENNHOM NVARCHAR(100),
    @MADETAI CHAR(10),
    @TRUONGNHOM CHAR(10),
    @SOLUONG_GV_NHOM INT
AS
BEGIN
    -- Kiểm tra Nhóm Đề tài có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM NHOM_DETAI WHERE MANHOM = @MANHOM)
    BEGIN
        PRINT(N'Mã Nhóm Đề tài không tồn tại.', 16, 1)
        RETURN
    END

    -- Kiểm tra ràng buộc: DETAI (nếu thay đổi MADETAI)
    IF NOT EXISTS (SELECT 1 FROM DETAI WHERE MADETAI = @MADETAI)
    BEGIN
        PRINT(N'Mã Đề tài không tồn tại.', 16, 1)
        RETURN
    END

    -- Kiểm tra ràng buộc: GIANGVIEN (Trưởng nhóm)
    IF NOT EXISTS (SELECT 1 FROM GIANGVIEN WHERE MAGV = @TRUONGNHOM)
    BEGIN
        PRINT(N'Mã Trưởng nhóm không tồn tại.', 16, 1)
        RETURN
    END
    
    -- Kiểm tra Trưởng nhóm mới có phải là thành viên của nhóm hiện tại không (tùy thuộc quy tắc)
    IF NOT EXISTS (SELECT 1 FROM THANHVIEN_NHOM WHERE MANHOM = @MANHOM AND MAGV = @TRUONGNHOM)
    BEGIN
        PRINT(N'Trưởng nhóm mới phải là thành viên hiện tại của nhóm.', 16, 1)
        -- Hoặc cần thêm thủ tục cập nhật vai trò của trưởng nhóm trong THANHVIEN_NHOM nếu cần
    END

    UPDATE NHOM_DETAI
    SET TENNHOM = @TENNHOM,
        MADETAI = @MADETAI,
        TRUONGNHOM = @TRUONGNHOM,
        SOLUONG_GV_NHOM = @SOLUONG_GV_NHOM
    WHERE MANHOM = @MANHOM
END
GO
-- Xóa Nhóm Đề tài (Kiểm tra ràng buộc THANHVIEN_NHOM)
CREATE PROCEDURE sp_DeleteNhomDeTai
    @MANHOM CHAR(10)
AS
BEGIN
    -- Kiểm tra ràng buộc: THANHVIEN_NHOM
    IF EXISTS (SELECT 1 FROM THANHVIEN_NHOM WHERE MANHOM = @MANHOM)
    BEGIN
        PRINT(N'Không thể xóa. Nhóm đang có Thành viên. Vui lòng xóa Thành viên trước.', 16, 1)
        RETURN
    END

    DELETE FROM NHOM_DETAI
    WHERE MANHOM = @MANHOM
END
GO
-- Thêm Thành viên vào Nhóm Đề tài
CREATE PROCEDURE sp_InsertThanhVienNhom
    @MANHOM CHAR(10),
    @MAGV CHAR(10),
    @VAITRO NVARCHAR(50),
    @NGAYTHAMGIA DATE
AS
BEGIN
    -- Kiểm tra ràng buộc: NHOM_DETAI
    IF NOT EXISTS (SELECT 1 FROM NHOM_DETAI WHERE MANHOM = @MANHOM)
    BEGIN
        PRINT(N'Mã Nhóm không tồn tại.', 16, 1)
        RETURN
    END

    -- Kiểm tra ràng buộc: GIANGVIEN
    IF NOT EXISTS (SELECT 1 FROM GIANGVIEN WHERE MAGV = @MAGV)
    BEGIN
        PRINT(N'Mã Giảng viên không tồn tại.', 16, 1)
        RETURN
    END

    -- Kiểm tra đã là thành viên chưa
    IF EXISTS (SELECT 1 FROM THANHVIEN_NHOM WHERE MANHOM = @MANHOM AND MAGV = @MAGV)
    BEGIN
        PRINT(N'Giảng viên đã là thành viên của nhóm này.', 16, 1)
        RETURN
    END

    INSERT INTO THANHVIEN_NHOM (MANHOM, MAGV, VAITRO, NGAYTHAMGIA)
    VALUES (@MANHOM, @MAGV, @VAITRO, @NGAYTHAMGIA)

    -- Cập nhật số lượng thành viên trong NHOM_DETAI (tùy chọn)
    UPDATE NHOM_DETAI SET SOLUONG_GV_NHOM = ISNULL(SOLUONG_GV_NHOM, 0) + 1 WHERE MANHOM = @MANHOM
END
GO
-- Sửa thông tin Thành viên trong Nhóm (Vai trò, Ngày tham gia)
CREATE PROCEDURE sp_UpdateThanhVienNhom
    @MANHOM CHAR(10),
    @MAGV CHAR(10),
    @VAITRO NVARCHAR(50),
    @NGAYTHAMGIA DATE
AS
BEGIN
    -- Kiểm tra Thành viên có tồn tại trong Nhóm không
    IF NOT EXISTS (SELECT 1 FROM THANHVIEN_NHOM WHERE MANHOM = @MANHOM AND MAGV = @MAGV)
    BEGIN
        PRINT(N'Giảng viên không phải là Thành viên của Nhóm này.', 16, 1)
        RETURN
    END

    UPDATE THANHVIEN_NHOM
    SET VAITRO = @VAITRO,
        NGAYTHAMGIA = @NGAYTHAMGIA
    WHERE MANHOM = @MANHOM AND MAGV = @MAGV
END
GO
-- Xóa Thành viên khỏi Nhóm Đề tài
CREATE PROCEDURE sp_DeleteThanhVienNhom
    @MANHOM CHAR(10),
    @MAGV CHAR(10)
AS
BEGIN
    -- Kiểm tra Thành viên có tồn tại trong Nhóm không
    IF NOT EXISTS (SELECT 1 FROM THANHVIEN_NHOM WHERE MANHOM = @MANHOM AND MAGV = @MAGV)
    BEGIN
        PRINT(N'Giảng viên không phải là Thành viên của Nhóm này.', 16, 1)
        RETURN
    END

    -- Kiểm tra xem Giảng viên có đang là Trưởng nhóm không
    IF EXISTS (SELECT 1 FROM NHOM_DETAI WHERE MANHOM = @MANHOM AND TRUONGNHOM = @MAGV)
    BEGIN
        PRINT(N'Không thể xóa. Giảng viên này đang là Trưởng nhóm. Vui lòng chỉ định Trưởng nhóm mới trước.', 16, 1)
        RETURN
    END

    DELETE FROM THANHVIEN_NHOM
    WHERE MANHOM = @MANHOM AND MAGV = @MAGV

    -- Cập nhật số lượng thành viên trong NHOM_DETAI (tùy chọn)
    UPDATE NHOM_DETAI SET SOLUONG_GV_NHOM = ISNULL(SOLUONG_GV_NHOM, 1) - 1 WHERE MANHOM = @MANHOM
END
GO
-- Thêm Thành viên vào Hội đồng
CREATE PROCEDURE sp_InsertThanhVienHD
    @MATHANHVIEN CHAR(10),
    @TENTHANHVIEN NVARCHAR(100),
    @MAHOIDONG CHAR(10)
AS
BEGIN
    -- Kiểm tra ràng buộc: HOIDONG
    IF NOT EXISTS (SELECT 1 FROM HOIDONG WHERE MAHOIDONG = @MAHOIDONG)
    BEGIN
        PRINT(N'Mã Hội đồng không tồn tại.', 16, 1)
        RETURN
    END

    -- Kiểm tra Mã Thành viên đã tồn tại chưa
    IF EXISTS (SELECT 1 FROM THANHVIEN_HD WHERE MATHANHVIEN = @MATHANHVIEN)
    BEGIN
        PRINT(N'Mã Thành viên Hội đồng đã tồn tại.', 16, 1)
        RETURN
    END

    INSERT INTO THANHVIEN_HD (MATHANHVIEN, TENTHANHVIEN, MAHOIDONG)
    VALUES (@MATHANHVIEN, @TENTHANHVIEN, @MAHOIDONG)
END
GO
-- Sửa thông tin Thành viên Hội đồng
CREATE PROCEDURE sp_UpdateThanhVienHD
    @MATHANHVIEN CHAR(10),
    @TENTHANHVIEN NVARCHAR(100),
    @MAHOIDONG CHAR(10)
AS
BEGIN
    -- Kiểm tra Thành viên có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM THANHVIEN_HD WHERE MATHANHVIEN = @MATHANHVIEN)
    BEGIN
        PRINT(N'Mã Thành viên Hội đồng không tồn tại.', 16, 1)
        RETURN
    END

    -- Kiểm tra ràng buộc: HOIDONG (nếu thay đổi MAHOIDONG)
    IF NOT EXISTS (SELECT 1 FROM HOIDONG WHERE MAHOIDONG = @MAHOIDONG)
    BEGIN
        PRINT(N'Mã Hội đồng không tồn tại.', 16, 1)
        RETURN
    END

    UPDATE THANHVIEN_HD
    SET TENTHANHVIEN = @TENTHANHVIEN,
        MAHOIDONG = @MAHOIDONG
    WHERE MATHANHVIEN = @MATHANHVIEN
END
GO
-- Xóa Thành viên Hội đồng (Kiểm tra ràng buộc DANHGIA)
CREATE PROCEDURE sp_DeleteThanhVienHD
    @MATHANHVIEN CHAR(10)
AS
BEGIN
    -- Kiểm tra ràng buộc: DANHGIA
    IF EXISTS (SELECT 1 FROM DANHGIA WHERE MATHANHVIEN = @MATHANHVIEN)
    BEGIN
        PRINT(N'Không thể xóa. Thành viên này đã thực hiện Đánh giá Đề tài.', 16, 1)
        RETURN
    END

    DELETE FROM THANHVIEN_HD
    WHERE MATHANHVIEN = @MATHANHVIEN
END
GO
-- Thêm Đánh giá của Thành viên cho Đề tài
CREATE PROCEDURE sp_InsertDanhGia
    @MATHANHVIEN CHAR(10),
    @MADETAI CHAR(10),
    @DIEM FLOAT,
    @NHANXET NVARCHAR(MAX)
AS
BEGIN
    -- Kiểm tra ràng buộc: THANHVIEN_HD
    IF NOT EXISTS (SELECT 1 FROM THANHVIEN_HD WHERE MATHANHVIEN = @MATHANHVIEN)
    BEGIN
        PRINT(N'Mã Thành viên Hội đồng không tồn tại.', 16, 1)
        RETURN
    END

    -- Kiểm tra ràng buộc: DETAI
    IF NOT EXISTS (SELECT 1 FROM DETAI WHERE MADETAI = @MADETAI)
    BEGIN
        PRINT(N'Mã Đề tài không tồn tại.', 16, 1)
        RETURN
    END

    -- Kiểm tra đã đánh giá chưa
    IF EXISTS (SELECT 1 FROM DANHGIA WHERE MATHANHVIEN = @MATHANHVIEN AND MADETAI = @MADETAI)
    BEGIN
        PRINT(N'Thành viên này đã đánh giá Đề tài này rồi. Vui lòng sử dụng thủ tục Sửa.', 16, 1)
        RETURN
    END

    INSERT INTO DANHGIA (MATHANHVIEN, MADETAI, DIEM, NHANXET)
    VALUES (@MATHANHVIEN, @MADETAI, @DIEM, @NHANXET)
END
GO
-- Sửa Đánh giá
CREATE PROCEDURE sp_UpdateDanhGia
    @MATHANHVIEN CHAR(10),
    @MADETAI CHAR(10),
    @DIEM FLOAT,
    @NHANXET NVARCHAR(MAX)
AS
BEGIN
    -- Kiểm tra Đánh giá có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM DANHGIA WHERE MATHANHVIEN = @MATHANHVIEN AND MADETAI = @MADETAI)
    BEGIN
        PRINT(N'Không tìm thấy Đánh giá này.', 16, 1)
        RETURN
    END

    UPDATE DANHGIA
    SET DIEM = @DIEM,
        NHANXET = @NHANXET
    WHERE MATHANHVIEN = @MATHANHVIEN AND MADETAI = @MADETAI
END
GO
-- Xóa Đánh giá
CREATE PROCEDURE sp_DeleteDanhGia
    @MATHANHVIEN CHAR(10),
    @MADETAI CHAR(10)
AS
BEGIN
    -- Kiểm tra Đánh giá có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM DANHGIA WHERE MATHANHVIEN = @MATHANHVIEN AND MADETAI = @MADETAI)
    BEGIN
        PRINT(N'Không tìm thấy Đánh giá này.', 16, 1)
        RETURN
    END

    DELETE FROM DANHGIA
    WHERE MATHANHVIEN = @MATHANHVIEN AND MADETAI = @MADETAI
END
GO
-- Thêm Kết quả Đánh giá (Điểm TB) cho Đề tài
CREATE PROCEDURE sp_InsertKetQuaDanhGia
    @MADETAI CHAR(10),
    @DIEM_TB FLOAT
AS
BEGIN
    -- Kiểm tra ràng buộc: DETAI
    IF NOT EXISTS (SELECT 1 FROM DETAI WHERE MADETAI = @MADETAI)
    BEGIN
        PRINT(N'Mã Đề tài không tồn tại.', 16, 1)
        RETURN
    END

    -- Kiểm tra Kết quả Đánh giá đã tồn tại chưa
    IF EXISTS (SELECT 1 FROM KETQUA_DANHGIA WHERE MADETAI = @MADETAI)
    BEGIN
        PRINT(N'Đề tài này đã có Kết quả Đánh giá. Vui lòng sử dụng thủ tục Sửa.', 16, 1)
        RETURN
    END

    INSERT INTO KETQUA_DANHGIA (MADETAI, DIEM_TB)
    VALUES (@MADETAI, @DIEM_TB)
END
GO
-- Sửa Kết quả Đánh giá
CREATE PROCEDURE sp_UpdateKetQuaDanhGia
    @MADETAI CHAR(10),
    @DIEM_TB FLOAT
AS
BEGIN
    -- Kiểm tra Kết quả Đánh giá có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM KETQUA_DANHGIA WHERE MADETAI = @MADETAI)
    BEGIN
        PRINT(N'Đề tài này chưa có Kết quả Đánh giá để sửa. Vui lòng sử dụng thủ tục Thêm.', 16, 1)
        RETURN
    END

    UPDATE KETQUA_DANHGIA
    SET DIEM_TB = @DIEM_TB
    WHERE MADETAI = @MADETAI
END
GO
-- Xóa Kết quả Đánh giá
CREATE PROCEDURE sp_DeleteKetQuaDanhGia
    @MADETAI CHAR(10)
AS
BEGIN
    -- Kiểm tra Kết quả Đánh giá có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM KETQUA_DANHGIA WHERE MADETAI = @MADETAI)
    BEGIN
        PRINT(N'Đề tài này không có Kết quả Đánh giá để xóa.', 16, 1)
        RETURN
    END

    DELETE FROM KETQUA_DANHGIA
    WHERE MADETAI = @MADETAI
END
GO

SELECT * FROM LINHVUC
EXEC sp_InsertLinhVuc 'IT', N'CÔNG NGHỆ THÔNG TIN';
EXEC sp_UpdateLinhVuc 'IT', N'CÔNG NGHỆ VÀ TRUYỀN THÔNG';
EXEC sp_DeleteLinhVuc 'IT';
EXEC sp_DeleteLinhVuc 'AI'; -- Lỗi: Đề tài DT01, DT03, DT06 đang sử dụng MALINHVUC='AI'

SELECT * FROM DETAI
EXEC sp_InsertDeTai 'DT09', N'NGHIÊN CỨU VỀ PHÂN TÍCH VĂN BẢN', 'CKHOA', 'DL', '2026', N'Nghiên cứu ứng dụng NLP trong phân tích dữ liệu';
EXEC sp_UpdateDeTai 'DT09', N'NGHIÊN CỨU VỀ PHÂN TÍCH VĂN BẢN NÂNG CAO', 'CTRUONG', 'DL', '2026', N'Nghiên cứu ứng dụng NLP trong phân tích dữ liệu';
EXEC sp_DeleteDeTai 'DT09';
EXEC sp_DeleteDeTai 'DT02'; -- Lỗi: Đề tài này có KETQUA, CHIPHI, NHOM_DETAI, DANHGIA, KETQUA_DANHGIA

SELECT * FROM KETQUA
EXEC sp_InsertKetQua 'DT04', N'HOÀN THÀNH', N'Đã triển khai hệ thống phân tích thị trường tự động hóa.';
EXEC sp_UpdateKetQua 'DT04', N'HOÀN THÀNH (ĐÃ NỘP)', N'Báo cáo và mã nguồn đã được nộp lên Hội đồng.';
EXEC sp_DeleteKetQua 'DT04';

SELECT * FROM CHIPHI
EXEC sp_InsertChiPhi 'CHI12', 'DT04', '2026-01-20', 50000, N'CHI PHÍ CÔNG TÁC', N'Đi công tác thu thập dữ liệu thị trường';
EXEC sp_UpdateChiPhi 'CHI12', 'DT04', '2026-01-20', 65000, N'CHI PHÍ CÔNG TÁC', N'Chi phí công tác tăng thêm';
EXEC sp_DeleteChiPhi 'CHI12';

SELECT * FROM GIANGVIEN
EXEC sp_InsertGiangVien 'GV21', N'LÊ HỒNG VÂN', 'FIT', '0912345678', 'VANLH@NEU.EDU.VN';
EXEC sp_UpdateGiangVien 'GV21', N'LÊ HỒNG VÂN', 'FDA', '0912345678', 'VANLH@NEU.EDU.VN';
EXEC sp_DeleteGiangVien 'GV21';
EXEC sp_DeleteGiangVien 'GV01'; -- Lỗi: GV01 là Trưởng nhóm GR01

SELECT * FROM NHOM_DETAI
EXEC sp_InsertNhomDeTai 'GR09', N'NHÓM PHÂN TÍCH THỊ TRƯỜNG', 'DT04', 'GV07', 3;
EXEC sp_UpdateNhomDeTai 'GR09', N'NHÓM PHÂN TÍCH THỊ TRƯỜNG MỚI', 'DT04', 'GV10', 3;
EXEC sp_DeleteNhomDeTai 'GR09'; -- Thành công nếu chưa có thành viên
EXEC sp_DeleteNhomDeTai 'GR01'; -- Lỗi: Nhóm GR01 đang có thành viên

SELECT * FROM THANHVIEN_NHOM
EXEC sp_InsertThanhVienNhom 'GR09', 'GV07', N'TRƯỞNG NHÓM', '2026-02-01';
EXEC sp_InsertThanhVienNhom 'GR09', 'GV10', N'THÀNH VIÊN', '2026-02-01';
EXEC sp_UpdateThanhVienNhom 'GR09', 'GV10', N'THƯ KÝ', '2026-02-01';
EXEC sp_DeleteThanhVienNhom 'GR09', 'GV10';
EXEC sp_DeleteThanhVienNhom 'GR09', 'GV07'; -- Lỗi: GV07 đang là Trưởng nhóm của GR09

SELECT * FROM THANHVIEN_HD
EXEC sp_InsertThanhVienHD 'TV13', N'TRẦN MINH TUYẾT', 'HD04';
EXEC sp_UpdateThanhVienHD 'TV13', N'TRẦN MINH TUYẾT', 'HD03';
EXEC sp_DeleteThanhVienHD 'TV13';
EXEC sp_DeleteThanhVienHD 'TV01'; -- Lỗi: TV01 đã tham gia Đánh giá DT03, DT06

SELECT * FROM DANHGIA
EXEC sp_InsertDanhGia 'TV04', 'DT04', 9.0, N'Đánh giá cao tính ứng dụng thực tế.';
EXEC sp_UpdateDanhGia 'TV04', 'DT04', 9.2, N'Cập nhật: Đánh giá rất cao tính ứng dụng thực tế.';
EXEC sp_DeleteDanhGia 'TV04', 'DT04';

SELECT * FROM KETQUA_DANHGIA
EXEC sp_InsertKetQuaDanhGia 'DT04', 9.1;
EXEC sp_UpdateKetQuaDanhGia 'DT04', 9.5;
EXEC sp_DeleteKetQuaDanhGia 'DT04';

CREATE OR ALTER VIEW V_ThongTinDeTai AS
SELECT 
    DETAI.MADETAI,
    DETAI.TENDETAI,
    GIANGVIEN.TENGV AS CHUNHIEM,
    CAP_DETAI.TENCAP AS CapDeTai,
    LINHVUC.TENLINHVUC AS LoaiDeTai,
    CHIPHI.SOTIENCHI,
    DETAI.NAM_TH,
    KETQUA.TIENDO,
    KETQUA.KQNC,
    KETQUA_DANHGIA.DIEM_TB
FROM DETAI, GIANGVIEN, NHOM_DETAI, CAP_DETAI, LINHVUC, CHIPHI, KETQUA,KETQUA_DANHGIA
WHERE GIANGVIEN.MAGV = NHOM_DETAI.TRUONGNHOM
  AND NHOM_DETAI.MADETAI = DETAI.MADETAI
  AND CAP_DETAI.MACAP = DETAI.MACAP
  AND LINHVUC.MALINHVUC = DETAI.MALINHVUC
  AND CHIPHI.MADETAI = DETAI.MADETAI
  AND KETQUA.MADETAI = DETAI.MADETAI
  AND KETQUA_DANHGIA.MADETAI = DETAI.MADETAI;
SELECT * FROM V_ThongTinDeTai

CREATE OR ALTER VIEW V_NhomNghienCuu AS
SELECT 
    NHOM_DETAI.MANHOM,
    NHOM_DETAI.TENNHOM,
    DETAI.TENDETAI,
    GIANGVIEN.TENGV AS TRUONGNHOM,
    NHOM_DETAI.SOLUONG_GV_NHOM
FROM NHOM_DETAI, GIANGVIEN, DETAI
WHERE NHOM_DETAI.TRUONGNHOM = GIANGVIEN.MAGV
  AND NHOM_DETAI.MADETAI = DETAI.MADETAI;
SELECT * FROM V_NhomNghienCuu

CREATE OR ALTER VIEW V_ThongKeChiPhi AS
SELECT 
    DETAI.MADETAI,
    DETAI.TENDETAI,
    SUM(CHIPHI.SOTIENCHI) AS TongChiPhi
FROM DETAI, CHIPHI
WHERE DETAI.MADETAI = CHIPHI.MADETAI
GROUP BY DETAI.MADETAI, DETAI.TENDETAI;
SELECT * FROM V_ThongKeChiPhi

CREATE OR ALTER VIEW V_KetQuaDeTai AS
SELECT 
    DETAI.MADETAI,
    DETAI.TENDETAI,
    KETQUA.TIENDO,
    KETQUA.KQNC,
    KETQUA_DANHGIA.DIEM_TB
FROM DETAI, KETQUA,KETQUA_DANHGIA
WHERE DETAI.MADETAI = KETQUA.MADETAI AND DETAI.MADETAI=KETQUA_DANHGIA.MADETAI;
SELECT * FROM V_KetQuaDeTai

CREATE OR ALTER VIEW V_Thongtin_GiangVien AS
SELECT 
    GIANGVIEN.MAGV,
    GIANGVIEN.TENGV,
    KHOA.TENKHOA,
    KHOA.TRUONGKHOA
FROM GIANGVIEN, KHOA
WHERE GIANGVIEN.MAKHOA = KHOA.MAKHOA;
SELECT * FROM V_Thongtin_GiangVien

CREATE OR ALTER VIEW V_DeTaiTheoNam AS
SELECT 
    DETAI.MADETAI,
    DETAI.TENDETAI,
    DETAI.NAM_TH,
    CAP_DETAI.TENCAP,
    LINHVUC.TENLINHVUC
FROM DETAI, CAP_DETAI, LINHVUC
WHERE DETAI.MACAP = CAP_DETAI.MACAP
  AND DETAI.MALINHVUC = LINHVUC.MALINHVUC;
  SELECT * FROM V_DeTaiTheoNam
--Hàm tính tông chi phi nghiên cứu của một đề tài 
CREATE FUNCTION FN_TongChiPhi(@MaDeTai CHAR(10))
RETURNS INT
AS
BEGIN
    DECLARE @Tong INT
    SELECT @Tong = SUM(SOTIENCHI)
    FROM CHIPHI
    WHERE MADETAI = @MaDeTai
    RETURN ISNULL(@Tong, 0)
END
SELECT dbo.FN_TongChiPhi('DT01') AS TongChiPhi_DT01

--Hàm tính điểm trung bình đánh giá của đề tài
CREATE FUNCTION FN_TinhDiemTB(@MaDeTai CHAR(10))
RETURNS FLOAT
AS
BEGIN
    DECLARE @DiemTB FLOAT
    SELECT @DiemTB = AVG(DIEM)
    FROM DANHGIA
    WHERE MADETAI = @MaDeTai
    RETURN @DiemTB
END
SELECT dbo.FN_TinhDiemTB('DT03') AS DiemTB_DT03
select * from DANHGIA

CREATE PROCEDURE SP_CapNhatKetQuaDanhGia
AS
BEGIN
    DELETE FROM KETQUA_DANHGIA
    INSERT INTO KETQUA_DANHGIA(MADETAI, DIEM_TB)
    SELECT MADETAI, AVG(DIEM)
    FROM DANHGIA
    GROUP BY MADETAI
END
EXEC SP_CapNhatKetQuaDanhGia

CREATE PROCEDURE SP_CapNhatSoLuongGVNhom
AS
BEGIN
    UPDATE NHOM_DETAI
    SET SOLUONG_GV_NHOM = (
        SELECT COUNT(*)
        FROM THANHVIEN_NHOM
        WHERE THANHVIEN_NHOM.MANHOM = NHOM_DETAI.MANHOM
    )
END
EXEC SP_CapNhatSoLuongGVNhom


CREATE PROCEDURE SP_CapNhatSoLuongGVKhoa
AS
BEGIN
    UPDATE KHOA
    SET SOLUONG_GV_KHOA = (
        SELECT COUNT(DISTINCT MAGV)
        FROM GIANGVIEN
        WHERE GIANGVIEN.MAKHOA = KHOA.MAKHOA
        AND MAGV IN (SELECT MAGV FROM THANHVIEN_NHOM)
    )
END
EXEC SP_CapNhatSoLuongGVKhoa

CREATE OR ALTER PROCEDURE sp_TraCuuThongTinDeTai
    @MaDeTai NVARCHAR(10)
AS
BEGIN
    SELECT 
        DETAI.MADETAI,
        DETAI.TENDETAI,
        GIANGVIEN.TENGV AS CHUNHIEM,
        CAP_DETAI.TENCAP AS CapDeTai,
        LINHVUC.TENLINHVUC AS LinhVuc,
        dbo.fn_TongChiPhi(DETAI.MADETAI) AS TongChiPhi,
        DETAI.NAM_TH,
        KETQUA.TIENDO,
        KETQUA.KQNC
    FROM DETAI, GIANGVIEN, NHOM_DETAI, CAP_DETAI, LINHVUC, CHIPHI, KETQUA
    WHERE GIANGVIEN.MAGV = NHOM_DETAI.TRUONGNHOM
      AND NHOM_DETAI.MADETAI = DETAI.MADETAI
      AND CAP_DETAI.MACAP = DETAI.MACAP
      AND LINHVUC.MALINHVUC = DETAI.MALINHVUC
      AND DETAI.MADETAI = CHIPHI.MADETAI
      AND DETAI.MADETAI = KETQUA.MADETAI
      AND DETAI.MADETAI = @MaDeTai
    GROUP BY 
        DETAI.MADETAI,
        DETAI.TENDETAI,
        GIANGVIEN.TENGV,
        CAP_DETAI.TENCAP,
        LINHVUC.TENLINHVUC,
        DETAI.NAM_TH,
        KETQUA.TIENDO,
        KETQUA.KQNC;
END;
SELECT * FROM DETAI
EXEC sp_TraCuuThongTinDeTai @MaDeTai = 'DT01';
