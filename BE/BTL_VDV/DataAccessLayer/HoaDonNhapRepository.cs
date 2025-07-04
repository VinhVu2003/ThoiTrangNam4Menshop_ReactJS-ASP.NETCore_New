﻿using DataAccessLayer;
using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer
{
    public class HoaDonNhapRepository:IHoaDonNhapRepository
    {
        private IDatabaseHelper _databaseHelper;
        public HoaDonNhapRepository(IDatabaseHelper databaseHelper)
        {
            _databaseHelper= databaseHelper;
        }


        public bool Create(HoaDonNhapModel model)
        {
            string msgError = "";
            try
            {
                var result = _databaseHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_hoadonnhap_create",
                "@MaNhaPhanPhoi", model.MaNhaPhanPhoi,
                "@NgayTao", DateTime.Now, // 👉 Lấy ngày hiện tại
                "@KieuThanhToan", model.KieuThanhToan,
                "@MaTaiKhoan", model.MaTaiKhoan,
                "@TongTien",model.TongTien,
                "@list_js_ChitietHDN", model.list_js_ChitietHDN != null ? MessageConvert.SerializeObject(model.list_js_ChitietHDN) : null);
               
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool Update(HoaDonNhapModel model)
        {
            string msgError = "";
            try
            {
                var result = _databaseHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_hoadonnhap_update",
                    "@MaHoaDon",model.MaHoaDon,
                "@MaNhaPhanPhoi", model.MaNhaPhanPhoi,
                "@NgayTao", model.NgayTao, // 👉 Lấy ngày hiện tại
                "@KieuThanhToan", model.KieuThanhToan,
                "@MaTaiKhoan", model.MaTaiKhoan,
                "@TongTien", model.TongTien,
                "@list_js_ChitietHDN", model.list_js_ChitietHDN != null ? MessageConvert.SerializeObject(model.list_js_ChitietHDN) : null);

                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<HoaDonNhapModel> Search(int pageIndex, int pageSize, out long total)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _databaseHelper.ExecuteSProcedureReturnDataTable(out msgError, "HoaDonNhap_Search",
                    "@page_index", pageIndex,
                    "@page_size", pageSize
                    );
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<HoaDonNhapModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<CTHDN_GetID_Model> CTHDN_Get_List_ByID(int id)
        {

            string sql = $"SELECT * FROM ChiTietHoaDonNhaps cthdn INNER JOIN SanPhams sp ON sp.MaSanPham = cthdn.MaSanPham WHERE MaHoaDon = {id}";
            var dt = _databaseHelper.ExecuteQueryReturnDataTable(sql);
            return dt.ConvertTo<CTHDN_GetID_Model>().ToList();
        }
        public bool Delete(int ID)
        {
            string msg = "";
            try
            {
                var result = _databaseHelper.ExecuteScalarSProcedureWithTransaction(out msg, "HoaDonNhap_Delete", "@MaHD", ID);
                if ((result != null && !string.IsNullOrEmpty(result.ToString()) || !string.IsNullOrEmpty(msg)))
                {
                    throw new Exception(Convert.ToString(result) + msg);
                }
                return true;
            }
            catch (Exception ex) { throw ex; }
        }



        
    }
}
