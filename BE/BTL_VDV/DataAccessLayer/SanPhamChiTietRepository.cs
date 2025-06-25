using DataModel;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer
{
    public class SanPhamChiTietRepository
    {
        private IDatabaseHelper _db;

        public SanPhamChiTietRepository(IDatabaseHelper db)
        {
            _db = db;
        }
        // Thêm mới
        public int Insert(SanPhamChiTietModel model)
        {
            string query = @"
            INSERT INTO SanPhamChiTiet (MaSP, MaSize, SoLuong, TrangThai)
            VALUES (@MaSP, @MaSize, @SoLuong, @TrangThai);
            SELECT CAST(SCOPE_IDENTITY() AS INT);";
            string msgError = "";

            var result = _db.ExecuteScalar(query, out msgError,
                new SqlParameter("@MaSP", model.MaSP),
                new SqlParameter("@MaSize", model.MaSize),
                new SqlParameter("@SoLuong", model.SoLuong),
                new SqlParameter("@TrangThai", model.TrangThai));

            if (!string.IsNullOrEmpty(msgError))
                throw new Exception(msgError);

            return Convert.ToInt32(result);
        }

        // Cập nhật
        public bool Update(SanPhamChiTietModel model)
        {
            string query = @"
            UPDATE SanPhamChiTiet
            SET MaSP = @MaSP,
                MaSize = @MaSize,
                SoLuong = @SoLuong,
                TrangThai = @TrangThai
            WHERE ID = @ID";

            int rows = _db.ExecuteNoneQuery2(query,
                new SqlParameter("@MaSP", model.MaSP),
                new SqlParameter("@MaSize", model.MaSize),
                new SqlParameter("@SoLuong", model.SoLuong),
                new SqlParameter("@TrangThai", model.TrangThai),
                new SqlParameter("@ID", model.ID));

            return rows > 0;
        }

        // Xóa
        public bool Delete(int id)
        {
            string query = "DELETE FROM SanPhamChiTiet WHERE ID = @ID";
            int rows = _db.ExecuteNoneQuery2(query, new SqlParameter("@ID", id));
            return rows > 0;
        }

        // Lấy tất cả
        public List<SanPhamChiTietModel> GetAll()
        {
            string sql = "SELECT * FROM SanPhamChiTiet";
            var dt = _db.ExecuteQueryReturnDataTable(sql);
            return dt.ConvertTo<SanPhamChiTietModel>().ToList();
        }
        // Lấy tất cả bản ghi theo MaSP
        public List<SanPhamChiTietModel> GetAllByMaSP(int maSP)
        {
            string sql = @"
        SELECT ct.*, s.TenSize 
        FROM SanPhamChiTiet ct
        JOIN Size s ON ct.MaSize = s.MaSize
        WHERE ct.MaSP = @MaSP";
            var dt = _db.ExecuteQueryReturnDataTable(sql, new SqlParameter("@MaSP", maSP));
            return dt.ConvertTo<SanPhamChiTietModel>().ToList();
        }

        public List<AdminViewSanPhamChiTietModel> GetAllinAdmin()
        {
            string sql = @"
                SELECT 
                        ct.ID,
                    	  sp.MaChuyenMuc,

                    sp.MaSanPham,
                    sp.TenSanPham,
                    sp.AnhDaiDien,
                    sp.Gia,
                    sp.MoTa,
                    ct.MaSize,
                    sz.TenSize,
                    ct.SoLuong AS SoLuongTon,
                    ct.TrangThai
                FROM SanPhams sp
                INNER JOIN SanPhamChiTiet ct ON sp.MaSanPham = ct.MaSP
                INNER JOIN Size sz ON ct.MaSize = sz.MaSize
                "; var dt = _db.ExecuteQueryReturnDataTable(sql);
                        return dt.ConvertTo<AdminViewSanPhamChiTietModel>().ToList();
                    }



        public bool CongSoLuongSanPhamChiTiet(int maSP, int maSize, int soLuong)
        {
            string sql = @"
        UPDATE SanPhamChiTiet
        SET SoLuong = SoLuong + @SoLuong
        WHERE MaSP = @MaSP AND MaSize = @MaSize";

            int rowsAffected = _db.ExecuteNoneQuery2(sql,
                new SqlParameter("@MaSP", maSP),
                new SqlParameter("@MaSize", maSize),
                new SqlParameter("@SoLuong", soLuong));

            return rowsAffected > 0;
        }



    }
}
