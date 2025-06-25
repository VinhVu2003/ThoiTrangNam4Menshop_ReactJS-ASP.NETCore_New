using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataAccessLayer;
using DataModel;
namespace BusinessLogicLayer
{
    public class GiamGiaBUS
    {
        private readonly GiamGiaRepository _giamGiaRepo;
        public GiamGiaBUS(IDatabaseHelper dbHelper)
        {
            // Khởi tạo repository với dbHelper truyền từ bên ngoài
            _giamGiaRepo = new GiamGiaRepository(dbHelper);
        }
        public int ThemGiamGia(GiamGiaModel model)
        {
            // Có thể thêm kiểm tra logic nghiệp vụ trước khi insert
            if (model.NgayBatDau > model.NgayKetThuc)
                throw new ArgumentException("Ngày bắt đầu phải nhỏ hơn ngày kết thúc");

            return _giamGiaRepo.Insert(model);
        }
        public bool CapNhatGiamGia(GiamGiaModel model)
        {
            // Kiểm tra tồn tại Id
            if (model.Id <= 0)
                throw new ArgumentException("Id không hợp lệ");

            return _giamGiaRepo.Update(model);
        }
        public bool XoaGiamGia(int id)
        {
            if (id <= 0)
                throw new ArgumentException("Id không hợp lệ");

            return _giamGiaRepo.Delete(id);
        }
        public List<GiamGiaModel> GetAllGiamGia()
        {
            return _giamGiaRepo.GetAll();
        }
        public List<GiamGiaModel> GetAllAdmin()
        {
            return _giamGiaRepo.GetAllAdmin();
        }
    }
}
