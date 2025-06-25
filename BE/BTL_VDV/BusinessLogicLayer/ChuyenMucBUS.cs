
using DataAccessLayer;
using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLogicLayer
{
    public class ChuyenMucBUS
    {
        private readonly ChuyenMucRepository _repository;

        public ChuyenMucBUS(IDatabaseHelper dbHelper)
        {
            _repository = new ChuyenMucRepository(dbHelper);
        }

      

        public int Create(ChuyenMucModel model)
        {
            if (string.IsNullOrEmpty(model.TenChuyenMuc))
                throw new System.Exception("Tên chuyên mục không được để trống");

            return _repository.Insert(model);
        }

        public bool Update(ChuyenMucModel model)
        {
            if (model.MaChuyenMuc <= 0)
                throw new System.Exception("ID chuyên mục không hợp lệ");

            return _repository.Update(model);
        }

        public bool Delete(int id)
        {
            if (id <= 0)
                throw new System.Exception("ID chuyên mục không hợp lệ");

            return _repository.Delete(id);
        }

        //public List<ChuyenMucModel> Search(int pageIndex, int pageSize, out long total)
        //{
        //    return _repository.Search(pageIndex, pageSize, out total);
        //}
        public List<ChuyenMucModel> GetAll()
        {
            return _repository.GetAll();
        }
    }
}
