using BusinessLogicLayer;
using DataAccessLayer;
using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Versioning;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLogicLayer
{
    public class SanPhamBUS
    {
        private SanPhamRepository _repo;

        public SanPhamBUS(SanPhamRepository repo)
        {
            _repo = repo;
        }

        public int Insert(SanPhamModel model)
        {
            return _repo.Insert(model);
        }

        public bool Update(SanPhamModel model)
        {
            return _repo.Update(model);
        }

        public bool Delete(int maSanPham)
        {
            return _repo.Delete(maSanPham);
        }

        public List<SanPhamModel> GetAll()
        {
            return _repo.GetAll();
        }

        public SanPhamModel GetById(int maSanPham)
        {
            return _repo.GetById(maSanPham);
        }
        public bool TangLuotXem(int maSanPham)
        {
            return _repo.TangLuotXem(maSanPham);
        }
        public List<SanPhamModel> GetAllByMaChuyenMuc(int maChuyenMuc)
        {
            return _repo.GetAllByMaChuyenMuc(maChuyenMuc);
        }
        
        public List<SanPhamModel> GetAllCoChiTiet()
        {
            return _repo.GetAllCoChiTiet();
        }
        public List<SanPhamBanChay> Search_SP_BanChay(int pageIndex, int pageSize, out long total)
        {
            return _repo.Search_SP_BanChay(pageIndex, pageSize, out total);
        }

        public List<SanPhamMoNhatModel> Search_SP_New(int pageIndex, int pageSize, out long total)
        {
            return _repo.Search_SP_New(pageIndex, pageSize, out total);
        }

        public List<SanPhamModel> GetAllPro_WithName_User(string tenSanPham)
        {
            return _repo.GetAllPro_WithName_User(tenSanPham);
        }


        public List<LichSuGiaNhapModel> GetLichSuGiaNhapByMaSanPham(int maSanPham)
        {
            return _repo.GetLichSuGiaNhapByMaSanPham(maSanPham);
        }
    }
}
