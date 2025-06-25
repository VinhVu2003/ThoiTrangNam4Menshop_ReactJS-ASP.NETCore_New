using DataModel;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer
{
    public class GiamGiaRepository
    {
        private IDatabaseHelper _db;
        public GiamGiaRepository(IDatabaseHelper db)
        {
            _db = db;
        }
        public int Insert(GiamGiaModel model)
        {
            string msgError = "";
            int newId = 0;
            try
            {
                var result = _db.ExecuteScalar(
                    @"INSERT INTO GiamGia 
            (TenChuongTrinh, LoaiGiamGia, GiaTriGiam, MaGiamGia, SoLuongMua, SoLuongTang, SanPhamTangId, GiaTriDonToiThieu,
             ApDungToanBoSanPham, NhomKhachHang, SoLuongToiDa, SoLuongDaDung,
             NgayBatDau, NgayKetThuc, DangHoatDong, NgayTao, NgayCapNhat)
              VALUES 
            (@TenChuongTrinh, @LoaiGiamGia, @GiaTriGiam, @MaGiamGia, @SoLuongMua, @SoLuongTang, @SanPhamTangId, @GiaTriDonToiThieu,
             @ApDungToanBoSanPham, @NhomKhachHang, @SoLuongToiDa, @SoLuongDaDung,
             @NgayBatDau, @NgayKetThuc, @DangHoatDong, @NgayTao, @NgayCapNhat);
              SELECT CAST(scope_identity() AS int);",
                    out msgError,
                    new SqlParameter("@TenChuongTrinh", model.TenChuongTrinh),
                    new SqlParameter("@LoaiGiamGia", model.LoaiGiamGia),
                    new SqlParameter("@GiaTriGiam", model.GiaTriGiam ?? (object)DBNull.Value),
                    new SqlParameter("@MaGiamGia", model.MaGiamGia ?? (object)DBNull.Value),
                    new SqlParameter("@SoLuongMua", model.SoLuongMua ?? (object)DBNull.Value),
                    new SqlParameter("@SoLuongTang", model.SoLuongTang ?? (object)DBNull.Value),
                    new SqlParameter("@SanPhamTangId", model.SanPhamTangId ?? (object)DBNull.Value),
                    new SqlParameter("@GiaTriDonToiThieu", model.GiaTriDonToiThieu ?? (object)DBNull.Value),
                    new SqlParameter("@ApDungToanBoSanPham", model.ApDungToanBoSanPham),
                    new SqlParameter("@NhomKhachHang", model.NhomKhachHang ?? (object)DBNull.Value),
                    new SqlParameter("@SoLuongToiDa", model.SoLuongToiDa ?? (object)DBNull.Value),
                    new SqlParameter("@SoLuongDaDung", model.SoLuongDaDung),
                    new SqlParameter("@NgayBatDau", model.NgayBatDau),
                    new SqlParameter("@NgayKetThuc", model.NgayKetThuc),
                    new SqlParameter("@DangHoatDong", model.DangHoatDong),
                    new SqlParameter("@NgayTao", model.NgayTao),
                    new SqlParameter("@NgayCapNhat", model.NgayCapNhat)
                );

                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);

                if (result != null && int.TryParse(result.ToString(), out int id))
                    newId = id;

                return newId;
            }
            catch (Exception ex)
            {
                throw new Exception("Lỗi thêm mới GiamGia: " + ex.Message);
            }
        }

        public bool Update(GiamGiaModel model)
        {
            string query = @"
        UPDATE GiamGia SET
            TenChuongTrinh = @TenChuongTrinh,
            LoaiGiamGia = @LoaiGiamGia,
            GiaTriGiam = @GiaTriGiam,
            MaGiamGia = @MaGiamGia,
            SoLuongMua = @SoLuongMua,
            SoLuongTang = @SoLuongTang,
            SanPhamTangId = @SanPhamTangId,
            GiaTriDonToiThieu = @GiaTriDonToiThieu,
            ApDungToanBoSanPham = @ApDungToanBoSanPham,
            NhomKhachHang = @NhomKhachHang,
            SoLuongToiDa = @SoLuongToiDa,
            SoLuongDaDung = @SoLuongDaDung,
            NgayBatDau = @NgayBatDau,
            NgayKetThuc = @NgayKetThuc,
            DangHoatDong = @DangHoatDong,
            NgayCapNhat = @NgayCapNhat
        WHERE Id = @Id";

            try
            {
                int rowsAffected = _db.ExecuteNoneQuery2(query,
                    new SqlParameter("@TenChuongTrinh", model.TenChuongTrinh),
                    new SqlParameter("@LoaiGiamGia", model.LoaiGiamGia),
                    new SqlParameter("@GiaTriGiam", model.GiaTriGiam ?? (object)DBNull.Value),
                    new SqlParameter("@MaGiamGia", model.MaGiamGia ?? (object)DBNull.Value),
                    new SqlParameter("@SoLuongMua", model.SoLuongMua ?? (object)DBNull.Value),
                    new SqlParameter("@SoLuongTang", model.SoLuongTang ?? (object)DBNull.Value),
                    new SqlParameter("@SanPhamTangId", model.SanPhamTangId ?? (object)DBNull.Value),
                    new SqlParameter("@GiaTriDonToiThieu", model.GiaTriDonToiThieu ?? (object)DBNull.Value),
                    new SqlParameter("@ApDungToanBoSanPham", model.ApDungToanBoSanPham),
                    new SqlParameter("@NhomKhachHang", model.NhomKhachHang ?? (object)DBNull.Value),
                    new SqlParameter("@SoLuongToiDa", model.SoLuongToiDa ?? (object)DBNull.Value),
                    new SqlParameter("@SoLuongDaDung", model.SoLuongDaDung),
                    new SqlParameter("@NgayBatDau", model.NgayBatDau),
                    new SqlParameter("@NgayKetThuc", model.NgayKetThuc),
                    new SqlParameter("@DangHoatDong", model.DangHoatDong),
                    new SqlParameter("@NgayCapNhat", model.NgayCapNhat),
                    new SqlParameter("@Id", model.Id)
                );

                return rowsAffected > 0;
            }
            catch (Exception ex)
            {
                throw new Exception("Lỗi cập nhật GiamGia: " + ex.Message);
            }
        }

        public bool Delete(int id)
        {
            string sql = "DELETE FROM GiamGia WHERE Id = @Id";
            try
            {
                int rowsAffected = _db.ExecuteNoneQuery2(sql,
                    new SqlParameter("@Id", id));
                return rowsAffected > 0;
            }
            catch (Exception)
            {
                throw;
            }
        }
        public List<GiamGiaModel> GetAll()
        {
            string sql = "SELECT * FROM GiamGia WHERE DangHoatDong = 1";
            var dt = _db.ExecuteQueryReturnDataTable(sql);
            return dt.ConvertTo<GiamGiaModel>().ToList();
        }

        public List<GiamGiaModel> GetAllAdmin()
        {
            string sql = "SELECT * FROM GiamGia";
            var dt = _db.ExecuteQueryReturnDataTable(sql);
            return dt.ConvertTo<GiamGiaModel>().ToList();
        }

    }
}
