using DataModel;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer
{
    public class KhachHangDAL
    {
        private IDatabaseHelper _db;

        public KhachHangDAL(IDatabaseHelper db)
        {
            _db = db;
        }

        // Thêm mới khách hàng, trả về MaKH vừa tạo
        public int Insert(KhachModel model)
        {
            string query = @"
                INSERT INTO KhachHang (TenKH, DiaChi, SDT, Email)
                VALUES (@TenKH, @DiaChi, @SDT, @Email);
                SELECT CAST(SCOPE_IDENTITY() AS INT);";

            string msgError = "";
            var result = _db.ExecuteScalar(query, out msgError,
                new SqlParameter("@TenKH", model.TenKH),
                new SqlParameter("@DiaChi", model.DiaChi),
                new SqlParameter("@SDT", model.SDT),
                new SqlParameter("@MaTaiKhoan", (object?)model.MaTaiKhoan ?? DBNull.Value),
                new SqlParameter("@Email", (object?)model.Email ?? DBNull.Value)
            );

            if (!string.IsNullOrEmpty(msgError))
                throw new Exception(msgError);

            return Convert.ToInt32(result);
        }
    }
}
