using DataModel;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer
{
    public class DanhGiaSanPhamRepository
    {
        private IDatabaseHelper _db;
        public DanhGiaSanPhamRepository(IDatabaseHelper db)
        {
            _db = db;
        }

        // Thêm đánh giá
        public int Insert(DanhGiaSanPhamModel model)
        {
            string query = @"
                INSERT INTO DanhGiaSanPham 
                (SanPhamId, KhachHangId, NoiDung, SoSao, ThoiGianTao, TrangThai, TenKhachHang)
                VALUES 
                (@SanPhamId, @KhachHangId, @NoiDung, @SoSao, GETDATE(), @TrangThai, @TenKhachHang);
                SELECT CAST(SCOPE_IDENTITY() AS INT);";

            string msgError = "";
            var result = _db.ExecuteScalar(query, out msgError,
                new SqlParameter("@SanPhamId", model.SanPhamId),
                new SqlParameter("@KhachHangId", (object)model.KhachHangId ?? DBNull.Value),
                new SqlParameter("@NoiDung", model.NoiDung),
                new SqlParameter("@SoSao", model.SoSao),
                new SqlParameter("@TrangThai", model.TrangThai),
                new SqlParameter("@TenKhachHang", (object)model.TenKhachHang ?? DBNull.Value)
            );

            if (!string.IsNullOrEmpty(msgError))
                throw new Exception(msgError);

            return Convert.ToInt32(result);
        }

        // Sửa đánh giá
        public bool Update(DanhGiaSanPhamModel model)
        {
            string query = @"
                UPDATE DanhGiaSanPham SET
                    NoiDung = @NoiDung,
                    SoSao = @SoSao,
                    TrangThai = @TrangThai,
                    TenKhachHang = @TenKhachHang
                WHERE Id = @Id";

            int rows = _db.ExecuteNoneQuery2(query,
                new SqlParameter("@NoiDung", model.NoiDung),
                new SqlParameter("@SoSao", model.SoSao),
                new SqlParameter("@TrangThai", model.TrangThai),
                new SqlParameter("@TenKhachHang", (object)model.TenKhachHang ?? DBNull.Value),
                new SqlParameter("@Id", model.Id)
            );

            return rows > 0;
        }

        // Xóa đánh giá
        public bool Delete(int id)
        {
            string query = "DELETE FROM DanhGiaSanPham WHERE Id = @Id";
            int rows = _db.ExecuteNoneQuery2(query, new SqlParameter("@Id", id));
            return rows > 0;
        }

        // Lấy tất cả đánh giá theo sản phẩm
        public List<DanhGiaSanPhamModel> GetAllBySanPhamId(int sanPhamId)
        {
            string sql = @"
                SELECT * FROM DanhGiaSanPham 
                WHERE SanPhamId = @SanPhamId AND TrangThai = 1
                ORDER BY ThoiGianTao DESC";

            var dt = _db.ExecuteQueryReturnDataTable(sql, new SqlParameter("@SanPhamId", sanPhamId));
            return dt.ConvertTo<DanhGiaSanPhamModel>().ToList();
        }
        public List<DanhGiaSanPhamModel> GetAll()
        {
            string query = "SELECT * FROM DanhGiaSanPham";
            var dt = _db.ExecuteQueryReturnDataTable(query);
            return dt.ConvertTo<DanhGiaSanPhamModel>().ToList();
        }

    }
}
