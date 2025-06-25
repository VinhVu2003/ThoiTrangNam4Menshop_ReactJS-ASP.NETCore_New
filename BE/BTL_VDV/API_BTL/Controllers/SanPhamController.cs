using BusinessLogicLayer;
using DataModel;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace API_BTL.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SanPhamController : ControllerBase
    {
        private readonly SanPhamBUS _bus;

        public SanPhamController(SanPhamBUS bus)
        {
            _bus = bus;
        }

        [HttpPost("insert")]
        public IActionResult Insert([FromBody] SanPhamModel model)
        {
            try
            {
                int id = _bus.Insert(model);
                return Ok(new { Id = id });
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpPut("update")]
        public IActionResult Update([FromBody] SanPhamModel model)
        {
            try
            {
                bool success = _bus.Update(model);
                return Ok(new { Success = success });
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
                bool success = _bus.Delete(id);
                return Ok(new { Success = success });
            }
            catch (Exception ex)
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
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpGet("get/{id}")]
        public IActionResult GetById(int id)
        {
            try
            {
                var sp = _bus.GetById(id);
                if (sp == null) return NotFound();
                return Ok(sp);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpPut("tangluotxem/{id}")]
        public IActionResult TangLuotXem(int id)
        {
            try
            {
                bool success = _bus.TangLuotXem(id);
                return Ok(new { Success = success });
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        [HttpGet("GetByMaChuyenMuc/{maChuyenMuc}")]
        public IActionResult GetAllByMaChuyenMuc(int maChuyenMuc)
        {
            try
            {
                var result = _bus.GetAllByMaChuyenMuc(maChuyenMuc);
                return Ok(result);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        [HttpGet("GetAllCoTrongKho")]
        public IActionResult GetAllCoChiTiet()
        {
            try
            {
                var result = _bus.GetAllCoChiTiet();
                return Ok(result);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        [Route("Search_SP_New")]
        [HttpPost]
        public IActionResult Search_SP_New([FromBody] Dictionary<string, object> formData)
        {
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());
                long total = 0;
                var data = _bus.Search_SP_New(page, pageSize, out total);
                return Ok(
                    new
                    {
                        TotalItems = total,
                        Data = data,
                        Page = page,
                        PageSize = pageSize
                    }
                    );
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        [Route("Search_SP_BanChay")]
        [HttpPost]
        public IActionResult Search_SP_BanChay([FromBody] Dictionary<string, object> formData)
        {
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());
                long total = 0;
                var data = _bus.Search_SP_BanChay(page, pageSize, out total);
                return Ok(
                    new
                    {
                        TotalItems = total,
                        Data = data,
                        Page = page,
                        PageSize = pageSize
                    }
                    );
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        [HttpPost("searchWithName_User")]
        public IActionResult GetAllPro_WithName_User([FromBody] InputTenSanPham request)
        {
            //if (string.IsNullOrWhiteSpace(request.TenSanPham))
            //    return BadRequest("Tên sản phẩm không được để trống");

            var result = _bus.GetAllPro_WithName_User(request.TenSanPham);

            if (result == null || result.Count == 0)
                return NotFound("Không tìm thấy sản phẩm nào");

            return Ok(result);
        }

        // GET api/LichSuGiaNhap/123
        [HttpGet("getlichsugianhap/{maSanPham}")]
        public IActionResult GetLichSuGiaNhap(int maSanPham)
        {
            try
            {
                var data = _bus.GetLichSuGiaNhapByMaSanPham(maSanPham);
                return Ok(data);
            }
            catch (Exception ex)
            {
                return StatusCode(500, "Lỗi khi lấy dữ liệu: " + ex.Message);
            }
        }
    }
}
