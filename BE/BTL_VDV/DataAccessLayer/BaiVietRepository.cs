using DataModel;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer
{
    public class BaiVietRepository
    {
        private IDatabaseHelper _db;

        public BaiVietRepository(IDatabaseHelper db)
        {
            _db = db;
        }

        // Thêm bài viết
        public int Insert(BaiVietModel model)
        {
            string msgError = "";
            int newId = 0;

            try
            {
                var result = _db.ExecuteScalar(
                    @"INSERT INTO BaiViet (TieuDe, NoiDung, NgayTao, TaiKhoanID)
                  VALUES (@TieuDe, @NoiDung, @NgayTao, @TaiKhoanID);
                  SELECT CAST(scope_identity() AS int);",
                    out msgError,
                    new SqlParameter("@TieuDe", model.TieuDe),
                    new SqlParameter("@NoiDung", model.NoiDung),
                    new SqlParameter("@NgayTao", model.NgayTao),
                    new SqlParameter("@TaiKhoanID", model.TaiKhoanID)
                );

                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);

                if (result != null && int.TryParse(result.ToString(), out int id))
                    newId = id;

                return newId;
            }
            catch (Exception ex)
            {
                throw new Exception("Lỗi thêm mới BaiViet: " + ex.Message);
            }
        }

        // Cập nhật bài viết
        public bool Update(BaiVietModel model)
        {
            string query = @"
        UPDATE BaiViet SET
            TieuDe = @TieuDe,
            NoiDung = @NoiDung,
            NgayTao = @NgayTao,
            TaiKhoanID = @TaiKhoanID
        WHERE BaiVietID = @BaiVietID";

            try
            {
                int rowsAffected = _db.ExecuteNoneQuery2(query,
                    new SqlParameter("@TieuDe", model.TieuDe),
                    new SqlParameter("@NoiDung", model.NoiDung),
                    new SqlParameter("@NgayTao", model.NgayTao),
                    new SqlParameter("@TaiKhoanID", model.TaiKhoanID),
                    new SqlParameter("@BaiVietID", model.BaiVietID)
                );

                return rowsAffected > 0;
            }
            catch (Exception ex)
            {
                throw new Exception("Lỗi cập nhật BaiViet: " + ex.Message);
            }
        }

        // Xóa bài viết
        public bool Delete(int id)
        {
            string sql = "DELETE FROM BaiViet WHERE BaiVietID = @BaiVietID";
            try
            {
                int rowsAffected = _db.ExecuteNoneQuery2(sql,
                    new SqlParameter("@BaiVietID", id));
                return rowsAffected > 0;
            }
            catch (Exception ex)
            {
                throw new Exception("Lỗi xóa BaiViet: " + ex.Message);
            }
        }

        // Lấy tất cả bài viết
        public List<BaiVietModel> GetAll()
        {
            string sql = "SELECT * FROM BaiViet ORDER BY NgayTao DESC";
            var dt = _db.ExecuteQueryReturnDataTable(sql);
            return dt.ConvertTo<BaiVietModel>().ToList();
        }
        public BaiVietModel GetByID(int id)
        {
            string sql = "SELECT * FROM BaiViet WHERE BaiVietID = @BaiVietID";
            var dt = _db.ExecuteQueryReturnDataTable(sql,
                new SqlParameter("@BaiVietID", id));

            if (dt.Rows.Count > 0)
            {
                return dt.ConvertTo<BaiVietModel>().FirstOrDefault();
            }
            return null;
        }
    }
}
