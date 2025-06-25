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
    public  class SizeRepository:ISizeRepository
    {
        private IDatabaseHelper _db;
        public SizeRepository(IDatabaseHelper db)
        {
            _db = db;
        }


        public SizeModel GetDatabyID(int id)
        {

            string msgError = "";
            try
            {
                var dt = _db.ExecuteSProcedureReturnDataTable(out msgError, "Size_get_by_id", "@MaID", id);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<SizeModel>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<SizeModel> Search(int pageIndex, int pageSize, out long total)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _db.ExecuteSProcedureReturnDataTable(out msgError, "Size_search",
                    "@page_index", pageIndex,
                    "@page_size", pageSize

                    );
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<SizeModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public int Insert(SizeModel model)
        {
            string msgError = "";
            int newId = 0;
            try
            {
                var result = _db.ExecuteScalar(
                    @"INSERT INTO Size (TenSize) VALUES (@TenSize);
                      SELECT CAST(scope_identity() AS int);",
                    out msgError,
                    new SqlParameter("@TenSize", model.TenSize ?? (object)DBNull.Value));

                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);

                if (result != null && int.TryParse(result.ToString(), out int id))
                    newId = id;

                return newId;
            }
            catch (Exception ex)
            {
                throw;
            }
        }
        public bool Update(SizeModel model)
        {
            string sqlUpdate = @"
                UPDATE Size
                SET TenSize = @TenSize,
                    Ghichu = @Ghichu
                WHERE MaSize = @MaSize";

                    try
                    {
                        // Giả sử ExecuteNoneQuery2 trả về số dòng bị ảnh hưởng (int)
                        int rowsAffected = _db.ExecuteNoneQuery2(sqlUpdate,
                            new SqlParameter("@TenSize", model.TenSize ?? (object)DBNull.Value),
                            new SqlParameter("@Ghichu", model.Ghichu ?? (object)DBNull.Value),
                            new SqlParameter("@MaSize", model.MaSize));

                        return rowsAffected >0;
                    }
                    catch (Exception ex)
                    {
                        // Bạn có thể log ex hoặc throw tùy ý
                        throw;
                    }
        }
        public bool Delete(int id)
        {
            string sql = "DELETE FROM Size WHERE MaSize = @MaSize";
            int rowsAffected = _db.ExecuteNoneQuery2(sql,
                new SqlParameter("@MaSize", id));
            return rowsAffected > 0;
        }
    }
}
