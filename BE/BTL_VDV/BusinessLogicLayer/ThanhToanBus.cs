using DataAccessLayer;
using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLogicLayer
{
    public class ThanhToanBus
    {
        private ThanhToanRepository _res;

        public ThanhToanBus(ThanhToanRepository res)
        {
            _res = res;
        }
        public int ThemGiaoDich(ThanhToanVNPAYModel giaoDich)
        {
            // Có thể thêm logic kiểm tra dữ liệu ở đây
            return _res.Insert(giaoDich);
        }
        public ThanhToanVNPAYModel GetById(int MaHoaDon)
        {
            return _res.GetById(MaHoaDon);
        }
    }
}
