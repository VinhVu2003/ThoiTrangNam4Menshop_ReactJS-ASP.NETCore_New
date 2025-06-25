using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel
{
    public class SanPhamModel
    {
        public int MaSanPham { get; set; }
        public int? MaChuyenMuc { get; set; }
        public string? TenSanPham { get; set; }
        public string? AnhDaiDien { get; set; }
        public decimal? Gia { get; set; }
        //public int? SoLuong { get; set; }
        public bool? TrangThai { get; set; }
        public int? LuotXem { get; set; }
        public string? MoTa { get; set; }


        // Thông tin giảm giá
        public int? GiamGiaId { get; set; }
        public decimal? GiaTriGiam { get; set; }
        public DateTime? NgayBatDau { get; set; }
        public DateTime? NgayKetThuc { get; set; }
            public int? DangHoatDong { get; set; }
        public string? TrangThaiGiamGia { get; set; }

    }

    public class SanPhamMoNhatModel
    {
        public int MaSanPham { get; set; }
        public int MaChuyenMuc { get; set; }
        public string TenSanPham { get; set; }
        public string AnhDaiDien { get; set; }
        public decimal Gia { get; set; }
        public decimal GiaGiam { get; set; }
        public int SoLuong { get; set; }
        public bool TrangThai { get; set; }
        public int LuotXem { get; set; }
        public int MaSize { get; set; }
        public string TenSize { get; set; }

    }

    public class SanPhamBanChay
    {
        public int MaSanPham { get; set; }
        public int MaChuyenMuc { get; set; }
        //public string tenchuyenmuc { get; set; }
        public string TenSanPham { get; set; }
        public string AnhDaiDien { get; set; }
        public decimal Gia { get; set; }
        public decimal GiaGiam { get; set; }
        public int SoLuong { get; set; }
        public bool TrangThai { get; set; }
        public int LuotXem { get; set; }
        public int MaSize { get; set; }
        public string TenSize { get; set; }

        public int SoLuongBan { get; set; }
    }

    public class InputTenSanPham
    {
        public string TenSanPham { get; set; }
    }
    public class DanhGiaSanPhamModel
    {
        public int Id { get; set; }
        public int SanPhamId { get; set; }
        public int? KhachHangId { get; set; }
        public string NoiDung { get; set; }
        public int SoSao { get; set; }
        public DateTime ThoiGianTao { get; set; }
        public bool TrangThai { get; set; }
        public string TenKhachHang { get; set; }
    }
}
