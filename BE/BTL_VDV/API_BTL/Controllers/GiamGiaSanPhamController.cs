using BusinessLogicLayer;
using DataModel;
using Microsoft.AspNetCore.Mvc;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace API_BTL.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class GiamGiaSanPhamController : ControllerBase
    {
        private readonly GiamGiaSanPhamBUS _bus;

        public GiamGiaSanPhamController(GiamGiaSanPhamBUS bus)
        {
            _bus = bus;
        }

        [HttpPost("insert")]
        public IActionResult Insert([FromBody] GiamGiaSanPhamModel model)
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
        public IActionResult Update([FromBody] GiamGiaSanPhamModel model)
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

        [HttpDelete("Delete_GiamGiaId_SanPhamId/{giamGiaId}/{sanPhamId}")]
        public IActionResult Delete_GiamGiaId_SanPhamId(int giamGiaId, int sanPhamId)
        {
            try
            {
                bool success = _bus.Delete_GiamGiaId_SanPhamId(giamGiaId, sanPhamId);
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

        [HttpGet("GetListPro_InDiscount/{giamGiaId}")]
        public IActionResult GetProdctInDiscountByIdDis(int giamGiaId)
        {
            try
            {
                var result = _bus.GetProdctInDiscountByIdDis(giamGiaId);
                return Ok(result);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpGet("LayDSSanPhamKhongThuocGiamGiaKhac/{giamGiaId}")]
        public IActionResult LayDSSanPhamKhongThuocGiamGiaKhac(int giamGiaId)
        {
            try
            {
                var result = _bus.LayDSSanPhamKhongThuocGiamGiaKhac(giamGiaId);
                return Ok(result);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
    }
}
