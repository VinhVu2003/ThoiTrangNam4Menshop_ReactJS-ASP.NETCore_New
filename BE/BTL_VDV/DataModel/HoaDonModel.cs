using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel
{
    public class HoaDonModel
    {

        public int MaHoaDon { get; set; }
        public string TrangThai {  get; set; }
        public DateTime? NgayTao { get; set; }
        public string? DiaChiGiaoHang { get; set; }
        public float TongGia {  get; set; }
        public int MaKH {  get; set; }
        public int TenKH { get; set; }
        public List<ChiTietHDModel> list_json_ChiTietHD { get; set; }
    }

    public class HoaDonThanhToanModel
    {
        public int MaHoaDon { get; set; }
        public string TrangThai { get; set; }
        public DateTime? NgayTao { get; set; }
        public string? DiaChiGiaoHang { get; set; }
        public float TongGia { get; set; }
        public int MaKH { get; set; }
        public string TenKH { get; set; }
        public string Email { get; set; }
        public string SDT { get; set; }
        // Thông tin thanh toán VNPay
        public int? MaGiaoDich { get; set; }
        public decimal? SoTien { get; set; }
        public string MaNganHang { get; set; }
        public string MaGiaoDichNganHang { get; set; }
        public string LoaiThe { get; set; }
        public string ThongTinDonHang { get; set; }
        public string NgayThanhToan { get; set; }
        public string MaPhanHoi { get; set; }
        public string MaWebsite { get; set; }
        public string MaGiaoDichVNPay { get; set; }
        public string TrangThaiGiaoDich { get; set; }
        public string MaThamChieu { get; set; }
        public DateTime? NgayTaoThanhToan { get; set; }
    }

}
