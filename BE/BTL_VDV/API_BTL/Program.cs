//using BusinessLogicLayer;
//using DataAccessLayer;

//var builder = WebApplication.CreateBuilder(args);

//// Add services to the container.


//builder.Services.AddControllers();
//builder.Services.AddTransient<IDatabaseHelper, DatabaseHelper>();

//builder.Services.AddTransient<IKhachRepository, KhachRepository>();
//builder.Services.AddTransient<IKhachBusiness, KhachBusiness>();

//builder.Services.AddTransient<IHoaDonBanRepository, HoaDonBanRepository>();
//builder.Services.AddTransient<IHoaDonBanBUS, HoaDonBanBUS>();

//builder.Services.AddTransient<IUserRepository, UserRepository>();
//builder.Services.AddTransient<IUserBUS, UserBUS>();

//builder.Services.AddTransient<INhaPhanPhoiRepository, NhaPhanPhoiRepository>();
//builder.Services.AddTransient<INhaPhanPhoiBUS, NhaPhanPhoiBUS>();

//builder.Services.AddTransient<IHoaDonNhapRepository, HoaDonNhapRepository>();
//builder.Services.AddTransient<IHoaDonNhapBUS, HoaDonNhapBUS>();

//builder.Services.AddTransient<IChuyenMucRepository, ChuyenMucRepository>();
//builder.Services.AddTransient<IChuyenMucBUS, ChuyenMucBUS>();

//builder.Services.AddTransient<ISanPhamRepository, SanPhamRepository>();
//builder.Services.AddTransient<ISanPhamBUS, SanPhamBUS>();

//builder.Services.AddTransient<ISizeRepository, SizeRepository>();
//builder.Services.AddTransient<ISizeBUS, SizeBUS>();


//// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
//builder.Services.AddEndpointsApiExplorer();
//builder.Services.AddSwaggerGen();

//var app = builder.Build();

//// Configure the HTTP request pipeline.
//if (app.Environment.IsDevelopment())
//{
//    app.UseSwagger();
//    app.UseSwaggerUI();
//}

//app.UseHttpsRedirection();

//app.UseAuthorization();

//app.MapControllers();

//app.Run();




using API_BTL.Services.VNPAY;
using BusinessLogicLayer;
using BusinessLogicLayer.Interfaces;
using DataAccessLayer;
using DataAccessLayer.Interfaces;
using DataModel;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using System.Text;

var builder = WebApplication.CreateBuilder(args);



builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", builder => builder.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader());
});
// Add services to the container.
builder.Services.AddTransient<IDatabaseHelper, DatabaseHelper>();

builder.Services.AddTransient<IKhachRepository, KhachRepository>();
builder.Services.AddTransient<IKhachBusiness, KhachBusiness>();

builder.Services.AddTransient<IHoaDonBanRepository, HoaDonBanRepository>();
builder.Services.AddTransient<IHoaDonBanBUS, HoaDonBanBUS>();

builder.Services.AddTransient<IUserRepository, UserRepository>();
builder.Services.AddTransient<BusinessLogicLayer.IUserBUS, BusinessLogicLayer.UserBUS>();

builder.Services.AddTransient<INhaPhanPhoiRepository, NhaPhanPhoiRepository>();
builder.Services.AddTransient<INhaPhanPhoiBUS, NhaPhanPhoiBUS>();

builder.Services.AddTransient<IHoaDonNhapRepository, HoaDonNhapRepository>();
builder.Services.AddTransient<IHoaDonNhapBUS, HoaDonNhapBUS>();

builder.Services.AddTransient<ChuyenMucRepository>();
builder.Services.AddTransient<ChuyenMucBUS>();

builder.Services.AddTransient<IDatHangRepository, DatHangRepository>();
builder.Services.AddTransient<IDatHangBusiness, DatHangBusiness>();

builder.Services.AddTransient<SanPhamRepository>();
builder.Services.AddTransient<SanPhamBUS>();

builder.Services.AddTransient<ISizeRepository, SizeRepository>();
builder.Services.AddTransient<ISizeBUS, SizeBUS>();

builder.Services.AddTransient<ThongKeDoanhThuRepository>();
builder.Services.AddTransient<ThongKeDoanhThuBUS>();

builder.Services.AddTransient<GiamGiaRepository>();
builder.Services.AddTransient<GiamGiaBUS>();

builder.Services.AddTransient<GiamGiaSanPhamRepository>();
builder.Services.AddTransient<GiamGiaSanPhamBUS>();

builder.Services.AddTransient<SanPhamChiTietRepository>();
builder.Services.AddTransient<SanPhamChiTietBUS>();
builder.Services.AddTransient<BaiVietRepository>();
builder.Services.AddTransient<BaiVietBus>();

builder.Services.AddTransient<IThongKeRepository, ThongKeRepository>();
builder.Services.AddTransient<IThongKeBUS, ThongKeBUS>();
builder.Services.AddTransient< ThanhToanRepository>();
builder.Services.AddTransient<ThanhToanBus>();

builder.Services.AddTransient<DanhGiaSanPhamRepository>();
builder.Services.AddTransient<DanhGiaSanPhamBUS>();


builder.Services.AddTransient<KhachHangDAL>();
builder.Services.AddTransient<KhachHangBUS>();
// configure strongly typed settings objects
IConfiguration configuration = builder.Configuration;
var appSettingsSection = configuration.GetSection("AppSettings");
builder.Services.Configure<AppSettings>(appSettingsSection);

// configure jwt authentication
var appSettings = appSettingsSection.Get<AppSettings>();
var key = Encoding.ASCII.GetBytes(appSettings.Secret);
builder.Services.AddAuthentication(x =>
{
    x.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    x.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
})
.AddJwtBearer(x =>
{
    x.RequireHttpsMetadata = false;
    x.SaveToken = true;
    x.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuerSigningKey = true,
        IssuerSigningKey = new SymmetricSecurityKey(key),
        ValidateIssuer = false,
        ValidateAudience = false
    };
});

// Add services to the container.
builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

//connet VNpay
builder.Services.AddScoped<IVnPayService, VnPayService>();

var app = builder.Build();
// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}
app.UseRouting();
app.UseCors(x => x
    .AllowAnyOrigin()
    .AllowAnyMethod()
    .AllowAnyHeader());
app.UseAuthentication();
app.UseAuthorization();
app.MapControllers();
app.Run();