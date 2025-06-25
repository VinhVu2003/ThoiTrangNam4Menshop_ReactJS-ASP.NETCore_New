using BusinessLogicLayer;
using DataAccessLayer;
using DataModel;
using Microsoft.AspNetCore.Mvc;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace API_BTL.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class KhachHangController : ControllerBase
    {
        private readonly KhachHangBUS _khachHangService;

        public KhachHangController(IDatabaseHelper dbHelper)
        {
            _khachHangService = new KhachHangBUS(dbHelper);
        }
        [HttpPost("them-moi")]
        public IActionResult ThemMoiKhachHang([FromBody] KhachModel model)
        {
            try
            {
                var maKH = _khachHangService.ThemMoiKhachHang(model);
                return Ok(new { MaKhachHang = maKH });
            }
            catch (Exception ex)
            {
                return BadRequest(new { Message = ex.Message });
            }
        }
    }
}
