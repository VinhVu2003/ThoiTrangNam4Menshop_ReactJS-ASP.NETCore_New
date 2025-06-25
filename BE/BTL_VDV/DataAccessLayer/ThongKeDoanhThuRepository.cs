using DataAccessLayer.Interfaces;
using DataModel;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer
{
    public class ThongKeDoanhThuRepository
    {
        public IDatabaseHelper _db;
        public ThongKeDoanhThuRepository(IDatabaseHelper db)
        {
            _db = db;
        }
        public List<DoanhThuTheoNgayModel> ThongKeDoanhThuTheoKhoang(DateTime fromDate, DateTime toDate)
        {
            string msgError = "";
            try
            {
                string sql = @"
                        WITH NgayDanhSach AS (
                            SELECT @FromDate AS Ngay
                            UNION ALL
                            SELECT DATEADD(DAY, 1, Ngay)
                            FROM NgayDanhSach
                            WHERE Ngay < @ToDate
                        )
                        SELECT 
                            ds.Ngay,
                            ISNULL(SUM(hd.TongGia), 0) AS DoanhThu
                        FROM NgayDanhSach ds
                        LEFT JOIN HoaDons hd ON CAST(hd.NgayTao AS DATE) = ds.Ngay AND hd.TrangThai = 5
                        GROUP BY ds.Ngay
                        ORDER BY ds.Ngay
                        OPTION (MAXRECURSION 1000);";

                var dt = _db.ExecuteQuery(sql, out msgError,
                    new SqlParameter("@FromDate", fromDate),
                    new SqlParameter("@ToDate", toDate));

                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);

                return dt.ConvertTo<DoanhThuTheoNgayModel>().ToList();
            }
            catch
            {
                throw;
            }
        }
        public List<DoanhThuTheoThangModel> ThongKeDoanhThuTheoThang(DateTime fromDate, DateTime toDate)
        {
            string msgError = "";
            string sql = @"
                WITH ThangNam AS (
                    SELECT 
                        DATEFROMPARTS(YEAR(@FromDate), MONTH(@FromDate), 1) AS ThangNam
                    UNION ALL
                    SELECT 
                        DATEADD(MONTH, 1, ThangNam)
                    FROM ThangNam
                    WHERE ThangNam < DATEFROMPARTS(YEAR(@ToDate), MONTH(@ToDate), 1)
                )
                SELECT 
                    YEAR(tn.ThangNam) AS Nam,
                    MONTH(tn.ThangNam) AS Thang,
                    ISNULL(SUM(cthd.TongGia), 0) AS DoanhThu
                FROM ThangNam tn
                LEFT JOIN HoaDons hd ON YEAR(hd.NgayTao) = YEAR(tn.ThangNam) AND MONTH(hd.NgayTao) = MONTH(tn.ThangNam)  AND hd.TrangThai = 5
                LEFT JOIN ChiTietHoaDons cthd ON hd.MaHoaDon = cthd.MaHoaDon
                GROUP BY YEAR(tn.ThangNam), MONTH(tn.ThangNam)
                ORDER BY Nam, Thang
                OPTION (MAXRECURSION 100)
                ";

            var dt = _db.ExecuteQuery(sql, out msgError,
                new SqlParameter("@FromDate", fromDate),
                new SqlParameter("@ToDate", toDate));

            if (!string.IsNullOrEmpty(msgError))
                throw new Exception(msgError);

            return dt.ConvertTo<DoanhThuTheoThangModel>().ToList();
        }

        public List<DoanhThuTheoNamModel> ThongKeDoanhThuTheoNam(DateTime fromDate, DateTime toDate)
        {
            string msgError = "";
            string sql = @"
        SELECT 
            YEAR(hd.NgayTao) AS Nam,
            SUM(cthd.TongGia) AS DoanhThu
                    FROM HoaDons hd
                    JOIN ChiTietHoaDons cthd ON hd.MaHoaDon = cthd.MaHoaDon
                    WHERE hd.NgayTao BETWEEN @FromDate AND @ToDate
                             AND hd.TrangThai = 5
                    GROUP BY YEAR(hd.NgayTao)
                    ORDER BY Nam;
              ";

            var dt = _db.ExecuteQuery(sql, out msgError,
                new SqlParameter("@FromDate", fromDate),
                new SqlParameter("@ToDate", toDate));

            if (!string.IsNullOrEmpty(msgError))
                throw new Exception(msgError);

            return dt.ConvertTo<DoanhThuTheoNamModel>().ToList();
        }

        public List<DonHangTheoTrangThaiModel> ThongKeDonHangTheoTrangThai()
        {
            string msgError = "";
            string sql = @"
                        SELECT 
                            TrangThai,
                            COUNT(*) AS SoLuongDon
                        FROM HoaDons
                        GROUP BY TrangThai";

            var dt = _db.ExecuteQuery(sql, out msgError);

            if (!string.IsNullOrEmpty(msgError))
                throw new Exception(msgError);

            return dt.ConvertTo<DonHangTheoTrangThaiModel>().ToList();
        }


        // Thống kê doanh thu theo sản phẩm
        public List<SanPhamBanChayModel> ThongKeSanPhamBanChay(DateTime fromDate, DateTime toDate, int top = 10)
        {
            string msgError = "";
            string sql = @"
            SELECT TOP(@Top) 
                sp.MaSanPham,
                sp.TenSanPham,
                SUM(cthd.SoLuong) AS SoLuongBanRa,
                SUM(cthd.TongGia) AS TongDoanhThu
            FROM ChiTietHoaDons cthd
            JOIN HoaDons hd ON cthd.MaHoaDon = hd.MaHoaDon
            JOIN SanPhams sp ON cthd.MaSanPham = sp.MaSanPham
            WHERE hd.NgayTao BETWEEN @FromDate AND @ToDate
              AND hd.TrangThai = 5
            GROUP BY sp.MaSanPham, sp.TenSanPham
            ORDER BY SoLuongBanRa DESC
        ";

            var dt = _db.ExecuteQuery(sql, out msgError,
                new SqlParameter("@FromDate", fromDate),
                new SqlParameter("@ToDate", toDate),
                new SqlParameter("@Top", top));

            if (!string.IsNullOrEmpty(msgError))
                throw new Exception(msgError);

            return dt.ConvertTo<SanPhamBanChayModel>().ToList();
        }

        // Thống kê doanh thu theo chuyên mục
        public List<DoanhThuTheoChuyenMucModel> ThongKeDoanhThuTheoChuyenMuc(DateTime fromDate, DateTime toDate)
        {
            string msgError = "";
            string sql = @"
            SELECT 
                cm.MaChuyenMuc,
                cm.TenChuyenMuc,
                SUM(cthd.SoLuong) AS SoLuongBanRa,
                SUM(cthd.TongGia) AS TongDoanhThu
            FROM ChiTietHoaDons cthd
            JOIN HoaDons hd ON cthd.MaHoaDon = hd.MaHoaDon
            JOIN SanPhams sp ON cthd.MaSanPham = sp.MaSanPham
            JOIN ChuyenMucs cm ON sp.MaChuyenMuc = cm.MaChuyenMuc
            WHERE hd.NgayTao BETWEEN @FromDate AND @ToDate
              AND hd.TrangThai = 5
            GROUP BY cm.MaChuyenMuc, cm.TenChuyenMuc
            ORDER BY TongDoanhThu DESC
        ";

            var dt = _db.ExecuteQuery(sql, out msgError,
                new SqlParameter("@FromDate", fromDate),
                new SqlParameter("@ToDate", toDate));

            if (!string.IsNullOrEmpty(msgError))
                throw new Exception(msgError);

            return dt.ConvertTo<DoanhThuTheoChuyenMucModel>().ToList();
        }


        public List<LoiNhuanTheoThoiGianModel> ThongKeLoiNhuanTheoNgay(DateTime fromDate, DateTime toDate)
        {
            string msgError = "";
            string sql = @"
                        SELECT 
                            CONVERT(varchar(10), CAST(hd.NgayTao AS DATE), 120) AS GiaiDoan,
                            SUM(cthd.TongGia) AS DoanhThu,
                            SUM(cthd.SoLuong * giaNhapTrungBinh.GiaNhapTB) AS GiaVon,
                            SUM(cthd.TongGia) - SUM(cthd.SoLuong * giaNhapTrungBinh.GiaNhapTB) AS LoiNhuan
                        FROM HoaDons hd
                        JOIN ChiTietHoaDons cthd ON hd.MaHoaDon = cthd.MaHoaDon
                        JOIN (
                            SELECT MaSanPham, 
                                CAST(SUM(GiaNhap * SoLuong) * 1.0 / NULLIF(SUM(SoLuong), 0) AS DECIMAL(18, 4)) AS GiaNhapTB
                            FROM ChiTietHoaDonNhaps
                            GROUP BY MaSanPham
                        ) AS giaNhapTrungBinh ON giaNhapTrungBinh.MaSanPham = cthd.MaSanPham
                        WHERE hd.NgayTao >= @fromDate AND hd.NgayTao < DATEADD(DAY, 1, @toDate)
                          AND hd.TrangThai = '5'
                        GROUP BY CAST(hd.NgayTao AS DATE)
                        ORDER BY giaiDoan;
                    ";

            var a = _db.ExecuteQuery(sql, out msgError,
                new SqlParameter("@fromDate", fromDate.Date),
                new SqlParameter("@toDate", toDate.Date)
            );

            if (!string.IsNullOrEmpty(msgError))
                throw new Exception(msgError);

            return a.ConvertTo<LoiNhuanTheoThoiGianModel>().ToList();
        }

        public List<LoiNhuanTheoThoiGianModel> ThongKeLoiNhuanTheoThang(DateTime fromDate, DateTime toDate)
        {
            string msgError = "";
            string sql = @"
                    SELECT 
                        CONVERT(varchar(7), hd.NgayTao, 120) AS GiaiDoan,
                        SUM(cthd.TongGia) AS DoanhThu,
                        SUM(cthd.SoLuong * giaNhapTrungBinh.GiaNhapTB) AS GiaVon,
                        SUM(cthd.TongGia) - SUM(cthd.SoLuong * giaNhapTrungBinh.GiaNhapTB) AS LoiNhuan
                    FROM HoaDons hd
                    JOIN ChiTietHoaDons cthd ON hd.MaHoaDon = cthd.MaHoaDon
                    JOIN (
                        SELECT MaSanPham, 
                            CAST(SUM(GiaNhap * SoLuong) * 1.0 / NULLIF(SUM(SoLuong), 0) AS DECIMAL(18, 4)) AS GiaNhapTB
                        FROM ChiTietHoaDonNhaps
                        GROUP BY MaSanPham
                    ) AS giaNhapTrungBinh ON giaNhapTrungBinh.MaSanPham = cthd.MaSanPham
                    WHERE hd.NgayTao BETWEEN @fromDate AND @toDate
                      AND hd.TrangThai = '5'
                    GROUP BY CONVERT(varchar(7), hd.NgayTao, 120)
                    ORDER BY GiaiDoan;
                ";

            var dt = _db.ExecuteQuery(sql, out msgError,
                new SqlParameter("@fromDate", fromDate.Date),
                new SqlParameter("@toDate", toDate.Date)
            );

            if (!string.IsNullOrEmpty(msgError))
                throw new Exception(msgError);

            return dt.ConvertTo<LoiNhuanTheoThoiGianModel>().ToList();
        }

        public List<LoiNhuanTheoSanPhamModel> ThongKeLoiNhuanTheoSanPham()
        {
            string msgError = "";
            string sql = @"
                        SELECT
                            sp.TenSanPham,
                            cthd.MaSanPham,
                            SUM(cthd.TongGia) AS DoanhThu,
                            SUM(cthd.SoLuong * giaNhapTrungBinh.GiaNhapTB) AS GiaVon,
                            SUM(cthd.TongGia) - SUM(cthd.SoLuong * giaNhapTrungBinh.GiaNhapTB) AS LoiNhuan
                        FROM HoaDons hd
                        JOIN ChiTietHoaDons cthd ON hd.MaHoaDon = cthd.MaHoaDon
                        JOIN SanPhams sp ON sp.MaSanPham = cthd.MaSanPham
                        JOIN (
                            SELECT MaSanPham, 
                                CAST(SUM(GiaNhap * SoLuong) * 1.0 / NULLIF(SUM(SoLuong), 0) AS DECIMAL(18,4)) AS GiaNhapTB
                            FROM ChiTietHoaDonNhaps
                            GROUP BY MaSanPham
                        ) AS giaNhapTrungBinh ON giaNhapTrungBinh.MaSanPham = cthd.MaSanPham
                        WHERE hd.TrangThai = '5'
                        GROUP BY cthd.MaSanPham, sp.TenSanPham
                        ORDER BY LoiNhuan DESC;
                    ";

            var dt = _db.ExecuteQuery(sql, out msgError);

            if (!string.IsNullOrEmpty(msgError))
                throw new Exception(msgError);

            return dt.ConvertTo<LoiNhuanTheoSanPhamModel>().ToList();
        }



        public List<TonKhoTheoDanhMucModel> ThongKeTonKhoTheoDanhMuc()
        {
            string msgError = "";
            string sql = @"
            SELECT 
                cm.MaChuyenMuc,
                cm.TenChuyenMuc,
                    SUM(ISNULL(spct.SoLuong, 0)) AS TongSoLuongTonKho
                FROM ChuyenMucs cm
                JOIN SanPhams sp ON sp.MaChuyenMuc = cm.MaChuyenMuc
                JOIN SanPhamChiTiet spct ON spct.MaSP = sp.MaSanPham
                WHERE sp.TrangThai = 1 AND spct.TrangThai = 1
                GROUP BY cm.MaChuyenMuc, cm.TenChuyenMuc
                ORDER BY TongSoLuongTonKho DESC;
            ";

            var data = _db.ExecuteQuery(sql, out msgError);

            if (!string.IsNullOrEmpty(msgError))
                throw new Exception(msgError);

            return data.ConvertTo<TonKhoTheoDanhMucModel>().ToList();
        }

    }
}
