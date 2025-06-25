using DataAccessLayer;
using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLogicLayer
{
    public class DanhGiaSanPhamBUS
    {
        private readonly DanhGiaSanPhamRepository _repo;

        public DanhGiaSanPhamBUS(DanhGiaSanPhamRepository repo)
        {
            _repo = repo;
        }
        public List<DanhGiaSanPhamModel> GetAll()
        {
            return _repo.GetAll();
        }

        public int Insert(DanhGiaSanPhamModel model)
        {
            return _repo.Insert(model);
        }

        public bool Update(DanhGiaSanPhamModel model)
        {
            return _repo.Update(model);
        }

        public bool Delete(int id)
        {
            return _repo.Delete(id);
        }

        public List<DanhGiaSanPhamModel> GetAllBySanPhamId(int sanPhamId)
        {
            return _repo.GetAllBySanPhamId(sanPhamId);
        }
    }
}
