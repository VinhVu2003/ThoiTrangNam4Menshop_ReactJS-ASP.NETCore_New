using BusinessLogicLayer;
using DataModel;
using Microsoft.AspNetCore.Mvc;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace API_BTL.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ThanhToanController : ControllerBase
    {
        private ThanhToanBus _bus;

        public ThanhToanController(ThanhToanBus bus)
        {
            _bus = bus;
        }
        // Thêm bài viết
        [Route("create")]
        [HttpPost]
        public ThanhToanVNPAYModel Create([FromBody] ThanhToanVNPAYModel model)
        {
            _bus.ThemGiaoDich(model);
            return model;
        }


        [HttpGet("{MaHoaDon}")]
        public IActionResult GetById(int MaHoaDon)
        {
            try
            {
                var result = _bus.GetById(MaHoaDon);
                if (result == null)
                    return NotFound("Không tìm thấy giao dịch");

                return Ok(result);
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }
    }
}
