using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel
{
    public class ThanhToanVNPAYModel

    {
        public int MaGiaoDich { get; set; }                 // Mã giao 
        public long SoTien { get; set; }                    // Số tiền thanh toán
        public string? MaNganHang { get; set; }             // Mã ngân hàng
        public string? MaGiaoDichNganHang { get; set; }     // Mã giao dịch tại ngân hàng
        public string? LoaiThe { get; set; }                // Loại thẻ (ATM, VISA, ...)
        public string? ThongTinDonHang { get; set; }        // Thông tin đơn hàng
        public string? NgayThanhToan { get; set; }          // Ngày thanh toán
        public string? MaPhanHoi { get; set; }              // Mã phản hồi từ VNPay
        public string? MaWebsite { get; set; }              // Mã website (Terminal code)
        public string? MaGiaoDichVNPay { get; set; }        // Mã giao dịch do VNPay cấp
        public string? TrangThaiGiaoDich { get; set; }      // Trạng thái giao dịch
        public string? MaThamChieu { get; set; }            // Mã tham chiếu giao dịch
        public DateTime? NgayTao { get; set; }              // Ngày tạo bản ghi
        public int MaHoaDon { get; set; }                   // Mã hóa đơn (khóa ngoại)
    }
}
