using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel
{
    public class GiamGiaSanPhamModel
    {
        public int Id { get; set; }
        public int GiamGiaId { get; set; }
        public int SanPhamId { get; set; }
    }

    public class SanPhamInGiamGiaModel
    {
        public int Id { get; set; }
        public int GiamGiaId { get; set; }
        public int SanPhamId { get; set; }
        public int MaSanPham { get; set; }
        public int? MaChuyenMuc { get; set; }
        public string? TenSanPham { get; set; }
        public string? AnhDaiDien { get; set; }
        public decimal? Gia { get; set; }
    }

}
