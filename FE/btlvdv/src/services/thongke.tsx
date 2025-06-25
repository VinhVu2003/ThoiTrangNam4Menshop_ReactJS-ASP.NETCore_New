import { apiClient } from "../constant/api";

export const getDonHangTheoTrangThai = async (): Promise<any> => {
  try {
    const res = await apiClient?.get(`/api/ThongKeDoanhThu/don-hang-theo-trang-thai`);
    return res?.data;
  } catch (error) {
    console.error("Error fetching order status statistics:", error);
    throw error;
  }
};
