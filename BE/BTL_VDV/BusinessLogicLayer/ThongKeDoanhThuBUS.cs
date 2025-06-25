using BusinessLogicLayer.Interfaces;
using DataAccessLayer;
using DataAccessLayer.Interfaces;
using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLogicLayer
{
    public class ThongKeDoanhThuBUS
    {
        private ThongKeDoanhThuRepository _res;
        public ThongKeDoanhThuBUS(ThongKeDoanhThuRepository res)
        {
            _res = res;
        }
        public List<DoanhThuTheoNgayModel> LayDoanhThuTheoKhoang(DateTime from, DateTime to)
        {
            return _res.ThongKeDoanhThuTheoKhoang(from, to);
        }
        public List<DoanhThuTheoThangModel> LayDoanhThuTheoThang(DateTime from, DateTime to)
        {
            return _res.ThongKeDoanhThuTheoThang(from, to);
        }

        public List<DoanhThuTheoNamModel> LayDoanhThuTheoNam(DateTime from, DateTime to)
        {
            return _res.ThongKeDoanhThuTheoNam(from, to);
        }
        public List<DonHangTheoTrangThaiModel> ThongKeDonHangTheoTrangThai()
        {
           

            return _res.ThongKeDonHangTheoTrangThai();
        }

        public List<SanPhamBanChayModel> GetSanPhamBanChay(DateTime fromDate, DateTime toDate, int top = 10)
        {
            return _res.ThongKeSanPhamBanChay(fromDate, toDate, top);
        }

        public List<DoanhThuTheoChuyenMucModel> GetDoanhThuTheoChuyenMuc(DateTime fromDate, DateTime toDate)
        {
            return _res.ThongKeDoanhThuTheoChuyenMuc(fromDate, toDate);
        }


        public List<LoiNhuanTheoThoiGianModel> ThongKeLoiNhuanTheoNgay(DateTime fromDate, DateTime toDate)
        {
            return _res.ThongKeLoiNhuanTheoNgay(fromDate, toDate);
        }

        public List<LoiNhuanTheoThoiGianModel> ThongKeLoiNhuanTheoThang(DateTime fromDate, DateTime toDate)
        {
            return _res.ThongKeLoiNhuanTheoThang(fromDate, toDate);
        }
        public List<LoiNhuanTheoSanPhamModel> ThongKeLoiNhuanTheoSanPham()
        {
            return _res.ThongKeLoiNhuanTheoSanPham();
        }

        public List<TonKhoTheoDanhMucModel> LayThongKeTonKhoTheoDanhMuc()
        {
            return _res.ThongKeTonKhoTheoDanhMuc();
        }
    }
}
