using BusinessLogicLayer;
using DataModel;
using Microsoft.AspNetCore.Mvc;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace API_BTL.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class GiamGiaController : ControllerBase
    {
        private readonly GiamGiaBUS _bus;
        public GiamGiaController(GiamGiaBUS bus)
        {
            _bus = bus;
        }
        [HttpGet("get_all")]
        public IActionResult GetAll()
        {
            try
            {
                var list = _bus.GetAllGiamGia();
                return Ok(list);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        [HttpGet("get_all_Admin")]
        public IActionResult GetAllAdmin()
        {
            try
            {
                var list = _bus.GetAllAdmin();
                return Ok(list);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        [HttpPost("insert")]
        public IActionResult Insert([FromBody] GiamGiaModel model)
        {
            try
            {
                if (model == null)
                    return BadRequest("Dữ liệu giảm giá không hợp lệ");

                int newId = _bus.ThemGiamGia(model);
                return Ok(new { Id = newId });
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        [HttpPut("update")]
        public IActionResult Update([FromBody] GiamGiaModel model)
        {
            try
            {
                if (model == null || model.Id <= 0)
                    return BadRequest("Dữ liệu đầu vào không hợp lệ");

                bool success = _bus.CapNhatGiamGia(model);
                if (success)
                    return Ok(new { message = "Cập nhật thành công" });
                else
                    return NotFound(new { message = "Không tìm thấy giảm giá hoặc không có gì thay đổi" });
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        [HttpDelete("delete/{id}")]
        public IActionResult Delete(int id)
        {
            try
            {
                bool success = _bus.XoaGiamGia(id);
                if (success)
                    return Ok(new { message = "Xóa thành công" });
                else
                    return NotFound(new { message = "Không tìm thấy giảm giá" });
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }


  
        
    }
}
