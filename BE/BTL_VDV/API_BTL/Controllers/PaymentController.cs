using API_BTL.Services.VNPAY;
using DataModel.VNPAY;
using Newtonsoft.Json;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace API_BTL.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PaymentController : ControllerBase
    {
        private readonly IVnPayService _vnPayService;
        public PaymentController(IVnPayService vnPayService)
        {

            _vnPayService = vnPayService;
        }

        [HttpPost("CreatePaymentUrlVnpay")]
        public IActionResult CreatePaymentUrlVnpay([FromBody] PaymentInformationModel model)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (model == null)
                return BadRequest(new { message = "Dữ liệu thanh toán không hợp lệ" });

            var url = _vnPayService.CreatePaymentUrl(model, HttpContext);
            // Thay vì Redirect, bạn nên trả về url cho client tự redirect (nếu cần)
            return Ok(new { paymentUrl = url });
        }



        // Callback từ VNPAY, GET vì VNPAY trả về query string
        [HttpGet("PaymentCallbackVnpay")]
        public IActionResult PaymentCallbackVnpay()
        {
            var response = _vnPayService.PaymentExecute(Request.Query);

            //return new JsonResult(response);
            bool isSuccess = response.VnPayResponseCode == "00";
            return Ok(new
            {
                Success = response.VnPayResponseCode == "00",
                ResponseCode = response.VnPayResponseCode,
                Message = response.VnPayResponseCode == "00" ? "Thanh toán thành công!" : "Thanh toán thất bại!",
                Data = response
            });
        }

        //{
        //  "orderType": "fashion",
        //  "amount": 100000,
        //  "orderDescription": "Thanh toán đơn hàng 123",
        //  "name": "Nguyen Van A"
        //}
}
}
