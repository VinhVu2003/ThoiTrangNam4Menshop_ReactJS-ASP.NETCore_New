using DataAccessLayer;
using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLogicLayer
{
    public class GiamGiaSanPhamBUS
    {
        private GiamGiaSanPhamRepository _res;
        public GiamGiaSanPhamBUS(GiamGiaSanPhamRepository res)
        {
            _res = res;
        }

        public int Insert(GiamGiaSanPhamModel model)
        {
            return _res.Insert(model);
        }

        public bool Update(GiamGiaSanPhamModel model)
        {
            return _res.Update(model);
        }

        public bool Delete(int id)
        {
            return _res.Delete(id);
        }
        public bool Delete_GiamGiaId_SanPhamId(int giamGiaId, int sanPhamId)
        {
            return _res.Delete_GiamGiaId_SanPhamId(giamGiaId, sanPhamId);
        }

        public List<GiamGiaSanPhamViewModel> GetAll()
        {
            return _res.GetAll();
        }
        public List<SanPhamInGiamGiaModel> GetProdctInDiscountByIdDis(int giamGiaId)
        {
            return _res.GetProdctInDiscountByIdDis(giamGiaId);
        }
        public List<SanPhamModel> LayDSSanPhamKhongThuocGiamGiaKhac(int giamGiaId)
        {
            return _res.LayDSSanPhamKhongThuocGiamGiaKhac(giamGiaId);
        }
    }
}
