using DataAccessLayer;
using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLogicLayer
{
    public class SanPhamChiTietBUS
    {
        private readonly SanPhamChiTietRepository _repo;

        public SanPhamChiTietBUS(SanPhamChiTietRepository repo)
        {
            _repo = repo;
        }
        public int Insert(SanPhamChiTietModel model)
        {
            // Có thể thêm validate ở đây nếu cần
            if (model.SoLuong < 0)
                throw new Exception("Số lượng không thể âm.");

            return _repo.Insert(model);
        }

        public bool Update(SanPhamChiTietModel model)
        {
            if (model.ID <= 0)
                throw new Exception("ID không hợp lệ.");

            return _repo.Update(model);
        }

        public bool Delete(int id)
        {
            if (id <= 0)
                throw new Exception("ID không hợp lệ.");

            return _repo.Delete(id);
        }

        public List<SanPhamChiTietModel> GetAll()
        {
            return _repo.GetAll();
        }

        public List<SanPhamChiTietModel> GetAllByMaSP(int maSP)
        {
            return _repo.GetAllByMaSP(maSP);
        }
        public List<AdminViewSanPhamChiTietModel> GetAllinAdmin()
        {
            return _repo.GetAllinAdmin();
        }

        public bool CongSoLuongNhieuSanPham(List<GiamSoLuongInput> danhSach)
        {
            bool success = true;

            foreach (var item in danhSach)
            {
                bool result = _repo.CongSoLuongSanPhamChiTiet(item.MaSanPham, item.MaSize, item.SoLuong);

                if (!result)
                {
                    success = false;
                }
            }

            return success;
        }

    }
}
