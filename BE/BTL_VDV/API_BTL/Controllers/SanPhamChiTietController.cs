using BusinessLogicLayer;
using DataModel;
using Microsoft.AspNetCore.Mvc;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace API_BTL.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SanPhamChiTietController : ControllerBase
    {
        private readonly SanPhamChiTietBUS _bus;

        public SanPhamChiTietController(SanPhamChiTietBUS bus)
        {
            _bus = bus;
        }
        [HttpPost("insert")]
        public IActionResult Insert([FromBody] SanPhamChiTietModel model)
        {
            try
            {
                int id = _bus.Insert(model);
                return Ok(new { Id = id });
            }
            catch (System.Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpPut("update")]
        public IActionResult Update([FromBody] SanPhamChiTietModel model)
        {
            try
            {
                bool success = _bus.Update(model);
                return Ok(new { Success = success });
            }
            catch (System.Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpDelete("delete/{id}")]
        public IActionResult Delete(int id)
        {
            try
            {
                bool success = _bus.Delete(id);
                return Ok(new { Success = success });
            }
            catch (System.Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpGet("getall")]
        public IActionResult GetAll()
        {
            try
            {
                var list = _bus.GetAll();
                return Ok(list);
            }
            catch (System.Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        [HttpGet("getallbymasp/{maSP}")]
        public IActionResult GetAllByMaSP(int maSP)
        {
            try
            {
                var list = _bus.GetAllByMaSP(maSP);
                return Ok(list);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpGet("getallViewAdmin")]
        public IActionResult GetAllinAdmin()
        {
            try
            {
                var list = _bus.GetAllinAdmin();
                return Ok(list);
            }
            catch (System.Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpPut("cong-soluong")]
        public IActionResult CongSoLuong([FromBody] List<GiamSoLuongInput> danhSach)
        {
            try
            {
                bool result = _bus.CongSoLuongNhieuSanPham(danhSach);

                if (result)
                {
                    return Ok(new
                    {
                        success = true,
                        message = "Đã cộng lại số lượng sản phẩm do huỷ đơn hàng."
                    });
                }
                else
                {
                    return BadRequest(new
                    {
                        success = false,
                        message = "Cộng số lượng thất bại cho một số sản phẩm."
                    });
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, new
                {
                    success = false,
                    message = "Lỗi khi cộng số lượng: " + ex.Message
                });
            }
        }


    }
}
