using BusinessLogicLayer;
using DataModel;
using DataAccessLayer;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;

namespace API_BTL.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ChuyenMucController : ControllerBase
    {
        private ChuyenMucBUS CMbus;
        public ChuyenMucController(ChuyenMucBUS bus)
        {
            CMbus = bus;
        }
        [Route("ChuyenMuc_Create")]
        [HttpPost]
        public ChuyenMucModel Create(ChuyenMucModel model) 
        {
            CMbus.Create(model);
            return model;
        }

        [Route("ChuyenMuc_Update")]
        [HttpPost]
        public ChuyenMucModel Update(ChuyenMucModel model)
        {
            CMbus.Update(model);
            return model;
        }
        [Route("ChuyenMuc_Delete")]
        [HttpDelete]
        public IActionResult Delete(int id)
        {
            CMbus.Delete(id);
            return Ok();
        }
        [Route("ChuyenMuc_Getall")]
        [HttpGet]
        public IActionResult GetAll()
        {
            try
            {
                var list = CMbus.GetAll();
                return Ok(list);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }




    }
}
