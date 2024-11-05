

-- Sử dụng cơ sở dữ liệu hiện có
USE DBQLDuAn

-- Tạo bảng Người Dùng
CREATE TABLE NguoiDung (
    NguoiDungID INT PRIMARY KEY,
    TenDangNhap VARCHAR(50) NOT NULL,
    MatKhau VARCHAR(255) NOT NULL,
    HoTen VARCHAR(100),
    Email VARCHAR(100),
    VaiTro VARCHAR(50),
    NgayTao DATE,
    LanDangNhapCuoi DATE
);

-- Insert mẫu
INSERT INTO NguoiDung (NguoiDungID, TenDangNhap, MatKhau, HoTen, Email, VaiTro, NgayTao, LanDangNhapCuoi)
VALUES
(1, 'admin', 'password123', N'Nguyen Van A', 'admin@example.com', N'Quản trị viên', '2024-01-01', '2024-09-10'),
(2, 'user1', 'userpassword', N'Tran Thi B', 'user1@example.com', N'Người dùng', '2024-01-15', '2024-09-11');

-- Tạo bảng Nhiệm Vụ
CREATE TABLE NhiemVu (
    NhiemVuID INT PRIMARY KEY,
    DuAnID INT,
    NguoiDuocGiaoID INT,
    TenNhiemVu VARCHAR(255),
    MoTa TEXT,
    TrangThai VARCHAR(50),
    NgayTao DATE,
    HanHoanThanh DATE
);

-- Insert mẫu
INSERT INTO NhiemVu (NhiemVuID, DuAnID, NguoiDuocGiaoID, TenNhiemVu, MoTa, TrangThai, NgayTao, HanHoanThanh)
VALUES
(1, 1, 2, N'Thiết kế giao diện', N'Thiết kế giao diện website công ty', N'Đang thực hiện', '2024-06-01', '2024-07-01'),
(2, 1, 2, N'Phát triển Backend', N'Xây dựng hệ thống backend cho dự án', N'Chưa bắt đầu', '2024-06-15', '2024-08-15');

INSERT INTO NhiemVu (NhiemVuID, DuAnID, NguoiDuocGiaoID, TenNhiemVu, MoTa, TrangThai, NgayTao, HanHoanThanh)
VALUES
(7, 8, 9, N'Thiết kế giao diện', N'Thiết kế giao diện website công ty', N'Đang thực hiện', '2024-08-01', '2024-05-01'),
(3, 4, 5, N'Phát triển Backend', N'Xây dựng hệ thống backend cho dự án', N'Chưa bắt đầu', '2024-09-15', '2024-04-15');


-- Tạo bảng Dự án 
CREATE TABLE DuAn (
    DuAnID INT PRIMARY KEY,      
    MoTa TEXT,                    
    NgayBatDau DATE,              
    NgayKetThuc DATE,           
    NganSach DECIMAL(18, 2)      
);

-- Insert dữ liệu mẫu vào bảng DuAn
INSERT INTO DuAn (DuAnID, MoTa, NgayBatDau, NgayKetThuc, NganSach)
VALUES
(1, N'Phát triển phần mềm quản lý dự án', '2024-01-01', '2024-12-31', 100000.00),
(2, N'Dự án cải tiến hệ thống CRM', '2024-02-15', '2024-08-15', 50000.00),
(3, N'Xây dựng hệ thống thanh toán trực tuyến', '2024-03-01', NULL, 75000.00);

-- Tạo bảng Quyền Truy Cập
CREATE TABLE QuyenTruyCap (
    QuyenTruyCapID INT PRIMARY KEY,
    DuAnID INT,
    NguoiDungID INT,
    CapQuyen VARCHAR(50)
);

-- Insert mẫu
INSERT INTO QuyenTruyCap (QuyenTruyCapID, DuAnID, NguoiDungID, CapQuyen)
VALUES
(1, 1, 1, 'Quản trị viên'),
(2, 1, 2, 'Người dùng');


