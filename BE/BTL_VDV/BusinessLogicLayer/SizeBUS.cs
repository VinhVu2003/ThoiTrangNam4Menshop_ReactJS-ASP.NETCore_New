using BusinessLogicLayer;
using DataAccessLayer;
using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLogicLayer
{
    public class SizeBUS : ISizeBUS
    {
        private ISizeRepository _res;
        public SizeBUS(ISizeRepository res)
        {
            _res = res;
        }

        public SizeModel GetDatabyID(int id)
        {
            return _res.GetDatabyID(id);
        }

        public List<SizeModel> Search(int pageIndex, int pageSize, out long total)
        {
            return _res.Search(pageIndex, pageSize, out total);
        }
        public int InsertSize(SizeModel model)
        {
            try
            {
                int newId = _res.Insert(model);
                return newId;
            }
            catch (Exception ex)
            {
                // Xử lý lỗi hoặc log nếu cần
                throw;
            }
        }
        public bool Update(SizeModel model)
        {
            return _res.Update(model); // Gọi sang repository
        }
        public bool Delete(int id)
        {
            return _res.Delete(id);
        }

    }
}
