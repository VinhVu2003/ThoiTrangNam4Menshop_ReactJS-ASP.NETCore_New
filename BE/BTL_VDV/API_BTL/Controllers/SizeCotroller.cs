using BusinessLogicLayer;
using DataModel;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using DataAccessLayer;
namespace API_BTL.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SizeCotroller : ControllerBase
    {
        private ISizeBUS _bus;
        public SizeCotroller(ISizeBUS bus)
        {
            _bus = bus;
        }

        [Route("get_by_id")]
        [HttpGet]
        public SizeModel GetAtabeyID(int id)
        {
            return _bus.GetDatabyID(id);
        }

        [Route("Size_Search")]
        [HttpPost]
        public IActionResult Search([FromBody] Dictionary<string, object> formData)
        {
            var response = new SizeModel();
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());
                long total = 0;
                var data = _bus.Search(page, pageSize, out total);
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

        [Route("insert")]
        [HttpPost]
        public IActionResult Insert([FromBody] SizeModel model)
        {
            try
            {
                if (model == null)
                    return BadRequest("Model is null");

                // Gọi phương thức Insert trong BUS
                int newId = _bus.InsertSize(model);

                // Trả về Id mới tạo
                return Ok(new { Id = newId });
            }
            catch (Exception ex)
            {
                // Trả lỗi về client
                return BadRequest(ex.Message);
            }
        }
        [Route("update")]
        [HttpPut]
        public IActionResult Update([FromBody] SizeModel model)
        {
            try
            {
                if (model == null || model.MaSize <= 0)
                    return BadRequest("Invalid input data");

                // Gọi phương thức Update trong BUS
                bool success = _bus.Update(model);

                if (success)
                    return Ok(new { message = "Update successful" });
                else
                    return NotFound(new { message = "Size not found or nothing to update" });
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        [Route("delete/{id}")]
        [HttpDelete]
        public IActionResult Delete(int id)
        {
            try
            {
                bool success = _bus.Delete(id);
                if (success)
                    return Ok(new { message = "Delete successful" });
                else
                    return NotFound(new { message = "Size not found" });
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }



    }
}