-- Tạo bảng Thành Viên Dự Án 
CREATE TABLE ThanhVienDuAn (
    DuAnID INT,
    NguoiDungID INT,
    VaiTro VARCHAR(50),
    NgayThamGia DATE,
    NgayKetThuc DATE,
    PRIMARY KEY (DuAnID, NguoiDungID)
);

-- Insert mẫu
INSERT INTO ThanhVienDuAn (DuAnID, NguoiDungID, VaiTro, NgayThamGia, NgayKetThuc)
VALUES
(1, 2, 'Thành viên', '2024-05-01', NULL),
(1, 1, 'Quản trị viên', '2024-01-01', NULL);


-- Tạo bảng Sprint 
CREATE TABLE Sprint (
    SprintID INT PRIMARY KEY,
    DuAnID INT,
    TenSprint VARCHAR(255),
    NgayBatDau DATE,
    NgayKetThuc DATE
);

-- Insert mẫu
INSERT INTO Sprint (SprintID, DuAnID, TenSprint, NgayBatDau, NgayKetThuc)
VALUES
(1, 1, 'Sprint 1', '2024-06-01', '2024-06-15'),
(2, 1, 'Sprint 2', '2024-06-16', '2024-06-30');


-- Tạo bảng Ngân Sách 
CREATE TABLE NganSach (
    NganSachID INT PRIMARY KEY,
    DuAnID INT,
    SoTien DECIMAL(18, 2),
    MoTa TEXT,
    NgayCapNhat DATE
);

-- Insert mẫu
INSERT INTO NganSach (NganSachID, DuAnID, SoTien, MoTa, NgayCapNhat) 
VALUES
(1, 1, 50000.00, 'Ngân sách phát triển dự án phần mềm', '2024-07-01');
INSERT INTO NganSach (NganSachID, DuAnID, SoTien, MoTa, NgayCapNhat)
VALUES
(2, 3, 20000.00, 'Ngân sách phát triển dự án ', '2024-07-01');

-- Tạo bảng Phản Hồi 
CREATE TABLE PhanHoi (
    PhanHoiID INT PRIMARY KEY,
    DuAnID INT,
    NguoiDungID INT,
    NoiDungPhanHoi TEXT,
    NgayPhanHoi DATE
);

-- Insert mẫu
INSERT INTO PhanHoi (PhanHoiID, DuAnID, NguoiDungID, NoiDungPhanHoi, NgayPhanHoi)
VALUES
(1, 1, 2, 'Cần cải thiện tốc độ xử lý của hệ thống', '2024-08-01');


-- Tạo bảng Lịch Sử Nhiệm Vụ 
CREATE TABLE LichSuNhiemVu (
    LichSuID INT PRIMARY KEY,
    NhiemVuID INT,
    NguoiThayDoiID INT,
    MoTaThayDoi TEXT,
    NgayThayDoi DATE
);

-- Insert mẫu
INSERT INTO LichSuNhiemVu (LichSuID, NhiemVuID, NguoiThayDoiID, MoTaThayDoi, NgayThayDoi)
VALUES
(1, 1, 1, 'Cập nhật trạng thái từ "Chưa bắt đầu" sang "Đang thực hiện"', '2024-06-10');


-- Tạo bảng Thông Báo 
CREATE TABLE ThongBao (
    ThongBaoID INT PRIMARY KEY,
    NguoiDungID INT,
    NoiDung TEXT,
    DaXem BIT,
    NgayGui DATE
);

-- Insert mẫu
INSERT INTO ThongBao (ThongBaoID, NguoiDungID, NoiDung, DaXem, NgayGui)
VALUES
(1, 2, 'Bạn có một nhiệm vụ mới', 0, '2024-07-01');
INSERT INTO ThongBao (ThongBaoID, NguoiDungID, NoiDung, DaXem, NgayGui)
VALUES
(3, 4, 'Bạn có một nhiệm vụ mới', 1, '2024-07-01');


