using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel
{
    public class SanPhamChiTietModel
    {
        public int ID { get; set; }
        public int MaSP { get; set; }
        public int MaSize { get; set; }
        public int SoLuong { get; set; }
        public int TrangThai { get; set; } // TRUE = đang bán, FALSE = ẩn hoặc ngưng

        public string?TenSize { get; set; } // thêm thuộc tính này


    }
    public class AdminViewSanPhamChiTietModel
    {
        public int ID { get; set; }
        public int MaSanPham { get; set; }
        public int? MaChuyenMuc { get; set; }
        public string? TenSanPham { get; set; }
        public string? AnhDaiDien { get; set; }
        public decimal? Gia { get; set; }
        public int? SoLuong { get; set; }
        public bool? TrangThai { get; set; }
        public int? LuotXem { get; set; }
        public string? MoTa { get; set; }
        public int MaSize { get; set; }
        public int SoLuongTon { get; set; }

        public string? TenSize { get; set; } // thêm thuộc tính này


    }

    public class GiamSoLuongInput
    {
        public int MaSanPham { get; set; }
        public int MaSize { get; set; }
        public int SoLuong { get; set; }
    }
}
