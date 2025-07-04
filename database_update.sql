USE [BTL_API_BLBH]
GO
/****** Object:  Table [dbo].[BaiViet]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  Table [dbo].[ChiTietHoaDonNhaps]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  Table [dbo].[ChiTietHoaDons]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  Table [dbo].[ChiTietTaiKhoan]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  Table [dbo].[ChuyenMucs]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  Table [dbo].[DanhGiaSanPham]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  Table [dbo].[GiamGia]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  Table [dbo].[GiamGia_SanPham]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  Table [dbo].[HoaDonNhaps]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  Table [dbo].[HoaDons]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  Table [dbo].[KhachHang]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  Table [dbo].[LoaiTaiKhoan]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  Table [dbo].[Location]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  Table [dbo].[MauSac]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  Table [dbo].[NhaPhanPhois]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  Table [dbo].[Owner]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  Table [dbo].[SanPhamChiTiet]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  Table [dbo].[SanPhams]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  Table [dbo].[SanPhams_NhaPhanPhois]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  Table [dbo].[Size]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  Table [dbo].[TaiKhoan]    Script Date: 25/06/2025 5:04:44 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThanhToanVNPay]    Script Date: 25/06/2025 5:04:44 PM ******/
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
SET IDENTITY_INSERT [dbo].[BaiViet] ON 