-- Tạo bảng Tài Liệu 
CREATE TABLE TaiLieu (
    TaiLieuID INT PRIMARY KEY,
    DuAnID INT,
    TenFile VARCHAR(255),
    DuongDan TEXT,
    NgayTaiLen DATE,
    NguoiTaiLenID INT
);

-- Insert mẫu
INSERT INTO TaiLieu (TaiLieuID, DuAnID, TenFile, DuongDan, NgayTaiLen, NguoiTaiLenID)
VALUES
(1, 1, 'Giao diện thiết kế', '/files/giaodien.pdf', '2024-06-05', 2);


-- Tạo bảng Phân tích Rủi Ro
CREATE TABLE PhanTichRuiRo (
    RuiRoID INT PRIMARY KEY,
    DuAnID INT,
    MoTaRuiRo TEXT,
    MucDoRuiRo VARCHAR(50),
    NgayTao DATE
);

-- Insert mẫu
INSERT INTO PhanTichRuiRo (RuiRoID, DuAnID, MoTaRuiRo, MucDoRuiRo, NgayTao)
VALUES
(1, 1, 'Nguy cơ chậm tiến độ', 'Cao', '2024-07-10');

-- Trigger function for update NhiemVu table
CREATE TRIGGER TR_UpdateNhiemVu
ON NhiemVu
AFTER UPDATE
AS
BEGIN
    -- Check if the updated row has changed the 'TrangThai' column
    IF UPDATE(TrangThai)
    BEGIN
        -- Get the updated 'TrangThai' value
        DECLARE @newTrangThai VARCHAR(50)
        SELECT @newTrangThai = TrangThai FROM inserted

        -- Get the updated 'NhiemVuID' value
        DECLARE @NhiemVuID INT
        SELECT @NhiemVuID = NhiemVuID FROM inserted

        -- Insert a new record into LichSuNhiemVu table
        INSERT INTO LichSuNhiemVu (NhiemVuID, NguoiThayDoiID, MoTaThayDoi, NgayThayDoi)
        VALUES (@NhiemVuID, (SELECT NguoiDungID FROM NguoiDung WHERE VaiTro = 'Quản trị viên'), 'Cập nhật trạng thái từ ' + (SELECT TrangThai FROM deleted) + ' sang ' + @newTrangThai, GETDATE())
    END
END;
GO

-- Trigger function for insert new record in NhiemVu
CREATE TRIGGER TR_InsertNhiemVu
ON NhiemVu
AFTER INSERT
AS
BEGIN
    -- Check if the new record is valid
    IF NOT EXISTS (SELECT 1 FROM inserted WHERE TrangThai IN ('Đang thực hiện', 'Chưa bắt đầu', 'Đã hoàn thành'))
    BEGIN
        -- Raise an error if the 'TrangThai' column is not valid
        RAISERROR('Trạng thái nhiệm vụ không hợp lệ.', 16, 1)
        ROLLBACK TRANSACTION
    END
END;
GO

-- Trigger function for insert new record in NganSach
CREATE TRIGGER TR_InsertNganSach
ON NganSach
AFTER INSERT
AS
BEGIN
    -- Get the inserted DuAnID
    DECLARE @DuAnID INT
    SELECT @DuAnID = DuAnID FROM inserted

    -- Check if the inserted NganSach is greater than the current NganSach in DuAn table
    IF EXISTS (SELECT 1 FROM DuAn WHERE DuAnID = @DuAnID AND NganSach < (SELECT SoTien FROM inserted))
    BEGIN
        -- Raise an error if the inserted NganSach is greater than the current NganSach
        RAISERROR('NganSach can not be greater than current NganSach in DuAn table.', 16, 1)
        ROLLBACK TRANSACTION
    END
END


