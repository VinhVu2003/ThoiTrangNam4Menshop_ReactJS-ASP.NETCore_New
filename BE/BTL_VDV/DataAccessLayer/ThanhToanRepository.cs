using DataModel;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer
{
    public class ThanhToanRepository
    {
        private IDatabaseHelper _db;

        public ThanhToanRepository(IDatabaseHelper db)
        {
            _db = db;
        }
        public int Insert(ThanhToanVNPAYModel model)
        {
            string query = @"
                INSERT INTO ThanhToanVNPay (
                    SoTien, MaNganHang, MaGiaoDichNganHang, LoaiThe, ThongTinDonHang,
                    NgayThanhToan, MaPhanHoi, MaWebsite, MaGiaoDichVNPay,
                    TrangThaiGiaoDich, MaThamChieu, MaHoaDon
                )
                VALUES (
                    @SoTien, @MaNganHang, @MaGiaoDichNganHang, @LoaiThe, @ThongTinDonHang,
                    @NgayThanhToan, @MaPhanHoi, @MaWebsite, @MaGiaoDichVNPay,
                    @TrangThaiGiaoDich, @MaThamChieu, @MaHoaDon
                );
                SELECT CAST(SCOPE_IDENTITY() AS INT);";

            string msgError = "";
            var result = _db.ExecuteScalar(query, out msgError,
                new SqlParameter("@SoTien", model.SoTien),
                new SqlParameter("@MaNganHang", (object?)model.MaNganHang ?? DBNull.Value),
                new SqlParameter("@MaGiaoDichNganHang", (object?)model.MaGiaoDichNganHang ?? DBNull.Value),
                new SqlParameter("@LoaiThe", (object?)model.LoaiThe ?? DBNull.Value),
                new SqlParameter("@ThongTinDonHang", (object?)model.ThongTinDonHang ?? DBNull.Value),
                new SqlParameter("@NgayThanhToan", (object?)model.NgayThanhToan ?? DBNull.Value),
                new SqlParameter("@MaPhanHoi", (object?)model.MaPhanHoi ?? DBNull.Value),
                new SqlParameter("@MaWebsite", (object?)model.MaWebsite ?? DBNull.Value),
                new SqlParameter("@MaGiaoDichVNPay", (object?)model.MaGiaoDichVNPay ?? DBNull.Value),
                new SqlParameter("@TrangThaiGiaoDich", (object?)model.TrangThaiGiaoDich ?? DBNull.Value),
                new SqlParameter("@MaThamChieu", (object?)model.MaThamChieu ?? DBNull.Value),
                new SqlParameter("@MaHoaDon", model.MaHoaDon)
            );

            if (!string.IsNullOrEmpty(msgError))
                throw new Exception(msgError);

            return Convert.ToInt32(result);
        }
        public ThanhToanVNPAYModel GetById(int MaHoaDon)
        {
            string msgError = "";
            string sql = "SELECT * FROM ThanhToanVNPay WHERE MaHoaDon = @MaHoaDon";

            var data = _db.ExecuteQuery(sql, out msgError, new SqlParameter("@MaHoaDon", MaHoaDon));

            if (!string.IsNullOrEmpty(msgError))
                throw new Exception(msgError);

            return data.ConvertTo<ThanhToanVNPAYModel>().FirstOrDefault();
        }

    }
}
