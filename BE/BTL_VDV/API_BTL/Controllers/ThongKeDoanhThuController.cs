using BusinessLogicLayer;
using BusinessLogicLayer.Interfaces;
using DataAccessLayer;
using DataModel;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace API_BTL.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ThongKeDoanhThuController : ControllerBase
    {
        private ThongKeDoanhThuBUS bus;
        public ThongKeDoanhThuController(ThongKeDoanhThuBUS bus)
        {
            this.bus = bus;
        }

        [HttpGet("doanh-thu-ngay")]
        public IActionResult GetDoanhThuNgay([FromQuery] DateTime from, [FromQuery] DateTime to)
        {
            try
            {
                var data = bus.LayDoanhThuTheoKhoang(from, to);
                return Ok(data);
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }
        [HttpGet("doanh-thu-thang")]
        public IActionResult GetDoanhThuThang([FromQuery] DateTime from, [FromQuery] DateTime to)
        {
            try
            {
                var data = bus.LayDoanhThuTheoThang(from, to);
                return Ok(data);
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }
        [HttpGet("doanh-thu-nam")]
        public IActionResult GetDoanhThuNam([FromQuery] DateTime from, [FromQuery] DateTime to)
        {
            try
            {
                var data = bus.LayDoanhThuTheoNam(from, to);
                return Ok(data);
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }

        [HttpGet("don-hang-theo-trang-thai")]
        public IActionResult ThongKeDonHangTheoTrangThai()
        {
            try
            {
                var result = bus.ThongKeDonHangTheoTrangThai();
                return Ok(result);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Lỗi hệ thống", error = ex.Message });
            }
        }


        // GET api/thongkedoanhthu/sanphamban
        [HttpGet("sanphamban")]
        public IActionResult GetSanPhamBanChay([FromQuery] DateTime fromDate, [FromQuery] DateTime toDate, [FromQuery] int top = 10)
        {
            try
            {
                var result = bus.GetSanPhamBanChay(fromDate, toDate, top);
                return Ok(result);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        // GET api/thongkedoanhthu/chuyenmuc
        [HttpGet("chuyenmuc")]
        public IActionResult GetDoanhThuTheoChuyenMuc([FromQuery] DateTime fromDate, [FromQuery] DateTime toDate)
        {
            try
            {
                var result = bus.GetDoanhThuTheoChuyenMuc(fromDate, toDate);
                return Ok(result);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }


        [HttpGet("loi-nhuan-ngay")]
        public IActionResult GetLoiNhuanTheoNgay(DateTime fromDate, DateTime toDate)
        {
            var result = bus.ThongKeLoiNhuanTheoNgay(fromDate, toDate);
            return Ok(result);
        }
        [HttpGet("loi-nhuan-thang")]
        public IActionResult ThongKeLoiNhuanTheoThang(DateTime fromDate, DateTime toDate)
        {
            var result = bus.ThongKeLoiNhuanTheoThang(fromDate, toDate);
            return Ok(result);
        }
        [HttpGet("loi-nhuan-theoSanPham")]
        public IActionResult ThongKeLoiNhuanTheoSanPham()
        {
            var result = bus.ThongKeLoiNhuanTheoSanPham();
            return Ok(result);
        }

        [HttpGet("ton-kho-theo-danh-muc")]
        public IActionResult GetThongKeTonKhoTheoDanhMuc()
        {
            try
            {
                var result = bus.LayThongKeTonKhoTheoDanhMuc();
                return Ok(result);
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }

    }
}