-- Trigger kiểm tra thời hạn hoàn thành nhiệm vụ
CREATE TRIGGER TR_CheckDeadlineNhiemVu
ON NhiemVu
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @HanHoanThanh DATE, @NgayTao DATE

    -- Lấy giá trị từ bản ghi được chèn/cập nhật
    SELECT @HanHoanThanh = HanHoanThanh, @NgayTao = NgayTao
    FROM inserted

    -- Kiểm tra nếu HanHoanThanh trước NgayTao
    IF @HanHoanThanh < @NgayTao
    BEGIN
        RAISERROR('Hạn hoàn thành nhiệm vụ không thể trước ngày tạo nhiệm vụ.', 16, 1)
        ROLLBACK TRANSACTION
    END
END;
GO

-- Trigger gửi thông báo khi có nhiệm vụ mới được thêm vào
CREATE TRIGGER TR_SendNotificationOnNewTask
ON NhiemVu
AFTER INSERT
AS
BEGIN
    DECLARE @NguoiDuocGiaoID INT, @TenNhiemVu VARCHAR(255), @NgayTao DATE

    -- Lấy thông tin nhiệm vụ mới
    SELECT @NguoiDuocGiaoID = NguoiDuocGiaoID, @TenNhiemVu = TenNhiemVu, @NgayTao = NgayTao
    FROM inserted

    -- Chèn thông báo mới vào bảng ThongBao
    INSERT INTO ThongBao (NguoiDungID, NoiDung, DaXem, NgayGui)
    VALUES (@NguoiDuocGiaoID, 'Bạn có nhiệm vụ mới: ' + @TenNhiemVu, 0, @NgayTao)
END;
GO

-- Trigger tự động cập nhật ngân sách dự án khi thêm khoản chi mới
CREATE TRIGGER TR_UpdateTotalBudget
ON NganSach
AFTER INSERT
AS
BEGIN
    DECLARE @DuAnID INT, @SoTien DECIMAL(18, 2)

    -- Lấy thông tin từ bản ghi được chèn
    SELECT @DuAnID = DuAnID, @SoTien = SoTien
    FROM inserted

    -- Cập nhật ngân sách dự án
    UPDATE DuAn
    SET NganSach = NganSach + @SoTien
    WHERE DuAnID = @DuAnID
END;
GO
-- Trigger xóa thông báo khi người dùng bị xóa
CREATE TRIGGER TR_DeleteNotificationsOnUserDelete
ON NguoiDung
AFTER DELETE
AS
BEGIN
    DECLARE @NguoiDungID INT

    -- Lấy thông tin người dùng bị xóa
    SELECT @NguoiDungID = NguoiDungID
    FROM deleted

    -- Xóa tất cả thông báo của người dùng này
    DELETE FROM ThongBao WHERE NguoiDungID = @NguoiDungID
END;
GO

-- Trigger kiểm tra quyền truy cập dự án khi thêm tài liệu
CREATE TRIGGER TR_CheckAccessBeforeAddingDocument
ON TaiLieu
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @DuAnID INT, @NguoiTaiLenID INT

    -- Lấy thông tin từ bản ghi được chèn
    SELECT @DuAnID = DuAnID, @NguoiTaiLenID = NguoiTaiLenID
    FROM inserted

    -- Kiểm tra nếu người dùng không có quyền truy cập dự án
    IF NOT EXISTS (SELECT 1 FROM QuyenTruyCap WHERE DuAnID = @DuAnID AND NguoiDungID = @NguoiTaiLenID)
    BEGIN
        RAISERROR('Người dùng không có quyền thêm tài liệu cho dự án này.', 16, 1)
        ROLLBACK TRANSACTION
    END
END;
GO


CREATE PROCEDURE ThemNhiemVu
    @DuAnID INT,
    @NguoiDuocGiaoID INT,
    @TenNhiemVu NVARCHAR(255),
    @MoTa TEXT,
    @TrangThai NVARCHAR(50),
    @NgayTao DATE,
    @HanHoanThanh DATE
