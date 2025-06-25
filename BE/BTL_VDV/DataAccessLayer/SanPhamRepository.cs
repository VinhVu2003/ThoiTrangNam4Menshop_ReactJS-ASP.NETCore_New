using DataAccessLayer;
using DataModel;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer
{
    public class SanPhamRepository
    {
        private IDatabaseHelper _db;
        public SanPhamRepository(IDatabaseHelper db)
        {
            _db = db;
        }

        // Thêm mới
        public int Insert(SanPhamModel model)
        {
            string query = @"
                INSERT INTO SanPhams 
                (MaChuyenMuc, TenSanPham, AnhDaiDien, Gia, TrangThai, LuotXem, MoTa)
                VALUES 
                (@MaChuyenMuc, @TenSanPham, @AnhDaiDien, @Gia, @TrangThai, @LuotXem, @MoTa);
                SELECT CAST(SCOPE_IDENTITY() AS INT);";

            string msgError = "";
            var result = _db.ExecuteScalar(query, out msgError,
                new SqlParameter("@MaChuyenMuc", (object)model.MaChuyenMuc ?? DBNull.Value),
                new SqlParameter("@TenSanPham", (object)model.TenSanPham ?? DBNull.Value),
                new SqlParameter("@AnhDaiDien", (object)model.AnhDaiDien ?? DBNull.Value),
                new SqlParameter("@Gia", (object)model.Gia ?? DBNull.Value),
                //new SqlParameter("@SoLuong", (object)model.SoLuong ?? DBNull.Value),
                new SqlParameter("@TrangThai", (object)model.TrangThai ?? DBNull.Value),
                new SqlParameter("@LuotXem", (object)model.LuotXem ?? DBNull.Value),
                new SqlParameter("@MoTa", (object)model.MoTa ?? DBNull.Value)
            );

            if (!string.IsNullOrEmpty(msgError))
                throw new Exception(msgError);

            return Convert.ToInt32(result);
        }
        // Cập nhật
        public bool Update(SanPhamModel model)
        {
            string query = @"
                UPDATE SanPhams SET
                    MaChuyenMuc = @MaChuyenMuc,
                    TenSanPham = @TenSanPham,
                    AnhDaiDien = @AnhDaiDien,
                    Gia = @Gia,
                    TrangThai = @TrangThai,
                    LuotXem = @LuotXem,
                    MoTa = @MoTa
                WHERE MaSanPham = @MaSanPham";

            int rows = _db.ExecuteNoneQuery2(query,
                new SqlParameter("@MaChuyenMuc", (object)model.MaChuyenMuc ?? DBNull.Value),
                new SqlParameter("@TenSanPham", (object)model.TenSanPham ?? DBNull.Value),
                new SqlParameter("@AnhDaiDien", (object)model.AnhDaiDien ?? DBNull.Value),
                new SqlParameter("@Gia", (object)model.Gia ?? DBNull.Value),
                new SqlParameter("@TrangThai", (object)model.TrangThai ?? DBNull.Value),
                new SqlParameter("@LuotXem", (object)model.LuotXem ?? DBNull.Value),
                new SqlParameter("@MoTa", (object)model.MoTa ?? DBNull.Value),
                new SqlParameter("@MaSanPham", model.MaSanPham)
            );

            return rows > 0;
        }
        // Xóa (xóa thực sự)
        public bool Delete(int maSanPham)
        {
            string query = "DELETE FROM SanPhams WHERE MaSanPham = @MaSanPham";
            int rows = _db.ExecuteNoneQuery2(query, new SqlParameter("@MaSanPham", maSanPham));
            return rows > 0;
        }
        // Lấy tất cả (nếu cần)
        public List<SanPhamModel> GetAll()
        {
            string sql = "SELECT * FROM SanPhams";
            var dt = _db.ExecuteQueryReturnDataTable(sql);
            return dt.ConvertTo<SanPhamModel>().ToList();
        }

        // Lấy theo ID
        public SanPhamModel GetById(int maSanPham)
        {
            string sql = @"
                    SELECT 
                        sp.*, 
                        gg.Id AS GiamGiaId, 
                        gg.GiaTriGiam, 
                        gg.NgayBatDau, 
                        gg.NgayKetThuc,
	                    gg.DangHoatDong,
                        CASE 
                            WHEN gg.Id IS NULL THEN N'Không có'
                            WHEN GETDATE() < gg.NgayBatDau THEN N'Chưa bắt đầu'
                            WHEN GETDATE() BETWEEN gg.NgayBatDau AND gg.NgayKetThuc THEN N'Đang diễn ra'
                            WHEN GETDATE() > gg.NgayKetThuc THEN N'Đã kết thúc'
                            ELSE N'Không xác định'
                        END AS TrangThaiGiamGia
                    FROM SanPhams sp
                    LEFT JOIN GiamGia_SanPham gsp ON sp.MaSanPham = gsp.SanPhamId
                    LEFT JOIN GiamGia gg ON gsp.GiamGiaId = gg.Id
                    WHERE sp.MaSanPham = @MaSanPham;";

            var dt = _db.ExecuteQueryReturnDataTable(sql, new SqlParameter("@MaSanPham", maSanPham));
            return dt.ConvertTo<SanPhamModel>().FirstOrDefault();
        }
        public bool TangLuotXem(int maSanPham)
        {
            string sql = @"
                UPDATE SanPhams
                SET LuotXem = ISNULL(LuotXem, 0) + 1
                WHERE MaSanPham = @MaSanPham";

            int rows = _db.ExecuteNoneQuery2(sql, new SqlParameter("@MaSanPham", maSanPham));
            return rows > 0;
        }
        //get theo machuyenmuc
        public List<SanPhamModel> GetAllByMaChuyenMuc(int maChuyenMuc)
        {
            string sql = @"
                SELECT * FROM SanPhams
                WHERE MaChuyenMuc = @MaChuyenMuc";

            var dt = _db.ExecuteQueryReturnDataTable(sql, new SqlParameter("@MaChuyenMuc", maChuyenMuc));
            return dt.ConvertTo<SanPhamModel>().ToList();
        }

        // Lấy tất cả sản phẩm có trong bảng SanPhamChiTiet (không trùng lặp)
        public List<SanPhamModel> GetAllCoChiTiet()
        {
            string sql = @"
                SELECT DISTINCT sp.* 
                FROM SanPhams sp
                INNER JOIN SanPhamChiTiet ct ON sp.MaSanPham = ct.MaSP
                WHERE ct.SoLuong > 0";

            var dt = _db.ExecuteQueryReturnDataTable(sql);
            return dt.ConvertTo<SanPhamModel>().ToList();
        }
        public List<SanPhamMoNhatModel> Search_SP_New(int pageIndex, int pageSize, out long total)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _db.ExecuteSProcedureReturnDataTable(out msgError, "User_New_Products",
                    "@page_index", pageIndex,
                    "@page_size", pageSize);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<SanPhamMoNhatModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public List<SanPhamBanChay> Search_SP_BanChay(int pageIndex, int pageSize, out long total)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _db.ExecuteSProcedureReturnDataTable(out msgError, "User_Selling_Products",
                    "@page_index", pageIndex,
                    "@page_size", pageSize);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<SanPhamBanChay>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public List<SanPhamModel> GetAllPro_WithName_User(string tenSanPham)
        {
            string sql = @"SELECT 
                                sp.*,
                                gsp.GiamGiaId,
                                gg.TenChuongTrinh,
                                gg.GiaTriGiam,
                                gg.LoaiGiamGia,
                                gg.DangHoatDong,
                                gg.NgayBatDau,
                                gg.NgayKetThuc
                            FROM SanPhams sp
                            LEFT JOIN GiamGia_SanPham gsp ON sp.MaSanPham = gsp.SanPhamId
                            left JOIN GiamGia gg 
                                ON gsp.GiamGiaId = gg.Id
                                AND gg.DangHoatDong = 1
                                AND GETDATE() BETWEEN gg.NgayBatDau AND gg.NgayKetThuc
                            WHERE sp.TenSanPham LIKE @TenSanPham;";

            SqlParameter[] parameters = new SqlParameter[]
            {
                     new SqlParameter("@TenSanPham", $"%{tenSanPham}%")
            };

            var dt = _db.ExecuteQueryReturnDataTable(sql, parameters);
            return dt.ConvertTo<SanPhamModel>().ToList();
        }


        public List<LichSuGiaNhapModel> GetLichSuGiaNhapByMaSanPham(int maSanPham)
        {
            string sql = @"
                SELECT 
                        ctn.Id,
                        ctn.MaHoaDon,
                        ctn.MaSanPham,
                        ctn.SoLuong,
                        ctn.GiaNhap,
                        ctn.TongTien,
                        ctn.DonViTinh,
                        ctn.MaSize,
                        s.TenSize,
                        hdn.NgayTao AS NgayNhap
                    FROM ChiTietHoaDonNhaps ctn
                    INNER JOIN HoaDonNhaps hdn ON ctn.MaHoaDon = hdn.MaHoaDon
                    LEFT JOIN Size s ON ctn.MaSize = s.MaSize
                    WHERE ctn.MaSanPham = @MaSanPham
                    ORDER BY hdn.NgayTao DESC";

            var dt = _db.ExecuteQueryReturnDataTable(sql,
                new SqlParameter("@MaSanPham", maSanPham));

            return dt.ConvertTo<LichSuGiaNhapModel>().ToList();
        }


    }
}
