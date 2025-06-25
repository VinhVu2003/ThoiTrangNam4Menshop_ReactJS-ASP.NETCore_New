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
    public class ChuyenMucRepository
    {
        private IDatabaseHelper _db;

        public ChuyenMucRepository(IDatabaseHelper db)
        {
            _db = db;
        }


        public int Insert(ChuyenMucModel model)
        {
            string msgError = "";
            int newId = 0;
            try
            {
                var result = _db.ExecuteScalar(
                    @"INSERT INTO ChuyenMucs (TenChuyenMuc, NoiDung, IDCapCha) 
                      VALUES (@TenChuyenMuc, @NoiDung, @IDCapCha);
                      SELECT CAST(scope_identity() AS int);",
                    out msgError,
                    new SqlParameter("@TenChuyenMuc", model.TenChuyenMuc ?? (object)DBNull.Value),
                    new SqlParameter("@NoiDung", model.NoiDung ?? (object)DBNull.Value),
                    new SqlParameter("@IDCapCha", model.IDCapCha.HasValue ? model.IDCapCha.Value : (object)DBNull.Value)
                );

                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);

                if (result != null && int.TryParse(result.ToString(), out int id))
                    newId = id;

                return newId;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public bool Update(ChuyenMucModel model)
        {
            string sqlUpdate = @"
                UPDATE ChuyenMucs
                SET TenChuyenMuc = @TenChuyenMuc,
                    NoiDung = @NoiDung,
                    IDCapCha = @IDCapCha
                WHERE MaChuyenMuc = @MaChuyenMuc";

            try
            {
                int rowsAffected = _db.ExecuteNoneQuery2(sqlUpdate,
                    new SqlParameter("@TenChuyenMuc", model.TenChuyenMuc ?? (object)DBNull.Value),
                    new SqlParameter("@NoiDung", model.NoiDung ?? (object)DBNull.Value),
                    new SqlParameter("@IDCapCha", model.IDCapCha.HasValue ? model.IDCapCha.Value : (object)DBNull.Value),
                    new SqlParameter("@MaChuyenMuc", model.MaChuyenMuc));

                return rowsAffected > 0;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public bool Delete(int id)
        {
            string sql = "DELETE FROM ChuyenMucs WHERE MaChuyenMuc = @MaChuyenMuc";
            try
            {
                int rowsAffected = _db.ExecuteNoneQuery2(sql,
                    new SqlParameter("@MaChuyenMuc", id));
                return rowsAffected > 0;
            }
            catch (Exception)
            {
                throw;
            }
        }
        public List<ChuyenMucModel> GetAll()
        {
            string sql = "SELECT * FROM ChuyenMucs"; // hoặc thêm điều kiện nếu cần
            var dt = _db.ExecuteQueryReturnDataTable(sql);
            return dt.ConvertTo<ChuyenMucModel>().ToList();
        }
    }
}
