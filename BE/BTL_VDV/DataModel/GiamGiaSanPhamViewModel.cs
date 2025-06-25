using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel
{
    public class GiamGiaSanPhamViewModel
    {
        public int Id { get; set; }
        public int GiamGiaId { get; set; }
        public int SanPhamId { get; set; }
        [Required]
        [StringLength(255)]
        public string TenChuongTrinh { get; set; }

        [Required]
        [StringLength(50)]
        public string LoaiGiamGia { get; set; } // Enum dạng string: PhanTram, GiaCoDinh, MaGiamGia, MuaXTangY

        public decimal? GiaTriGiam { get; set; }

        [StringLength(100)]
        public string? MaGiamGia { get; set; }

        public int? SoLuongMua { get; set; }

        public int? SoLuongTang { get; set; }

        public int? SanPhamTangId { get; set; }

        public decimal? GiaTriDonToiThieu { get; set; }

        [Required]
        public bool ApDungToanBoSanPham { get; set; } = true;

        [StringLength(50)]
        public string? NhomKhachHang { get; set; }

        [Required]
        public DateTime NgayBatDau { get; set; }

        [Required]
        public DateTime NgayKetThuc { get; set; }

        [Required]
        public bool DangHoatDong { get; set; } = true;

        [Required]
        public DateTime NgayTao { get; set; } = DateTime.Now;

        [Required]
        public DateTime NgayCapNhat { get; set; } = DateTime.Now;
        public int? SoLuongToiDa { get; set; }  // ✅ Mới thêm: giới hạn số lượt dùng

        public int SoLuongDaDung { get; set; } = 0;  // ✅ Mới thêm: số lượt đã dùng
    }
}
