using BusinessLogicLayer;
using DataModel;
using Microsoft.AspNetCore.Mvc;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace API_BTL.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DanhGiaSanPhamController : ControllerBase
    {
        private readonly DanhGiaSanPhamBUS _bus;

        public DanhGiaSanPhamController(DanhGiaSanPhamBUS bus)
        {
            _bus = bus;
        }
        [HttpGet("get-all")]
        public IActionResult GetAll()
        {
            try
            {
                var data = _bus.GetAll();
                return Ok(data);
            }
            catch (Exception ex)
            {
                return BadRequest(new { success = false, message = ex.Message });
            }
        }

        [HttpPost("create")]
        public IActionResult Create([FromBody] DanhGiaSanPhamModel model)
        {
            try
            {
                var id = _bus.Insert(model);
                return Ok(new { success = true, id });
            }
            catch (Exception ex)
            {
                return BadRequest(new { success = false, message = ex.Message });
            }
        }

        [HttpPut("update")]
        public IActionResult Update([FromBody] DanhGiaSanPhamModel model)
        {
            try
            {
                var success = _bus.Update(model);
                return Ok(new { success });
            }
            catch (Exception ex)
            {
                return BadRequest(new { success = false, message = ex.Message });
            }
        }

        [HttpDelete("delete/{id}")]
        public IActionResult Delete(int id)
        {
            try
            {
                var success = _bus.Delete(id);
                return Ok(new { success });
            }
            catch (Exception ex)
            {
                return BadRequest(new { success = false, message = ex.Message });
            }
        }

        [HttpGet("get-all/{sanPhamId}")]
        public IActionResult GetAll(int sanPhamId)
        {
            try
            {
                var data = _bus.GetAllBySanPhamId(sanPhamId);
                return Ok(data);
            }
            catch (Exception ex)
            {
                return BadRequest(new { success = false, message = ex.Message });
            }
        }


    }
}
