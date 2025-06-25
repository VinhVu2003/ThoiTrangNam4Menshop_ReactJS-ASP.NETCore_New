using DataAccessLayer;
using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLogicLayer
{
    public class BaiVietBus
    {
        private BaiVietRepository _res;

        public BaiVietBus(BaiVietRepository res)
        {
            _res = res;
        }

        // Thêm bài viết
        public int Insert(BaiVietModel model)
        {
            return _res.Insert(model);
        }

        // Cập nhật bài viết
        public bool Update(BaiVietModel model)
        {
            return _res.Update(model);
        }

        // Xóa bài viết theo ID
        public bool Delete(int id)
        {
            return _res.Delete(id);
        }

        // Lấy tất cả bài viết
        public List<BaiVietModel> GetAll()
        {
            return _res.GetAll();
        }
        public BaiVietModel GetByID(int id)
        {
            return _res.GetByID(id);
        }
    }
}