AS
BEGIN
    -- Kiểm tra dữ liệu đầu vào
    IF @HanHoanThanh < @NgayTao
    BEGIN
        RAISERROR('Hạn hoàn thành nhiệm vụ không thể trước ngày tạo nhiệm vụ.', 16, 1);
        RETURN;
    END
    
    -- Thêm nhiệm vụ mới vào bảng NhiemVu
    INSERT INTO NhiemVu (DuAnID, NguoiDuocGiaoID, TenNhiemVu, MoTa, TrangThai, NgayTao, HanHoanThanh)
    VALUES (@DuAnID, @NguoiDuocGiaoID, @TenNhiemVu, @MoTa, @TrangThai, @NgayTao, @HanHoanThanh);
    
    -- Thông báo nhiệm vụ mới
    INSERT INTO ThongBao (NguoiDungID, NoiDung, DaXem, NgayGui)
    VALUES (@NguoiDuocGiaoID, 'Bạn có nhiệm vụ mới: ' + @TenNhiemVu, 0, @NgayTao);
END;


CREATE PROCEDURE CapNhatNhiemVu
    @NhiemVuID INT,
    @TrangThai NVARCHAR(50),
    @NguoiThayDoiID INT
AS
BEGIN
    -- Kiểm tra nếu NhiemVuID tồn tại
    IF NOT EXISTS (SELECT 1 FROM NhiemVu WHERE NhiemVuID = @NhiemVuID)
    BEGIN
        RAISERROR('Nhiệm vụ không tồn tại.', 16, 1);
        RETURN;
    END

    -- Cập nhật nhiệm vụ
    UPDATE NhiemVu
    SET TrangThai = @TrangThai
    WHERE NhiemVuID = @NhiemVuID;
    
    -- Ghi lại lịch sử thay đổi
    INSERT INTO LichSuNhiemVu (NhiemVuID, NguoiThayDoiID, MoTaThayDoi, NgayThayDoi)
    VALUES (@NhiemVuID, @NguoiThayDoiID, 'Cập nhật trạng thái thành ' + @TrangThai, GETDATE());
END;


CREATE PROCEDURE XoaNhiemVu
    @NhiemVuID INT
AS
BEGIN
    -- Kiểm tra nếu NhiemVuID tồn tại
    IF NOT EXISTS (SELECT 1 FROM NhiemVu WHERE NhiemVuID = @NhiemVuID)
    BEGIN
        RAISERROR('Nhiệm vụ không tồn tại.', 16, 1);
        RETURN;
    END

    -- Xóa nhiệm vụ
    DELETE FROM NhiemVu
    WHERE NhiemVuID = @NhiemVuID;
    
    -- Ghi lại lịch sử nhiệm vụ bị xóa
    INSERT INTO LichSuNhiemVu (NhiemVuID, NguoiThayDoiID, MoTaThayDoi, NgayThayDoi)
    VALUES (@NhiemVuID, NULL, 'Nhiệm vụ đã bị xóa', GETDATE());
END;


-- Procedure lấy nhiêm vụ theo dự án
CREATE PROCEDURE LayDanhSachNhiemVu
    @DuAnID INT
AS
BEGIN
    SELECT NhiemVuID, TenNhiemVu, TrangThai, NgayTao, HanHoanThanh
    FROM NhiemVu
    WHERE DuAnID = @DuAnID;
END;

-- Stored procedure thêm người dùng mới	
CREATE PROCEDURE ThemNguoiDung
    @TenDangNhap NVARCHAR(50),
    @MatKhau NVARCHAR(255),
    @HoTen NVARCHAR(100),
    @Email NVARCHAR(100),
    @VaiTro NVARCHAR(50)
AS
BEGIN
    -- Kiểm tra xem tên đăng nhập đã tồn tại hay chưa
    IF EXISTS (SELECT 1 FROM NguoiDung WHERE TenDangNhap = @TenDangNhap)
    BEGIN
        RAISERROR('Tên đăng nhập đã tồn tại.', 16, 1);
        RETURN;
    END

    -- Thêm người dùng mới
    INSERT INTO NguoiDung (TenDangNhap, MatKhau, HoTen, Email, VaiTro, NgayTao)
    VALUES (@TenDangNhap, @MatKhau, @HoTen, @Email, @VaiTro, GETDATE());
END;
