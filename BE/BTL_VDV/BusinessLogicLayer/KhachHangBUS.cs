using DataAccessLayer;
using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLogicLayer
{
    public class KhachHangBUS
    {
        private readonly KhachHangDAL _khachHangRepo;
        public KhachHangBUS(IDatabaseHelper db)
        {
            _khachHangRepo = new KhachHangDAL(db);
        }
        public int ThemMoiKhachHang(KhachModel model)
        {
            if (string.IsNullOrEmpty(model.TenKH))
                throw new ArgumentException("Tên khách hàng không được để trống");

            if (string.IsNullOrEmpty(model.SDT))
                throw new ArgumentException("Số điện thoại không được để trống");

            return _khachHangRepo.Insert(model);
        }
    }
}