INSERT [dbo].[BaiViet] ([BaiVietID], [TieuDe], [NoiDung], [NgayTao], [TaiKhoanID]) VALUES (2, N'Giới thiệu 4MEN', N'<p class="ql-align-justify"><span style="color: rgb(0, 0, 0);">Thương hiệu thời&nbsp;trang nam 4MEN được&nbsp;thành lập từ tháng 3 năm 2010, là thương hiệu thời trang&nbsp;uy tín hàng đầu tại Việt Nam dành riêng cho phái mạnh.</span></p><p class="ql-align-justify"><br></p><p class="ql-align-justify"><strong style="color: rgb(0, 0, 0);">SỨ MỆNH</strong></p><p class="ql-align-justify"><span style="color: rgb(0, 0, 0);">Không ngừng sáng tạo và tỉ mỉ từ công đoạn sản xuất đến các khâu&nbsp;dịch vụ, nhằm&nbsp;mang đến&nbsp;cho Quý Khách Hàng những trải nghiệm mua sắm&nbsp;đặc biệt&nbsp;nhất: sản phẩm chất lượng - dịch vụ&nbsp;hoàn hảo - xu hướng thời trang mới mẻ và tinh tế. Thông qua các sản phẩm thời trang, 4MEN luôn mong muốn&nbsp;truyền tải đến bạn&nbsp;những thông điệp tốt đẹp cùng với&nbsp;nguồn cảm hứng trẻ trung và&nbsp;tích cực.</span></p><p class="ql-align-justify"><br></p><p class="ql-align-justify"><strong style="color: rgb(0, 0, 0);">TẦM NHÌN</strong></p><p class="ql-align-justify"><span style="color: rgb(0, 0, 0);">Với mục tiêu xây dựng&nbsp;và phát triển những&nbsp;giá trị&nbsp;bền vững,&nbsp;trong 10 năm tới, 4MEN sẽ trở thành thương hiệu&nbsp;dẫn đầu&nbsp;về thời trang phái mạnh trên&nbsp;thị trường Việt Nam.</span></p><p class="ql-align-justify"><strong style="color: rgb(0, 0, 0);">THÔNG ĐIỆP 4MEN GỬI ĐẾN BẠN</strong></p><p class="ql-align-justify"><span style="color: rgb(0, 0, 0);">4MEN muốn truyền cảm hứng tích cực đến các chàng trai: Việc mặc đẹp rất quan trọng, nó thể hiện được cá tính, sự tự tin và cả một phần lối sống, cách suy nghĩ của bản thân. Mặc thanh lịch, sống thanh lịch.</span></p><p class="ql-align-justify"><strong style="color: rgb(0, 0, 0);">Chọn&nbsp;4MEN, bạn đang lựa chọn sự hoàn hảo cho điểm nhấn&nbsp;thời trang của chính mình!</strong></p><p class="ql-align-justify">&nbsp;</p>', CAST(N'2025-05-31T14:31:07.050' AS DateTime), 1)
INSERT [dbo].[BaiViet] ([BaiVietID], [TieuDe], [NoiDung], [NgayTao], [TaiKhoanID]) VALUES (4, N'Chính sách bảo mật', N'<h1>Chính sách bảo mật</h1><p><strong style="color: rgb(0, 0, 0);">1.&nbsp;Mục đích và phạm vi thu thập thông tin</strong></p><p><span style="color: rgb(0, 0, 0);">- Chúng tôi thu thập thông tin từ bạn khi bạn&nbsp;đặt hàng&nbsp;trên trang web hoặc liên hệ email, điện thoại với chúng tôi.&nbsp;Bất kỳ thông tin chúng tôi thu thập từ bạn có thể được sử dụng một trong những cách sau đây:</span></p><p><span style="color: rgb(0, 0, 0);">+ Để cải thiện trang web của chúng tôi&nbsp;(Chúng tôi liên tục cố gắng để cải thiện các dịch vụ trang web của chúng tôi dựa trên các thông tin và phản hồi chúng tôi nhận được từ bạn)</span></p><p><span style="color: rgb(0, 0, 0);">+&nbsp;Để cải thiện dịch vụ khách hàng&nbsp;(Thông tin của bạn sẽ giúp chúng tôi&nbsp;đáp ứng&nbsp;hiệu quả hơn yêu cầu dịch vụ khách hàng và nhu cầu hỗ trợ&nbsp;của bạn)</span></p><p><span style="color: rgb(0, 0, 0);">+ Để xử lý các giao dịch</span></p><p><span style="color: rgb(0, 0, 0);">+ Địa chỉ email mà bạn cung cấp khi xử lý đơn hàng, có thể được sử dụng để gửi cho bạn thông tin và cập nhật liên quan đến đặt hàng của bạn, ngoài việc tiếp nhận tin tức thường xuyên, cập nhật, sản phẩm hoặc dịch vụ liên quan đến thông tin</span></p><p><br></p><p><strong style="color: rgb(0, 0, 0);">2.&nbsp;Phạm vi sử dụng thông tin</strong></p><p><span style="color: rgb(0, 0, 0);">4menshop.com sử dụng thông tin khách hàng trong trường hợp thông báo đơn hàng đến với khách hàng. Không sử dụng thông tin khách hàng cho các mục đích khác mà chưa được sự đồng ý của khách hàng.</span></p><p><br></p><p><strong style="color: rgb(0, 0, 0);">3.&nbsp;Thời gian lưu trữ thông tin</strong></p><p><span style="color: rgb(0, 0, 0);">4menshop.com lưu trữ thông tin khách hàng, đơn hàng nhằm để đối chiếu khi có phát sinh vấn đề xảy ra, không lưu trữ thông tin khác, nhạy cảm của khách hàng như số điện thoại, thông tin địa chỉ..v.v..</span></p><p><br></p><p><strong style="color: rgb(0, 0, 0);">4.&nbsp;Địa chỉ của đơn vị thu thập và quản lý thông tin cá nhân</strong></p><p><span style="color: rgb(0, 0, 0);">4menshop.com lưu trữ thông tin khách hàng thông qua việc khách hàng email đặt hàng, không yêu cầu khách hàng phải để lại thông tin nếu chưa được sự đồng ý.</span></p><p><br></p><p><strong style="color: rgb(0, 0, 0);">5. Phương tiện và công cụ để người dùng tiếp cận và điều chỉnh</strong></p><p><span style="color: rgb(0, 0, 0);">Khách hàng hoàn toàn có thể yêu cầu&nbsp;4menshop.com cung cấp hoặc xóa bỏ thông tin của chính mình nếu có nhu cầu, 4MEN hoàn toàn không sử dụng hoặc chỉnh sửa thông tin khách hàng.</span></p><p><br></p><p><strong style="color: rgb(0, 0, 0);">6.&nbsp;Cam kết bảo mật thông tin cá nhân khách hàng</strong></p><p><span style="color: rgb(0, 0, 0);">- Thông tin của bạn, dù công hay tư, sẽ&nbsp;</span><strong style="color: rgb(0, 0, 0);">không</strong><span style="color: rgb(0, 0, 0);">&nbsp;được bán, trao đổi, chuyển nhượng, hoặc để lộ cho bất kỳ công ty khác cho bất kỳ lý do nào, mà không có sự đồng ý của bạn</span></p><p>- Tất cả các thông tin nhạy cảm chỉ có thể truy cập bởi những người được ủy quyền có quyền truy cập và được yêu cầu để giữ cho các thông tin bí mật.</p>', CAST(N'2025-05-31T14:59:32.163' AS DateTime), 1)
INSERT [dbo].[BaiViet] ([BaiVietID], [TieuDe], [NoiDung], [NgayTao], [TaiKhoanID]) VALUES (5, N'Hướng dẫn đặt hàng', N'<h1>Hướng dẫn đặt hàng</h1><p class="ql-align-justify"><strong style="color: rgb(0, 0, 0);">HƯỚNG DẪN MUA HÀNG TẠI HỆ THỐNG CỬA HÀNG THỜI TRANG&nbsp;4MEN</strong></p><p class="ql-align-justify"><span style="color: rgb(0, 0, 0);">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p><p class="ql-align-justify"><span style="color: rgb(0, 0, 0);">4MEN - hệ thống&nbsp;thời trang nam uy tín hiện đang sở hữu đến 15 chi nhánh, phân bố&nbsp;rộng khắp khu vực Đông Nam Bộ và Tây Nam Bộ. Quý khách hàng khi đến với hệ thống cửa hàng của 4MEN có thể hoàn toàn tin tưởng và hài lòng, từ&nbsp;phong cách và chất lượng&nbsp;sản cho đến thái độ, quy cách của nhân viên luôn được kiểm&nbsp;soát một cách chặt chẽ, đảm bảo quý&nbsp;khách hàng phải được phục vụ một cách chu đáo, chất lượng nhất.</span></p><p class="ql-align-justify"><span style="color: rgb(0, 0, 0);">Ngoài việc&nbsp;tham khảo hoặc liên hệ với 4MEN&nbsp;để được giải đáp&nbsp;mọi vấn đề liên quan đến&nbsp;cửa hàng, sản phẩm,... Quý khách hàng có thể&nbsp;trực tiếp đến Store&nbsp;4MEN gần nhất để tham gia mua sắm và nhận thêm&nbsp;nhiều ưu đãi hấp dẫn khác.</span></p><p class="ql-align-justify">&nbsp;</p><p class="ql-align-justify"><strong style="color: rgb(0, 0, 0);">HỆ THỐNG CỬA HÀNG THỜI TRANG 4MEN</strong></p><p class="ql-align-justify"><strong style="color: rgb(0, 0, 0);">4MEN KHU VỰC TP.HCM</strong></p><ul><li class="ql-align-justify"><strong>Chi nhánh Quận 3</strong>&nbsp;</li><li class="ql-align-justify">- Địa chỉ: 458 Lê Văn Sỹ, P.14, Q.3&nbsp;</li><li class="ql-align-justify">- Điện thoại:&nbsp;<span style="color: rgb(34, 34, 34);">0865413593</span></li><li class="ql-align-justify"><strong>Chi nhánh Quận 7</strong>&nbsp;</li><li class="ql-align-justify">- Địa chỉ: 384 Huỳnh Tấn Phát, P. Bình Thuận, Q.7&nbsp;</li><li class="ql-align-justify">- Điện thoại: 0968 168 584</li><li class="ql-align-justify"><strong>Chi nhánh Quận 9</strong>&nbsp;</li><li class="ql-align-justify">- Địa chỉ: 199 Đỗ Xuân Hợp, P. Phước Long B, Q.9</li><li class="ql-align-justify">- Điện thoại: 02866 595 044</li><li class="ql-align-justify"><strong>Chi nhánh Quận Gò Vấp</strong></li><li class="ql-align-justify">- Địa chỉ: 526 Quang Trung, P.11, Q. Gò Vấp&nbsp;</li><li class="ql-align-justify">- Điện thoại: 0989 830 685</li><li class="ql-align-justify"><strong>Chi nhánh Quận Bình Thạnh</strong></li><li class="ql-align-justify">- Địa chỉ:&nbsp;50 Nguyễn Gia Trí (Đường D2 cũ), P.25, Q. Bình Thạnh</li><li class="ql-align-justify">- Điện thoại:&nbsp;02866827164</li><li class="ql-align-justify"><strong>Chi nhánh Tân Phú</strong>&nbsp;</li><li class="ql-align-justify">- Địa chỉ: 533 Âu Cơ, P. Phú Trung, Q. Tân Phú&nbsp;</li><li class="ql-align-justify">- Điện thoại: 0286 286 9504</li><li class="ql-align-justify"><strong>Chi nhánh Bình Tân</strong>&nbsp;</li><li class="ql-align-justify">- Địa chỉ: 69-71 Nguyễn Thị Tú, P. Bình Hưng Hòa B, Q. Bình Tân&nbsp;</li><li class="ql-align-justify">- Điện thoại: 0286 2755 746</li><li class="ql-align-justify"><strong>Chi nhánh Tân Bình</strong>&nbsp;</li><li class="ql-align-justify">- Địa chỉ: 798 Cách Mạng Tháng 8, P.5, Q. Tân Bình&nbsp;</li><li class="ql-align-justify">- Điện thoại: 0975 215 734</li><li class="ql-align-justify"><strong>Chi nhánh Hóc Môn</strong>&nbsp;</li><li class="ql-align-justify">- Địa chỉ: 122 Nguyễn Ảnh Thủ, Trung Chánh, H. Hóc Môn&nbsp;</li><li class="ql-align-justify">- Điện thoại: 0383 261 004</li><li class="ql-align-justify"><strong>Chi nhánh Thủ Đức</strong>&nbsp;</li><li class="ql-align-justify">- ĐC: 166 Võ Văn Ngân, P. Bình Thọ, Q. Thủ Đức&nbsp;</li><li class="ql-align-justify">- Điện thoại: 0394 945 773</li></ul><h3 class="ql-align-justify"><strong>4MEN&nbsp;ĐÔNG NAM BỘ</strong></h3><ul><li class="ql-align-justify"><strong>Chi nhánh Biên Hòa - Đồng Nai</strong>&nbsp;</li><li class="ql-align-justify">- Địa chỉ: 1333 Phạm Văn Thuận, P. Thống Nhất, Tp. Biên Hòa&nbsp;</li><li class="ql-align-justify">- Điện thoại: 0251 655 7607</li><li class="ql-align-justify"><strong>Chi nhánh Vũng Tàu</strong>&nbsp;</li><li class="ql-align-justify">- Địa chỉ: 344 Trương Công Định, P.8, TP. Vũng Tàu&nbsp;</li><li class="ql-align-justify">- Điện thoại: 0254 6545 009<strong>&nbsp;</strong></li><li class="ql-align-justify"><strong>Chi nhánh&nbsp;Thủ Dầu Một - Bình Dương</strong></li><li class="ql-align-justify">- Địa chỉ:&nbsp;103 đường Yersin , P. Phú Cường, Tp. Thủ Dầu Một, Bình Dương</li><li class="ql-align-justify">- Điện thoại:&nbsp;0365 836 367</li></ul><h3 class="ql-align-justify"><strong>4MEN TÂY NAM BỘ</strong></h3><ul><li class="ql-align-justify"><strong>Chi nhánh Long Xuyên - An Giang</strong>&nbsp;</li><li class="ql-align-justify">- Địa chỉ: 904C Hà Hoàng Hổ, P. Mỹ Xuyên, Tp. Long Xuyên&nbsp;</li><li class="ql-align-justify">- Điện thoại: 0865 738 031</li><li class="ql-align-justify"><strong>Chi nhánh Cần Thơ</strong></li><li class="ql-align-justify">- Địa chỉ:&nbsp;73 Nguyễn Việt Hồng, P. An Phú, Q. Ninh Kiều, Cần Thơ</li><li class="ql-align-justify">- Điện thoại:&nbsp;0989 662 315</li></ul><p class="ql-align-justify"><span style="color: rgb(178, 34, 34);">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p><p class="ql-align-justify"><strong style="color: rgb(0, 0, 0);">HƯỚNG DẪN MUA HÀNG QUA ĐIỆN THOẠI</strong></p><p class="ql-align-justify">&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: rgb(0, 0, 0);">&nbsp;&nbsp;</span></p><p class="ql-align-justify"><span style="color: rgb(0, 0, 0);">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>Quý khách vui lòng gọi vào số:&nbsp;<span style="color: rgb(0, 0, 255);">0868.444.644</span>&nbsp;để cung cấp các thông tin: Mã hàng, size, số lượng, tên, số điện thoại&nbsp;và địa chỉ người nhận hàng. Nhân viên tổng đài 4MEN sẽ tư vấn cách thức đặt hàng dễ dàng và nhanh nhất cho quý khách.</p><p class="ql-align-justify">&nbsp;</p><p class="ql-align-justify"><strong style="color: rgb(0, 0, 0);">HƯỚNG DẪN MUA HÀNG QUA WEBSITE 4MEN</strong></p><p class="ql-align-justify"><br></p><p class="ql-align-justify"><strong>Để mua hàng online qua website 4MEN, quý khách vui lòng làm theo các bước hướng dẫn sau:</strong></p><p class="ql-align-justify"><strong>Bước đầu tiên</strong>:&nbsp;Tại sản phẩm cần mua,&nbsp;<strong>chọn size</strong>,&nbsp;<strong>chọn số lượng</strong>, sau đó:</p><p class="ql-align-justify">- Nhấp&nbsp;vào&nbsp;ô&nbsp;<span style="color: rgb(0, 0, 255);">MUA NGAY</span>&nbsp;,&nbsp;tiếp tục chuyển qua bước 1</p><p class="ql-align-center"><br></p><p class="ql-align-center"><img src="http://4menshop.com/images/2017/12/20171206_403db50aded604ff243f8b2750b1567f_1512550567.jpg" alt="Hướng dẫn đặt hàng - 1"></p><p class="ql-align-justify"><br></p><p class="ql-align-justify"><strong>BƯỚC&nbsp;1: Nhập&nbsp;thông tin cần thiết</strong></p><p class="ql-align-justify">- Kiểm tra lại thông tin sản phẩm đặt hàng&nbsp;(tên sản phẩm, số lượng, size,&nbsp;đơn giá)&nbsp;tại mục&nbsp;<span style="color: rgb(255, 0, 0);">1</span>&nbsp;ở cột&nbsp;<strong>"Giỏ hàng của bạn"</strong>&nbsp;bên phải</p><p class="ql-align-justify">-&nbsp;Nhập thông tin liên hệ đầy đủ của người mua tại mục&nbsp;&nbsp;<span style="color: rgb(255, 0, 0);">2</span></p><p class="ql-align-justify">- Nhập địa chỉ giao hàng tại mục&nbsp;&nbsp;<span style="color: rgb(255, 0, 0);">3</span></p><p class="ql-align-justify">- Quý khách có thể theo dõi phí vận chuyển (PVC)&nbsp;&nbsp;phát sinh và tổng tiền thanh toán&nbsp;tại mục&nbsp;<span style="color: rgb(255, 0, 0);">*</span>&nbsp;ở cột&nbsp;<strong>"Thông tin đơn hàng"</strong>&nbsp;bên phải.</p><p class="ql-align-justify">- Nhấn chọn&nbsp;<span style="color: rgb(0, 0, 255);">GỬI ĐƠN HÀNG</span>&nbsp;tại mục&nbsp;<span style="color: rgb(255, 0, 0);">4</span>&nbsp;, hoặc mục&nbsp;<span style="color: rgb(255, 0, 0);">*</span></p><p class="ql-align-center"><br></p><p class="ql-align-center"><img src="http://4menshop.com/images/2017/12/20171206_3fc4e234e3a6fc3acbc77a93a5f3c7a4_1512550567.jpg" alt="Hướng dẫn đặt hàng - 2"></p><p class="ql-align-justify"><br></p><p class="ql-align-justify"><strong>BƯỚC&nbsp;2: Nhận thông báo&nbsp;gửi đơn hàng</strong></p><p class="ql-align-justify">- Quý khách sau khi nhấn nút&nbsp;<strong>GỬI ĐƠN HÀNG</strong>&nbsp;sẽ nhận được thông báo&nbsp;đặt hàng thành công, để mua thêm sản phẩm vui lòng nhấn chọn&nbsp;<strong>TIẾP TỤC THAM GIA MUA HÀNG</strong></p><p class="ql-align-justify"><br></p><p class="ql-align-justify"><img src="http://4menshop.com/images/2015/07/20150717_f10dec5cab127665f8be86bc0524f146_1437129867.jpg" alt="Hướng dẫn đặt hàng - 3"></p><p class="ql-align-justify"><br></p><p class="ql-align-justify">Sau khi nhận được đơn hàng của quý khách, 4MEN sẽ phản hồi lại trong vòng 24h để xác nhận đơn hàng, hình thức thanh toán, giao hàng, chuyển hàng hoặc thông báo các trường hợp đơn hàng gặp sự cố.</p><p class="ql-align-justify">&nbsp;</p><p class="ql-align-center">Cảm ơn quý khách đã tin tưởng và lựa chọn&nbsp;THƯƠNG HIỆU THỜI TRANG NAM&nbsp;4MEN</p><p class="ql-align-center">Chúc quý khách có những giây phút mua sắm vui vẻ.</p><p><br></p>', CAST(N'2025-05-31T15:00:22.987' AS DateTime), 1)
INSERT [dbo].[BaiViet] ([BaiVietID], [TieuDe], [NoiDung], [NgayTao], [TaiKhoanID]) VALUES (6, N'Hướng dẫn chọn size', N'<h1>Hướng dẫn chọn size</h1><p>Nếu bạn băn khoăn không biết chọn size nào cho phù hợp với cân nặng và chiều cao của mình, đừng lo lắng! Hãy xem bảng hướng dẫn chọn size bên dưới mà&nbsp;<span style="color: rgb(255, 0, 0);">4MEN</span>&nbsp;tư vấn riêng dành cho bạn</p><p class="ql-align-center">&nbsp;</p><p class="ql-align-center"><img src="https://4menshop.com/images/2025/02/20250225_942b24227803333462ad0a836de59c55_1740467669.png" alt="Hướng dẫn chọn size - 1"></p><p class="ql-align-center"><br></p><p class="ql-align-center"><img src="https://4menshop.com/images/2025/02/20250225_ce158bd0367fb835c4126585331a7c66_1740467669.png" alt="Hướng dẫn chọn size - 2"></p><p class="ql-align-center">&nbsp;</p><p class="ql-align-center"><img src="https://4menshop.com/images/2016/12/20161226_ac1f530b18a20a327758473fa4930fc7_1482759836.jpg" alt="Hướng dẫn chọn size - 3"></p><p>Bảng hướng dẫn chọn size trên là bảng hướng dẫn dựa trên kinh nghiệm nhiều năm của 4MEN theo khảo sát nhu cầu sở thích của khách hàng, tất nhiên sẽ không tuyệt đối, sẽ có những trường hợp ngoại lệ phụ thuộc theo vóc dáng, sở thích của từng người. Ví dụ có người thích mặc ôm, có người thích mặc rộng...</p><p><br></p><p>Nếu bạn vẫn còn có những mắc thắc và băn khoăn cần được giải đáp? Hãy liên hệ ngay với Bộ phận Chăm sóc khách hàng của 4MEN qua&nbsp;Hotline&nbsp;<strong>(08)68 444 644</strong>&nbsp;để được hỗ trợ thêm.</p>', CAST(N'2025-05-31T15:02:36.270' AS DateTime), 1)
INSERT [dbo].[BaiViet] ([BaiVietID], [TieuDe], [NoiDung], [NgayTao], [TaiKhoanID]) VALUES (7, N'Chính sách thanh toán - Giao hàng', N'<h1>Chính sách thanh toán - Giao hàng</h1><p>4MEN&nbsp;giao hàng tận nơi trên toàn quốc với chính sách giao hàng cụ thể như sau:</p><p><br></p><p><strong>1. CHÍNH SÁCH THANH TOÁN:</strong></p><p><br></p><p>Khách hàng có thể lựa chọn các hình thức thanh toán khi mua sắm trực tuyến tại 4MEN:</p><ul><li>Thanh toán trực tiếp tại cửa hàng</li><li>Thanh toán trực tuyến qua ứng dụng Vnpay bằng QR code, thẻ ATM nội địa, thẻ quốc tế&nbsp;Visa/Master/JCB</li><li>Thanh toán trực tiếp COD:&nbsp;Nhân viên vận chuyển thu tiền mặt khi giao hàng cho khách.</li><li>Thanh toán chuyển khoản trực tiếp vào số tài kho<span style="color: rgb(0, 0, 0);">ản&nbsp;</span><strong style="color: rgb(0, 0, 0);">109879770901&nbsp;</strong><span style="color: rgb(0, 0, 0);">- Ngân hàng TMCP Công Thương Việt Nam - Chi nhánh Tân Bình (Vietinbank).</span></li></ul><p><strong>2. CHÍNH SÁCH GIAO HÀNG:</strong></p><p><br></p><p><strong>A- Phí vận chuyển:</strong></p><p>4MEN&nbsp;Miễn phí&nbsp;giao cho đơn hàng từ 399.000 VND (ba trăm chín mươi chín ngàn đồng). Đối với đơn hàng chưa đủ điều kiện freeship, 4MEN áp dụng mức phí giao hàng theo bảng giá sau:</p><p>&nbsp;</p><p><br></p><p><img src="https://4menshop.com/images/2023/09/20230918_0b0dc24e1a03e98c82af620361d3f36e_1695003484.jpg" alt="Chính sách thanh toán - giao hàng - 1"></p><p><strong>Khu vực TP.HCM:</strong></p><p>- Nội Thành: Các quận: 1, 3, 4, 5, 6, 7, 8, 10, 11, Bình Thạnh, Gò Vấp, Phú Nhuận, Tân Bình, Tân Phú,&nbsp;Tp Thủ Đức (quận 2, 9, Thủ Đức cũ)</p><p>- Ngoại Thành: Các quận - huyện: 12, Bình Chánh, Bình Tân, Cần Giờ, Củ Chi, Hóc Môn, Nhà Bè.</p><p><br></p><p><strong>B- Thời gian giao hàng:</strong></p><ul><li>Thời gian vận chuyển hàng thường mất từ 2 - 4&nbsp;ngày làm việc (không tính thứ bảy, chủ nhật hay các ngày lễ tết).&nbsp;</li><li>Chỉ tiêu thời gian trên được tính đến trung tâm tỉnh, thành phố của khách hàng,&nbsp;Nếu khách hàng ở tại Huyện, Xã cộng thêm 1 – 2 ngày&nbsp;(tùy vào nơi đến).</li></ul><p>* Việc giao hàng được thực hiện trong giờ hành chính.</p><p>* Khi nhận hàng quý khách cần xem lại mặt hàng vừa nhận, nếu mặt hàng vừa giao không đúng theo yêu cầu của quý khách, quý khách có thể từ chối nhận hàng.</p>', CAST(N'2025-05-31T15:38:12.107' AS DateTime), 1)
INSERT [dbo].[BaiViet] ([BaiVietID], [TieuDe], [NoiDung], [NgayTao], [TaiKhoanID]) VALUES (8, N'Chính sách đổi hàng', N'<h1>Chính sách đổi hàng</h1><p class="ql-align-center"><img src="https://4menshop.com/images/2025/05/20250505_6e3761e7ae7f2fdb93b753f7142badd3_1746462427.jpg" alt="Chính sách đổi hàng - 1"></p><p><br></p>', CAST(N'2025-05-31T15:38:50.860' AS DateTime), 1)
INSERT [dbo].[BaiViet] ([BaiVietID], [TieuDe], [NoiDung], [NgayTao], [TaiKhoanID]) VALUES (9, N'Chính sách khách vip', N'<h1>Chính sách khách vip</h1><p class="ql-align-center"><img src="https://4menshop.com/images/2025/05/20250505_294f63fec6d905b2f7bb10a47fe9728c_1746462362.jpg" alt="Chính sách khách vip - 1"></p><p><br></p>', CAST(N'2025-05-31T15:40:46.547' AS DateTime), 1)
INSERT [dbo].[BaiViet] ([BaiVietID], [TieuDe], [NoiDung], [NgayTao], [TaiKhoanID]) VALUES (10, N'Câu hỏi thường gặp', N'<h1>Câu hỏi thường gặp</h1><p><br></p><p><strong>1. Tôi muốn mua hàng phải làm sao?</strong></p><p>Khi bạn muốn mua một mặt hàng tại 4MEN, bạn có thể đến shop mua trực tiếp, gọi điện cho 4MEN hoặc đặt hàng trên website</p><p>(Hướng dẫn mua hàng quý khách có thể tham khảo tại link sau: https://4menshop.com/dat-hang-truc-tuyen.html&nbsp;)</p><p>&nbsp;</p><p><strong>2. Tôi ở xa có mua hàng được không? Shop có giao hàng không?</strong></p><p>4MEN giao hàng và thu tiền tận nơi trên toàn quốc, miễn phí giao hàng cho hóa đơn từ 01 triệu đồng trở lên, nên các bạn yên tâm thoải mái mua hàng nhé!</p><p><br></p><p><strong>3. Tôi không biết chọn size như thế nào?</strong></p><p>Nếu bạn băn khoăn không biết chọn size nào cho phù hợp với cân nặng và chiều cao của mình, hãy xem chi tiết tại link sau:&nbsp;<a href="https://4menshop.com/huong-dan-chon-size.html" rel="noopener noreferrer" target="_blank" style="color: rgb(179, 31, 42);">https://4menshop.com/huong-dan-chon-size.html</a></p><p><br></p><p><strong>4. Sao tôi có thể tin tưởng khi chuyển tiền rồi, tôi sẽ nhận được hàng?</strong></p><p>Khác với một số shop chỉ bán hàng trôi nổi trên mạng không rõ địa chỉ, 4MEN là một hệ thống cửa hàng có địa chỉ rõ ràng cụ thể được đăng tải trên website của shop. Đặc biệt 4MEN sử dụng dịch vụ giao hàng và thu tiền tại nhà, khi nào khách hàng nhận được hàng thì mới thanh toán, nên rủi ro là 0%. Uy tín và đảm bảo chất lượng hàng hoá cũng như lợi ích của khách hàng luôn là tiêu chí hàng đầu của 4MEN.</p><p><br></p><p><strong>5. Hàng hóa trên 4MEN có đảm bảo chất lượng và mẫu mã không?</strong></p><p>Hàng hoá tại 4MEN luôn được cam kết và đảm bảo về chất lượng nên bạn hoàn toàn có thể yên tâm. Khi 4MEN giao hàng khách hàng có thể kiểm tra sản phẩm, nếu không đúng có thể từ chối nhận.</p><p><br></p><p><strong>6. Tôi muốn lên shop để mua trực tiếp</strong></p><p>Bạn có thể đến trực tiếp shop theo các địa chỉ cửa hàng&nbsp;thuộc hệ thống 4MEN ở cuối website, thời gian mở cửa từ 8h30 đến 22h00 hàng ngày (kể cả chủ nhật)</p><p>&nbsp;</p><p><strong>7. Tôi mua hàng rồi, không vừa ý có thể đổi lại hay không?</strong></p><p>Hàng đã mua quý khách được đổi trong vòng 5 ngày với điều kiện hàng được đổi phải đảm bảo còn mới 100% chưa qua sử dụng. 4MEN không giải quyết các trường hợp đổi hàng đã sử dụng qua hoặc các trường hợp trả lại hàng.</p><p>&nbsp;</p><p><strong>8. Bao lâu tôi nhận được hàng?</strong></p><p>Tùy thuộc vào địa chỉ nhận hàng của các bạn mà thời gian nhận hàng trong vòng 24h đến 72h trong thời gian làm việc.&nbsp;(Xem thêm thời gian giao hàng tại link sau:&nbsp;https://4menshop.com/chinh-sach-thanh-toan-giao-hang.html)</p><p>&nbsp;</p><p><strong>9. Tại sao qua một thời gian mà hàng của tôi vẫn chưa nhận được?</strong></p><p>Tùy thuộc vào địa chỉ nhận hàng của quý khách mà thời gian nhận hàng trong vòng 24h đến 72h trong thời gian làm việc. Tuy nhiên trong một số trường hợp phát sinh ngoài ý muốn (thiên tai hỏa hoạn,&nbsp;địa chỉ giao hàng không chính xác, không có người nhận, không liên hệ được với người nhận…) nên việc giao hàng sẽ&nbsp;không được chính xác về&nbsp;thời gian. Các bạn vui lòng liên hệ lại với shop, 4MEN sẽ kiểm tra với công ty vận chuyển để xác nhận thông tin &amp; giao hàng lại cho các bạn trong thời gian sớm nhất.</p><p>&nbsp;</p><p><strong>10. Shop có cửa hàng ở tỉnh không ?</strong></p><p>Hiện tại shop có 3 cửa hàng tại tỉnh gồm&nbsp;Biên Hòa, Vũng Tàu và An Giang. Các tỉnh thành khác 4MEN sẽ mở rộng trong thời gian tới. Các bạn ở xa có thể đặt hàng và thanh toán từ khắp các tỉnh thành ở Việt Nam, 4MEN đều có thể giao hàng tận tay các bạn.</p>', CAST(N'2025-05-31T15:41:28.857' AS DateTime), 1)
INSERT [dbo].[BaiViet] ([BaiVietID], [TieuDe], [NoiDung], [NgayTao], [TaiKhoanID]) VALUES (11, N'Chính sách cookie', N'<h1>Chính sách cookie</h1><p><br></p><p>4MEN sử dụng cookie trình duyệt&nbsp;cho nhiều mục đích trên các trang web và trong thông tin liên lạc email của chúng tôi để&nbsp;cung cấp dịch vụ và nâng cao trải nghiệm người dùng, người truy cập website, khách hàng,... Chúng tôi hiện đang triển khai cách thức chia sẻ những tài nguyên&nbsp;đó cho các đối tác tin cậy và nâng cao trải nghiệm trên trang web của họ. Chính sách này mô tả các loại cookie mà chúng tôi sử dụng (và được đối tác của chúng tôi sử dụng), chúng được dùng làm gì và bạn có thể thay đổi các tùy chọn cookie ấy&nbsp;của mình như thế nào.</p><p><br></p><p><strong>‘Cookie’ là gì?</strong></p><p><br></p><p>Cookie là các bite, dạng&nbsp;thông tin nhỏ được trình duyệt của bạn lưu trữ trên ổ cứng máy tính của bạn. Mỗi lần&nbsp;bạn truy cập lại trang web trên hệ thống của&nbsp;4MEN(R), trình duyệt web của bạn gửi những cookie này trở lại cho chúng tôi để chúng tôi có thể tùy chỉnh trải nghiệm của bạn để phù hợp hơn với sở thích và tùy chọn của bạn hoặc chỉ đơn giản là hỗ trợ bạn đăng nhập để sử dụng các dịch vụ của chúng tôi.</p><p><br></p><p><strong>4MEN sử dụng những loại cookie nào?</strong></p><p><br></p><p>Những&nbsp;cookie mà chúng tôi sử dụng cho phép chúng tôi nhận ra mỗi người dùng quay lại và thông tin liên quan của họ để bạn không cần nhập nhiều lần cùng một thông tin. Chúng cũng giúp chúng tôi hiểu được các dạng&nbsp;lưu lượng truy cập của khách truy cập qua trang web của chúng tôi, để chúng tôi có thể nâng cao khả năng sử dụng.</p><p><br></p><p>Hãy xem một số loại cookie được sử dụng trên trang web của chúng tôi:</p><p><br></p><p><strong>Cookie thiết yếu</strong></p><p>4MEN có thể sử dụng các cookie thiết yếu để cho phép bạn nhận được các dịch vụ bạn yêu cầu qua website 4MENSHOP.COM của chúng tôi. Nếu không có những cookie này, các dịch vụ bạn đã yêu cầu sẽ không thể được cung cấp.</p><p>&nbsp;</p><p><strong>Chẳng hạn, những cookie này có thể được sử dụng để:</strong></p><ul><li>Vận hành và ghi nhớ các mặt hàng bạn chọn/đặt vào ‘giỏ hàng’ khi sử dụng</li><li>Cho phép bạn truy cập vào các khu vực an toàn trên trang web của chúng tôi mà không cần liên tục đăng nhập vào dịch vụ</li><li>Ghi nhớ hành động trước đây mà bạn đã thực hiện (như hoàn thành biểu mẫu trực tuyến) khi điều hướng trở lại trang trong cùng một phiên</li></ul><p><br></p><p><strong>Các mô-đun cookie hoạt động</strong></p><p>4MEN có thể sử dụng các cookie hoạt động để thu thập thông tin về các&nbsp;trang web, quảng cáo (Uy tín: google, facebook) và thông tin liên lạc email của chúng tôi được sử dụng và để cảnh báo chúng tôi nếu có lỗi xảy ra. Những cookie này có thể được sử dụng để thu thập các dữ thiệu&nbsp;thông tin khá chi tiết khi bạn trải nghiệm "lướt web" trên website&nbsp;như: Trang truy cập lần cuối, số trang đã truy cập, thư liên lạc qua email có được mở không, phần nào trên trang web hoặc thư liên lạc qua email của chúng tôi được nhấn vào và thời gian giữa các lần nhấn. Mặc dù thông tin này có thể được kết hợp với các chi tiết như địa chỉ IP, miền hoặc thông tin trình duyệt của bạn, thông tin chỉ được phân tích tổng hợp với thông tin từ người dùng khác và không được thực hiện theo cách thức có thể nhận dạng bạn trực tiếp.</p><p>&nbsp;</p><p><strong>Chẳng hạn, những cookie này có thể được sử dụng trên trang web của chúng tôi để:</strong></p><ul><li>Phân tích và cải thiện hoạt động và thiết kế của các trang web, quảng cáo và thư liên lạc qua email của chúng tôi</li><li>Tính số lượng phản hồi với quảng cáo của chúng tôi để cải thiện hiệu quả của quảng cáo</li><li>Đo số lượng lỗi hiển thị trên trang web của chúng tôi để cải thiện các khiếu nại về dịch vụ và quản lý của chúng tôi</li></ul><p><br></p><p><strong>Cookie giới thiệu</strong></p><p>4MEN&nbsp;có thể truy cập các cookie giới thiệu được các trang web của đối tác kinh doanh của chúng tôi gửi tới thiết bị của bạn. Những cookie này được sử dụng mỗi khi đối tác kinh doanh của chúng tôi giới thiệu ai đó tới trang web của chúng tôi dù lượt truy cập của người đó có dẫn đến việc mua sản phẩm hoặc dịch vụ của 4MEN&nbsp;hay không. Thông tin này có thể được tiết lộ cho đối tác kinh doanh của chúng tôi, nhưng chỉ theo cách ẩn danh và không theo cách có thể nhận dạng bạn trực tiếp.</p><p>Chúng tôi sử dụng thông tin này để đáp ứng các nghĩa vụ theo hợp đồng của chúng tôi với các đối tác kinh doanh và để hỗ trợ họ cải thiện hiệu quả trang web của họ.</p><p><br></p><p><strong>Cookie chức năng</strong></p><p>4MEN&nbsp;có thể sử dụng cookie chức năng, tuy không thiết yếu nhưng cho phép nhiều tính năng hữu ích khác nhau trên trang web của chúng tôi.</p><p>Chẳng hạn, những cookie này có thể được sử dụng trên trang web của chúng tôi để:</p><p>&nbsp;</p><ul><li>Ghi nhớ các tùy chọn mà bạn đã chọn trong lần truy cập trước vào trang web của chúng tôi, như quốc gia/ngôn ngữ, sở thích của bạn và cách trình bày trang web của chúng tôi (chẳng hạn, bố cục, cỡ chữ, màu sắc, v.v..), để bạn không cần phải thông báo lại cho chúng tôi</li><li>Ghi nhớ câu trả lời cho các câu hỏi mà trang web của chúng tôi đã hỏi bạn, như không muốn tham gia bảng câu hỏi về sự hài lòng của khách hàng, để chúng tôi không hỏi lại bạn nữa</li><li>Phát hiện liệu dịch vụ đã được cung cấp cho bạn chưa, chẳng hạn, cung cấp dịch vụ trợ giúp trực tuyến với người hỗ trợ</li><li>Cung cấp thông tin cho phép một dịch vụ tùy chọn hoạt động, như xem video trực tuyến hoặc bình luận trong blog</li></ul><p><br></p><p><strong>Cookie nhắm mục tiêu hoặc giới thiệu sản phẩm</strong></p><p>Cookie nhắm mục tiêu hoặc giới thiệu sản phẩm&nbsp;có thể được sử dụng trên trang web của chúng tôi để phân phát sản phẩm&nbsp;có liên quan hơn đến bạn và sở thích của bạn. Những cookie này có thể thu thập thông tin khá chi tiết về thói quen duyệt web của bạn trên trang website của 4MEN&nbsp;(như bạn đã nhấn vào sản phẩm và dịch vụ nào). Chúng có thể được sử dụng để nhận dạng khi bạn truy cập lại trang web của chúng tôi và/hoặc truy cập trang web là một phần trong mạng lưới đối tác quảng cáo của chúng tôi.</p><p><br></p><p>Chẳng hạn, những cookie này có thể được sử dụng để thu thập thông tin về các sản phẩm và dịch vụ của 4MEN&nbsp;mà bạn đã duyệt hoặc đã thêm vào giỏ hàng của mình trên trang web của chúng tôi để:</p><p>&nbsp;</p><ul><li>Các đối tác quảng cáo của chúng tôi (google, facebook, các doanh nghiệp quảng cáo trực tuyết trong nước,..)&nbsp;có thể cung cấp cho bạn quảng cáo trên các trang web khác của họ&nbsp;trong mạng lưới quảng cáo của họ về các sản phẩm và dịch vụ của 4MEN&nbsp;mà bạn đã xem</li><li>Chúng tôi có thể giới hạn số lần bạn nhìn thấy quảng cáo cũng như đo hiệu quả của một chiến dịch quảng cáo</li></ul><p><br></p><p>Những cookie này có thể được 4MEN&nbsp;và/hoặc đối tác quảng cáo của chúng tôi lưu trữ và truy cập.</p><p><br></p><p><strong>Cookie bên thứ ba</strong></p><p>Việc bạn sử dụng trang web của chúng tôi có thể dẫn đến một số cookie được lưu trữ mà không được 4MEN(R) kiểm soát. Điều này có thể xảy ra khi Trang bạn đang truy cập bao gồm các nội dung được hiển thị từ trang web bên thứ ba và sẽ dẫn đến việc bạn nhận cookie từ các dịch vụ bên thứ ba này. Tuy nhiên, sẽ không có thông tin cá nhân nào được lưu trữ trong những cookie này, trừ khi bạn đăng nhập vào tài khoản của mình.</p><p>Chẳng hạn, những cookie này có thể đến từ:</p><ul><li>YouTube hoặc Facebook</li><li>Các nhà khai thác mạng đáng tin cậy</li><li>Các cơ quan truyền thông có trả phí</li><li>Các chương trình tiếp thị của chính 4MEN</li></ul><p><br></p><p>4MEN&nbsp;không kiểm soát việc lưu trữ hoặc truy cập vào những cookie này. Bạn nên xem xét chính sách bảo mật và cookie của các dịch vụ này để tìm hiểu về cách sử dụng cookie của những bên thứ ba này.</p><p><br></p><p><strong>Mua hàng với 4MEN</strong></p><p>Chúng tôi&nbsp;cam kết bảo vệ quyền riêng tư của khách hàng và chúng tôi đã thực hiện các biện pháp mạnh nhằm đảm bảo rằng thông tin chúng tôi thu thập từ bạn sẽ được an toàn và bí mật. Cookie của 4MEN(R) không được sử dụng để truy cập vào thông tin đã nhập trên máy chủ an toàn. Bạn chỉ có thể truy cập thông tin này khi nhập tên và số tham chiếu đơn đặt hàng của mình.</p><p><br></p><p><strong>Cách điều chỉnh cài đặt cookie của bạn</strong></p><p>Hầu hết các trình duyệt sẽ cho phép bạn xóa cookie khỏi ổ cứng máy tính của mình, chặn chấp nhận cookie hoặc nhận cảnh báo trước khi cookie được lưu trữ.</p><p><br></p><p><strong>Điều gì xảy ra nếu cookie bị vô hiệu hóa?</strong></p><p>Nếu bạn chặn hoặc xóa cookie, chúng tôi có thể không khôi phục được bất kỳ tùy chọn hoặc cài đặt tùy chỉnh nào bạn đã chỉ định trước đó và khả năng cá nhân hóa trải nghiệm trực tuyến của bạn sẽ bị hạn chế.</p><p><br></p><p><strong>Tìm hiểu cách thay đổi cài đặt của bạn cho:</strong></p><ul><li>Google Chrome:&nbsp;http://support.google.com/chrome/answer/95647?hl=en</li><li>Mozilla Firefox:&nbsp;http://support.mozilla.org/en-US/kb/enable-and-disable-cookies-website-preferences</li><li>Internet Explorer:&nbsp;http://support.microsoft.com/kb/196955</li><li>Safari:&nbsp;http://support.apple.com/kb/PH5042</li></ul><p><br></p>', CAST(N'2025-05-31T15:42:17.257' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[BaiViet] OFF
GO
SET IDENTITY_INSERT [dbo].[ChiTietHoaDonNhaps] ON 

INSERT [dbo].[ChiTietHoaDonNhaps] ([Id], [MaHoaDon], [SoLuong], [DonViTinh], [GiaNhap], [TongTien], [MaSize], [MaSanPham]) VALUES (237, 159, 5, N'cái', CAST(180000 AS Decimal(18, 0)), CAST(900000 AS Decimal(18, 0)), 1, 184)
INSERT [dbo].[ChiTietHoaDonNhaps] ([Id], [MaHoaDon], [SoLuong], [DonViTinh], [GiaNhap], [TongTien], [MaSize], [MaSanPham]) VALUES (238, 159, 5, N'cái', CAST(180000 AS Decimal(18, 0)), CAST(900000 AS Decimal(18, 0)), 2, 184)
INSERT [dbo].[ChiTietHoaDonNhaps] ([Id], [MaHoaDon], [SoLuong], [DonViTinh], [GiaNhap], [TongTien], [MaSize], [MaSanPham]) VALUES (239, 160, 5, N'cái', CAST(175000 AS Decimal(18, 0)), CAST(875000 AS Decimal(18, 0)), 2, 185)
INSERT [dbo].[ChiTietHoaDonNhaps] ([Id], [MaHoaDon], [SoLuong], [DonViTinh], [GiaNhap], [TongTien], [MaSize], [MaSanPham]) VALUES (240, 160, 5, N'cái', CAST(175000 AS Decimal(18, 0)), CAST(875000 AS Decimal(18, 0)), 3, 185)
INSERT [dbo].[ChiTietHoaDonNhaps] ([Id], [MaHoaDon], [SoLuong], [DonViTinh], [GiaNhap], [TongTien], [MaSize], [MaSanPham]) VALUES (241, 160, 4, N'cái', CAST(175000 AS Decimal(18, 0)), CAST(700000 AS Decimal(18, 0)), 4, 185)
INSERT [dbo].[ChiTietHoaDonNhaps] ([Id], [MaHoaDon], [SoLuong], [DonViTinh], [GiaNhap], [TongTien], [MaSize], [MaSanPham]) VALUES (242, 161, 5, N'cái', CAST(195000 AS Decimal(18, 0)), CAST(975000 AS Decimal(18, 0)), 1, 190)
INSERT [dbo].[ChiTietHoaDonNhaps] ([Id], [MaHoaDon], [SoLuong], [DonViTinh], [GiaNhap], [TongTien], [MaSize], [MaSanPham]) VALUES (243, 161, 5, N'cái', CAST(195000 AS Decimal(18, 0)), CAST(975000 AS Decimal(18, 0)), 2, 190)
INSERT [dbo].[ChiTietHoaDonNhaps] ([Id], [MaHoaDon], [SoLuong], [DonViTinh], [GiaNhap], [TongTien], [MaSize], [MaSanPham]) VALUES (244, 161, 5, N'cái', CAST(195000 AS Decimal(18, 0)), CAST(975000 AS Decimal(18, 0)), 3, 190)
INSERT [dbo].[ChiTietHoaDonNhaps] ([Id], [MaHoaDon], [SoLuong], [DonViTinh], [GiaNhap], [TongTien], [MaSize], [MaSanPham]) VALUES (245, 162, 5, N'cái', CAST(300000 AS Decimal(18, 0)), CAST(1500000 AS Decimal(18, 0)), 1, 210)
INSERT [dbo].[ChiTietHoaDonNhaps] ([Id], [MaHoaDon], [SoLuong], [DonViTinh], [GiaNhap], [TongTien], [MaSize], [MaSanPham]) VALUES (246, 162, 5, N'cái', CAST(300000 AS Decimal(18, 0)), CAST(1500000 AS Decimal(18, 0)), 2, 210)
INSERT [dbo].[ChiTietHoaDonNhaps] ([Id], [MaHoaDon], [SoLuong], [DonViTinh], [GiaNhap], [TongTien], [MaSize], [MaSanPham]) VALUES (247, 162, 5, N'cái', CAST(300000 AS Decimal(18, 0)), CAST(1500000 AS Decimal(18, 0)), 3, 210)
INSERT [dbo].[ChiTietHoaDonNhaps] ([Id], [MaHoaDon], [SoLuong], [DonViTinh], [GiaNhap], [TongTien], [MaSize], [MaSanPham]) VALUES (248, 164, 5, N'cái', CAST(180000 AS Decimal(18, 0)), CAST(900000 AS Decimal(18, 0)), 1, 222)
INSERT [dbo].[ChiTietHoaDonNhaps] ([Id], [MaHoaDon], [SoLuong], [DonViTinh], [GiaNhap], [TongTien], [MaSize], [MaSanPham]) VALUES (249, 164, 5, N'cái', CAST(180000 AS Decimal(18, 0)), CAST(900000 AS Decimal(18, 0)), 2, 222)
INSERT [dbo].[ChiTietHoaDonNhaps] ([Id], [MaHoaDon], [SoLuong], [DonViTinh], [GiaNhap], [TongTien], [MaSize], [MaSanPham]) VALUES (250, 165, 5, N'cái', CAST(100000 AS Decimal(18, 0)), CAST(500000 AS Decimal(18, 0)), 1, 219)
INSERT [dbo].[ChiTietHoaDonNhaps] ([Id], [MaHoaDon], [SoLuong], [DonViTinh], [GiaNhap], [TongTien], [MaSize], [MaSanPham]) VALUES (251, 165, 5, N'cái', CAST(100000 AS Decimal(18, 0)), CAST(500000 AS Decimal(18, 0)), 2, 219)
INSERT [dbo].[ChiTietHoaDonNhaps] ([Id], [MaHoaDon], [SoLuong], [DonViTinh], [GiaNhap], [TongTien], [MaSize], [MaSanPham]) VALUES (252, 166, 5, N'cái', CAST(200000 AS Decimal(18, 0)), CAST(1000000 AS Decimal(18, 0)), 1, 221)
INSERT [dbo].[ChiTietHoaDonNhaps] ([Id], [MaHoaDon], [SoLuong], [DonViTinh], [GiaNhap], [TongTien], [MaSize], [MaSanPham]) VALUES (253, 166, 5, N'cái', CAST(200000 AS Decimal(18, 0)), CAST(1000000 AS Decimal(18, 0)), 2, 221)
INSERT [dbo].[ChiTietHoaDonNhaps] ([Id], [MaHoaDon], [SoLuong], [DonViTinh], [GiaNhap], [TongTien], [MaSize], [MaSanPham]) VALUES (254, 167, 5, N'cái', CAST(200000 AS Decimal(18, 0)), CAST(1000000 AS Decimal(18, 0)), 1, 218)
INSERT [dbo].[ChiTietHoaDonNhaps] ([Id], [MaHoaDon], [SoLuong], [DonViTinh], [GiaNhap], [TongTien], [MaSize], [MaSanPham]) VALUES (255, 167, 5, N'cái', CAST(200000 AS Decimal(18, 0)), CAST(1000000 AS Decimal(18, 0)), 2, 218)
INSERT [dbo].[ChiTietHoaDonNhaps] ([Id], [MaHoaDon], [SoLuong], [DonViTinh], [GiaNhap], [TongTien], [MaSize], [MaSanPham]) VALUES (256, 167, 5, N'cái', CAST(200000 AS Decimal(18, 0)), CAST(1000000 AS Decimal(18, 0)), 3, 218)
INSERT [dbo].[ChiTietHoaDonNhaps] ([Id], [MaHoaDon], [SoLuong], [DonViTinh], [GiaNhap], [TongTien], [MaSize], [MaSanPham]) VALUES (257, 168, 5, N'cái', CAST(200000 AS Decimal(18, 0)), CAST(1000000 AS Decimal(18, 0)), 1, 223)
INSERT [dbo].[ChiTietHoaDonNhaps] ([Id], [MaHoaDon], [SoLuong], [DonViTinh], [GiaNhap], [TongTien], [MaSize], [MaSanPham]) VALUES (258, 168, 5, N'cái', CAST(200000 AS Decimal(18, 0)), CAST(1000000 AS Decimal(18, 0)), 2, 223)
INSERT [dbo].[ChiTietHoaDonNhaps] ([Id], [MaHoaDon], [SoLuong], [DonViTinh], [GiaNhap], [TongTien], [MaSize], [MaSanPham]) VALUES (259, 168, 5, N'cái', CAST(200000 AS Decimal(18, 0)), CAST(1000000 AS Decimal(18, 0)), 3, 223)
INSERT [dbo].[ChiTietHoaDonNhaps] ([Id], [MaHoaDon], [SoLuong], [DonViTinh], [GiaNhap], [TongTien], [MaSize], [MaSanPham]) VALUES (260, 169, 5, N'cái', CAST(300000 AS Decimal(18, 0)), CAST(1500000 AS Decimal(18, 0)), 7, 224)
INSERT [dbo].[ChiTietHoaDonNhaps] ([Id], [MaHoaDon], [SoLuong], [DonViTinh], [GiaNhap], [TongTien], [MaSize], [MaSanPham]) VALUES (261, 169, 5, N'cái', CAST(300000 AS Decimal(18, 0)), CAST(1500000 AS Decimal(18, 0)), 10, 224)
INSERT [dbo].[ChiTietHoaDonNhaps] ([Id], [MaHoaDon], [SoLuong], [DonViTinh], [GiaNhap], [TongTien], [MaSize], [MaSanPham]) VALUES (262, 169, 5, N'cái', CAST(300000 AS Decimal(18, 0)), CAST(1500000 AS Decimal(18, 0)), 11, 224)
INSERT [dbo].[ChiTietHoaDonNhaps] ([Id], [MaHoaDon], [SoLuong], [DonViTinh], [GiaNhap], [TongTien], [MaSize], [MaSanPham]) VALUES (263, 170, 5, N'cái', CAST(300000 AS Decimal(18, 0)), CAST(1500000 AS Decimal(18, 0)), 7, 225)
INSERT [dbo].[ChiTietHoaDonNhaps] ([Id], [MaHoaDon], [SoLuong], [DonViTinh], [GiaNhap], [TongTien], [MaSize], [MaSanPham]) VALUES (264, 170, 5, N'cái', CAST(300000 AS Decimal(18, 0)), CAST(1500000 AS Decimal(18, 0)), 10, 225)
INSERT [dbo].[ChiTietHoaDonNhaps] ([Id], [MaHoaDon], [SoLuong], [DonViTinh], [GiaNhap], [TongTien], [MaSize], [MaSanPham]) VALUES (265, 171, 5, N'cái', CAST(300000 AS Decimal(18, 0)), CAST(1500000 AS Decimal(18, 0)), 7, 226)
INSERT [dbo].[ChiTietHoaDonNhaps] ([Id], [MaHoaDon], [SoLuong], [DonViTinh], [GiaNhap], [TongTien], [MaSize], [MaSanPham]) VALUES (266, 171, 5, N'cái', CAST(300000 AS Decimal(18, 0)), CAST(1500000 AS Decimal(18, 0)), 10, 226)
INSERT [dbo].[ChiTietHoaDonNhaps] ([Id], [MaHoaDon], [SoLuong], [DonViTinh], [GiaNhap], [TongTien], [MaSize], [MaSanPham]) VALUES (267, 172, 5, N'cái', CAST(300000 AS Decimal(18, 0)), CAST(1500000 AS Decimal(18, 0)), 7, 229)
INSERT [dbo].[ChiTietHoaDonNhaps] ([Id], [MaHoaDon], [SoLuong], [DonViTinh], [GiaNhap], [TongTien], [MaSize], [MaSanPham]) VALUES (268, 172, 5, N'cái', CAST(300000 AS Decimal(18, 0)), CAST(1500000 AS Decimal(18, 0)), 10, 229)
INSERT [dbo].[ChiTietHoaDonNhaps] ([Id], [MaHoaDon], [SoLuong], [DonViTinh], [GiaNhap], [TongTien], [MaSize], [MaSanPham]) VALUES (269, 173, 5, N'cái', CAST(300000 AS Decimal(18, 0)), CAST(1500000 AS Decimal(18, 0)), 1, 228)
INSERT [dbo].[ChiTietHoaDonNhaps] ([Id], [MaHoaDon], [SoLuong], [DonViTinh], [GiaNhap], [TongTien], [MaSize], [MaSanPham]) VALUES (270, 173, 5, N'cái', CAST(300000 AS Decimal(18, 0)), CAST(1500000 AS Decimal(18, 0)), 2, 228)
INSERT [dbo].[ChiTietHoaDonNhaps] ([Id], [MaHoaDon], [SoLuong], [DonViTinh], [GiaNhap], [TongTien], [MaSize], [MaSanPham]) VALUES (271, 174, 5, N'cái', CAST(350000 AS Decimal(18, 0)), CAST(1750000 AS Decimal(18, 0)), 1, 212)
INSERT [dbo].[ChiTietHoaDonNhaps] ([Id], [MaHoaDon], [SoLuong], [DonViTinh], [GiaNhap], [TongTien], [MaSize], [MaSanPham]) VALUES (272, 174, 5, N'cái', CAST(350000 AS Decimal(18, 0)), CAST(1750000 AS Decimal(18, 0)), 2, 212)
INSERT [dbo].[ChiTietHoaDonNhaps] ([Id], [MaHoaDon], [SoLuong], [DonViTinh], [GiaNhap], [TongTien], [MaSize], [MaSanPham]) VALUES (273, 174, 5, N'cái', CAST(350000 AS Decimal(18, 0)), CAST(1750000 AS Decimal(18, 0)), 3, 212)
INSERT [dbo].[ChiTietHoaDonNhaps] ([Id], [MaHoaDon], [SoLuong], [DonViTinh], [GiaNhap], [TongTien], [MaSize], [MaSanPham]) VALUES (274, 175, 5, N'cái', CAST(330000 AS Decimal(18, 0)), CAST(1650000 AS Decimal(18, 0)), 1, 210)
INSERT [dbo].[ChiTietHoaDonNhaps] ([Id], [MaHoaDon], [SoLuong], [DonViTinh], [GiaNhap], [TongTien], [MaSize], [MaSanPham]) VALUES (275, 175, 5, N'cái', CAST(330000 AS Decimal(18, 0)), CAST(1650000 AS Decimal(18, 0)), 2, 210)
INSERT [dbo].[ChiTietHoaDonNhaps] ([Id], [MaHoaDon], [SoLuong], [DonViTinh], [GiaNhap], [TongTien], [MaSize], [MaSanPham]) VALUES (276, 176, 5, N'cái', CAST(200000 AS Decimal(18, 0)), CAST(1000000 AS Decimal(18, 0)), 14, 230)
SET IDENTITY_INSERT [dbo].[ChiTietHoaDonNhaps] OFF
GO
SET IDENTITY_INSERT [dbo].[ChiTietHoaDons] ON 

INSERT [dbo].[ChiTietHoaDons] ([MaChiTietHoaDon], [MaHoaDon], [SoLuong], [TongGia], [GiamGia], [MaSize], [MaSanPham]) VALUES (441, 263, 1, CAST(250000 AS Decimal(18, 0)), N'không có', 1, 223)
INSERT [dbo].[ChiTietHoaDons] ([MaChiTietHoaDon], [MaHoaDon], [SoLuong], [TongGia], [GiamGia], [MaSize], [MaSanPham]) VALUES (442, 264, 1, CAST(200000 AS Decimal(18, 0)), N'không có', 1, 190)
INSERT [dbo].[ChiTietHoaDons] ([MaChiTietHoaDon], [MaHoaDon], [SoLuong], [TongGia], [GiamGia], [MaSize], [MaSanPham]) VALUES (443, 265, 1, CAST(150000 AS Decimal(18, 0)), N'không có', 1, 219)
INSERT [dbo].[ChiTietHoaDons] ([MaChiTietHoaDon], [MaHoaDon], [SoLuong], [TongGia], [GiamGia], [MaSize], [MaSanPham]) VALUES (444, 266, 1, CAST(400000 AS Decimal(18, 0)), N'không có', 1, 210)
INSERT [dbo].[ChiTietHoaDons] ([MaChiTietHoaDon], [MaHoaDon], [SoLuong], [TongGia], [GiamGia], [MaSize], [MaSanPham]) VALUES (445, 267, 1, CAST(370000 AS Decimal(18, 0)), N'không có', 7, 224)
INSERT [dbo].[ChiTietHoaDons] ([MaChiTietHoaDon], [MaHoaDon], [SoLuong], [TongGia], [GiamGia], [MaSize], [MaSanPham]) VALUES (446, 268, 1, CAST(400000 AS Decimal(18, 0)), N'không có', 7, 229)
INSERT [dbo].[ChiTietHoaDons] ([MaChiTietHoaDon], [MaHoaDon], [SoLuong], [TongGia], [GiamGia], [MaSize], [MaSanPham]) VALUES (447, 269, 1, CAST(370000 AS Decimal(18, 0)), N'không có', 10, 224)
INSERT [dbo].[ChiTietHoaDons] ([MaChiTietHoaDon], [MaHoaDon], [SoLuong], [TongGia], [GiamGia], [MaSize], [MaSanPham]) VALUES (448, 270, 1, CAST(450000 AS Decimal(18, 0)), N'không có', 7, 226)
INSERT [dbo].[ChiTietHoaDons] ([MaChiTietHoaDon], [MaHoaDon], [SoLuong], [TongGia], [GiamGia], [MaSize], [MaSanPham]) VALUES (449, 271, 1, CAST(370000 AS Decimal(18, 0)), N'không có', 11, 224)
INSERT [dbo].[ChiTietHoaDons] ([MaChiTietHoaDon], [MaHoaDon], [SoLuong], [TongGia], [GiamGia], [MaSize], [MaSanPham]) VALUES (450, 272, 1, CAST(350000 AS Decimal(18, 0)), N'không có', 1, 228)
INSERT [dbo].[ChiTietHoaDons] ([MaChiTietHoaDon], [MaHoaDon], [SoLuong], [TongGia], [GiamGia], [MaSize], [MaSanPham]) VALUES (451, 273, 1, CAST(400000 AS Decimal(18, 0)), N'không có', 10, 229)
INSERT [dbo].[ChiTietHoaDons] ([MaChiTietHoaDon], [MaHoaDon], [SoLuong], [TongGia], [GiamGia], [MaSize], [MaSanPham]) VALUES (452, 274, 1, CAST(300000 AS Decimal(18, 0)), N'không có', 1, 221)
INSERT [dbo].[ChiTietHoaDons] ([MaChiTietHoaDon], [MaHoaDon], [SoLuong], [TongGia], [GiamGia], [MaSize], [MaSanPham]) VALUES (453, 275, 1, CAST(300000 AS Decimal(18, 0)), N'không có', 2, 221)
INSERT [dbo].[ChiTietHoaDons] ([MaChiTietHoaDon], [MaHoaDon], [SoLuong], [TongGia], [GiamGia], [MaSize], [MaSanPham]) VALUES (454, 276, 1, CAST(300000 AS Decimal(18, 0)), N'không có', 2, 221)
INSERT [dbo].[ChiTietHoaDons] ([MaChiTietHoaDon], [MaHoaDon], [SoLuong], [TongGia], [GiamGia], [MaSize], [MaSanPham]) VALUES (455, 277, 1, CAST(300000 AS Decimal(18, 0)), N'không có', 2, 221)
INSERT [dbo].[ChiTietHoaDons] ([MaChiTietHoaDon], [MaHoaDon], [SoLuong], [TongGia], [GiamGia], [MaSize], [MaSanPham]) VALUES (456, 278, 1, CAST(340000 AS Decimal(18, 0)), N'không có', 1, 210)
INSERT [dbo].[ChiTietHoaDons] ([MaChiTietHoaDon], [MaHoaDon], [SoLuong], [TongGia], [GiamGia], [MaSize], [MaSanPham]) VALUES (457, 279, 1, CAST(170000 AS Decimal(18, 0)), N'không có', 1, 184)
INSERT [dbo].[ChiTietHoaDons] ([MaChiTietHoaDon], [MaHoaDon], [SoLuong], [TongGia], [GiamGia], [MaSize], [MaSanPham]) VALUES (458, 280, 1, CAST(199000 AS Decimal(18, 0)), N'không có', 1, 222)
INSERT [dbo].[ChiTietHoaDons] ([MaChiTietHoaDon], [MaHoaDon], [SoLuong], [TongGia], [GiamGia], [MaSize], [MaSanPham]) VALUES (459, 281, 1, CAST(199000 AS Decimal(18, 0)), N'không có', 1, 222)
INSERT [dbo].[ChiTietHoaDons] ([MaChiTietHoaDon], [MaHoaDon], [SoLuong], [TongGia], [GiamGia], [MaSize], [MaSanPham]) VALUES (460, 282, 1, CAST(199000 AS Decimal(18, 0)), N'không có', 1, 222)
INSERT [dbo].[ChiTietHoaDons] ([MaChiTietHoaDon], [MaHoaDon], [SoLuong], [TongGia], [GiamGia], [MaSize], [MaSanPham]) VALUES (461, 283, 1, CAST(199000 AS Decimal(18, 0)), N'không có', 1, 222)
INSERT [dbo].[ChiTietHoaDons] ([MaChiTietHoaDon], [MaHoaDon], [SoLuong], [TongGia], [GiamGia], [MaSize], [MaSanPham]) VALUES (462, 284, 1, CAST(199000 AS Decimal(18, 0)), N'không có', 1, 222)
INSERT [dbo].[ChiTietHoaDons] ([MaChiTietHoaDon], [MaHoaDon], [SoLuong], [TongGia], [GiamGia], [MaSize], [MaSanPham]) VALUES (463, 285, 1, CAST(199000 AS Decimal(18, 0)), N'không có', 1, 222)
INSERT [dbo].[ChiTietHoaDons] ([MaChiTietHoaDon], [MaHoaDon], [SoLuong], [TongGia], [GiamGia], [MaSize], [MaSanPham]) VALUES (464, 286, 1, CAST(150000 AS Decimal(18, 0)), N'không có', 2, 219)
INSERT [dbo].[ChiTietHoaDons] ([MaChiTietHoaDon], [MaHoaDon], [SoLuong], [TongGia], [GiamGia], [MaSize], [MaSanPham]) VALUES (465, 287, 1, CAST(170000 AS Decimal(18, 0)), N'không có', 1, 184)
INSERT [dbo].[ChiTietHoaDons] ([MaChiTietHoaDon], [MaHoaDon], [SoLuong], [TongGia], [GiamGia], [MaSize], [MaSanPham]) VALUES (466, 288, 1, CAST(340000 AS Decimal(18, 0)), N'không có', 2, 210)
INSERT [dbo].[ChiTietHoaDons] ([MaChiTietHoaDon], [MaHoaDon], [SoLuong], [TongGia], [GiamGia], [MaSize], [MaSanPham]) VALUES (467, 289, 1, CAST(340000 AS Decimal(18, 0)), N'không có', 2, 210)
INSERT [dbo].[ChiTietHoaDons] ([MaChiTietHoaDon], [MaHoaDon], [SoLuong], [TongGia], [GiamGia], [MaSize], [MaSanPham]) VALUES (468, 290, 1, CAST(170000 AS Decimal(18, 0)), N'không có', 2, 184)
SET IDENTITY_INSERT [dbo].[ChiTietHoaDons] OFF
GO
SET IDENTITY_INSERT [dbo].[ChiTietTaiKhoan] ON 

INSERT [dbo].[ChiTietTaiKhoan] ([MaChitietTaiKhoan], [MaTaiKhoan], [HoTen], [DiaChi], [SoDienThoai], [AnhDaiDien]) VALUES (1, 1, N'Vũ Đình Vinh', N'Thanh Miện, Hải Dương', N'0865087460', N'')
INSERT [dbo].[ChiTietTaiKhoan] ([MaChitietTaiKhoan], [MaTaiKhoan], [HoTen], [DiaChi], [SoDienThoai], [AnhDaiDien]) VALUES (8, 10, N'1', N'1', N'Admin2', N'')
INSERT [dbo].[ChiTietTaiKhoan] ([MaChitietTaiKhoan], [MaTaiKhoan], [HoTen], [DiaChi], [SoDienThoai], [AnhDaiDien]) VALUES (10, 12, N'string', N'string', N'string', N'')
INSERT [dbo].[ChiTietTaiKhoan] ([MaChitietTaiKhoan], [MaTaiKhoan], [HoTen], [DiaChi], [SoDienThoai], [AnhDaiDien]) VALUES (13, 15, N'a', N'a', N'User1', N'')
SET IDENTITY_INSERT [dbo].[ChiTietTaiKhoan] OFF
GO
SET IDENTITY_INSERT [dbo].[ChuyenMucs] ON 

INSERT [dbo].[ChuyenMucs] ([MaChuyenMuc], [TenChuyenMuc], [NoiDung], [IDCapCha]) VALUES (1, N'Áo Sơ Mi', N'string', 60)
INSERT [dbo].[ChuyenMucs] ([MaChuyenMuc], [TenChuyenMuc], [NoiDung], [IDCapCha]) VALUES (2, N'Áo thun', N'string', 60)
INSERT [dbo].[ChuyenMucs] ([MaChuyenMuc], [TenChuyenMuc], [NoiDung], [IDCapCha]) VALUES (3, N'Áo Polo', N'string', 60)
INSERT [dbo].[ChuyenMucs] ([MaChuyenMuc], [TenChuyenMuc], [NoiDung], [IDCapCha]) VALUES (5, N'Áo len', NULL, 60)
INSERT [dbo].[ChuyenMucs] ([MaChuyenMuc], [TenChuyenMuc], [NoiDung], [IDCapCha]) VALUES (31, N'Quần Tây', N'trống', 61)
INSERT [dbo].[ChuyenMucs] ([MaChuyenMuc], [TenChuyenMuc], [NoiDung], [IDCapCha]) VALUES (35, N'Quần Jeans', NULL, 61)
INSERT [dbo].[ChuyenMucs] ([MaChuyenMuc], [TenChuyenMuc], [NoiDung], [IDCapCha]) VALUES (38, N'Quần short', NULL, 61)
INSERT [dbo].[ChuyenMucs] ([MaChuyenMuc], [TenChuyenMuc], [NoiDung], [IDCapCha]) VALUES (39, N'Thắt lưng', NULL, 65)
INSERT [dbo].[ChuyenMucs] ([MaChuyenMuc], [TenChuyenMuc], [NoiDung], [IDCapCha]) VALUES (40, N'Ví da', NULL, 65)
INSERT [dbo].[ChuyenMucs] ([MaChuyenMuc], [TenChuyenMuc], [NoiDung], [IDCapCha]) VALUES (41, N'Cà vạt', NULL, 65)
INSERT [dbo].[ChuyenMucs] ([MaChuyenMuc], [TenChuyenMuc], [NoiDung], [IDCapCha]) VALUES (42, N'Mũ nón', NULL, 65)
INSERT [dbo].[ChuyenMucs] ([MaChuyenMuc], [TenChuyenMuc], [NoiDung], [IDCapCha]) VALUES (43, N'Túi xách', NULL, 65)
INSERT [dbo].[ChuyenMucs] ([MaChuyenMuc], [TenChuyenMuc], [NoiDung], [IDCapCha]) VALUES (46, N'Sandal', NULL, 65)
INSERT [dbo].[ChuyenMucs] ([MaChuyenMuc], [TenChuyenMuc], [NoiDung], [IDCapCha]) VALUES (60, N'Áo Nam', N'string', NULL)
INSERT [dbo].[ChuyenMucs] ([MaChuyenMuc], [TenChuyenMuc], [NoiDung], [IDCapCha]) VALUES (61, N'Quần Nam', N'string', NULL)
INSERT [dbo].[ChuyenMucs] ([MaChuyenMuc], [TenChuyenMuc], [NoiDung], [IDCapCha]) VALUES (65, N'Phụ kiện', NULL, NULL)
INSERT [dbo].[ChuyenMucs] ([MaChuyenMuc], [TenChuyenMuc], [NoiDung], [IDCapCha]) VALUES (72, N'vfdvf', N'', 71)
SET IDENTITY_INSERT [dbo].[ChuyenMucs] OFF
GO
SET IDENTITY_INSERT [dbo].[DanhGiaSanPham] ON 

INSERT [dbo].[DanhGiaSanPham] ([Id], [SanPhamId], [KhachHangId], [NoiDung], [SoSao], [ThoiGianTao], [TrangThai], [TenKhachHang]) VALUES (11, 184, NULL, N'Hàng tốt, nhưng chưa ok trong tầm giá', 4, CAST(N'2025-06-04T19:32:55.630' AS DateTime), 1, N'Vũ Đình Vinh')
INSERT [dbo].[DanhGiaSanPham] ([Id], [SanPhamId], [KhachHangId], [NoiDung], [SoSao], [ThoiGianTao], [TrangThai], [TenKhachHang]) VALUES (12, 184, 85, N'Hàng ok đó
', 5, CAST(N'2025-06-04T19:39:00.420' AS DateTime), 1, N'Vũ Minh Tuấn')
INSERT [dbo].[DanhGiaSanPham] ([Id], [SanPhamId], [KhachHangId], [NoiDung], [SoSao], [ThoiGianTao], [TrangThai], [TenKhachHang]) VALUES (13, 190, 85, N'ok đấy
', 4, CAST(N'2025-06-04T20:06:15.910' AS DateTime), 1, N'Vũ Minh Tuấn')
INSERT [dbo].[DanhGiaSanPham] ([Id], [SanPhamId], [KhachHangId], [NoiDung], [SoSao], [ThoiGianTao], [TrangThai], [TenKhachHang]) VALUES (14, 194, 85, N'Ok đấy', 3, CAST(N'2025-06-05T22:43:06.053' AS DateTime), 1, N'Vũ Minh Tuấn')
INSERT [dbo].[DanhGiaSanPham] ([Id], [SanPhamId], [KhachHangId], [NoiDung], [SoSao], [ThoiGianTao], [TrangThai], [TenKhachHang]) VALUES (15, 193, 85, N'ok', 2, CAST(N'2025-06-05T23:30:29.690' AS DateTime), 1, N'Vũ Minh Tuấn')
INSERT [dbo].[DanhGiaSanPham] ([Id], [SanPhamId], [KhachHangId], [NoiDung], [SoSao], [ThoiGianTao], [TrangThai], [TenKhachHang]) VALUES (16, 184, NULL, N'ok', 3, CAST(N'2025-06-10T13:43:02.667' AS DateTime), 0, N'Vinh')
SET IDENTITY_INSERT [dbo].[DanhGiaSanPham] OFF
GO
SET IDENTITY_INSERT [dbo].[GiamGia] ON 

INSERT [dbo].[GiamGia] ([Id], [TenChuongTrinh], [LoaiGiamGia], [GiaTriGiam], [MaGiamGia], [SoLuongMua], [SoLuongTang], [SanPhamTangId], [GiaTriDonToiThieu], [ApDungToanBoSanPham], [NhomKhachHang], [NgayBatDau], [NgayKetThuc], [DangHoatDong], [NgayTao], [NgayCapNhat], [SoLuongToiDa], [SoLuongDaDung]) VALUES (1, N'Khuyến mãi hè 2025', N'PhanTramTheoSanPham', CAST(15.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, 1, NULL, CAST(N'2025-05-29T00:00:00.000' AS DateTime), CAST(N'2025-06-27T23:59:59.000' AS DateTime), 1, CAST(N'2025-05-27T10:00:00.000' AS DateTime), CAST(N'2025-05-31T03:20:22.750' AS DateTime), NULL, 0)
INSERT [dbo].[GiamGia] ([Id], [TenChuongTrinh], [LoaiGiamGia], [GiaTriGiam], [MaGiamGia], [SoLuongMua], [SoLuongTang], [SanPhamTangId], [GiaTriDonToiThieu], [ApDungToanBoSanPham], [NhomKhachHang], [NgayBatDau], [NgayKetThuc], [DangHoatDong], [NgayTao], [NgayCapNhat], [SoLuongToiDa], [SoLuongDaDung]) VALUES (9, N'Mã giảm giá cho khách mới', N'PhanTramTheoSanPham', CAST(12.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, 0, NULL, CAST(N'2025-05-29T00:00:00.000' AS DateTime), CAST(N'2026-05-16T00:00:00.000' AS DateTime), 1, CAST(N'2025-05-31T06:17:15.060' AS DateTime), CAST(N'2025-05-31T06:17:15.060' AS DateTime), NULL, 0)
INSERT [dbo].[GiamGia] ([Id], [TenChuongTrinh], [LoaiGiamGia], [GiaTriGiam], [MaGiamGia], [SoLuongMua], [SoLuongTang], [SanPhamTangId], [GiaTriDonToiThieu], [ApDungToanBoSanPham], [NhomKhachHang], [NgayBatDau], [NgayKetThuc], [DangHoatDong], [NgayTao], [NgayCapNhat], [SoLuongToiDa], [SoLuongDaDung]) VALUES (10, N'Khuyến mãi hè 2025', N'PhanTramTheoDonHang', CAST(2.00 AS Decimal(18, 2)), N'4MENSHOPCODE', NULL, NULL, NULL, NULL, 1, N'VIP', CAST(N'2025-05-21T00:00:00.000' AS DateTime), CAST(N'2026-05-21T00:00:00.000' AS DateTime), 1, CAST(N'2025-05-31T06:24:23.547' AS DateTime), CAST(N'2025-06-02T15:01:16.790' AS DateTime), 32, 0)
INSERT [dbo].[GiamGia] ([Id], [TenChuongTrinh], [LoaiGiamGia], [GiaTriGiam], [MaGiamGia], [SoLuongMua], [SoLuongTang], [SanPhamTangId], [GiaTriDonToiThieu], [ApDungToanBoSanPham], [NhomKhachHang], [NgayBatDau], [NgayKetThuc], [DangHoatDong], [NgayTao], [NgayCapNhat], [SoLuongToiDa], [SoLuongDaDung]) VALUES (11, N'qưeqwewqe', N'PhanTramTheoDonHang', CAST(12.00 AS Decimal(18, 2)), N'3232434', NULL, NULL, NULL, NULL, 1, N'THUONG', CAST(N'2025-05-28T00:00:00.000' AS DateTime), CAST(N'2026-05-29T00:00:00.000' AS DateTime), 0, CAST(N'2025-05-31T07:16:49.920' AS DateTime), CAST(N'2025-05-31T08:27:18.710' AS DateTime), 33, 0)
INSERT [dbo].[GiamGia] ([Id], [TenChuongTrinh], [LoaiGiamGia], [GiaTriGiam], [MaGiamGia], [SoLuongMua], [SoLuongTang], [SanPhamTangId], [GiaTriDonToiThieu], [ApDungToanBoSanPham], [NhomKhachHang], [NgayBatDau], [NgayKetThuc], [DangHoatDong], [NgayTao], [NgayCapNhat], [SoLuongToiDa], [SoLuongDaDung]) VALUES (12, N'string', N'GiaCoDinhTheoDonHang', CAST(50000.00 AS Decimal(18, 2)), N'4MENSHOPHE2025', NULL, NULL, NULL, NULL, 1, N'THUONG', CAST(N'2025-05-29T00:00:00.000' AS DateTime), CAST(N'2026-05-21T00:00:00.000' AS DateTime), 1, CAST(N'2025-05-31T08:00:33.503' AS DateTime), CAST(N'2025-06-02T15:01:40.803' AS DateTime), 43, 0)
SET IDENTITY_INSERT [dbo].[GiamGia] OFF
GO
SET IDENTITY_INSERT [dbo].[GiamGia_SanPham] ON 

INSERT [dbo].[GiamGia_SanPham] ([Id], [GiamGiaId], [SanPhamId]) VALUES (20, 1, 184)
INSERT [dbo].[GiamGia_SanPham] ([Id], [GiamGiaId], [SanPhamId]) VALUES (21, 1, 210)
SET IDENTITY_INSERT [dbo].[GiamGia_SanPham] OFF
GO
SET IDENTITY_INSERT [dbo].[HoaDonNhaps] ON 

INSERT [dbo].[HoaDonNhaps] ([MaHoaDon], [MaNhaPhanPhoi], [NgayTao], [KieuThanhToan], [MaTaiKhoan], [TongTien]) VALUES (159, 2, CAST(N'2025-06-08T20:45:09.753' AS DateTime), N'Tiền mặt', 1, CAST(1800000 AS Decimal(18, 0)))
INSERT [dbo].[HoaDonNhaps] ([MaHoaDon], [MaNhaPhanPhoi], [NgayTao], [KieuThanhToan], [MaTaiKhoan], [TongTien]) VALUES (160, 3, CAST(N'2025-06-08T20:45:45.070' AS DateTime), N'Tiền mặt', 1, CAST(2450000 AS Decimal(18, 0)))
INSERT [dbo].[HoaDonNhaps] ([MaHoaDon], [MaNhaPhanPhoi], [NgayTao], [KieuThanhToan], [MaTaiKhoan], [TongTien]) VALUES (161, 4, CAST(N'2025-06-08T20:46:19.890' AS DateTime), N'Tiền mặt', 1, CAST(2925000 AS Decimal(18, 0)))
INSERT [dbo].[HoaDonNhaps] ([MaHoaDon], [MaNhaPhanPhoi], [NgayTao], [KieuThanhToan], [MaTaiKhoan], [TongTien]) VALUES (162, 3, CAST(N'2025-06-08T20:46:56.100' AS DateTime), N'Tiền mặt', 1, CAST(4500000 AS Decimal(18, 0)))
INSERT [dbo].[HoaDonNhaps] ([MaHoaDon], [MaNhaPhanPhoi], [NgayTao], [KieuThanhToan], [MaTaiKhoan], [TongTien]) VALUES (164, 61, CAST(N'2025-06-08T20:48:45.070' AS DateTime), N'Tiền mặt', 1, CAST(1800000 AS Decimal(18, 0)))
INSERT [dbo].[HoaDonNhaps] ([MaHoaDon], [MaNhaPhanPhoi], [NgayTao], [KieuThanhToan], [MaTaiKhoan], [TongTien]) VALUES (165, 63, CAST(N'2025-06-08T20:49:12.090' AS DateTime), N'Tiền mặt', 1, CAST(1000000 AS Decimal(18, 0)))
INSERT [dbo].[HoaDonNhaps] ([MaHoaDon], [MaNhaPhanPhoi], [NgayTao], [KieuThanhToan], [MaTaiKhoan], [TongTien]) VALUES (166, 4, CAST(N'2025-06-08T20:49:58.657' AS DateTime), N'Thẻ', 1, CAST(2000000 AS Decimal(18, 0)))
INSERT [dbo].[HoaDonNhaps] ([MaHoaDon], [MaNhaPhanPhoi], [NgayTao], [KieuThanhToan], [MaTaiKhoan], [TongTien]) VALUES (167, 2, CAST(N'2025-06-08T20:51:12.190' AS DateTime), N'Tiền mặt', 1, CAST(3000000 AS Decimal(18, 0)))
INSERT [dbo].[HoaDonNhaps] ([MaHoaDon], [MaNhaPhanPhoi], [NgayTao], [KieuThanhToan], [MaTaiKhoan], [TongTien]) VALUES (168, 3, CAST(N'2025-06-08T20:56:01.003' AS DateTime), N'Tiền mặt', 1, CAST(3000000 AS Decimal(18, 0)))
INSERT [dbo].[HoaDonNhaps] ([MaHoaDon], [MaNhaPhanPhoi], [NgayTao], [KieuThanhToan], [MaTaiKhoan], [TongTien]) VALUES (169, 60, CAST(N'2025-06-08T21:12:56.073' AS DateTime), N'Tiền mặt', 1, CAST(4500000 AS Decimal(18, 0)))
INSERT [dbo].[HoaDonNhaps] ([MaHoaDon], [MaNhaPhanPhoi], [NgayTao], [KieuThanhToan], [MaTaiKhoan], [TongTien]) VALUES (170, 60, CAST(N'2025-06-08T21:13:28.633' AS DateTime), N'Thẻ', 1, CAST(3000000 AS Decimal(18, 0)))
INSERT [dbo].[HoaDonNhaps] ([MaHoaDon], [MaNhaPhanPhoi], [NgayTao], [KieuThanhToan], [MaTaiKhoan], [TongTien]) VALUES (171, 3, CAST(N'2025-06-08T21:17:58.547' AS DateTime), N'Tiền mặt', 1, CAST(3000000 AS Decimal(18, 0)))
INSERT [dbo].[HoaDonNhaps] ([MaHoaDon], [MaNhaPhanPhoi], [NgayTao], [KieuThanhToan], [MaTaiKhoan], [TongTien]) VALUES (172, 63, CAST(N'2025-06-08T21:26:27.313' AS DateTime), N'Tiền mặt', 1, CAST(3000000 AS Decimal(18, 0)))
INSERT [dbo].[HoaDonNhaps] ([MaHoaDon], [MaNhaPhanPhoi], [NgayTao], [KieuThanhToan], [MaTaiKhoan], [TongTien]) VALUES (173, 2, CAST(N'2025-06-09T19:53:37.793' AS DateTime), N'Thẻ', 1, CAST(3000000 AS Decimal(18, 0)))
INSERT [dbo].[HoaDonNhaps] ([MaHoaDon], [MaNhaPhanPhoi], [NgayTao], [KieuThanhToan], [MaTaiKhoan], [TongTien]) VALUES (174, 4, CAST(N'2025-06-09T19:55:26.647' AS DateTime), N'Tiền mặt', 1, CAST(5250000 AS Decimal(18, 0)))
INSERT [dbo].[HoaDonNhaps] ([MaHoaDon], [MaNhaPhanPhoi], [NgayTao], [KieuThanhToan], [MaTaiKhoan], [TongTien]) VALUES (175, 4, CAST(N'2025-06-10T13:03:18.090' AS DateTime), N'Thẻ', 1, CAST(3300000 AS Decimal(18, 0)))
INSERT [dbo].[HoaDonNhaps] ([MaHoaDon], [MaNhaPhanPhoi], [NgayTao], [KieuThanhToan], [MaTaiKhoan], [TongTien]) VALUES (176, 3, CAST(N'2025-06-10T13:07:58.413' AS DateTime), N'Tiền mặt', 1, CAST(1000000 AS Decimal(18, 0)))
SET IDENTITY_INSERT [dbo].[HoaDonNhaps] OFF
GO
SET IDENTITY_INSERT [dbo].[HoaDons] ON 

INSERT [dbo].[HoaDons] ([MaHoaDon], [TrangThai], [NgayTao], [TongGia], [DiaChiGiaoHang], [ThoiGianGiaoHang], [MaKH]) VALUES (263, N'5', CAST(N'2025-06-07T20:57:38.893' AS DateTime), CAST(250000 AS Decimal(18, 0)), N'số 4, Phường Hàng Trống, Quận Hoàn Kiếm, Thành phố Hà Nội', NULL, 143)
INSERT [dbo].[HoaDons] ([MaHoaDon], [TrangThai], [NgayTao], [TongGia], [DiaChiGiaoHang], [ThoiGianGiaoHang], [MaKH]) VALUES (264, N'5', CAST(N'2025-06-06T21:00:53.827' AS DateTime), CAST(200000 AS Decimal(18, 0)), N'dsdsds, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', NULL, 144)
INSERT [dbo].[HoaDons] ([MaHoaDon], [TrangThai], [NgayTao], [TongGia], [DiaChiGiaoHang], [ThoiGianGiaoHang], [MaKH]) VALUES (265, N'5', CAST(N'2025-06-05T21:02:56.303' AS DateTime), CAST(150000 AS Decimal(18, 0)), N'số 4, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', NULL, 145)
INSERT [dbo].[HoaDons] ([MaHoaDon], [TrangThai], [NgayTao], [TongGia], [DiaChiGiaoHang], [ThoiGianGiaoHang], [MaKH]) VALUES (266, N'7', CAST(N'2025-06-04T21:04:18.537' AS DateTime), CAST(400000 AS Decimal(18, 0)), N'32, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', NULL, 146)
INSERT [dbo].[HoaDons] ([MaHoaDon], [TrangThai], [NgayTao], [TongGia], [DiaChiGiaoHang], [ThoiGianGiaoHang], [MaKH]) VALUES (267, N'5', CAST(N'2025-06-08T21:18:49.550' AS DateTime), CAST(370000 AS Decimal(18, 0)), N'23, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', NULL, 147)
INSERT [dbo].[HoaDons] ([MaHoaDon], [TrangThai], [NgayTao], [TongGia], [DiaChiGiaoHang], [ThoiGianGiaoHang], [MaKH]) VALUES (268, N'5', CAST(N'2025-06-08T21:28:39.183' AS DateTime), CAST(400000 AS Decimal(18, 0)), N'56, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', NULL, 148)
INSERT [dbo].[HoaDons] ([MaHoaDon], [TrangThai], [NgayTao], [TongGia], [DiaChiGiaoHang], [ThoiGianGiaoHang], [MaKH]) VALUES (269, N'5', CAST(N'2025-06-09T19:57:54.290' AS DateTime), CAST(370000 AS Decimal(18, 0)), N'ewew, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', NULL, 149)
INSERT [dbo].[HoaDons] ([MaHoaDon], [TrangThai], [NgayTao], [TongGia], [DiaChiGiaoHang], [ThoiGianGiaoHang], [MaKH]) VALUES (270, N'5', CAST(N'2025-06-09T19:59:38.850' AS DateTime), CAST(450000 AS Decimal(18, 0)), N'dsdsds, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', NULL, 150)
INSERT [dbo].[HoaDons] ([MaHoaDon], [TrangThai], [NgayTao], [TongGia], [DiaChiGiaoHang], [ThoiGianGiaoHang], [MaKH]) VALUES (271, N'5', CAST(N'2025-06-09T20:18:33.960' AS DateTime), CAST(370000 AS Decimal(18, 0)), N'45, Phường Trúc Bạch, Quận Ba Đình, Thành phố Hà Nội', NULL, 151)
INSERT [dbo].[HoaDons] ([MaHoaDon], [TrangThai], [NgayTao], [TongGia], [DiaChiGiaoHang], [ThoiGianGiaoHang], [MaKH]) VALUES (272, N'5', CAST(N'2025-06-09T20:23:14.057' AS DateTime), CAST(350000 AS Decimal(18, 0)), N'32, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', NULL, 152)
INSERT [dbo].[HoaDons] ([MaHoaDon], [TrangThai], [NgayTao], [TongGia], [DiaChiGiaoHang], [ThoiGianGiaoHang], [MaKH]) VALUES (273, N'8', CAST(N'2025-06-09T20:25:44.047' AS DateTime), CAST(400000 AS Decimal(18, 0)), N'32, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', NULL, 153)
INSERT [dbo].[HoaDons] ([MaHoaDon], [TrangThai], [NgayTao], [TongGia], [DiaChiGiaoHang], [ThoiGianGiaoHang], [MaKH]) VALUES (274, N'5', CAST(N'2025-06-09T21:39:11.123' AS DateTime), CAST(300000 AS Decimal(18, 0)), N'23, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', NULL, 154)
INSERT [dbo].[HoaDons] ([MaHoaDon], [TrangThai], [NgayTao], [TongGia], [DiaChiGiaoHang], [ThoiGianGiaoHang], [MaKH]) VALUES (275, N'5', CAST(N'2025-06-09T21:47:29.057' AS DateTime), CAST(300000 AS Decimal(18, 0)), N'32, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', NULL, 155)
INSERT [dbo].[HoaDons] ([MaHoaDon], [TrangThai], [NgayTao], [TongGia], [DiaChiGiaoHang], [ThoiGianGiaoHang], [MaKH]) VALUES (276, N'8', CAST(N'2025-06-09T22:10:14.937' AS DateTime), CAST(300000 AS Decimal(18, 0)), N'32, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', NULL, 156)
INSERT [dbo].[HoaDons] ([MaHoaDon], [TrangThai], [NgayTao], [TongGia], [DiaChiGiaoHang], [ThoiGianGiaoHang], [MaKH]) VALUES (277, N'7', CAST(N'2025-06-09T22:14:51.060' AS DateTime), CAST(300000 AS Decimal(18, 0)), N'32, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', NULL, 157)
INSERT [dbo].[HoaDons] ([MaHoaDon], [TrangThai], [NgayTao], [TongGia], [DiaChiGiaoHang], [ThoiGianGiaoHang], [MaKH]) VALUES (278, N'3', CAST(N'2025-06-09T22:39:30.960' AS DateTime), CAST(340000 AS Decimal(18, 0)), N'32, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', NULL, 158)
INSERT [dbo].[HoaDons] ([MaHoaDon], [TrangThai], [NgayTao], [TongGia], [DiaChiGiaoHang], [ThoiGianGiaoHang], [MaKH]) VALUES (279, N'1', CAST(N'2025-06-09T22:55:14.533' AS DateTime), CAST(170000 AS Decimal(18, 0)), N'32, Phường Tân Định, Quận 1, Thành phố Hồ Chí Minh', NULL, 159)
INSERT [dbo].[HoaDons] ([MaHoaDon], [TrangThai], [NgayTao], [TongGia], [DiaChiGiaoHang], [ThoiGianGiaoHang], [MaKH]) VALUES (280, N'1', CAST(N'2025-06-09T23:36:04.637' AS DateTime), CAST(199000 AS Decimal(18, 0)), N'32, Phường Trúc Bạch, Quận Ba Đình, Thành phố Hà Nội', NULL, 160)
INSERT [dbo].[HoaDons] ([MaHoaDon], [TrangThai], [NgayTao], [TongGia], [DiaChiGiaoHang], [ThoiGianGiaoHang], [MaKH]) VALUES (281, N'7', CAST(N'2025-06-09T23:41:17.503' AS DateTime), CAST(199000 AS Decimal(18, 0)), N'23, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', NULL, 161)
INSERT [dbo].[HoaDons] ([MaHoaDon], [TrangThai], [NgayTao], [TongGia], [DiaChiGiaoHang], [ThoiGianGiaoHang], [MaKH]) VALUES (282, N'7', CAST(N'2025-06-09T23:48:13.537' AS DateTime), CAST(199000 AS Decimal(18, 0)), N'33, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', NULL, 162)
INSERT [dbo].[HoaDons] ([MaHoaDon], [TrangThai], [NgayTao], [TongGia], [DiaChiGiaoHang], [ThoiGianGiaoHang], [MaKH]) VALUES (283, N'7', CAST(N'2025-06-09T23:48:14.197' AS DateTime), CAST(199000 AS Decimal(18, 0)), N'33, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', NULL, 163)
INSERT [dbo].[HoaDons] ([MaHoaDon], [TrangThai], [NgayTao], [TongGia], [DiaChiGiaoHang], [ThoiGianGiaoHang], [MaKH]) VALUES (284, N'1', CAST(N'2025-06-09T16:55:03.193' AS DateTime), CAST(0 AS Decimal(18, 0)), N'null', NULL, 64)
INSERT [dbo].[HoaDons] ([MaHoaDon], [TrangThai], [NgayTao], [TongGia], [DiaChiGiaoHang], [ThoiGianGiaoHang], [MaKH]) VALUES (285, N'9', CAST(N'2025-06-09T16:59:27.823' AS DateTime), CAST(0 AS Decimal(18, 0)), N'null', NULL, 64)
INSERT [dbo].[HoaDons] ([MaHoaDon], [TrangThai], [NgayTao], [TongGia], [DiaChiGiaoHang], [ThoiGianGiaoHang], [MaKH]) VALUES (286, N'1', CAST(N'2025-06-10T12:57:59.123' AS DateTime), CAST(150000 AS Decimal(18, 0)), N'32, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', NULL, 166)
INSERT [dbo].[HoaDons] ([MaHoaDon], [TrangThai], [NgayTao], [TongGia], [DiaChiGiaoHang], [ThoiGianGiaoHang], [MaKH]) VALUES (287, N'1', CAST(N'2025-06-10T13:37:32.363' AS DateTime), CAST(170000 AS Decimal(18, 0)), N'32, Phường Tân Định, Quận 1, Thành phố Hồ Chí Minh', NULL, 167)
INSERT [dbo].[HoaDons] ([MaHoaDon], [TrangThai], [NgayTao], [TongGia], [DiaChiGiaoHang], [ThoiGianGiaoHang], [MaKH]) VALUES (288, N'0', CAST(N'2025-06-25T15:58:56.153' AS DateTime), CAST(340000 AS Decimal(18, 0)), N'h, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', NULL, 168)
INSERT [dbo].[HoaDons] ([MaHoaDon], [TrangThai], [NgayTao], [TongGia], [DiaChiGiaoHang], [ThoiGianGiaoHang], [MaKH]) VALUES (289, N'0', CAST(N'2025-06-25T15:58:59.797' AS DateTime), CAST(340000 AS Decimal(18, 0)), N'h, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', NULL, 169)
INSERT [dbo].[HoaDons] ([MaHoaDon], [TrangThai], [NgayTao], [TongGia], [DiaChiGiaoHang], [ThoiGianGiaoHang], [MaKH]) VALUES (290, N'9', CAST(N'2025-06-25T08:59:52.547' AS DateTime), CAST(0 AS Decimal(18, 0)), N'null', NULL, 64)
SET IDENTITY_INSERT [dbo].[HoaDons] OFF
GO
SET IDENTITY_INSERT [dbo].[KhachHang] ON 

INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (64, N'Vũ Đình Vinh', N'Hải Dương', N'098765432 ', NULL, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (67, N'Huấn', N'Yên Bái', N'0657687987', NULL, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (68, N'Khá Bảnh', N'Bắc Ninh', N'0856472195', NULL, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (69, N'Dương Minh Tuyền', N'Bắc Ninh', N'03726172  ', NULL, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (71, N'Vũ Minh Hải', N'Cà Mau', N'0398237639', NULL, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (73, N'Vũ Hải Đăng', N'Hải Phòng', N'09648364  ', NULL, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (75, N'Lê Minh Khôi', N'Thái Bình', N'0957685848', NULL, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (76, N'Nguyễn Văn Quyết', N'Hà Nội', N'0984754754', NULL, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (84, N'Vũ Đình Vinh', N'Hải Dương', N'0865087460', 16, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (85, N'Vũ Minh Tuấn', N'Hà Nội', N'0853746586', 17, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (86, N'Vũ Hải Đăng', N'Hải Dương', N'0975847364', 18, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (87, N'Vũ Đình Tuyến', N'Quỳnh Phụng, Thái Bình', N'0974635443', 19, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (98, N'Vũ Quang Vinh', N'Hải Dương', N'0865087460', 22, NULL)
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (102, N'1', N'1, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', N'1         ', NULL, N'1')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (110, N'Vũ Hải Đăng', N'3, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', N'3         ', NULL, N'3')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (111, N'Vũ Hải Đăng', N'3, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', N'3         ', NULL, N'3')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (125, N'string', N'string', N'string    ', NULL, N'string')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (127, N'string', N'string', N'string    ', NULL, N'string')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (135, N'Vũ Hải Đăng', N'a, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', N'0975847364', NULL, N'vuv47109@gmail.com')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (137, N'Vũ Đình Vinh', N'23, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', N'0975847364', NULL, N'vuv47109@gmail.com')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (138, N'Vũ Hữu Tuấn', N'34, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', N'0958675867', NULL, N'vuv28104@gmail.com')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (139, N'Vũ Hữu Tuấn', N'45, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', N'0957685765', NULL, N'vuv28104@gmail.com')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (141, N'Vũ Hải Đăng', N'fg, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', N'0975847364', NULL, N'vuv47109@gmail.com')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (142, N'Vũ Hải Đăng', N'fg, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', N'0975847364', NULL, N'vuv47109@gmail.com')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (143, N'Vũ Minh Quang', N'số 4, Phường Hàng Trống, Quận Hoàn Kiếm, Thành phố Hà Nội', N'0857685748', NULL, N'vuv47109@gmail.com')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (144, N'Vũ Hải Đăng', N'dsdsds, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', N'0975847364', NULL, N'cd@gmail.com')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (145, N'Vũ Hải Đăng', N'số 4, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', N'0975847364', NULL, N'vuv28104@gmail.com')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (146, N'Vũ Hải Đăng', N'32, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', N'0975847364', NULL, N'vuv47109@gmail.com')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (147, N'Vũ Hải', N'23, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', N'0975847364', NULL, N'vuv47109@gmail.com')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (148, N'Vũ Đăng', N'56, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', N'0975847364', NULL, N'vuv28104@gmail.com')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (149, N'Vũ Hải Đăng', N'ewew, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', N'0975847364', NULL, N'vuv47109@gmail.com')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (150, N'Vũ Vinh', N'dsdsds, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', N'0975847364', NULL, N'vuv28104@gmail.com')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (151, N'Vũ Minh', N'45, Phường Trúc Bạch, Quận Ba Đình, Thành phố Hà Nội', N'0975847364', NULL, N'vuv47109@gmail.com')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (152, N'Vũ Hải Đăng', N'32, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', N'0975847364', NULL, N'vuv47109@gmail.com')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (153, N'Vũ Đình Đạt', N'32, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', N'0975847364', NULL, N'vuv47109@gmail.com')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (154, N'Thu Huyền', N'23, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', N'0975847364', NULL, N'vuv47109@gmail.com')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (155, N'Vũ Hải Đăng', N'32, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', N'0975847364', NULL, N'vuv47109@gmail.com')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (156, N'Vũ Hải Minh', N'32, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', N'0975847364', NULL, N'vuv47109@gmail.com')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (157, N'Vũ Hữu', N'32, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', N'0975847364', NULL, N'vuv47109@gmail.com')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (158, N'Vũ Hải Đăng', N'32, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', N'0975847364', NULL, N'vuv28104@gmail.com')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (159, N'Vũ Hải Đăng', N'32, Phường Tân Định, Quận 1, Thành phố Hồ Chí Minh', N'0975847364', NULL, N'vuv47109@gmail.com')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (160, N'Vũ Hải Đăng', N'32, Phường Trúc Bạch, Quận Ba Đình, Thành phố Hà Nội', N'0975847364', NULL, N'vuv47109@gmail.com')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (161, N'Vũ Hải Đăng', N'23, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', N'0975847364', NULL, N'vuv47109@gmail.com')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (162, N'Vũ Hải Đăng', N'33, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', N'0975847364', NULL, N'vuv47109@gmail.com')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (163, N'Vũ Hải Đăng', N'33, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', N'0975847364', NULL, N'vuv47109@gmail.com')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (164, N'Vũ Hải Đăng', N'32, Phường Hàng Trống, Quận Hoàn Kiếm, Thành phố Hà Nội', N'0975847364', NULL, N'vuv47109@gmail.com')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (165, N'Vinh', N'2, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', N'0975847364', NULL, N'vuv47109@gmail.com')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (166, N'Vũ Vinh', N'32, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', N'0975847364', NULL, N'vuv28104@gmail.com')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (167, N'Vũ Hải Đăng', N'32, Phường Tân Định, Quận 1, Thành phố Hồ Chí Minh', N'0975847364', NULL, N'vuv47109@gmail.com')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (168, N'Vũ Hải Đăng', N'h, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', N'0975847364', NULL, N'vuv47109@gmail.com')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (169, N'Vũ Hải Đăng', N'h, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', N'0975847364', NULL, N'vuv47109@gmail.com')
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [DiaChi], [SDT], [MaTaiKhoan], [Email]) VALUES (170, N'Vũ Hải Đăng', N'32, Phường Hàng Trống, Quận Hoàn Kiếm, Thành phố Hà Nội', N'0975847364', NULL, N'vuv47109@gmail.com')
SET IDENTITY_INSERT [dbo].[KhachHang] OFF
GO
SET IDENTITY_INSERT [dbo].[LoaiTaiKhoan] ON 

INSERT [dbo].[LoaiTaiKhoan] ([MaLoai], [TenLoai], [Mota]) VALUES (1, N'Admin', NULL)
INSERT [dbo].[LoaiTaiKhoan] ([MaLoai], [TenLoai], [Mota]) VALUES (2, N'KhachHang', NULL)
SET IDENTITY_INSERT [dbo].[LoaiTaiKhoan] OFF
GO
SET IDENTITY_INSERT [dbo].[NhaPhanPhois] ON 

INSERT [dbo].[NhaPhanPhois] ([MaNhaPhanPhoi], [TenNhaPhanPhoi], [DiaChi], [SoDienThoai], [MoTa]) VALUES (2, N'Zara', N'Hà Nội', N'0987654322', N'Chưa có')
INSERT [dbo].[NhaPhanPhois] ([MaNhaPhanPhoi], [TenNhaPhanPhoi], [DiaChi], [SoDienThoai], [MoTa]) VALUES (3, N'Topman', N'Hưng Yên', N'0987654323', N'Chưa có')
INSERT [dbo].[NhaPhanPhois] ([MaNhaPhanPhoi], [TenNhaPhanPhoi], [DiaChi], [SoDienThoai], [MoTa]) VALUES (4, N'UNIQLO ', N'Hải Dương', N'0987654324', N'Chưa có')
INSERT [dbo].[NhaPhanPhois] ([MaNhaPhanPhoi], [TenNhaPhanPhoi], [DiaChi], [SoDienThoai], [MoTa]) VALUES (60, N'Marc Fashion', N'Thái Bình', N'0958475323', NULL)
INSERT [dbo].[NhaPhanPhois] ([MaNhaPhanPhoi], [TenNhaPhanPhoi], [DiaChi], [SoDienThoai], [MoTa]) VALUES (61, N'YODY CLOTHES', N'Nam Định', N'0395673421', NULL)
INSERT [dbo].[NhaPhanPhois] ([MaNhaPhanPhoi], [TenNhaPhanPhoi], [DiaChi], [SoDienThoai], [MoTa]) VALUES (62, N'IVY moda', N'Hà Nội', N'0975646583', NULL)
INSERT [dbo].[NhaPhanPhois] ([MaNhaPhanPhoi], [TenNhaPhanPhoi], [DiaChi], [SoDienThoai], [MoTa]) VALUES (63, N'20Again Store', N'Hà Nội', N'0985647312', NULL)
SET IDENTITY_INSERT [dbo].[NhaPhanPhois] OFF
GO
SET IDENTITY_INSERT [dbo].[SanPhamChiTiet] ON 

INSERT [dbo].[SanPhamChiTiet] ([ID], [MaSP], [MaSize], [SoLuong], [TrangThai]) VALUES (102, 184, 1, 3, 1)
INSERT [dbo].[SanPhamChiTiet] ([ID], [MaSP], [MaSize], [SoLuong], [TrangThai]) VALUES (103, 184, 2, 4, 1)
INSERT [dbo].[SanPhamChiTiet] ([ID], [MaSP], [MaSize], [SoLuong], [TrangThai]) VALUES (104, 185, 2, 5, 1)
INSERT [dbo].[SanPhamChiTiet] ([ID], [MaSP], [MaSize], [SoLuong], [TrangThai]) VALUES (105, 185, 3, 5, 1)
INSERT [dbo].[SanPhamChiTiet] ([ID], [MaSP], [MaSize], [SoLuong], [TrangThai]) VALUES (106, 185, 4, 4, 1)
INSERT [dbo].[SanPhamChiTiet] ([ID], [MaSP], [MaSize], [SoLuong], [TrangThai]) VALUES (107, 190, 1, 4, 1)
INSERT [dbo].[SanPhamChiTiet] ([ID], [MaSP], [MaSize], [SoLuong], [TrangThai]) VALUES (108, 190, 2, 5, 1)
INSERT [dbo].[SanPhamChiTiet] ([ID], [MaSP], [MaSize], [SoLuong], [TrangThai]) VALUES (109, 190, 3, 5, 1)
INSERT [dbo].[SanPhamChiTiet] ([ID], [MaSP], [MaSize], [SoLuong], [TrangThai]) VALUES (110, 210, 1, 9, 1)
INSERT [dbo].[SanPhamChiTiet] ([ID], [MaSP], [MaSize], [SoLuong], [TrangThai]) VALUES (111, 210, 2, 8, 1)
INSERT [dbo].[SanPhamChiTiet] ([ID], [MaSP], [MaSize], [SoLuong], [TrangThai]) VALUES (112, 210, 3, 5, 1)
INSERT [dbo].[SanPhamChiTiet] ([ID], [MaSP], [MaSize], [SoLuong], [TrangThai]) VALUES (113, 222, 1, 2, 1)
INSERT [dbo].[SanPhamChiTiet] ([ID], [MaSP], [MaSize], [SoLuong], [TrangThai]) VALUES (114, 222, 2, 5, 1)
INSERT [dbo].[SanPhamChiTiet] ([ID], [MaSP], [MaSize], [SoLuong], [TrangThai]) VALUES (115, 219, 1, 4, 1)
INSERT [dbo].[SanPhamChiTiet] ([ID], [MaSP], [MaSize], [SoLuong], [TrangThai]) VALUES (116, 219, 2, 4, 1)
INSERT [dbo].[SanPhamChiTiet] ([ID], [MaSP], [MaSize], [SoLuong], [TrangThai]) VALUES (117, 221, 1, 4, 1)
INSERT [dbo].[SanPhamChiTiet] ([ID], [MaSP], [MaSize], [SoLuong], [TrangThai]) VALUES (118, 221, 2, 4, 1)
INSERT [dbo].[SanPhamChiTiet] ([ID], [MaSP], [MaSize], [SoLuong], [TrangThai]) VALUES (119, 218, 1, 5, 1)
INSERT [dbo].[SanPhamChiTiet] ([ID], [MaSP], [MaSize], [SoLuong], [TrangThai]) VALUES (120, 218, 2, 5, 1)
INSERT [dbo].[SanPhamChiTiet] ([ID], [MaSP], [MaSize], [SoLuong], [TrangThai]) VALUES (121, 218, 3, 5, 1)
INSERT [dbo].[SanPhamChiTiet] ([ID], [MaSP], [MaSize], [SoLuong], [TrangThai]) VALUES (122, 223, 1, 4, 1)
INSERT [dbo].[SanPhamChiTiet] ([ID], [MaSP], [MaSize], [SoLuong], [TrangThai]) VALUES (123, 223, 2, 5, 1)
INSERT [dbo].[SanPhamChiTiet] ([ID], [MaSP], [MaSize], [SoLuong], [TrangThai]) VALUES (124, 223, 3, 5, 1)
INSERT [dbo].[SanPhamChiTiet] ([ID], [MaSP], [MaSize], [SoLuong], [TrangThai]) VALUES (125, 224, 7, 4, 1)
INSERT [dbo].[SanPhamChiTiet] ([ID], [MaSP], [MaSize], [SoLuong], [TrangThai]) VALUES (126, 224, 10, 4, 1)
INSERT [dbo].[SanPhamChiTiet] ([ID], [MaSP], [MaSize], [SoLuong], [TrangThai]) VALUES (127, 224, 11, 4, 1)
INSERT [dbo].[SanPhamChiTiet] ([ID], [MaSP], [MaSize], [SoLuong], [TrangThai]) VALUES (128, 225, 7, 5, 1)
INSERT [dbo].[SanPhamChiTiet] ([ID], [MaSP], [MaSize], [SoLuong], [TrangThai]) VALUES (129, 225, 10, 5, 1)
INSERT [dbo].[SanPhamChiTiet] ([ID], [MaSP], [MaSize], [SoLuong], [TrangThai]) VALUES (130, 226, 7, 4, 1)
INSERT [dbo].[SanPhamChiTiet] ([ID], [MaSP], [MaSize], [SoLuong], [TrangThai]) VALUES (131, 226, 10, 5, 1)
INSERT [dbo].[SanPhamChiTiet] ([ID], [MaSP], [MaSize], [SoLuong], [TrangThai]) VALUES (132, 229, 7, 4, 1)
INSERT [dbo].[SanPhamChiTiet] ([ID], [MaSP], [MaSize], [SoLuong], [TrangThai]) VALUES (133, 229, 10, 5, 1)
INSERT [dbo].[SanPhamChiTiet] ([ID], [MaSP], [MaSize], [SoLuong], [TrangThai]) VALUES (134, 228, 1, 4, 1)
INSERT [dbo].[SanPhamChiTiet] ([ID], [MaSP], [MaSize], [SoLuong], [TrangThai]) VALUES (135, 228, 2, 5, 1)
INSERT [dbo].[SanPhamChiTiet] ([ID], [MaSP], [MaSize], [SoLuong], [TrangThai]) VALUES (136, 212, 1, 5, 1)
INSERT [dbo].[SanPhamChiTiet] ([ID], [MaSP], [MaSize], [SoLuong], [TrangThai]) VALUES (137, 212, 2, 5, 1)
INSERT [dbo].[SanPhamChiTiet] ([ID], [MaSP], [MaSize], [SoLuong], [TrangThai]) VALUES (138, 212, 3, 5, 1)
INSERT [dbo].[SanPhamChiTiet] ([ID], [MaSP], [MaSize], [SoLuong], [TrangThai]) VALUES (139, 230, 14, 5, 1)
SET IDENTITY_INSERT [dbo].[SanPhamChiTiet] OFF
GO
SET IDENTITY_INSERT [dbo].[SanPhams] ON 

INSERT [dbo].[SanPhams] ([MaSanPham], [MaChuyenMuc], [TenSanPham], [AnhDaiDien], [Gia], [TrangThai], [LuotXem], [MoTa]) VALUES (184, 1, N'Áo Sơ Mi Sọc Thêu Huy Hiệu M Form Tailored SM180 Màu Trắng', N'ao-so-mi-soc-theu-huy-hieu-m-form-tailored-sm180-19228-slide-products-682aa760e6b83.jpg,ao-so-mi-soc-theu-huy-hieu-m-form-tailored-sm180-19228-slide-products-682aa761657d3.jpg', CAST(200000 AS Decimal(18, 0)), 1, 84, N'<p><strong style="color: rgb(51, 51, 51); background-color: rgb(250, 250, 250);">Quần Tây Sidetab 2 Bên Form Regular QT068*Thông tin sản phẩm:- Mã sản phẩm: QT068- Chất liệu: (30% Cotton, 65% T, 5% Spandex)- Họa tiết:&nbsp;- Form: Regular&nbsp;&nbsp;- Màu: Trắng Kem / Xám / Đen</strong>** Sản phẩm hiện có tại Website, Facebook và hệ thống cửa hàng 4MEN toàn quốc.</p>')
INSERT [dbo].[SanPhams] ([MaSanPham], [MaChuyenMuc], [TenSanPham], [AnhDaiDien], [Gia], [TrangThai], [LuotXem], [MoTa]) VALUES (185, 1, N'Áo Sơ Mi Sọc Thêu Huy Hiệu M Form Tailored SM180 Màu Xanh', N'ao-so-mi-soc-theu-huy-hieu-m-form-tailored-sm180-soc-trang-19229-slide-products-682aa7b54d1e1.jpg,ao-so-mi-soc-theu-huy-hieu-m-form-tailored-sm180-soc-trang-19229-slide-products-682aa7b58d681.jpg,ao-so-mi-soc-theu-huy-hieu-m-form-tailored-sm180-soc-trang-19229-slide-products-682aa7b685ef8.jpg', CAST(200000 AS Decimal(18, 0)), 1, 12, N'<p><strong style="background-color: rgb(250, 250, 250); color: rgb(51, 51, 51);">Áo Sơ Mi Oxford Thêu Hình Mỏ Neo 4M Form Regular SM185</strong><span style="background-color: rgb(250, 250, 250); color: rgb(51, 51, 51);">*Thông tin sản phẩm:- Mã sản phẩm: SM185- Chất liệu: Oxford&nbsp;(100% Cotton)&nbsp;&nbsp;- Họa tiết: Thêu- Form: Regular- Màu: Sọc Xanh / Sọc xanh biển&nbsp;** Sản phẩm hiện có tại Website, Facebook và hệ thống cửa hàng 4MEN toàn quốc.</span></p>')
INSERT [dbo].[SanPhams] ([MaSanPham], [MaChuyenMuc], [TenSanPham], [AnhDaiDien], [Gia], [TrangThai], [LuotXem], [MoTa]) VALUES (190, 35, N'Quần Jeans Trơn Xanh Nhạt Form Slimfit QJ113 Màu Xanh', N'quan-jean-tron-form-slimfit-qj112-19259-slide-products-68344320f1701.jpg,quan-jean-tron-form-slimfit-qj112-19259-slide-products-68344322515f6.jpg', CAST(200000 AS Decimal(18, 0)), 1, 20, N'<p><strong style="color: rgb(51, 51, 51); background-color: rgb(250, 250, 250);">Quần Jeans Trơn Xanh Nhạt Form Slimfit QJ113</strong><em style="color: rgb(51, 51, 51); background-color: rgb(250, 250, 250);">- Phong cách tối giản – dễ phối, dễ mặc:&nbsp;</em><span style="color: rgb(51, 51, 51); background-color: rgb(250, 250, 250);">Một thiết kế jeans trơn không họa tiết, không rách, không wash đậm – tập trung vào form dáng và sắc độ hiện đại.</span><em style="color: rgb(51, 51, 51); background-color: rgb(250, 250, 250);">- Form Slimfit ôm vừa, tôn dáng:</em><strong style="color: rgb(51, 51, 51); background-color: rgb(250, 250, 250);">&nbsp;</strong><span style="color: rgb(51, 51, 51); background-color: rgb(250, 250, 250);">Phom quần ôm gọn thân dưới nhưng vẫn đảm bảo sự thoải mái khi di chuyển. Giúp tổng thể vóc dáng cân đối, gọn gàng.</span><em style="color: rgb(51, 51, 51); background-color: rgb(250, 250, 250);">- Chất liệu co giãn nhẹ, mặc cả ngày vẫn dễ chịu:</em>97% cotton, 3% spandexBề mặt vải mềm, thoáng khíĐứng form tốt, giữ phom đẹp sau nhiều lần giặt<em style="color: rgb(51, 51, 51); background-color: rgb(250, 250, 250);">- Gam màu xanh biển nhạt – trẻ trung &amp; linh hoạt:&nbsp;</em><span style="color: rgb(51, 51, 51); background-color: rgb(250, 250, 250);">Dễ phối với áo thun, sơ mi hoặc áo polo. Từ dạo phố, đi làm đến gặp gỡ bạn bè đều phù hợp.</span><strong style="color: rgb(51, 51, 51); background-color: rgb(250, 250, 250);"><em>** Thông tin sản phẩm:</em></strong>Mã sản phẩm: QJ113Chất liệu: Jeans&nbsp;Họa tiết: Trơn&nbsp;Form: SlimfitMàu: Xanh biển<span style="color: rgb(51, 51, 51); background-color: rgb(250, 250, 250);">** Sản phẩm hiện có tại Website, Facebook và hệ thống cửa hàng 4MEN toàn quốc.</span></p>')
INSERT [dbo].[SanPhams] ([MaSanPham], [MaChuyenMuc], [TenSanPham], [AnhDaiDien], [Gia], [TrangThai], [LuotXem], [MoTa]) VALUES (193, 3, N'Áo Polo Rayon In Logo Bánh Lái Form Regular PO165 Màu Xanh', N'ao-polo-rayon-in-logo-banh-lai-form-regular-po165-mau-xanh-da-19194-slide-products-6808beead6bf1.jpg', CAST(400000 AS Decimal(18, 0)), 1, 29, N'dvfdvfd')
INSERT [dbo].[SanPhams] ([MaSanPham], [MaChuyenMuc], [TenSanPham], [AnhDaiDien], [Gia], [TrangThai], [LuotXem], [MoTa]) VALUES (194, 3, N'Áo Thun In Logo Bãi Biển Form Slimfit AT170 Màu Trắng', N'ao-thun-in-logo-bai-bien-form-slimfit-at170-mau-trang-19232-slide-products-682e90530b741.jpg', CAST(300000 AS Decimal(18, 0)), 1, 27, N'vfdfdv')
INSERT [dbo].[SanPhams] ([MaSanPham], [MaChuyenMuc], [TenSanPham], [AnhDaiDien], [Gia], [TrangThai], [LuotXem], [MoTa]) VALUES (210, 1, N'Áo Sơ Mi Linen Xám Thêu Hình Mỏ Neo 4M Form Regular SM186 Màu Xám', N'ao-so-mi-linen-trang-theu-hinh-mo-neo-4m-form-regular-sm184-mau-trang-19200-slide-products-6808c6d3c3bca.jpg,ao-so-mi-linen-trang-theu-hinh-mo-neo-4m-form-regular-sm184-mau-trang-19200-slide-products-6808c6d37a259.jpg,ao-so-mi-linen-xam-theu-hinh-mo-neo-4m-form-regular-sm186-mau-xam-19200-slide-products-682ec59279f32.jpg', CAST(400000 AS Decimal(18, 0)), 1, 16, N'<p>Áo sơ mi nam SM186 thuộc bộ sưu tập hè 2025 – PELAGOS, mang phong cách Nautical Preppy phóng khoáng với thiết kế cổ Cuban thanh lịch, tay ngắn xẻ lai tạo sự thoải mái, cùng với phần xẻ lai áo 5cm giúp áo ôm dáng nhưng vẫn thoải mái trong từng chuyển động. Logo mỏ neo 4MEN thêu cùng màu vải chính tạo điểm nhấn tinh tế, đồng điệu.</p><p>Chất liệu Linen với 20% Linen, 77% Cotton, 3% Spandex, mang đến sự thoáng mát, nhẹ nhàng và khả năng thấm hút vượt trội, rất phù hợp cho những ngày hè oi ả. Dáng regular fit dễ mặc, phù hợp với nhiều phong cách.</p><p>SM186 là lựa chọn lý tưởng cho những dịp dạo biển, thư giãn cuối tuần hay các hoạt động ngoài trời, mang lại vẻ ngoài thư thái, năng động nhưng vẫn giữ được vẻ lịch lãm, phóng khoáng đúng chất mùa hè.</p><p><strong style="background-color: rgb(250, 250, 250); color: rgb(51, 51, 51);">Áo Sơ Mi Linen Xám Thêu Hình Mỏ Neo 4M Form Regular SM186</strong><span style="background-color: rgb(250, 250, 250); color: rgb(51, 51, 51);">*Thông tin sản phẩm:- Mã sản phẩm: SM186- Chất liệu: Linen&nbsp;(20% Linen, 77% Cotton, 3% Spandex)&nbsp;&nbsp;- Họa tiết: Thêu- Form: Regular- Màu: Xám** Sản phẩm hiện có tại Website, Facebook và hệ thống cửa hàng 4MEN toàn quốc.</span></p>')
INSERT [dbo].[SanPhams] ([MaSanPham], [MaChuyenMuc], [TenSanPham], [AnhDaiDien], [Gia], [TrangThai], [LuotXem], [MoTa]) VALUES (212, 1, N'Áo Sơ Mi Oxford Sọc Xanh Thêu Bánh Lái Form Tailored SM183 Sọc Xanh Biển', N'ao-so-mi-dieu-ly-han-che-nhan-wrinkle-x-theu-peakhour-form-slimfit-sm182-19195-slide-products-6808c06059787.jpg,ao-so-mi-oxford-soc-xanh-theu-banh-lai-form-tailored-sm183-soc-xanh-bien-19195-slide-products-682ec3ba88e1e.jpg,ao-so-mi-oxford-soc-xanh-theu-banh-lai-form-tailored-sm183-soc-xanh-bien-19195-slide-products-682ec3b8dc935.jpg', CAST(400000 AS Decimal(18, 0)), 1, 24, N'<p>Áo sơ mi nam SM183 thuộc bộ sưu tập hè 2025 – PELAGOS, mang phong cách Nautical Preppy thanh lịch, nổi bật với thiết kế tay dài chỉn chu, sử dụng họa tiết sọc xanh classic và điểm nhấn logo bánh lái thêu nổi tinh tế – đồng bộ màu sắc với từng đường sọc vải, tạo cảm giác hài hòa và sang trọng.</p><p>Chất liệu Oxford 100% Cotton cao cấp, dày dặn vừa phải, thấm hút tốt và bền màu theo thời gian. Dáng tailored-fit ôm nhẹ, tôn dáng mà vẫn thoải mái vận động.</p><p>SM183 là lựa chọn lý tưởng cho những dịp làm việc, gặp gỡ hay du lịch biển, mang lại vẻ ngoài lịch lãm, tinh gọn nhưng vẫn phóng khoáng.&nbsp;</p><p><strong style="background-color: rgb(250, 250, 250); color: rgb(51, 51, 51);">Áo Sơ Mi Oxford Sọc Xanh Thêu Bánh Lái Form Tailored SM183</strong><span style="background-color: rgb(250, 250, 250); color: rgb(51, 51, 51);">*Thông tin sản phẩm:- Mã sản phẩm: SM183- Chất liệu: Oxford&nbsp;(100% Cotton)&nbsp;&nbsp;- Họa tiết: Thêu- Form: Tailored- Màu: Sọc Xanh Biển** Sản phẩm hiện có tại Website, Facebook và hệ thống cửa hàng 4MEN toàn quốc.</span></p>')
INSERT [dbo].[SanPhams] ([MaSanPham], [MaChuyenMuc], [TenSanPham], [AnhDaiDien], [Gia], [TrangThai], [LuotXem], [MoTa]) VALUES (218, 1, N'Áo Sơ Mi Sọc Form Slimfit SM172 Sọc Trắng', N'ao-so-mi-soc-form-slimfit-sm172-19036-slide-products-676e15d952d3a.jpg,ao-so-mi-soc-form-slimfit-sm172-19036-slide-products-676e15e27116e.jpg', CAST(300000 AS Decimal(18, 0)), 1, 2, N'<p><span style="background-color: rgb(250, 250, 250); color: rgb(8, 27, 58);">Áo sơ mi kẻ sọc form slimfit mang đến vẻ thanh lịch và chỉnh chu với họa tiết kẻ sọc thời thượng và thiết kế ôm vừa vặn, tôn dáng. Chất liệu Poly cao cấp mềm mại, thoáng khí, ít nhăn, giúp áo giữ phom dáng hoàn hảo suốt cả ngày. Sự kết hợp giữa kẻ sọc và các gam màu cổ điển (Sọc Trắng, Sọc Đen, Sọc Xanh) tạo nên phong cách hiện đại, phù hợp cả công sở lịch lãm lẫn dạo phố trẻ trung. Áo đa năng, linh hoạt, lý tưởng cho nhiều dịp và dễ dàng phối đồ trong mọi thời tiết.</span><strong style="background-color: rgb(250, 250, 250); color: rgb(51, 51, 51);">Áo Sơ Mi Sọc Form Slimfit SM172</strong><span style="background-color: rgb(250, 250, 250); color: rgb(0, 0, 0);">- Thông tin sản phẩm:- Mã sản phẩm: SM172- Chất liệu: (100% Poly)- Họa tiết: Kẻ Sọc- Form: Slimfit- Màu: Sọc Đen/ Sọc Trắng/ Sọc Xanh</span></p>')
INSERT [dbo].[SanPhams] ([MaSanPham], [MaChuyenMuc], [TenSanPham], [AnhDaiDien], [Gia], [TrangThai], [LuotXem], [MoTa]) VALUES (219, 1, N'Áo Overshirt Vải Caro Flannel Thêu Heritage Form Loose SM167', N'ao-overshirt-vai-caro-flannel-theu-heritage-form-loose-sm166-18829-slide-products-67161cd9949d2.jpg,ao-overshirt-vai-caro-flannel-theu-heritage-form-loose-sm167-18829-slide-products-6759d4990158c.jpg,ao-overshirt-vai-caro-flannel-theu-heritage-form-loose-sm166-18829-slide-products-67161cda73b1d.jpg', CAST(150000 AS Decimal(18, 0)), 1, 20, N'<p><strong>Áo Overshirt Vải Caro Flannel Thêu Heritage Form Loose SM167:</strong><span style="background-color: rgb(250, 250, 250); color: rgb(51, 51, 51);">Thông tin sản phẩm:- Mã sản phẩm: SM167- Chất liệu: Flannel- Họa tiết: Thêu- Form: Loose&nbsp;- Màu: Caro Nâu** Sản phẩm hiện có tại Website, Facebook và hệ thống cửa hàng 4MEN toàn quốc.</span></p>')
INSERT [dbo].[SanPhams] ([MaSanPham], [MaChuyenMuc], [TenSanPham], [AnhDaiDien], [Gia], [TrangThai], [LuotXem], [MoTa]) VALUES (221, 1, N'Áo Overshirt Vải Caro Flannel Thêu Heritage Form Loose SM166 Caro Xanh Lá', N'ao-overshirt-vai-caro-flannel-theu-heritage-form-loose-sm166-18809-slide-products-670f31ce002bc.jpg,ao-overshirt-vai-caro-flannel-theu-heritage-form-loose-sm166-caro-xanh-la-18809-slide-products-6759d15cb48f0.jpg,ao-overshirt-vai-caro-flannel-theu-heritage-form-loose-sm166-caro-xanh-la-18809-slide-products-6759d15c5c214.jpg', CAST(300000 AS Decimal(18, 0)), 1, 10, N'<p><strong>Áo Overshirt Vải Caro Flannel Thêu Heritage Form Loose SM166:</strong></p><p><span style="color: rgb(51, 51, 51); background-color: rgb(250, 250, 250);">Thông tin sản phẩm:</span></p><p><span style="color: rgb(51, 51, 51); background-color: rgb(250, 250, 250);">- Mã sản phẩm: SM166</span></p><p><span style="color: rgb(51, 51, 51); background-color: rgb(250, 250, 250);">- Chất liệu: Flannel</span></p><p><span style="color: rgb(51, 51, 51); background-color: rgb(250, 250, 250);">- Họa tiết: Thêu</span></p><p><span style="color: rgb(51, 51, 51); background-color: rgb(250, 250, 250);">- Form: Loose&nbsp;</span></p><p><span style="color: rgb(51, 51, 51); background-color: rgb(250, 250, 250);">- Màu: Caro Xanh Đen / Caro Xanh Lá</span></p><p><span style="color: rgb(51, 51, 51); background-color: rgb(250, 250, 250);">** Sản phẩm hiện có tại Website, Facebook và hệ thống cửa hàng 4MEN toàn quốc.</span></p>')
INSERT [dbo].[SanPhams] ([MaSanPham], [MaChuyenMuc], [TenSanPham], [AnhDaiDien], [Gia], [TrangThai], [LuotXem], [MoTa]) VALUES (222, 1, N'Áo Sơ Mi Linen Sọc Tay Ngắn Form Loose SM148 Sọc Kem', N'ao-so-mi-linen-soc-tay-ngan-form-loose-sm148-18519-slide-products-664f1765b27a4.jpg,ao-so-mi-linen-soc-tay-ngan-form-loose-sm148-soc-kem-18519-slide-products-66755cc4f3ba5.png', CAST(199000 AS Decimal(18, 0)), 1, 2, N'<p><strong style="background-color: rgb(250, 250, 250); color: rgb(51, 51, 51);">Áo Sơ Mi Linen Sọc Tay Ngắn Form Loose SM148</strong></p><p><strong style="background-color: rgb(250, 250, 250); color: rgb(51, 51, 51);">Áo Sơ Mi Linen Sọc Tay Ngắn Form Loose SM148</strong><span style="background-color: rgb(250, 250, 250); color: rgb(0, 0, 0);">Thông tin sản phẩm:- Mã sản phẩm: SM148- Chất liệu: Linen (100% cotton)- Họa tiết: Trơn- Form: Loose- Màu: Sọc Kem / Sọc Xanh** Sản phẩm hiện có tại Website, Facebook và hệ thống cửa hàng 4MEN toàn quốc.</span></p>')
INSERT [dbo].[SanPhams] ([MaSanPham], [MaChuyenMuc], [TenSanPham], [AnhDaiDien], [Gia], [TrangThai], [LuotXem], [MoTa]) VALUES (223, 1, N'Áo Sơ Mi Loose Escape SM095 Màu Đen', N'-17005-slide-products-62d7cc83d8aca.jpg,-17005-slide-products-62d7cc84182de.jpg,-17005-slide-products-62d7cc844eb60.jpg,-17005-slide-products-62d7cc8487fab.jpg', CAST(250000 AS Decimal(18, 0)), 1, 14, N'<p>null</p>')
INSERT [dbo].[SanPhams] ([MaSanPham], [MaChuyenMuc], [TenSanPham], [AnhDaiDien], [Gia], [TrangThai], [LuotXem], [MoTa]) VALUES (224, 31, N'Quần Tây Sidetab 2 Bên Form Regular QT068 Màu Trắng Kem', N'quan-tay-sidetab-2-ben-form-regular-qt068-19210-slide-products-6808d0c1b9cf2.jpg,quan-tay-sidetab-2-ben-form-regular-qt068-mau-trang-kem-19210-slide-products-682ec88be7832.jpg,quan-tay-sidetab-2-ben-form-regular-qt068-mau-trang-kem-19210-slide-products-682ec88b6618b.jpg', CAST(370000 AS Decimal(18, 0)), 1, 6, N'<p><span style="background-color: rgb(250, 250, 250); color: rgb(51, 51, 51);">Quần tây nam QT068 thuộc bộ sưu tập hè 2025 – PELAGOS, mang phong cách Nautical Preppy tinh tế và thanh lịch. Thiết kế sidetab hiện đại với phần lưng thun ẩn gài nút tăng giảm 2 bên, mang đến sự vừa vặn tối ưu và thoải mái cho người mặc. Điểm nhấn ở phần lai lơ vê 3cm, tạo sự phá cách nhẹ nhàng nhưng không kém phần sang trọng.</span></p><p><span style="background-color: rgb(250, 250, 250); color: rgb(51, 51, 51);">Chất liệu 30% Cotton, 65% Polyester, 5% Spandex mang đến sự mềm mại, thoáng mát và co giãn nhẹ, tạo cảm giác dễ chịu suốt cả ngày. Dáng regular fit phù hợp cho các dịp dạo phố, đi làm hay tham gia các sự kiện ngoài trời, giữ được vẻ ngoài lịch lãm nhưng vẫn thoải mái và năng động.</span></p><p><span style="background-color: rgb(250, 250, 250); color: rgb(51, 51, 51);">QT068 là sự lựa chọn hoàn hảo cho những quý ông yêu thích phong cách preppy nhưng vẫn đòi hỏi sự chỉn chu và tinh tế trong từng chi tiết.</span></p><p><strong style="background-color: rgb(250, 250, 250); color: rgb(51, 51, 51);">Quần Tây Sidetab 2 Bên Form Regular QT068</strong><span style="background-color: rgb(250, 250, 250); color: rgb(51, 51, 51);">*Thông tin sản phẩm:- Mã sản phẩm: QT068- Chất liệu: (30% Cotton, 65% T, 5% Spandex)- Họa tiết:&nbsp;- Form: Regular&nbsp;&nbsp;- Màu: Trắng Kem / Xám / Đen</span>** Sản phẩm hiện có tại Website, Facebook và hệ thống cửa hàng 4MEN toàn quốc.</p>')
INSERT [dbo].[SanPhams] ([MaSanPham], [MaChuyenMuc], [TenSanPham], [AnhDaiDien], [Gia], [TrangThai], [LuotXem], [MoTa]) VALUES (225, 31, N'Quần Tây Trơn Form Slimfit QT050 Màu Đen', N'quan-tay-sidetab-vai-rayon-form-slim-cropped-qt063-mau-be-18842-slide-products-6724ae6c40e36.jpg,quan-tay-sidetab-vai-rayon-form-slim-cropped-qt063-mau-be-18842-slide-products-6724ae770a1f0.jpg,quan-tay-sidetab-vai-rayon-form-slim-cropped-qt063-mau-be-18842-slide-products-6724ae7725013.jpg', CAST(430000 AS Decimal(18, 0)), 1, NULL, N'<p><strong style="color: rgb(51, 51, 51); background-color: rgb(250, 250, 250);">Quần Tây Sidetab Vải Rayon Form Slim-cropped QT063:</strong></p><p><span style="background-color: rgb(250, 250, 250); color: rgb(0, 0, 0);">Thông tin sản phẩm:</span></p><p><span style="background-color: rgb(250, 250, 250); color: rgb(0, 0, 0);">- Mã sản phẩm: QT063</span></p><p><span style="background-color: rgb(250, 250, 250); color: rgb(0, 0, 0);">- Chất liệu: Rayon</span></p><p><span style="background-color: rgb(250, 250, 250); color: rgb(0, 0, 0);">- Họa tiết: Trơn</span></p><p><span style="background-color: rgb(250, 250, 250); color: rgb(0, 0, 0);">- Form:&nbsp;Slim-cropped</span></p><p><span style="color: rgb(0, 0, 0); background-color: rgb(250, 250, 250);">- Màu: Be / Xám / Đen</span></p><p><span style="color: rgb(0, 0, 0); background-color: rgb(250, 250, 250);">** Sản phẩm hiện có tại Website, Facebook và hệ thống cửa hàng 4MEN toàn quốc.</span></p>')
INSERT [dbo].[SanPhams] ([MaSanPham], [MaChuyenMuc], [TenSanPham], [AnhDaiDien], [Gia], [TrangThai], [LuotXem], [MoTa]) VALUES (226, 35, N'Quần Jean Thêu Chữ M Form Slimfit QJ110 XANH BIỂN ĐẬM', N'quan-jean-theu-chu-m-form-slimfit-qj110-xanh-dam-18994-slide-products-676e7509ec650.jpg,quan-jean-theu-chu-m-form-slimfit-qj110-xanh-bien-dam-18994-slide-products-67d2a8e5e91af.jpg,quan-jean-theu-chu-m-form-slimfit-qj110-xanh-bien-dam-18994-slide-products-67d2a8e6b38d5.jpg', CAST(450000 AS Decimal(18, 0)), 1, 2, N'<p><span style="background-color: rgb(250, 250, 250); color: rgb(0, 0, 0);">Quần Jean QJ110 được làm từ chất liệu jeans co giãn, mang lại sự thoải mái và linh hoạt. Thiết kế slimfit tôn dáng, dễ dàng phối hợp với nhiều kiểu trang phục. Điểm nhấn nổi bật là họa tiết bông lúa cách điệu thêu ngang miệng túi nhỏ, cùng với diễu chỉ đôi túi đắp thân sau tạo điểm nhấn bằng logo M.</span></p><p><br></p><p><span style="background-color: rgb(250, 250, 250); color: rgb(0, 0, 0);">Với hiệu ứng wash loang và wash râu mèo, quần mang đến vẻ ngoài cá tính. Màu xanh biển và xanh biển đậm dễ dàng kết hợp với nhiều phong cách, từ thanh lịch đến năng động.</span></p><p><br></p><p><strong style="background-color: rgb(250, 250, 250); color: rgb(0, 0, 0);">Quần Jean Thêu Chữ M Form Slimfit QJ110</strong></p><p><span style="background-color: rgb(250, 250, 250); color: rgb(0, 0, 0);">- Thông tin sản phẩm:</span></p><p><span style="background-color: rgb(250, 250, 250); color: rgb(0, 0, 0);">- Mã sản phẩm: QJ110</span></p><p><span style="background-color: rgb(250, 250, 250); color: rgb(0, 0, 0);">- Chất liệu: Jeans (98% cotton, 2% spandex)</span></p><p><span style="background-color: rgb(250, 250, 250); color: rgb(0, 0, 0);">- Họa tiết: Thêu</span></p><p><span style="background-color: rgb(250, 250, 250); color: rgb(0, 0, 0);">- Form: Slimfit</span></p><p><span style="background-color: rgb(250, 250, 250); color: rgb(0, 0, 0);">- Màu: Xanh biển / Xanh biển đậm</span></p>')
INSERT [dbo].[SanPhams] ([MaSanPham], [MaChuyenMuc], [TenSanPham], [AnhDaiDien], [Gia], [TrangThai], [LuotXem], [MoTa]) VALUES (228, 35, N'Quần Jeans Thêu 4M Túi Sau Form Straight QJ104 Màu Be', N'quan-jeans-theu-4m-tui-sau-form-straight-qj104-18751-slide-products-6700fa13e5a35.jpg,quan-jeans-theu-4m-tui-sau-form-straight-qj104-mau-be-18751-slide-products-6708f2bd62026.jpg,quan-jeans-theu-4m-tui-sau-form-straight-qj104-mau-be-18751-slide-products-6708f2bda5383.jpg', CAST(350000 AS Decimal(18, 0)), 1, 2, N'<p><strong style="color: rgb(51, 51, 51); background-color: rgb(250, 250, 250);">Quần Jeans Thêu 4M Túi Sau Form Straight QJ104:</strong></p><p><span style="color: rgb(0, 0, 0); background-color: rgb(250, 250, 250);">Thông tin sản phẩm:</span></p><p><span style="color: rgb(0, 0, 0); background-color: rgb(250, 250, 250);">- Mã sản phẩm: QJ104</span></p><p><span style="color: rgb(0, 0, 0); background-color: rgb(250, 250, 250);">- Chất liệu: Jean</span></p><p><span style="color: rgb(0, 0, 0); background-color: rgb(250, 250, 250);">- Họa tiết: Thêu</span></p><p><span style="color: rgb(0, 0, 0); background-color: rgb(250, 250, 250);">- Form: Straight</span></p><p><span style="color: rgb(0, 0, 0); background-color: rgb(250, 250, 250);">- Màu: Đen / Be</span></p><p><span style="color: rgb(0, 0, 0); background-color: rgb(250, 250, 250);">** Sản phẩm hiện có tại Website, Facebook và hệ thống cửa hàng 4MEN toàn quốc.</span></p>')
INSERT [dbo].[SanPhams] ([MaSanPham], [MaChuyenMuc], [TenSanPham], [AnhDaiDien], [Gia], [TrangThai], [LuotXem], [MoTa]) VALUES (229, 35, N'Quần Jeans Thêu Mỏ Neo Form Straight QJ099 Màu Xanh Biển Đậm', N'quan-jeans-theu-mo-neo-form-straight-qj099-18542-slide-products-6650904f6b4f6.jpg,quan-jeans-theu-mo-neo-form-straight-qj099-18542-slide-products-6650904f9b4bf.jpg,quan-jeans-theu-mo-neo-form-straight-qj099-18542-slide-products-6650904fc3bce.jpg,quan-jeans-theu-mo-neo-form-straight-qj099-18542-slide-products-665090502f6c2.jpg,quan-jeans-theu-mo-neo-form-straight-qj099-18542-slide-products-6650904fe7b22.jpg', CAST(400000 AS Decimal(18, 0)), 1, 8, N'<p><strong style="background-color: rgb(250, 250, 250); color: rgb(51, 51, 51);">Quần Jeans Thêu Mỏ Neo Form Straight QJ099</strong><span style="background-color: rgb(250, 250, 250); color: rgb(0, 0, 0);">Thông tin sản phẩm:- Mã sản phẩm: QJ099- Chất liệu: Jean (100% cotton)- Họa tiết: Thêu- Form: Straight- Màu: Xanh Biển Đậm / Xanh Biển** Sản phẩm hiện có tại Website, Facebook và hệ thống cửa hàng 4MEN toàn quốc.</span></p>')
INSERT [dbo].[SanPhams] ([MaSanPham], [MaChuyenMuc], [TenSanPham], [AnhDaiDien], [Gia], [TrangThai], [LuotXem], [MoTa]) VALUES (230, 39, N'Thắt lưng khóa tự động TL184', N'-19086-slide-products-6788b3efb1317.jpg,-19086-slide-products-6788b3efa6251.jpg,-19086-slide-products-6788b3efc39e1.jpg', CAST(300000 AS Decimal(18, 0)), 1, 2, N'<p><strong style="background-color: rgb(250, 250, 250); color: rgb(51, 51, 51);">Thắt lưng khóa tự động TL184</strong><span style="background-color: rgb(250, 250, 250); color: rgb(0, 0, 0);">Thông tin sản phẩm:- Mã sản phẩm:&nbsp;</span><span style="background-color: rgb(250, 250, 250); color: rgb(51, 51, 51);">TL184</span><span style="background-color: rgb(250, 250, 250); color: rgb(0, 0, 0);">- Chất liệu:&nbsp;- Họa tiết: Trơn- Form: Regular- Màu: Đen** Sản phẩm hiện có tại Website (4men.com.vn &amp; 4menshop.com) và Facebook 4MEN.</span></p>')
SET IDENTITY_INSERT [dbo].[SanPhams] OFF
GO
SET IDENTITY_INSERT [dbo].[Size] ON 

INSERT [dbo].[Size] ([MaSize], [TenSize], [Ghichu]) VALUES (1, N'S', NULL)
INSERT [dbo].[Size] ([MaSize], [TenSize], [Ghichu]) VALUES (2, N'M', NULL)
INSERT [dbo].[Size] ([MaSize], [TenSize], [Ghichu]) VALUES (3, N'L', N'')
INSERT [dbo].[Size] ([MaSize], [TenSize], [Ghichu]) VALUES (4, N'XL', NULL)
INSERT [dbo].[Size] ([MaSize], [TenSize], [Ghichu]) VALUES (5, N'2XL', NULL)
INSERT [dbo].[Size] ([MaSize], [TenSize], [Ghichu]) VALUES (7, N'28', NULL)
INSERT [dbo].[Size] ([MaSize], [TenSize], [Ghichu]) VALUES (10, N'29', N'')
INSERT [dbo].[Size] ([MaSize], [TenSize], [Ghichu]) VALUES (11, N'30', NULL)
INSERT [dbo].[Size] ([MaSize], [TenSize], [Ghichu]) VALUES (12, N'31', NULL)
INSERT [dbo].[Size] ([MaSize], [TenSize], [Ghichu]) VALUES (13, N'32', NULL)
INSERT [dbo].[Size] ([MaSize], [TenSize], [Ghichu]) VALUES (14, N'Free', NULL)
SET IDENTITY_INSERT [dbo].[Size] OFF
GO
SET IDENTITY_INSERT [dbo].[TaiKhoan] ON 

INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [LoaiTaiKhoan], [TenTaiKhoan], [MatKhau], [Email]) VALUES (1, 1, N'Admin1', N'12345', N'vuv28104@gmail.com')
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [LoaiTaiKhoan], [TenTaiKhoan], [MatKhau], [Email]) VALUES (2, 2, N'Vinh1', N'12345', N'vuv28104@gmail.com')
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [LoaiTaiKhoan], [TenTaiKhoan], [MatKhau], [Email]) VALUES (3, 1, N'TestUser', N'MyPassword', N'test@example.com')
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [LoaiTaiKhoan], [TenTaiKhoan], [MatKhau], [Email]) VALUES (10, 2, N'Admin2', N'12345', N'1')
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [LoaiTaiKhoan], [TenTaiKhoan], [MatKhau], [Email]) VALUES (12, 2, N'string', N'string', N'string')
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [LoaiTaiKhoan], [TenTaiKhoan], [MatKhau], [Email]) VALUES (15, 2, N'User1', N'12345', N'a')
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [LoaiTaiKhoan], [TenTaiKhoan], [MatKhau], [Email]) VALUES (16, 2, N'User2', N'12345', N'string')
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [LoaiTaiKhoan], [TenTaiKhoan], [MatKhau], [Email]) VALUES (17, 2, N'User3', N'12345', N'trống')
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [LoaiTaiKhoan], [TenTaiKhoan], [MatKhau], [Email]) VALUES (18, 2, N'User4', N'12345', N'cdcdc')
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [LoaiTaiKhoan], [TenTaiKhoan], [MatKhau], [Email]) VALUES (19, 2, N'nams2minhanh', N'12345', N'vuv47109@gmail.com')
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [LoaiTaiKhoan], [TenTaiKhoan], [MatKhau], [Email]) VALUES (20, 2, N'vudinhvinh', N'12345', N'vuv28104@gmail.com')
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [LoaiTaiKhoan], [TenTaiKhoan], [MatKhau], [Email]) VALUES (21, 2, N'v', N'12345', N'2')
INSERT [dbo].[TaiKhoan] ([MaTaiKhoan], [LoaiTaiKhoan], [TenTaiKhoan], [MatKhau], [Email]) VALUES (22, 2, N'vudinhvinh2003', N'12345', N'vuv28104@gmail.com')
SET IDENTITY_INSERT [dbo].[TaiKhoan] OFF
GO
SET IDENTITY_INSERT [dbo].[ThanhToanVNPay] ON 

INSERT [dbo].[ThanhToanVNPay] ([MaGiaoDich], [SoTien], [MaNganHang], [MaGiaoDichNganHang], [LoaiThe], [ThongTinDonHang], [NgayThanhToan], [MaPhanHoi], [MaWebsite], [MaGiaoDichVNPay], [TrangThaiGiaoDich], [MaThamChieu], [NgayTao], [MaHoaDon]) VALUES (8, 450000, N'NCB', N'VNP15009319', N'ATM', N'Vũ Vinh Thanh toan don hang 450000', N'20250609200100', N'00', N'WF78NK6E', N'15009319', N'00', N'638850959816806233', CAST(N'2025-06-09T20:00:28.143' AS DateTime), 270)
INSERT [dbo].[ThanhToanVNPay] ([MaGiaoDich], [SoTien], [MaNganHang], [MaGiaoDichNganHang], [LoaiThe], [ThongTinDonHang], [NgayThanhToan], [MaPhanHoi], [MaWebsite], [MaGiaoDichVNPay], [TrangThaiGiaoDich], [MaThamChieu], [NgayTao], [MaHoaDon]) VALUES (9, 340000, N'NCB', N'VNP15009583', N'ATM', N'Vũ Hải Đăng Thanh toan don hang 340000', N'20250609224139', N'00', N'WF78NK6E', N'15009583', N'00', N'638851055743352129', CAST(N'2025-06-09T22:41:35.643' AS DateTime), 278)
SET IDENTITY_INSERT [dbo].[ThanhToanVNPay] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UC_TenTaiKhoan]    Script Date: 25/06/2025 5:04:44 PM ******/
ALTER TABLE [dbo].[TaiKhoan] ADD  CONSTRAINT [UC_TenTaiKhoan] UNIQUE NONCLUSTERED 
(
	[TenTaiKhoan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
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
/****** Object:  StoredProcedure [dbo].[Admin_Selling_Products]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Chuyenmuc_search]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[create_chuyen_muc]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[create_CTTK]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[create_gio_hang]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[create_khach_hang]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[create_login]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[create_NhaPhanPhoi]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[create_San_Pham]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[create_TaiKhoanVaChiTietTaiKhoan]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CTHD_GetByID]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Delete_chuyen_muc]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[delete_giohang]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[delete_khachhang]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[delete_NPP]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Get_all_GioHang]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Get_all_Size]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Get_List_CTHD]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Get_List_CTHDN]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Get_NhaPhanPhoi]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[getInforTaiKhoan]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[HoaDon_Delete]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[HoaDon_getbyid]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[HoaDon_Search]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[HoaDonNhap_Delete]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[HoaDonNhap_Search]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[KH_get_by_id]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[NhaPhanPhoi_search]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SanPham_Delete]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Sanpham_getbyID]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SanPham_search]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[SanPham_Update]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Search_MaKH]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Search_sp_TheoSize]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Size_get_by_id]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Size_search]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_create_KhachHang_va_HoaDon]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_get_all_hoadons_with_details]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_hoa_don_update]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_hoadon_create]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_hoadonnhap_create]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_hoadonnhap_update]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_khach_search]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_login]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_thong_ke_khachhang]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[ThongKeDoanhThu]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[thongkeTopCustomer]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Update_chuyen_muc]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[update_khach_hang]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[update_NhaPhanPhoi]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[User_Ao_Nam_Search]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[User_Chuyenmuc_search]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[user_HistoryCart]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[User_Hot_Product]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[User_New_Products]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[USer_SanPham_search]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[User_Selling_Products]    Script Date: 25/06/2025 5:04:44 PM ******/
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
/****** Object:  StoredProcedure [dbo].[User_SP_Search_ChuyenMuc]    Script Date: 25/06/2025 5:04:44 PM ******/
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
