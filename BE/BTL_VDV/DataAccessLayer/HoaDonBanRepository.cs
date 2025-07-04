﻿using DataAccessLayer;
using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer
{
    public  class HoaDonBanRepository : IHoaDonBanRepository
    {
        private IDatabaseHelper _dbHelper;
        public HoaDonBanRepository(IDatabaseHelper DatabaseHelper)
        {
            this._dbHelper = DatabaseHelper;
        }

        public int Create(HoaDonModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_hoadon_create",
                "@TrangThai", model.TrangThai,
                "@NgayTao", DateTime.Now, // 👉 Lấy ngày hiện tại
                "@TongGia",model.TongGia,
                "@DiaChiGiaoHang", model.DiaChiGiaoHang,
                "@MaKH", model.MaKH,
                "@list_json_chitiethoadon", model.list_json_ChiTietHD != null ? MessageConvert.SerializeObject(model.list_json_ChiTietHD) : null);
                if (result != null && int.TryParse(result.ToString(), out int maHoaDon) && maHoaDon > 0)
                {
                    model.MaHoaDon = maHoaDon;
                    return maHoaDon;  // Trả về mã hóa đơn
                }
                return 0;

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool Update(HoaDonModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_hoa_don_update",
                "@MaHoaDon", model.MaHoaDon,
                "@TrangThai", model.TrangThai,
                "@NgayTao", model.NgayTao,
                "@TongGia",model.TongGia,
                "@DiaChiGiaoHang", model.DiaChiGiaoHang,
                "@MaKH", model.MaKH,
                "@list_json_chitiethoadon", model.list_json_ChiTietHD != null ? MessageConvert.SerializeObject(model.list_json_ChiTietHD) : null);
                if ((result != null && !string.IsNullOrEmpty(result.ToString())) || !string.IsNullOrEmpty(msgError))
                {
                    throw new Exception(Convert.ToString(result) + msgError);
                }
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool Delete(int ID)
        {
            string msg = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msg, "HoaDon_Delete", "@MaHoaDon", ID);
                if ((result != null && !string.IsNullOrEmpty(result.ToString()) || !string.IsNullOrEmpty(msg)))
                {
                    throw new Exception(Convert.ToString(result) + msg);
                }
                return true;
            }
            catch (Exception ex) { throw ex; }
        }

        public List<HoaDonSearch_Model> Search(int pageIndex, int pageSize, out long total, string TenKhach)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "HoaDon_Search",
                    "@page_index", pageIndex,
                    "@page_size", pageSize,
                    "@ten_khach", TenKhach
                    );
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<HoaDonSearch_Model>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public HoaDonModel GetDatabyID(int id)
        {

            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "HoaDon_getbyid", "@MaHD", id);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<HoaDonModel>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<CTHDB_GetID_Model> CTHD_Get_List_ByID(int id)
        {

            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "Get_List_CTHD", "@MaHD", id);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<CTHDB_GetID_Model>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public CTHDB_GetID_Model CTHD_GetDatabyID(int id)
        {

            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "CTHD_GetByID", "@MaID", id);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<CTHDB_GetID_Model>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<HoaDonThanhToanModel> GetAllWithThanhToan()
        {
            string msgError = "";
            string sql = @"
           SELECT 
                    hd.MaHoaDon,
                    kh.TenKH,
                    kh.Email,
                    kh.SDT,
	                hd.TrangThai,
                    hd.MaKH,
	                hd.DiaChiGiaoHang,
                    hd.NgayTao,
                    hd.TongGia,
                    tt.MaGiaoDich,
                    tt.SoTien,
                    tt.MaNganHang,
                    tt.MaGiaoDichNganHang,
                    tt.LoaiThe,
                    tt.ThongTinDonHang,
                    tt.NgayThanhToan,
                    tt.MaPhanHoi,
                    tt.MaWebsite,
                    tt.MaGiaoDichVNPay,
                    tt.TrangThaiGiaoDich,
                    tt.MaThamChieu,
                    tt.NgayTao AS NgayTaoThanhToan
                FROM HoaDons hd
                LEFT JOIN ThanhToanVNPay tt ON hd.MaHoaDon = tt.MaHoaDon
                LEFT JOIN KhachHang kh ON hd.MaKH = kh.MaKH
                ORDER BY hd.NgayTao DESC
                        ";

            var data = _dbHelper.ExecuteQuery(sql, out msgError);

            if (!string.IsNullOrEmpty(msgError))
                throw new Exception(msgError);

            return data.ConvertTo<HoaDonThanhToanModel>().ToList();
        }
    }
}
