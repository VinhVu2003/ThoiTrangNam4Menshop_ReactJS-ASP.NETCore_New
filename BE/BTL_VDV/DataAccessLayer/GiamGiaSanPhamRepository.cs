using DataModel;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer
{
    public class GiamGiaSanPhamRepository
    {
        private IDatabaseHelper _db;

        public GiamGiaSanPhamRepository(IDatabaseHelper db)
        {
            _db = db;
        }

        // Thêm mới
        public int Insert(GiamGiaSanPhamModel model)
        {
            string query = @"
            INSERT INTO GiamGia_SanPham (GiamGiaId, SanPhamId)
            VALUES (@GiamGiaId, @SanPhamId);
            SELECT CAST(SCOPE_IDENTITY() AS INT);";

            string msgError = "";
            var result = _db.ExecuteScalar(query, out msgError,
                new SqlParameter("@GiamGiaId", model.GiamGiaId),
                new SqlParameter("@SanPhamId", model.SanPhamId));

            if (!string.IsNullOrEmpty(msgError))
                throw new Exception(msgError);

            return Convert.ToInt32(result);
        }

        // Cập nhật
        public bool Update(GiamGiaSanPhamModel model)
        {
            string query = @"
            UPDATE GiamGia_SanPham
            SET GiamGiaId = @GiamGiaId,
                SanPhamId = @SanPhamId
            WHERE Id = @Id";

            int rows = _db.ExecuteNoneQuery2(query,
                new SqlParameter("@GiamGiaId", model.GiamGiaId),
                new SqlParameter("@SanPhamId", model.SanPhamId),
                new SqlParameter("@Id", model.Id));

            return rows > 0;
        }

        // Xóa
        public bool Delete(int id)
        {
            string query = "DELETE FROM GiamGia_SanPham WHERE Id = @Id";
            int rows = _db.ExecuteNoneQuery2(query, new SqlParameter("@Id", id));
            return rows > 0;
        }
        //xóa theo 
        public bool Delete_GiamGiaId_SanPhamId(int giamGiaId, int sanPhamId)
        {
            string query = "DELETE FROM GiamGia_SanPham WHERE GiamGiaId = @GiamGiaId AND SanPhamId = @SanPhamId";
            int rows = _db.ExecuteNoneQuery2(query,
                new SqlParameter("@GiamGiaId", giamGiaId),
                new SqlParameter("@SanPhamId", sanPhamId));
            return rows > 0;
        }

        // Lấy tất cả
        public List<GiamGiaSanPhamViewModel> GetAll()
        {
            string sql = @"
                SELECT gsp.*, gg.*
                FROM GiamGia_SanPham gsp
                JOIN GiamGia gg ON gsp.GiamGiaId = gg.Id";

            var dt = _db.ExecuteQueryReturnDataTable(sql);
            return dt.ConvertTo<GiamGiaSanPhamViewModel>().ToList();
        }
      
        public List<SanPhamInGiamGiaModel> GetProdctInDiscountByIdDis(int giamGiaId)
        {
            string sql = @"
                    select*
                    from GiamGia_SanPham g
                    inner join SanPhams s on s.MaSanPham=g.SanPhamId
                    where g.GiamGiaId = @giamGiaId;";

            var dt = _db.ExecuteQueryReturnDataTable(sql, new SqlParameter("@giamGiaId", giamGiaId));
            return dt.ConvertTo<SanPhamInGiamGiaModel>().ToList();
        }


        //Lấy tất cả sản phẩm từ bảng SanPhams mà không bị gán vào bất kỳ chương trình giảm giá nào khác
        public List<SanPhamModel> LayDSSanPhamKhongThuocGiamGiaKhac(int giamGiaId)
        {
            string sql = @"
                   SELECT *
                            FROM SanPhams sp
                            WHERE NOT EXISTS (
                                SELECT 1
                                FROM GiamGia_SanPham ggsp
                                WHERE ggsp.SanPhamId = sp.MaSanPham
                                  AND ggsp.GiamGiaId != @giamGiaId
                            )";

            var dt = _db.ExecuteQueryReturnDataTable(sql, new SqlParameter("@giamGiaId", giamGiaId));
            return dt.ConvertTo<SanPhamModel>().ToList();
        }
    }
}
