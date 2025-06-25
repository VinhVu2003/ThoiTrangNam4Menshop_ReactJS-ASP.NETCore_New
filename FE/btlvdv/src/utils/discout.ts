// src/hooks/useGiamGiaSanPham.ts
import { useEffect, useState } from "react";
import { getAllGiamGiaSanPham } from "../services/discount.services";

export function useGiamGiaSanPham() {
  const [danhSachGiamGia, setDanhSachGiamGia] = useState<any[]>([]);

  useEffect(() => {
    const fetchDiscounts = async () => {
      try {
        const response = await getAllGiamGiaSanPham();
        setDanhSachGiamGia(response);
      } catch (error) {
        console.error("Error fetching discounts:", error);
      }
    };
    fetchDiscounts();
  }, []);

  // Hàm kiểm tra sản phẩm có được giảm giá không
  const kiemTraGiamGia = (maSanPham: number) => {
    const giamGia = danhSachGiamGia.find((item) => item.sanPhamId === maSanPham);
    return giamGia && giamGia.dangHoatDong === true;
  };

  // Hàm lấy giá trị giảm giá
  const layGiaTriGiam = (maSanPham: number) => {
    const giamGia = danhSachGiamGia.find((item) => item.sanPhamId === maSanPham);
    return giamGia ? giamGia.giaTriGiam : 0;
  };

  // Hàm tính giá sau khi giảm giá
  const tinhGiaSauGiam = (giaGoc: number, maSanPham: number) => {
    const giamGia = danhSachGiamGia.find((item) => item.sanPhamId === maSanPham);
    if (giamGia && giamGia.dangHoatDong === true) {
      return giaGoc * (1 - giamGia.giaTriGiam / 100);
    }
    return giaGoc;
  };

  return { danhSachGiamGia, kiemTraGiamGia, layGiaTriGiam, tinhGiaSauGiam };
}
