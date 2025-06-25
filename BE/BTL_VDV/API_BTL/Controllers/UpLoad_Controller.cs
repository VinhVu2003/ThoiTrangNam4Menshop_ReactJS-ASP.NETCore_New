using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace API_BTL.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UpLoad_Controller : ControllerBase
    {
        private readonly IWebHostEnvironment _environment;

        private string _path;

        public UpLoad_Controller(IConfiguration configuration)
        {
            _path = configuration["AppSettings:PATH"];
        }

        [NonAction]
        public string CreatePathFile(string RelativePathFileName)
        {
            try
            {
                string serverRootPathFolder = _path;
                string fullPathFile = $@"{serverRootPathFolder}\{RelativePathFileName}";
                string fullPathFolder = System.IO.Path.GetDirectoryName(fullPathFile);
                if (!Directory.Exists(fullPathFolder))
                    Directory.CreateDirectory(fullPathFolder);
                return fullPathFile;
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }

        [Route("upload")]
        [HttpPost, DisableRequestSizeLimit]
        public async Task<IActionResult> Upload(IFormFile file)
        {
            try
            {
                if (file.Length > 0)
                {
                    string filePath = $"{file.FileName}";
                    var fullPath = CreatePathFile(filePath);
                    using (var fileStream = new FileStream(fullPath, FileMode.Create))
                    {
                        await file.CopyToAsync(fileStream);
                    }
                    return Ok(new { filePath });
                }
                else
                {
                    return BadRequest();
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, "Không tìm thây");
            }
        }

        [Route("upload-multiple")]
        [HttpPost, DisableRequestSizeLimit]
        public async Task<IActionResult> UploadMultiple(List<IFormFile> files)
        {
            try
            {
                if (files == null || files.Count == 0)
                {
                    return BadRequest("Không có file nào được gửi.");
                }

                List<string> savedPaths = new List<string>();

                foreach (var file in files)
                {
                    if (file.Length > 0)
                    {
                        string filePath = $"{Guid.NewGuid()}_{file.FileName}"; // tránh trùng tên
                        string fullPath = CreatePathFile(filePath);

                        using (var stream = new FileStream(fullPath, FileMode.Create))
                        {
                            await file.CopyToAsync(stream);
                        }

                        savedPaths.Add(filePath);
                    }
                }

                return Ok(new { files = savedPaths });
            }
            catch (Exception ex)
            {
                return StatusCode(500, "Lỗi khi upload file: " + ex.Message);
            }
        }
    }
}
