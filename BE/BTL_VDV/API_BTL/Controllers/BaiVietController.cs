using BusinessLogicLayer;
using DataModel;
using Microsoft.AspNetCore.Mvc;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace API_BTL.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BaiVietController : ControllerBase
    {
        private BaiVietBus _bus;

        public BaiVietController(BaiVietBus bus)
        {
            _bus = bus;
        }

        // Thêm bài viết
        [Route("create")]
        [HttpPost]
        public BaiVietModel Create([FromBody] BaiVietModel model)
        {
            _bus.Insert(model);
            return model;
        }

        // Cập nhật bài viết
        [Route("update")]
        [HttpPost]
        public BaiVietModel Update([FromBody] BaiVietModel model)
        {
            _bus.Update(model);
            return model;
        }

        // Xóa bài viết
        [Route("delete")]
        [HttpDelete]
        public IActionResult Delete(int id)
        {
            _bus.Delete(id);
            return Ok();
        }

        // Lấy toàn bộ bài viết
        [Route("get-all")]
        [HttpGet]
        public List<BaiVietModel> GetAll()
        {
            return _bus.GetAll();
        }

        [Route("get-by-id")]
        [HttpGet]
        public BaiVietModel GetByID(int id)
        {
            return _bus.GetByID(id);
        }
    }
}
