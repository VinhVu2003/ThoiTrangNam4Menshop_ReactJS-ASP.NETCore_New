using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel
{
    public class ThongKeDoanhThuModel
    {
        public int SoDonHang {  get; set; }
        public Decimal DoanhThu {  get; set; }
        public int SoLuongSP {  get; set; }
    }
    public class DoanhThuTheoThangModel
    {
        public int Nam { get; set; }
        public int Thang { get; set; }
        public decimal DoanhThu { get; set; }
    }

    public class DoanhThuTheoNamModel
    {
        public int Nam { get; set; }
        public decimal DoanhThu { get; set; }
    }
    public class DonHangTheoTrangThaiModel
    {
        public string TrangThai { get; set; }
        public int SoLuongDon { get; set; }
    }

    public class SanPhamBanChayModel
    {
        public int MaSanPham { get; set; }
        public string TenSanPham { get; set; }
        public int SoLuongBanRa { get; set; }
        public decimal TongDoanhThu { get; set; }
    }

    public class DoanhThuTheoChuyenMucModel
    {
        public int MaChuyenMuc { get; set; }
        public string TenChuyenMuc { get; set; }
        public int SoLuongBanRa { get; set; }
        public decimal TongDoanhThu { get; set; }
    }

    public class LoiNhuanTheoThoiGianModel
    {
        public string GiaiDoan { get; set; }  // giờ kiểu string, đúng format "yyyy-MM-dd"
        public decimal DoanhThu { get; set; }
        public decimal GiaVon { get; set; }
        public decimal LoiNhuan { get; set; }
    }

    public class LoiNhuanTheoSanPhamModel
    {
        public string TenSanPham { get; set; }
        public string MaSanPham { get; set; }
        public decimal DoanhThu { get; set; }
        public decimal GiaVon { get; set; }
        public decimal LoiNhuan { get; set; }
    }

    public class TonKhoTheoDanhMucModel
    {
        public int MaChuyenMuc { get; set; }
        public string TenChuyenMuc { get; set; }
        public int TongSoLuongTonKho { get; set; }
    }
}
