USE [BTL_API_BLBH]
GO
/****** Object:  Table [dbo].[BaiViet]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BaiViet](
	[BaiVietID] [int] IDENTITY(1,1) NOT NULL,
	[TieuDe] [nvarchar](255) NOT NULL,
	[NoiDung] [nvarchar](max) NOT NULL,
	[NgayTao] [datetime] NOT NULL,
	[TaiKhoanID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[BaiVietID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChiTietHoaDonNhaps]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietHoaDonNhaps](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MaHoaDon] [int] NULL,
	[SoLuong] [int] NULL,
	[DonViTinh] [nvarchar](50) NULL,
	[GiaNhap] [decimal](18, 0) NULL,
	[TongTien] [decimal](18, 0) NULL,
	[MaSize] [int] NULL,
	[MaSanPham] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChiTietHoaDons]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietHoaDons](
	[MaChiTietHoaDon] [int] IDENTITY(1,1) NOT NULL,
	[MaHoaDon] [int] NULL,
	[SoLuong] [int] NULL,
	[TongGia] [decimal](18, 0) NULL,
	[GiamGia] [nvarchar](250) NULL,
	[MaSize] [int] NULL,
	[MaSanPham] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaChiTietHoaDon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChiTietTaiKhoan]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietTaiKhoan](
	[MaChitietTaiKhoan] [int] IDENTITY(1,1) NOT NULL,
	[MaTaiKhoan] [int] NULL,
	[HoTen] [nvarchar](50) NULL,
	[DiaChi] [nvarchar](250) NULL,
	[SoDienThoai] [nvarchar](11) NULL,
	[AnhDaiDien] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaChitietTaiKhoan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChuyenMucs]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChuyenMucs](
	[MaChuyenMuc] [int] IDENTITY(1,1) NOT NULL,
	[TenChuyenMuc] [nvarchar](50) NULL,
	[NoiDung] [nvarchar](max) NULL,
	[IDCapCha] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaChuyenMuc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DanhGiaSanPham]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DanhGiaSanPham](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SanPhamId] [int] NOT NULL,
	[KhachHangId] [int] NULL,
	[NoiDung] [nvarchar](max) NULL,
	[SoSao] [int] NULL,
	[ThoiGianTao] [datetime] NULL,
	[TrangThai] [bit] NULL,
	[TenKhachHang] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GiamGia]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiamGia](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TenChuongTrinh] [nvarchar](255) NOT NULL,
	[LoaiGiamGia] [nvarchar](50) NOT NULL,
	[GiaTriGiam] [decimal](18, 2) NULL,
	[MaGiamGia] [nvarchar](100) NULL,
	[SoLuongMua] [int] NULL,
	[SoLuongTang] [int] NULL,
	[SanPhamTangId] [int] NULL,
	[GiaTriDonToiThieu] [decimal](18, 2) NULL,
	[ApDungToanBoSanPham] [bit] NOT NULL,
	[NhomKhachHang] [nvarchar](50) NULL,
	[NgayBatDau] [datetime] NOT NULL,
	[NgayKetThuc] [datetime] NOT NULL,
	[DangHoatDong] [bit] NOT NULL,
	[NgayTao] [datetime] NOT NULL,
	[NgayCapNhat] [datetime] NOT NULL,
	[SoLuongToiDa] [int] NULL,
	[SoLuongDaDung] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GiamGia_SanPham]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiamGia_SanPham](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[GiamGiaId] [int] NOT NULL,
	[SanPhamId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HoaDonNhaps]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoaDonNhaps](
	[MaHoaDon] [int] IDENTITY(1,1) NOT NULL,
	[MaNhaPhanPhoi] [int] NULL,
	[NgayTao] [datetime] NULL,
	[KieuThanhToan] [nvarchar](max) NULL,
	[MaTaiKhoan] [int] NULL,
	[TongTien] [decimal](18, 0) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaHoaDon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HoaDons]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoaDons](
	[MaHoaDon] [int] IDENTITY(1,1) NOT NULL,
	[TrangThai] [nvarchar](1) NULL,
	[NgayTao] [datetime] NULL,
	[TongGia] [decimal](18, 0) NULL,
	[DiaChiGiaoHang] [nvarchar](350) NULL,
	[ThoiGianGiaoHang] [datetime] NULL,
	[MaKH] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaHoaDon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KhachHang]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhachHang](
	[MaKH] [int] IDENTITY(1,1) NOT NULL,
	[TenKH] [nvarchar](50) NULL,
	[DiaChi] [nvarchar](max) NULL,
	[SDT] [char](10) NULL,
	[MaTaiKhoan] [int] NULL,
	[Email] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiTaiKhoan]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiTaiKhoan](
	[MaLoai] [int] IDENTITY(1,1) NOT NULL,
	[TenLoai] [nvarchar](50) NULL,
	[Mota] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaLoai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Location]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Location](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MauSac]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MauSac](
	[MaMau] [int] IDENTITY(1,1) NOT NULL,
	[TenMau] [nvarchar](50) NOT NULL,
	[GhiChu] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaMau] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NhaPhanPhois]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhaPhanPhois](
	[MaNhaPhanPhoi] [int] IDENTITY(1,1) NOT NULL,
	[TenNhaPhanPhoi] [nvarchar](250) NULL,
	[DiaChi] [nvarchar](max) NULL,
	[SoDienThoai] [nvarchar](50) NULL,
	[MoTa] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaNhaPhanPhoi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Owner]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Owner](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Phone] [nvarchar](15) NULL,
	[Email] [nvarchar](100) NULL,
	[Address] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SanPhamChiTiet]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SanPhamChiTiet](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MaSP] [int] NOT NULL,
	[MaSize] [int] NOT NULL,
	[SoLuong] [int] NOT NULL,
	[TrangThai] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SanPhams]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SanPhams](
	[MaSanPham] [int] IDENTITY(1,1) NOT NULL,
	[MaChuyenMuc] [int] NULL,
	[TenSanPham] [nvarchar](150) NULL,
	[AnhDaiDien] [nvarchar](max) NULL,
	[Gia] [decimal](18, 0) NULL,
	[TrangThai] [bit] NULL,
	[LuotXem] [int] NULL,
	[MoTa] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaSanPham] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SanPhams_NhaPhanPhois]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SanPhams_NhaPhanPhois](
	[MaSanPham] [int] NOT NULL,
	[MaNhaPhanPhoi] [int] NOT NULL,
 CONSTRAINT [FK_CTDHN] PRIMARY KEY CLUSTERED 
(
	[MaSanPham] ASC,
	[MaNhaPhanPhoi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Size]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Size](
	[MaSize] [int] IDENTITY(1,1) NOT NULL,
	[TenSize] [nvarchar](250) NULL,
	[Ghichu] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaSize] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaiKhoan]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaiKhoan](
	[MaTaiKhoan] [int] IDENTITY(1,1) NOT NULL,
	[LoaiTaiKhoan] [int] NULL,
	[TenTaiKhoan] [nvarchar](50) NULL,
	[MatKhau] [nvarchar](50) NULL,
	[Email] [nvarchar](150) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaTaiKhoan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_TenTaiKhoan] UNIQUE NONCLUSTERED 
(
	[TenTaiKhoan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThanhToanVNPay]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThanhToanVNPay](
	[MaGiaoDich] [int] IDENTITY(1,1) NOT NULL,
	[SoTien] [bigint] NOT NULL,
	[MaNganHang] [nvarchar](50) NULL,
	[MaGiaoDichNganHang] [nvarchar](100) NULL,
	[LoaiThe] [nvarchar](50) NULL,
	[ThongTinDonHang] [nvarchar](500) NULL,
	[NgayThanhToan] [nvarchar](20) NULL,
	[MaPhanHoi] [nvarchar](10) NULL,
	[MaWebsite] [nvarchar](50) NULL,
	[MaGiaoDichVNPay] [nvarchar](100) NULL,
	[TrangThaiGiaoDich] [nvarchar](10) NULL,
	[MaThamChieu] [nvarchar](100) NULL,
	[NgayTao] [datetime] NULL,
	[MaHoaDon] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaGiaoDich] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BaiViet] ADD  DEFAULT (getdate()) FOR [NgayTao]
GO
ALTER TABLE [dbo].[DanhGiaSanPham] ADD  DEFAULT (getdate()) FOR [ThoiGianTao]
GO
ALTER TABLE [dbo].[DanhGiaSanPham] ADD  DEFAULT ((1)) FOR [TrangThai]
GO
ALTER TABLE [dbo].[GiamGia] ADD  DEFAULT ((1)) FOR [ApDungToanBoSanPham]
GO
ALTER TABLE [dbo].[GiamGia] ADD  DEFAULT ((1)) FOR [DangHoatDong]
GO
ALTER TABLE [dbo].[GiamGia] ADD  DEFAULT (getdate()) FOR [NgayTao]
GO
ALTER TABLE [dbo].[GiamGia] ADD  DEFAULT (getdate()) FOR [NgayCapNhat]
GO
ALTER TABLE [dbo].[GiamGia] ADD  DEFAULT ((0)) FOR [SoLuongDaDung]
GO
ALTER TABLE [dbo].[SanPhamChiTiet] ADD  DEFAULT ((0)) FOR [SoLuong]
GO
ALTER TABLE [dbo].[SanPhamChiTiet] ADD  DEFAULT ((1)) FOR [TrangThai]
GO
ALTER TABLE [dbo].[ThanhToanVNPay] ADD  DEFAULT (getdate()) FOR [NgayTao]
GO
ALTER TABLE [dbo].[BaiViet]  WITH CHECK ADD  CONSTRAINT [FK_BaiViet_TaiKhoan] FOREIGN KEY([TaiKhoanID])
REFERENCES [dbo].[TaiKhoan] ([MaTaiKhoan])
GO
ALTER TABLE [dbo].[BaiViet] CHECK CONSTRAINT [FK_BaiViet_TaiKhoan]
GO
ALTER TABLE [dbo].[ChiTietHoaDonNhaps]  WITH CHECK ADD FOREIGN KEY([MaHoaDon])
REFERENCES [dbo].[HoaDonNhaps] ([MaHoaDon])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ChiTietHoaDonNhaps]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietHoaDonNhaps_MaSanPham] FOREIGN KEY([MaSanPham])
REFERENCES [dbo].[SanPhams] ([MaSanPham])
GO
ALTER TABLE [dbo].[ChiTietHoaDonNhaps] CHECK CONSTRAINT [FK_ChiTietHoaDonNhaps_MaSanPham]
GO
ALTER TABLE [dbo].[ChiTietHoaDons]  WITH CHECK ADD FOREIGN KEY([MaHoaDon])
REFERENCES [dbo].[HoaDons] ([MaHoaDon])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ChiTietHoaDons]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietHoaDons_MaSanPham] FOREIGN KEY([MaSanPham])
REFERENCES [dbo].[SanPhams] ([MaSanPham])
GO
ALTER TABLE [dbo].[ChiTietHoaDons] CHECK CONSTRAINT [FK_ChiTietHoaDons_MaSanPham]
GO
ALTER TABLE [dbo].[ChiTietTaiKhoan]  WITH CHECK ADD FOREIGN KEY([MaTaiKhoan])
REFERENCES [dbo].[TaiKhoan] ([MaTaiKhoan])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DanhGiaSanPham]  WITH CHECK ADD FOREIGN KEY([KhachHangId])
REFERENCES [dbo].[KhachHang] ([MaKH])
GO
ALTER TABLE [dbo].[DanhGiaSanPham]  WITH CHECK ADD FOREIGN KEY([SanPhamId])
REFERENCES [dbo].[SanPhams] ([MaSanPham])
GO
ALTER TABLE [dbo].[GiamGia_SanPham]  WITH CHECK ADD  CONSTRAINT [FK__GiamGia_S__GiamG__42ECDBF6] FOREIGN KEY([GiamGiaId])
REFERENCES [dbo].[GiamGia] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[GiamGia_SanPham] CHECK CONSTRAINT [FK__GiamGia_S__GiamG__42ECDBF6]
GO
ALTER TABLE [dbo].[GiamGia_SanPham]  WITH CHECK ADD FOREIGN KEY([SanPhamId])
REFERENCES [dbo].[SanPhams] ([MaSanPham])
GO
ALTER TABLE [dbo].[HoaDonNhaps]  WITH CHECK ADD FOREIGN KEY([MaNhaPhanPhoi])
REFERENCES [dbo].[NhaPhanPhois] ([MaNhaPhanPhoi])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[HoaDonNhaps]  WITH CHECK ADD FOREIGN KEY([MaTaiKhoan])
REFERENCES [dbo].[TaiKhoan] ([MaTaiKhoan])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[HoaDons]  WITH CHECK ADD FOREIGN KEY([MaKH])
REFERENCES [dbo].[KhachHang] ([MaKH])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[KhachHang]  WITH CHECK ADD  CONSTRAINT [FK_KhachHang_TaiKhoan] FOREIGN KEY([MaTaiKhoan])
REFERENCES [dbo].[TaiKhoan] ([MaTaiKhoan])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[KhachHang] CHECK CONSTRAINT [FK_KhachHang_TaiKhoan]
GO
ALTER TABLE [dbo].[SanPhamChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_SanPhamChiTiet_SanPham] FOREIGN KEY([MaSP])
REFERENCES [dbo].[SanPhams] ([MaSanPham])
GO
ALTER TABLE [dbo].[SanPhamChiTiet] CHECK CONSTRAINT [FK_SanPhamChiTiet_SanPham]
GO
ALTER TABLE [dbo].[SanPhamChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_SanPhamChiTiet_Size] FOREIGN KEY([MaSize])
REFERENCES [dbo].[Size] ([MaSize])
GO
ALTER TABLE [dbo].[SanPhamChiTiet] CHECK CONSTRAINT [FK_SanPhamChiTiet_Size]
GO
ALTER TABLE [dbo].[SanPhams]  WITH CHECK ADD FOREIGN KEY([MaChuyenMuc])
REFERENCES [dbo].[ChuyenMucs] ([MaChuyenMuc])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SanPhams_NhaPhanPhois]  WITH CHECK ADD FOREIGN KEY([MaNhaPhanPhoi])
REFERENCES [dbo].[NhaPhanPhois] ([MaNhaPhanPhoi])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SanPhams_NhaPhanPhois]  WITH CHECK ADD FOREIGN KEY([MaSanPham])
REFERENCES [dbo].[SanPhams] ([MaSanPham])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TaiKhoan]  WITH CHECK ADD FOREIGN KEY([LoaiTaiKhoan])
REFERENCES [dbo].[LoaiTaiKhoan] ([MaLoai])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ThanhToanVNPay]  WITH CHECK ADD  CONSTRAINT [FK__ThanhToan__MaHoa__2803DB90] FOREIGN KEY([MaHoaDon])
REFERENCES [dbo].[HoaDons] ([MaHoaDon])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ThanhToanVNPay] CHECK CONSTRAINT [FK__ThanhToan__MaHoa__2803DB90]
GO
ALTER TABLE [dbo].[DanhGiaSanPham]  WITH CHECK ADD CHECK  (([SoSao]>=(1) AND [SoSao]<=(5)))
GO
/****** Object:  StoredProcedure [dbo].[Admin_Selling_Products]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Admin_Selling_Products] (@page_index  INT, 
                                       @page_size   INT,
									   @fr_NgayTao datetime, 
									   @to_NgayTao datetime
									   )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY SUM(c.SoLuong) DESC)) AS RowNumber, 
						      
							  s.TenSanPham,
							  s.AnhDaiDien,
							  SUM(c.SoLuong) AS TongSoLuong,
							  
							  s.Gia
							 
							 
                        INTO #Results1
                        FROM HoaDons  h
						inner join ChiTietHoaDons c on c.MaHoaDon = h.MaHoaDon
						inner join SanPhams s on s.MaSanPham = c.MaSanPham
					    WHERE  						
						((@fr_NgayTao IS NULL
                        AND @to_NgayTao IS NULL)
                        OR (@fr_NgayTao IS NOT NULL
                            AND @to_NgayTao IS NULL
                            AND h.NgayTao >= @fr_NgayTao)
                        OR (@fr_NgayTao IS NULL
                            AND @to_NgayTao IS NOT NULL
                            AND h.NgayTao <= @to_NgayTao)
                        OR h.NgayTao >= @fr_NgayTao AND h.NgayTao <= DATEADD(day, 1, @to_NgayTao))  
						GROUP BY s.TenSanPham, s.AnhDaiDien, s.Gia
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY SUM(c.SoLuong) DESC)) AS RowNumber, 
                            
							  s.TenSanPham,
							  s.AnhDaiDien,
							  SUM(c.SoLuong) AS TongSoLuong,
							  
							  s.Gia
                        INTO #Results2
                        FROM HoaDons  h
						inner join ChiTietHoaDons c on c.MaHoaDon = h.MaHoaDon
						inner join SanPhams s on s.MaSanPham = c.MaSanPham
					    WHERE  					
						((@fr_NgayTao IS NULL
                        AND @to_NgayTao IS NULL)
                        OR (@fr_NgayTao IS NOT NULL
                            AND @to_NgayTao IS NULL
                            AND h.NgayTao >= @fr_NgayTao)
                        OR (@fr_NgayTao IS NULL
                            AND @to_NgayTao IS NOT NULL
                            AND h.NgayTao <= @to_NgayTao)
                        OR h.NgayTao >= @fr_NgayTao AND h.NgayTao <= DATEADD(day, 1, @to_NgayTao))
						GROUP BY s.TenSanPham, s.AnhDaiDien, s.Gia
						SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2                        
                        DROP TABLE #Results2; 
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[Chuyenmuc_search]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[Chuyenmuc_search] (@page_index  INT, 
                                 @page_size  int)
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY h.MaChuyenMuc ASC)) AS RowNumber, 
                              h.MaChuyenMuc,
							  h.TenChuyenMuc,
							  h.DacBiet,
							  h.NoiDung
							  
                        INTO #Results1
                        FROM ChuyenMucs as h 
					      
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
						SELECT(ROW_NUMBER() OVER(
                              ORDER BY h.MaChuyenMuc ASC)) AS RowNumber, 
                              h.MaChuyenMuc,
							  h.TenChuyenMuc,
							  h.DacBiet,
							  h.NoiDung
                        INTO #Results2
                        FROM ChuyenMucs as h 
						
						SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2                        
                        DROP TABLE #Results2; 
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[create_chuyen_muc]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[create_chuyen_muc](
@TenChuyenMuc nvarchar(250),
@NoiDung nvarchar(250))
as
begin
	insert into ChuyenMucs(TenChuyenMuc,NoiDung)
	values (@TenChuyenMuc,@NoiDung)
end
GO
/****** Object:  StoredProcedure [dbo].[create_CTTK]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[create_CTTK](
@MaTaiKhoan int,
@Hoten nvarchar(250),
@DiaChi nvarchar(250),
@SDT nvarchar(250),
@Anh nvarchar(250))
as
begin
	insert into ChiTietTaiKhoan(MaTaiKhoan,HoTen,DiaChi,SoDienThoai,AnhDaiDien)
	values (@MaTaiKhoan,@Hoten,@DiaChi,@SDT,@Anh)
end
GO
/****** Object:  StoredProcedure [dbo].[create_gio_hang]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[create_gio_hang](
@MaTaiKhoan int,
@MaSanPham int)
as
begin
	insert into GioHang(MaTaiKhoan,MaSanPham)
	values (@MaTaiKhoan,@MaSanPham)
end
GO
/****** Object:  StoredProcedure [dbo].[create_khach_hang]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[create_khach_hang](
@TenKH nvarchar(50),
@diachi nvarchar(250),
@sdt nvarchar(50))
as
begin
	insert into KhachHang(TenKH,DiaChi,SDT)
	values (@TenKH,@diachi,@sdt)
end
GO
/****** Object:  StoredProcedure [dbo].[create_login]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[create_login](
@LoaiTaiKhoan int,
@TenTaiKhoan nvarchar(250),
@MatKhau nvarchar(250),
@Email nvarchar(250))
as
begin
	insert into TaiKhoan(LoaiTaiKhoan,TenTaiKhoan,MatKhau,Email)
	values (@LoaiTaiKhoan,@TenTaiKhoan,@MatKhau,@Email)
end
GO
/****** Object:  StoredProcedure [dbo].[create_NhaPhanPhoi]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[create_NhaPhanPhoi](
@TenNPP nvarchar(50),
@diachi nvarchar(250),
@sdt nvarchar(50))
as
begin
	insert into NhaPhanPhois(TenNhaPhanPhoi,DiaChi,SoDienThoai)
	values (@TenNPP,@diachi,@sdt)
end
GO
/****** Object:  StoredProcedure [dbo].[create_San_Pham]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[create_San_Pham](

@MaChuyenMuc int,
@Anh nvarchar(250),
@TenSanPham nvarchar(max),
@Gia int,
@SoLuong int,
@MaSize int)
as
begin
	insert into SanPhams(MaChuyenMuc,AnhDaiDien,TenSanPham,Gia,SoLuong,MaSize)
	values (@MaChuyenMuc,@Anh,@TenSanPham,@Gia,@SoLuong,@MaSize)
end
GO
/****** Object:  StoredProcedure [dbo].[create_TaiKhoanVaChiTietTaiKhoan]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[create_TaiKhoanVaChiTietTaiKhoan](
    @LoaiTaiKhoan int,
    @TenTaiKhoan nvarchar(250),
    @MatKhau nvarchar(250),
    @Email nvarchar(250),
    @Hoten nvarchar(250),
    @DiaChi nvarchar(250),
    @SDT nvarchar(250))
AS
BEGIN
    DECLARE @MaTaiKhoan int;

    -- Phần 1: Tạo tài khoản và lấy MaTaiKhoan mới
    BEGIN
        INSERT INTO TaiKhoan(LoaiTaiKhoan, TenTaiKhoan, MatKhau, Email)
        VALUES (@LoaiTaiKhoan, @TenTaiKhoan, @MatKhau, @Email);

        -- Lấy MaTaiKhoan mới tạo
        SET @MaTaiKhoan = SCOPE_IDENTITY();
    END;

    -- Phần 2: Tạo chi tiết tài khoản với MaTaiKhoan mới
    BEGIN
        INSERT INTO KhachHang( TenKH, DiaChi, SDT, MaTaiKhoan)
        VALUES ( @Hoten, @DiaChi, @SDT, @MaTaiKhoan);
    END;
END;
GO
/****** Object:  StoredProcedure [dbo].[CTHD_GetByID]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[CTHD_GetByID]
@MaID int
as
begin
select * from ChiTietHoaDons as k inner join SanPhams as s on k.MaSanPham=s.MaSanPham 
where k.MaChiTietHoaDon=@MaID 
end
GO
/****** Object:  StoredProcedure [dbo].[Delete_chuyen_muc]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Delete_chuyen_muc](
@MaChuyenMuc int
)
as
begin
	delete from ChuyenMucs
	where MaChuyenMuc=@MaChuyenMuc
end
GO
/****** Object:  StoredProcedure [dbo].[delete_giohang]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[delete_giohang]
as
begin
	delete from GioHang 
end
GO
/****** Object:  StoredProcedure [dbo].[delete_khachhang]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[delete_khachhang](@MaKH nvarchar(50))
as
begin
	delete from KhachHang where MaKH=@MaKH
end
GO
/****** Object:  StoredProcedure [dbo].[delete_NPP]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[delete_NPP](@MaNPP int)
as
begin
	delete from NhaPhanPhois where MaNhaPhanPhoi=@MaNPP
end
GO
/****** Object:  StoredProcedure [dbo].[Get_all_GioHang]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Get_all_GioHang]
as
begin
	select*from GioHang
end
GO
/****** Object:  StoredProcedure [dbo].[Get_all_Size]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_all_Size] (@page_index  INT, 
                                       @page_size   INT,
									   @ten_SP Nvarchar(50)
									   )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY sz.TenSize ASC)) AS RowNumber, 
							  s.MaSize,
							  sz.TenSize
							  
                        INTO #Results1
                        FROM SanPhams  s
						inner join Size sz on s.MaSize = sz.MaSize
					    WHERE  (@ten_SP = '' Or s.TenSanPham = @ten_SP) 					
						          
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY sz.TenSize ASC)) AS RowNumber, 
							  s.MaSize,
							  sz.TenSize
							
                        INTO #Results2
                        FROM SanPhams  s
						inner join Size sz on s.MaSize = sz.MaSize
					    WHERE  (@ten_SP = '' Or s.TenSanPham = @ten_SP) 	
						SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2                        
                        DROP TABLE #Results2; 
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[Get_List_CTHD]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Get_List_CTHD] (@MaHD INT)
AS
BEGIN
    SELECT 
        c.MaHoaDon,
        c.MaSanPham,
        s.TenSanPham,
        s.AnhDaiDien,
        c.SoLuong,
        c.TongGia,
        c.GiamGia,
        c.MaSize,
        si.TenSize
    FROM ChiTietHoaDons c
    INNER JOIN SanPhams s ON c.MaSanPham = s.MaSanPham
    INNER JOIN SanPhamChiTiet spct ON s.MaSanPham = spct.MaSP AND c.MaSize = spct.MaSize
    INNER JOIN Size si ON spct.MaSize = si.MaSize
    WHERE c.MaHoaDon = @MaHD
END;
GO
/****** Object:  StoredProcedure [dbo].[Get_List_CTHDN]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Get_List_CTHDN](@MaHD int)
as
	begin
		select *
		from ChiTietHoaDonNhaps c inner join SanPhams s on c.MaSanPham=s.MaSanPham  
		inner join Size as si on s.MaSize=si.MaSize
		where c.MaHoaDon=@MaHD
end
GO
/****** Object:  StoredProcedure [dbo].[Get_NhaPhanPhoi]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Get_NhaPhanPhoi]
@MaID int
as
begin
select * from NhaPhanPhois as k where k.MaNhaPhanPhoi=@MaID 
end
GO
/****** Object:  StoredProcedure [dbo].[getInforTaiKhoan]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[getInforTaiKhoan](@MaTaiKhoan int)
AS
BEGIN
   select*
	from TaiKhoan as tk inner join ChiTietTaiKhoan as cttk on tk.MaTaiKhoan=cttk.MaTaiKhoan
	where tk.MaTaiKhoan = @MaTaiKhoan
END;
GO
/****** Object:  StoredProcedure [dbo].[HoaDon_Delete]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[HoaDon_Delete](@MaHoaDon int)
as
begin
	delete from HoaDons where MaHoaDon=@MaHoaDon
end
GO
/****** Object:  StoredProcedure [dbo].[HoaDon_getbyid]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[HoaDon_getbyid]
@MaHD int
as
begin
select * from HoaDons as k where k.MaHoaDon=@MaHD
end
GO
/****** Object:  StoredProcedure [dbo].[HoaDon_Search]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[HoaDon_Search] (@page_index  INT, 
                                       @page_size   INT,
									   @ten_khach Nvarchar(50)
									   )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY h.MaHoaDon ASC)) AS RowNumber, 
                              h.MaHoaDon,
							  h.MaKH,
							  h.TrangThai,
							  h.NgayTao,
							  h.TongGia,
							  h.DiaChiGiaoHang,
							  kh.TenKH

                        INTO #Results1
                        FROM HoaDons  h
						inner join ChiTietHoaDons c on c.MaHoaDon = h.MaHoaDon
						inner join KhachHang kh on h.MaKH=kh.MaKH
					    WHERE  (@ten_khach = '' Or kh.TenKH like N'%'+@ten_khach+'%') 
						group by h.MaHoaDon,
							  h.MaKH,
							  h.TrangThai,
							  h.NgayTao,
							  h.TongGia,
							  h.DiaChiGiaoHang,
							  kh.TenKH
					             
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY h.MaHoaDon ASC)) AS RowNumber, 
                              h.MaHoaDon,
							  h.MaKH,
							  h.TrangThai,
							  h.NgayTao,
							  h.TongGia,
							  h.DiaChiGiaoHang,
							  kh.TenKH
                        INTO #Results2
                        FROM HoaDons  h
						inner join ChiTietHoaDons c on c.MaHoaDon = h.MaHoaDon
						inner join KhachHang kh on h.MaKH=kh.MaKH
					    WHERE  (@ten_khach = '' Or kh.TenKH like N'%'+@ten_khach+'%') 		
						group by h.MaHoaDon,
							  h.MaKH,
							  h.TrangThai,
							  h.NgayTao,
							  h.TongGia,
							  h.DiaChiGiaoHang,
							  kh.TenKH

						SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2                        
                        DROP TABLE #Results2; 
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[HoaDonNhap_Delete]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[HoaDonNhap_Delete]
    @MaHD INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- 1. Cập nhật lại số lượng tồn kho trong SanPhamChiTiet
        UPDATE spct
        SET spct.SoLuong = spct.SoLuong - cthd.SoLuong
        FROM SanPhamChiTiet spct
        INNER JOIN ChiTietHoaDonNhaps cthd
            ON spct.MaSP = cthd.MaSanPham AND spct.MaSize = cthd.MaSize
        WHERE cthd.MaHoaDon = @MaHD;

        -- 2. Xóa hóa đơn nhập
        DELETE FROM HoaDonNhaps WHERE MaHoaDon = @MaHD;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrMsg NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrMsg, 16, 1);
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[HoaDonNhap_Search]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[HoaDonNhap_Search] (@page_index  INT, 
                                       @page_size   INT
									   )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY h.MaHoaDon ASC)) AS RowNumber, 
                              h.MaHoaDon,
							  h.MaNhaPhanPhoi,
							  h.NgayTao,
							  h.KieuThanhToan,
							  h.MaTaiKhoan,
							  h.TongTien,
							  n.TenNhaPhanPhoi
                        INTO #Results1
                        FROM HoaDonNhaps  h inner join NhaPhanPhois n on h.MaNhaPhanPhoi=n.MaNhaPhanPhoi
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY h.MaHoaDon ASC)) AS RowNumber, 
                              h.MaHoaDon,
							  h.MaNhaPhanPhoi,
							  h.NgayTao,
							  h.KieuThanhToan,
							  h.MaTaiKhoan,
							  h.TongTien,
							  n.TenNhaPhanPhoi
                        INTO #Results2
                        FROM HoaDonNhaps  h		inner join NhaPhanPhois n on h.MaNhaPhanPhoi=n.MaNhaPhanPhoi
						
						SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2                        
                        DROP TABLE #Results2; 
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[KH_get_by_id]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[KH_get_by_id]
@MaID int
as
begin
select * from KhachHang as k where k.MaKH=@MaID 
end
GO
/****** Object:  StoredProcedure [dbo].[NhaPhanPhoi_search]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[NhaPhanPhoi_search] (@page_index  INT, 
                                 @page_size  int 			  
									   )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY h.MaNhaPhanPhoi ASC)) AS RowNumber, 
                              h.MaNhaPhanPhoi,
							  h.TenNhaPhanPhoi,
							  h.DiaChi,
							  h.SoDienThoai,
							  h.MoTa
                        INTO #Results1
                        FROM NhaPhanPhois as h 
					      
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
						SELECT(ROW_NUMBER() OVER(
                              ORDER BY h.MaNhaPhanPhoi ASC)) AS RowNumber, 
                              h.MaNhaPhanPhoi,
							  h.TenNhaPhanPhoi,
							  h.DiaChi,
							  h.SoDienThoai,
							  h.MoTa
                        INTO #Results2
                        FROM NhaPhanPhois as h 
						
						SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2                        
                        DROP TABLE #Results2; 
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[SanPham_Delete]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SanPham_Delete](@MaSP nvarchar(50))
as
begin
	delete from SanPhams where MaSanPham=@MaSP
end
GO
/****** Object:  StoredProcedure [dbo].[Sanpham_getbyID]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Sanpham_getbyID]
@MaID nvarchar(30)
as
begin
select * from SanPhams as k where k.MaSanPham=@MaID 
end
GO
/****** Object:  StoredProcedure [dbo].[SanPham_search]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SanPham_search] (@page_index  INT, 
                                       @page_size   INT,
									   @TenSP nvarchar(10)
									   )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY h.MaSanPham ASC)) AS RowNumber, 
                              h.MaSanPham,
							  h.MaChuyenMuc,
							  h.TenSanPham,
							  h.AnhDaiDien,
							  h.MaSize,
							  h.Gia,
							  h.SoLuong,
							  s.TenSize,
							  c.TenChuyenMuc
                        INTO #Results1
                        FROM SanPhams  h inner join Size s on h.MaSize=s.MaSize
									inner join ChuyenMucs c on c.MaChuyenMuc=h.MaChuyenMuc
					    where
							(@TenSP = '' Or h.TenSanPham like N'%'+@TenSP+'%') 
						
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY h.MaSanPham ASC)) AS RowNumber, 
                              h.MaSanPham,
							  h.MaChuyenMuc,
							  h.TenSanPham,
							  h.AnhDaiDien,
							  h.MaSize,
							  h.Gia,
							  h.SoLuong,
							   s.TenSize,
							  c.TenChuyenMuc
                        INTO #Results2
                        FROM SanPhams  h inner join Size s on h.MaSize=s.MaSize
									inner join ChuyenMucs c on c.MaChuyenMuc=h.MaChuyenMuc
		
						where
							(@TenSP = '' Or h.TenSanPham like N'%'+@TenSP+'%') 
						
						SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2                        
                        DROP TABLE #Results2; 
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[SanPham_Update]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SanPham_Update]
(
@MaSP int,
@MaChuyenMuc int,
@Anh nvarchar(max),
@TenSanPham nvarchar(max),
@Gia int,
@SoLuong int,
@MaSize int
)
AS
BEGIN
    UPDATE SanPhams
    SET MaChuyenMuc = @MaChuyenMuc,
        AnhDaiDien = @Anh,
        TenSanPham = @TenSanPham,
        Gia = @Gia,
		SoLuong=@SoLuong,
		MaSize=@MaSize
    WHERE MaSanPham = @MaSP;
END;
GO
/****** Object:  StoredProcedure [dbo].[Search_MaKH]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Search_MaKH]( @TenKH nvarchar(250),@DiaChi nvarchar(250),@SDT nvarchar(11))
as
begin
	select*
	from KhachHang k 
	where k.TenKH=@TenKH and k.DiaChi=@DiaChi and k.SDT=@SDT
end 
GO
/****** Object:  StoredProcedure [dbo].[Search_sp_TheoSize]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[Search_sp_TheoSize]( @TenSP nvarchar(250),
									   @MaSize int)
as
begin
	select s.MaSanPham,s.MaChuyenMuc,s.TenSanPham,s.AnhDaiDien,s.Gia,s.SoLuong,s.MaSize,sz.TenSize
	from SanPhams s inner join Size sz on s.MaSize=sz.MaSize 
	where ( @TenSP = '' Or s.TenSanPham like N'%'+ @TenSP+'%') and
							(@MaSize = s.MaSize)
end 
GO
/****** Object:  StoredProcedure [dbo].[Size_get_by_id]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Size_get_by_id]
@MaID nvarchar(30)
as
begin
select * from Size as k where k.MaSize=@MaID 
end
GO
/****** Object:  StoredProcedure [dbo].[Size_search]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[Size_search] (@page_index  INT, 
                                 @page_size  int)
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY h.MaSize ASC)) AS RowNumber, 
                              h.MaSize,
							  h.TenSize,
							  h.Ghichu
                        INTO #Results1
                        FROM Size as h 
					      
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
						SELECT(ROW_NUMBER() OVER(
                              ORDER BY h.MaSize ASC)) AS RowNumber, 
                              h.MaSize,
							  h.TenSize,
							  h.Ghichu
                        INTO #Results2
                        FROM Size as h 
						
						SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2                        
                        DROP TABLE #Results2; 
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_create_KhachHang_va_HoaDon]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_create_KhachHang_va_HoaDon] (
    @TenKH NVARCHAR(50),
    @diachi NVARCHAR(250),
    @sdt NVARCHAR(50),
    @TrangThai BIT,
    @NgayTao DATETIME,
    @DiaChiGiaoHang NVARCHAR(250),
    @TongGia FLOAT,
    @list_json_chitiethoadon NVARCHAR(MAX)
)
AS
BEGIN
    DECLARE @MaKH INT;

    -- Tạo khách hàng mới và lưu mã khách hàng vào @MaKH
    INSERT INTO KhachHang (TenKH, DiaChi, SDT)
    VALUES (@TenKH, @diachi, @sdt);

    -- Lấy MaKH của khách hàng vừa tạo
    SET @MaKH = SCOPE_IDENTITY();

    -- Tạo hóa đơn bán với mã khách hàng vừa tạo
    INSERT INTO HoaDons (TrangThai, NgayTao, TongGia, DiaChiGiaoHang, MaKH)
    VALUES (@TrangThai, @NgayTao, @TongGia, @DiaChiGiaoHang, @MaKH);

    DECLARE @MaHoaDon INT;
    SET @MaHoaDon = SCOPE_IDENTITY();

    -- Thêm các chi tiết hóa đơn
    IF (@list_json_chitiethoadon IS NOT NULL)
    BEGIN
        INSERT INTO ChiTietHoaDons (MaSanPham, MaHoaDon, SoLuong, TongGia, GiamGia)
        SELECT JSON_VALUE(p.value, '$.maSanPham'), @MaHoaDon, JSON_VALUE(p.value, '$.soLuong'), JSON_VALUE(p.value, '$.tongGia'), JSON_VALUE(p.value, '$.giamGia')
        FROM OPENJSON(@list_json_chitiethoadon) AS p;
    END;

    SELECT @MaKH AS 'MaKH', @MaHoaDon AS 'MaHoaDon'; -- Trả về MaKH và MaHoaDon
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_get_all_hoadons_with_details]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_get_all_hoadons_with_details]
AS
BEGIN
    SELECT
        H.MaHoaDon,
        H.TrangThai,
        H.NgayTao,
        H.TongGia,
        H.DiaChiGiaoHang,
        H.MaKH,
        (
            SELECT
                MaSanPham,
                SoLuong,
                TongGia,
                GiamGia
            FROM ChiTietHoaDons CH
            WHERE CH.MaHoaDon = H.MaHoaDon
            FOR JSON AUTO
        ) AS ChiTietHoaDonJSON
    FROM HoaDons H;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_hoa_don_update]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_hoa_don_update]
(@MaHoaDon        int,  
 @MaKH int,
 @TrangThai         nvarchar(1),  
 @NgayTao datetime,
 @TongGia float,
 @DiaChiGiaoHang nvarchar(250),
 @list_json_chitiethoadon NVARCHAR(MAX)
)
AS
    BEGIN
		UPDATE HoaDons
		SET
			TrangThai = @TrangThai,
			NgayTao=@NgayTao,
			DiaChiGiaoHang=@DiaChiGiaoHang,
			TongGia=@TongGia,
			MaKH=@MaKH
		WHERE MaHoaDon = @MaHoaDon;
		
		IF(@list_json_chitiethoadon IS NOT NULL) 
		BEGIN
			 -- Insert data to temp table 
		   SELECT
			  JSON_VALUE(p.value, '$.maChiTietHoaDon') as maChiTietHoaDon,
			  JSON_VALUE(p.value, '$.maHoaDon') as maHoaDon,
			  JSON_VALUE(p.value, '$.maSanPham') as maSanPham,
			  JSON_VALUE(p.value, '$.soLuong') as soLuong,
			  JSON_VALUE(p.value, '$.tongGia') as tongGia,
			  JSON_VALUE(p.value, '$.giamGia') as giamGia,
			  			  JSON_VALUE(p.value, '$.maSize') as maSize,

			  JSON_VALUE(p.value, '$.status') AS status
			  INTO #Results 
		   FROM OPENJSON(@list_json_chitiethoadon) AS p;
		 
		 -- Insert data to table with STATUS = 1;
			INSERT INTO ChiTietHoaDons (MaSanPham, 
						  MaHoaDon,
                          SoLuong, 
                          TongGia,
						  GiamGia,
						  MaSize) 
			   SELECT
				  #Results.maSanPham,
				  @MaHoaDon,
				  #Results.soLuong,
				  #Results.tongGia,
				  #Results.giamGia,
				  #Results.maSize
			   FROM  #Results 
			   WHERE #Results.status = '1' 
			
			-- Update data to table with STATUS = 2
			  UPDATE ChiTietHoaDons		
			  SET
				 SoLuong = #Results.soLuong,
				 TongGia = #Results.tongGia,
				 GiamGia = #Results.giamGia
			  FROM #Results 
			  WHERE  ChiTietHoaDons.maChiTietHoaDon = #Results.maChiTietHoaDon AND #Results.status = '2';
			
			-- Delete data to table with STATUS = 3
			DELETE C
			FROM ChiTietHoaDons C
			INNER JOIN #Results R
				ON C.maChiTietHoaDon=R.maChiTietHoaDon
			WHERE R.status = '3';
			DROP TABLE #Results;
		END;
        SELECT '';
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_hoadon_create]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_hoadon_create]
( 
 @TrangThai nvarchar(1),  
 @NgayTao datetime,
 @DiaChiGiaoHang nvarchar(250),
 @TongGia float,
 @MaKH int,
 @list_json_chitiethoadon NVARCHAR(MAX)
)
AS
    BEGIN
		DECLARE @MaHoaDon INT;
        INSERT INTO HoaDons
                (
				TrangThai,
				NgayTao,
				TongGia,
				DiaChiGiaoHang,
				MaKH
                )
                VALUES
                (
                 @TrangThai,
				 @NgayTao,
				 @TongGia,
				 @DiaChiGiaoHang,
				 @MaKH
                );

				SET @MaHoaDon = (SELECT SCOPE_IDENTITY());
                IF(@list_json_chitiethoadon IS NOT NULL)
                    BEGIN
                        INSERT INTO ChiTietHoaDons
						 (MaSanPham, 
						  MaHoaDon,
                          SoLuong, 
                          TongGia,
						  GiamGia,
						  MaSize
                        )
                    SELECT JSON_VALUE(p.value, '$.maSanPham'), 
                            @MaHoaDon, 
                            JSON_VALUE(p.value, '$.soLuong'), 
                            JSON_VALUE(p.value, '$.tongGia'),
							JSON_VALUE(p.value, '$.giamGia'),
							JSON_VALUE(p.value, '$.maSize')

                    FROM OPENJSON(@list_json_chitiethoadon) AS p;
				-- Cập nhật số lượng sản phẩm
				-- Cập nhật số lượng sản phẩm sau khi thêm chi tiết hóa đơn
						UPDATE spct
						SET spct.SoLuong = spct.SoLuong - cthd.SoLuong
						FROM SanPhamChiTiet spct
						INNER JOIN ChiTietHoaDons cthd
							ON spct.MaSP = cthd.MaSanPham AND spct.MaSize = cthd.MaSize
						WHERE cthd.MaHoaDon = @MaHoaDon;
                END;
        SELECT @MaHoaDon;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_hoadonnhap_create]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_hoadonnhap_create]
( 
 @MaNhaPhanPhoi int,
 @NgayTao datetime,
 @KieuThanhToan nvarchar(250),
 @MaTaiKhoan int,
 @TongTien decimal(18, 0),
 @list_js_ChitietHDN NVARCHAR(MAX)
)
AS
BEGIN
    DECLARE @MaHoaDon INT;
    INSERT INTO HoaDonNhaps
            ( 
            MaNhaPhanPhoi,
            NgayTao,
            KieuThanhToan,
            MaTaiKhoan,
            TongTien
            )
            VALUES
            (
             @MaNhaPhanPhoi,
             @NgayTao, 
             @KieuThanhToan,
             @MaTaiKhoan,
             @TongTien
            );
        
            SET @MaHoaDon = (SELECT SCOPE_IDENTITY());
        
            IF(@list_js_ChitietHDN IS NOT NULL)
            BEGIN
                INSERT INTO ChiTietHoaDonNhaps
                 (
                  MaSanPham,
                  MaHoaDon,
                  SoLuong, 
                  DonViTinh,
                  GiaNhap,
                  TongTien,
				  MaSize
                )
                SELECT  
                    JSON_VALUE(p.value, '$.maSanPham'),
                    @MaHoaDon,
                    JSON_VALUE(p.value, '$.soLuong'), 
                    JSON_VALUE(p.value, '$.donViTinh'),
                    JSON_VALUE(p.value,'$.giaNhap'),
                    JSON_VALUE(p.value, '$.tongTien')    ,
					JSON_VALUE(p.value, '$.maSize')
                FROM OPENJSON(@list_js_ChitietHDN) AS p;
				-- === Xử lý cập nhật kho ===
						-- 1. Cộng dồn nếu đã có sản phẩm
						UPDATE sp
						SET sp.SoLuong = sp.SoLuong + cthdn.SoLuong
						FROM SanPhamChiTiet sp
						INNER JOIN ChiTietHoaDonNhaps cthdn
							ON sp.MaSP = cthdn.MaSanPham AND sp.MaSize = cthdn.MaSize
						WHERE cthdn.MaHoaDon = @MaHoaDon;

						-- 2. Thêm mới sản phẩm nếu chưa có
						INSERT INTO SanPhamChiTiet (MaSP, MaSize, SoLuong, TrangThai)
							SELECT cthdn.MaSanPham, cthdn.MaSize, cthdn.SoLuong, 1
							FROM ChiTietHoaDonNhaps cthdn
							LEFT JOIN SanPhamChiTiet spct
								ON spct.MaSP = cthdn.MaSanPham AND spct.MaSize = cthdn.MaSize
							WHERE cthdn.MaHoaDon = @MaHoaDon AND spct.MaSP IS NULL;
						
            END;
    SELECT '';
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_hoadonnhap_update]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_hoadonnhap_update]
(
    @MaHoaDon INT,
    @MaNhaPhanPhoi INT,
    @NgayTao DATETIME,
    @KieuThanhToan NVARCHAR(250),
    @MaTaiKhoan INT,
    @TongTien DECIMAL(18, 0),
    @list_js_ChitietHDN NVARCHAR(MAX)
)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- 1. Cập nhật thông tin hóa đơn
        UPDATE HoaDonNhaps
        SET 
            MaNhaPhanPhoi = @MaNhaPhanPhoi,
            NgayTao = @NgayTao,
            KieuThanhToan = @KieuThanhToan,
            MaTaiKhoan = @MaTaiKhoan,
            TongTien = @TongTien
        WHERE MaHoaDon = @MaHoaDon;

        -- 2. Lấy danh sách chi tiết cũ
        -- Tạm lưu bảng chi tiết cũ để tính toán điều chỉnh kho
        DECLARE @tblChiTietCu TABLE
        (
            MaSanPham INT,
            MaSize INT,
            SoLuong INT
        );

        INSERT INTO @tblChiTietCu(MaSanPham, MaSize, SoLuong)
        SELECT MaSanPham, MaSize, SoLuong
        FROM ChiTietHoaDonNhaps
        WHERE MaHoaDon = @MaHoaDon;

        -- 3. Xóa chi tiết cũ
        DELETE FROM ChiTietHoaDonNhaps WHERE MaHoaDon = @MaHoaDon;

        -- 4. Thêm chi tiết mới từ JSON
        INSERT INTO ChiTietHoaDonNhaps
        (
            MaSanPham,
            MaHoaDon,
            SoLuong,
            DonViTinh,
            GiaNhap,
            TongTien,
            MaSize
        )
        SELECT
            JSON_VALUE(p.value, '$.maSanPham'),
            @MaHoaDon,
            JSON_VALUE(p.value, '$.soLuong'),
            JSON_VALUE(p.value, '$.donViTinh'),
            JSON_VALUE(p.value, '$.giaNhap'),
            JSON_VALUE(p.value, '$.tongTien'),
            JSON_VALUE(p.value, '$.maSize')
        FROM OPENJSON(@list_js_ChitietHDN) AS p;

        -- 5. Tính toán điều chỉnh tồn kho
        -- Bước 1: Bù lại số lượng cũ (trừ đi số lượng cũ)
        UPDATE spct
        SET spct.SoLuong = spct.SoLuong - ct.SoLuong
        FROM SanPhamChiTiet spct
        INNER JOIN @tblChiTietCu ct ON spct.MaSP = ct.MaSanPham AND spct.MaSize = ct.MaSize;

        -- Bước 2: Cộng số lượng mới
        UPDATE spct
        SET spct.SoLuong = spct.SoLuong + cthdn.SoLuong
        FROM SanPhamChiTiet spct
        INNER JOIN ChiTietHoaDonNhaps cthdn
            ON spct.MaSP = cthdn.MaSanPham AND spct.MaSize = cthdn.MaSize
        WHERE cthdn.MaHoaDon = @MaHoaDon;

        -- 6. Thêm mới các sản phẩm tồn kho chưa có trong SanPhamChiTiet
        INSERT INTO SanPhamChiTiet (MaSP, MaSize, SoLuong, TrangThai)
        SELECT 
            cthdn.MaSanPham, 
            cthdn.MaSize, 
            cthdn.SoLuong, 
            1
        FROM ChiTietHoaDonNhaps cthdn
        WHERE cthdn.MaHoaDon = @MaHoaDon
        AND NOT EXISTS (
            SELECT 1 FROM SanPhamChiTiet spct
            WHERE spct.MaSP = cthdn.MaSanPham AND spct.MaSize = cthdn.MaSize
        );

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrMsg NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrMsg, 16, 1);
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_khach_search]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_khach_search] (@page_index  INT, 
                                       @page_size   INT,
									   @ten_khach Nvarchar(50),
									   @dia_chi Nvarchar(250),
										@MaTK int
									   )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY TenKH ASC)) AS RowNumber, 
                              k.MaKH,
							  k.TenKH,
							  k.DiaChi,
							  k.SDT,
							  k.MaTaiKhoan
                        INTO #Results1
                        FROM KhachHang AS k
					    WHERE  (@ten_khach = '' Or k.TenKH like N'%'+@ten_khach+'%') and						
						(@dia_chi = '' Or k.DiaChi like N'%'+@dia_chi+'%') and 
						(@MaTK =0 or @MaTK=k.MaTaiKhoan); 
						
                        SELECT @RecordCount = COUNT(*)--Gắn số lượng hàng vào biến recordCount
                        FROM #Results1;

                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY TenKH ASC)) AS RowNumber, 
                              k.MaKH,
							  k.TenKH,
							  k.DiaChi,
							  k.SDT,
							  k.MaTaiKhoan
                        INTO #Results2
                        FROM KhachHang AS k
					    WHERE  (@ten_khach = '' Or k.TenKH like N'%'+@ten_khach+'%') and						
						(@dia_chi = '' Or k.DiaChi like N'%'+@dia_chi+'%') and
						(@MaTK =0 or @MaTK=k.MaTaiKhoan);                  
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2;                        
                        DROP TABLE #Results1; 
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_login]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[sp_login](@taikhoan nvarchar(50), @matkhau nvarchar(50))
AS
    BEGIN
      SELECT  *
      FROM TaiKhoan
      where TenTaiKhoan= @taikhoan and MatKhau = @matkhau;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_thong_ke_khachhang]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_thong_ke_khachhang] (@page_index  INT, 
                                       @page_size   INT,
									   @ten_khach Nvarchar(50),
									   @fr_NgayTao datetime, 
									   @to_NgayTao datetime
									   )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY h.NgayTao ASC)) AS RowNumber, 
                              s.MaSanPham,
							  s.TenSanPham,
							  c.SoLuong,
							  c.TongGia,
							  h.NgayTao,
							  kh.TenKH,
							  kh.Diachi
                        INTO #Results1
                        FROM HoaDons  h
						inner join ChiTietHoaDons c on c.MaHoaDon = h.MaHoaDon
						inner join SanPhams s on s.MaSanPham = c.MaSanPham 
						inner join KhachHang kh on h.MaKH=kh.MaKH
					    WHERE  (@ten_khach = '' Or kh.TenKH like N'%'+@ten_khach+'%') and						
							h.NgayTao >= @fr_NgayTao AND h.NgayTao <= DATEADD(day, 1, @to_NgayTao);             
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY h.NgayTao ASC)) AS RowNumber, 
                              s.MaSanPham,
							  s.TenSanPham,
							  c.SoLuong,
							  c.TongGia,
							  h.NgayTao,
							  kh.TenKH,
							  kh.Diachi
                        INTO #Results2
                        FROM HoaDons  h
						inner join ChiTietHoaDons c on c.MaHoaDon = h.MaHoaDon
						inner join SanPhams s on s.MaSanPham = c.MaSanPham
						inner join KhachHang kh on h.MaKH=kh.MaKH
					    WHERE  (@ten_khach = '' Or kh.TenKH like N'%'+@ten_khach+'%') and						
						h.NgayTao >= @fr_NgayTao AND h.NgayTao <= DATEADD(day, 1, @to_NgayTao);
						SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2                        
                        DROP TABLE #Results2; 
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[ThongKeDoanhThu]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ThongKeDoanhThu]
    @from_Ngay DATETIME,
    @to_Ngay DATETIME
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        --N'Tổng' AS Ngay,
        COUNT( c.MaHoaDon) AS SoDonHang,
        SUM(h.TongGia) AS DoanhThu,
		sum(c.SoLuong) as SoLuongSP
    FROM 
        HoaDons h inner join ChiTietHoaDons c on h.MaHoaDon=c.MaHoaDon
    WHERE 
         h.NgayTao >= @from_Ngay AND h.NgayTao <= DATEADD(day, 1, @to_Ngay);
END;
GO
/****** Object:  StoredProcedure [dbo].[thongkeTopCustomer]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[thongkeTopCustomer]( @fr_NgayTao datetime, 
									   @to_NgayTao datetime)
as
begin
	select k.MaKH,k.TenKH,k.DiaChi,k.SDT,Sum(c.SoLuong)as TongMua
	from KhachHang as k inner join HoaDons as h on k.MaKH=h.MaKH
						inner join ChiTietHoaDons as c on c.MaHoaDon=h.MaHoaDon
	where h.NgayTao >= @fr_NgayTao AND h.NgayTao <= DATEADD(day, 1, @to_NgayTao)
	group by k.MaKH,k.TenKH,k.DiaChi,k.SDT
	order by Sum(c.SoLuong) desc
	
end
GO
/****** Object:  StoredProcedure [dbo].[Update_chuyen_muc]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc  [dbo].[Update_chuyen_muc](
@MaChuyenMuc int,
@TenChuyenMuc nvarchar(250),
@NoiDung nvarchar(250)
)
as
begin
	update ChuyenMucs
	set TenChuyenMuc=@TenChuyenMuc,
		NoiDung=@NoiDung
	where
		MaChuyenMuc=@MaChuyenMuc
end
GO
/****** Object:  StoredProcedure [dbo].[update_khach_hang]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[update_khach_hang](
@MaKH nvarchar(50),
@TenKH nvarchar(50),
@diachi nvarchar(250),
@sdt nvarchar(50))
as
begin
	update KhachHang
	set TenKH=@TenKH, DiaChi=@diachi, SDT=@sdt
	where @MaKH=MaKH
end
GO
/****** Object:  StoredProcedure [dbo].[update_NhaPhanPhoi]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[update_NhaPhanPhoi](
@MaNPP int,
@TenNPP nvarchar(50),
@diachi nvarchar(250),
@sdt nvarchar(50))
as
begin
	update NhaPhanPhois
	set TenNhaPhanPhoi=@TenNPP, DiaChi=@diachi, SoDienThoai=@sdt
	where @MaNPP=MaNhaPhanPhoi
end
GO
/****** Object:  StoredProcedure [dbo].[User_Ao_Nam_Search]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[User_Ao_Nam_Search] (@page_index  INT, 
                                       @page_size   INT,
									   @TenCM nvarchar(10),
									   @TenSize nvarchar(10)
									   )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY h.MaSanPham ASC)) AS RowNumber, 
                              h.MaSanPham,
							  h.MaChuyenMuc,
							  c.TenChuyenMuc,
							  h.TenSanPham,
							  h.AnhDaiDien,
							  h.MaSize,
							  s.TenSize,
							  h.Gia,
							  h.SoLuong
							
                        INTO #Results1
                        FROM SanPhams  h
						inner join ChuyenMucs c on c.MaChuyenMuc = h.MaChuyenMuc
						inner join Size s on s.MaSize = h.MaSize
					    where
							(@TenCM = '' Or c.TenChuyenMuc like N'%'+@TenCM+'%') and
							(@TenSize = '' Or s.TenSize like N'%'+@TenSize+'%')
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY h.MaSanPham ASC)) AS RowNumber, 
                              h.MaSanPham,
							  h.MaChuyenMuc,
							  c.TenChuyenMuc,
							  h.TenSanPham,
							  h.AnhDaiDien,
							  h.MaSize,
							  s.TenSize,
							  h.Gia,
							  h.SoLuong
                        INTO #Results2
                        FROM SanPhams  h
						inner join ChuyenMucs c on c.MaChuyenMuc = h.MaChuyenMuc
						inner join Size s on s.MaSize = h.MaSize
						where
							(@TenCM = '' Or c.TenChuyenMuc like N'%'+@TenCM+'%') and
							(@TenSize = '' Or s.TenSize like N'%'+@TenSize+'%')
						SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2                        
                        DROP TABLE #Results2; 
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[User_Chuyenmuc_search]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[User_Chuyenmuc_search] (@page_index  INT, 
                                 @page_size  int,
								 @TenChuyenMuc nvarchar(250))
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY h.MaChuyenMuc ASC)) AS RowNumber, 
                              h.MaChuyenMuc,
							  h.TenChuyenMuc,
							  h.DacBiet,
							  h.NoiDung
							  
                        INTO #Results1
                        FROM ChuyenMucs as h 
					    where (@TenChuyenMuc IS NULL OR h.TenChuyenMuc LIKE '%' + @TenChuyenMuc + '%'); -- New condition for category name
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
						SELECT(ROW_NUMBER() OVER(
                              ORDER BY h.MaChuyenMuc ASC)) AS RowNumber, 
                              h.MaChuyenMuc,
							  h.TenChuyenMuc,
							  h.DacBiet,
							  h.NoiDung
                        INTO #Results2
                        FROM ChuyenMucs as h 
						 where (@TenChuyenMuc IS NULL OR h.TenChuyenMuc LIKE '%' + @TenChuyenMuc + '%'); -- New condition for category name
						SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2                        
                        DROP TABLE #Results2; 
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[user_HistoryCart]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[user_HistoryCart] (
				@MaKH int,
				@TrangThai nvarchar(1) = null
					)
AS
    BEGIN
       select h.MaHoaDon,h.DiaChiGiaoHang,h.NgayTao,h.TrangThai,s.TenSanPham,s.AnhDaiDien,s.Gia,c.SoLuong,c.TongGia,si.TenSize
	   from HoaDons as h inner join KhachHang as k on k.MaKH=h.MaKH 
	   inner join ChiTietHoaDons as c on c.MaHoaDon = h.MaHoaDon
	   inner join SanPhams as s on s.MaSanPham=c.MaSanPham 
	   inner join Size as si on si.MaSize=s.MaSize
      where @MaKH=k.MaKH and
			(@TrangThai IS NULL OR h.TrangThai = @TrangThai)
    END;
GO
/****** Object:  StoredProcedure [dbo].[User_Hot_Product]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[User_Hot_Product] (@page_index  INT, 
                                       @page_size   INT,
									   @fr_NgayTao datetime, 
									   @to_NgayTao datetime
									   )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY SUM(c.SoLuong) DESC)) AS RowNumber, 
						      s.MaSanPham,
							  s.TenSanPham,
							  s.AnhDaiDien,
							  SUM(c.SoLuong) AS TongSoLuong,
							  s.Gia,
							  h.NgayTao
							 
                        INTO #Results1
                        FROM HoaDons  h
						inner join ChiTietHoaDons c on c.MaHoaDon = h.MaHoaDon
						inner join SanPhams s on s.MaSanPham = c.MaSanPham
					    WHERE  						
						((@fr_NgayTao IS NULL
                        AND @to_NgayTao IS NULL)
                        OR (@fr_NgayTao IS NOT NULL
                            AND @to_NgayTao IS NULL
                            AND h.NgayTao >= @fr_NgayTao)
                        OR (@fr_NgayTao IS NULL
                            AND @to_NgayTao IS NOT NULL
                            AND h.NgayTao <= @to_NgayTao)
                        OR (h.NgayTao BETWEEN @fr_NgayTao AND @to_NgayTao))       
						GROUP BY s.MaSanPham, s.TenSanPham, s.AnhDaiDien, s.Gia, h.NgayTao
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY SUM(c.SoLuong) DESC)) AS RowNumber, 
                              s.MaSanPham,
							  s.TenSanPham,
							  s.AnhDaiDien,
							  SUM(c.SoLuong) AS TongSoLuong,
							  s.Gia,
							  h.NgayTao
                        INTO #Results2
                        FROM HoaDons  h
						inner join ChiTietHoaDons c on c.MaHoaDon = h.MaHoaDon
						inner join SanPhams s on s.MaSanPham = c.MaSanPham
					    WHERE  					
						((@fr_NgayTao IS NULL
                        AND @to_NgayTao IS NULL)
                        OR (@fr_NgayTao IS NOT NULL
                            AND @to_NgayTao IS NULL
                            AND h.NgayTao >= @fr_NgayTao)
                        OR (@fr_NgayTao IS NULL
                            AND @to_NgayTao IS NOT NULL
                            AND h.NgayTao <= @to_NgayTao)
                        OR (h.NgayTao BETWEEN @fr_NgayTao AND @to_NgayTao))
						GROUP BY s.MaSanPham, s.TenSanPham, s.AnhDaiDien, s.Gia, h.NgayTao
						SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2                        
                        DROP TABLE #Results2; 
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[User_New_Products]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[User_New_Products] (@page_index  INT, 
                                       @page_size   INT
									   --@fr_NgayTao datetime, 
									   --@to_NgayTao datetime
									   )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY h.NgayTao DESC)) AS RowNumber, 
						      s.MaSanPham,
							  s.TenSanPham,
							  s.AnhDaiDien,
							  s.Gia,
							  h.NgayTao
							 
                        INTO #Results1
                        FROM HoaDonNhaps  h
						inner join ChiTietHoaDonNhaps c on c.MaHoaDon = h.MaHoaDon
						inner join SanPhams s on s.MaSanPham = c.MaSanPham 
					 --   WHERE  						
						--((@fr_NgayTao IS NULL
      --                  AND @to_NgayTao IS NULL)
      --                  OR (@fr_NgayTao IS NOT NULL
      --                      AND @to_NgayTao IS NULL
      --                      AND h.NgayTao >= @fr_NgayTao)
      --                  OR (@fr_NgayTao IS NULL
      --                      AND @to_NgayTao IS NOT NULL
      --                      AND h.NgayTao <= @to_NgayTao)
      --                  OR (h.NgayTao BETWEEN @fr_NgayTao AND @to_NgayTao))       
						GROUP BY s.MaSanPham, s.TenSanPham, s.AnhDaiDien, s.Gia, h.NgayTao
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY h.NgayTao DESC)) AS RowNumber, 
						      s.MaSanPham,
							  s.TenSanPham,
							  s.AnhDaiDien,
							  s.Gia,
							  h.NgayTao
							 
                        INTO #Results2
                        FROM HoaDonNhaps  h
						inner join ChiTietHoaDonNhaps c on c.MaHoaDon = h.MaHoaDon
						inner join SanPhams s on s.MaSanPham = c.MaSanPham 
					 --   WHERE  					
						--((@fr_NgayTao IS NULL
      --                  AND @to_NgayTao IS NULL)
      --                  OR (@fr_NgayTao IS NOT NULL
      --                      AND @to_NgayTao IS NULL
      --                      AND h.NgayTao >= @fr_NgayTao)
      --                  OR (@fr_NgayTao IS NULL
      --                      AND @to_NgayTao IS NOT NULL
      --                      AND h.NgayTao <= @to_NgayTao)
      --                  OR (h.NgayTao BETWEEN @fr_NgayTao AND @to_NgayTao))
						GROUP BY s.MaSanPham, s.TenSanPham, s.AnhDaiDien, s.Gia, h.NgayTao
						SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2                        
                        DROP TABLE #Results2; 
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[USer_SanPham_search]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USer_SanPham_search] (@page_index  INT, 
                                       @page_size   INT,
									   @TenSP nvarchar(250),
									   @TenSize nvarchar(10),
									   @MinPrice int,
									   @MaxPrice int
									   )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY h.MaSanPham ASC)) AS RowNumber, 
                              h.MaSanPham,
							  h.MaChuyenMuc,
							  c.TenChuyenMuc,
							  h.TenSanPham,
							  h.AnhDaiDien,
							  h.MaSize,
							  s.TenSize,
							  h.Gia,
							  h.SoLuong
							
                        INTO #Results1
                        FROM SanPhams  h
						inner join ChuyenMucs c on c.MaChuyenMuc = h.MaChuyenMuc
						inner join Size s on s.MaSize = h.MaSize
					    where
							(@TenSP = '' Or h.TenSanPham = @TenSP) and
							(@TenSize = '' Or s.TenSize = @TenSize) 
							and	(@MinPrice =0  or h.Gia >= @MinPrice)
							and(@MaxPrice =0  or h.Gia <= @MaxPrice)
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY h.MaSanPham ASC)) AS RowNumber, 
                              h.MaSanPham,
							  h.MaChuyenMuc,
							  c.TenChuyenMuc,
							  h.TenSanPham,
							  h.AnhDaiDien,
							  h.MaSize,
							  s.TenSize,
							  h.Gia,
							  h.SoLuong
                        INTO #Results2
                        FROM SanPhams  h
						inner join ChuyenMucs c on c.MaChuyenMuc = h.MaChuyenMuc
						inner join Size s on s.MaSize = h.MaSize
						 where
							(@TenSP = '' Or h.TenSanPham = @TenSP) and
							(@TenSize = '' Or s.TenSize = @TenSize) 
							and	(@MinPrice =0  or h.Gia >= @MinPrice)
							and(@MaxPrice =0  or h.Gia <= @MaxPrice)
						SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2                        
                        DROP TABLE #Results2; 
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[User_Selling_Products]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[User_Selling_Products] (@page_index  INT, 
                                       @page_size   INT		   
									   )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT (ROW_NUMBER() OVER(
                              ORDER BY SUM(c.SoLuong) DESC)) AS RowNumber, 
                              s.MaSanPham,
							  s.TenSanPham,
							  s.AnhDaiDien,
							  SUM(c.SoLuong) AS SoLuongBan,
							  s.Gia
                        INTO #Results1
                        FROM SanPhams  s
						inner join ChiTietHoaDons c on s.MaSanPham= c.MaSanPham
						GROUP BY s.MaSanPham, s.TenSanPham, s.AnhDaiDien, s.Gia
						
					
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
                        SELECT (ROW_NUMBER() OVER(
                              ORDER BY SUM(c.SoLuong) DESC)) AS RowNumber, 
                              s.MaSanPham,
							  s.TenSanPham,
							  s.AnhDaiDien,
							  SUM(c.SoLuong) AS SoLuongBan,
							  s.Gia
                        INTO #Results2
                        FROM SanPhams  s
						inner join ChiTietHoaDons c on s.MaSanPham= c.MaSanPham
						GROUP BY s.MaSanPham, s.TenSanPham, s.AnhDaiDien, s.Gia

					
						SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2                        
                        DROP TABLE #Results2; 
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[User_SP_Search_ChuyenMuc]    Script Date: 25/06/2025 4:02:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[User_SP_Search_ChuyenMuc] (@page_index  INT, 
                                       @page_size   INT,
									   @MaCM int)
									   
									   
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY h.MaSanPham ASC)) AS RowNumber, 
                              h.MaSanPham,
							  h.MaChuyenMuc,
							  c.TenChuyenMuc,
							  h.TenSanPham,
							  h.AnhDaiDien,
							  h.MaSize,
							 
							  h.Gia,
							  h.SoLuong
							
                        INTO #Results1
                        FROM SanPhams  h
						inner join ChuyenMucs c on c.MaChuyenMuc = h.MaChuyenMuc
					    where
							h.MaChuyenMuc=@MaCM
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY h.MaSanPham ASC)) AS RowNumber, 
                              h.MaSanPham,
							  h.MaChuyenMuc,
							  c.TenChuyenMuc,
							  h.TenSanPham,
							  h.AnhDaiDien,
							  h.MaSize,
							  h.Gia,
							  h.SoLuong
                        INTO #Results2
                        FROM SanPhams  h
						inner join ChuyenMucs c on c.MaChuyenMuc = h.MaChuyenMuc
						where
							h.MaChuyenMuc=@MaCM
						SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2                        
                        DROP TABLE #Results2; 
        END;
    END;
GO
