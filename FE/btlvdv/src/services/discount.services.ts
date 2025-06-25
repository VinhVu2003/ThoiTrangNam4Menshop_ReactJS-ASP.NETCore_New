import { apiClient } from "../constant/api";

export const getAllGiamGiaSanPham = async (): Promise<any> => {  
  const res = await apiClient?.get(`api/GiamGiaSanPham/getall`);
  return res?.data;
};
export const get_all_Admin_GiamGia = async (): Promise<any> => {
  const res = await apiClient?.get(`api/GiamGia/get_all_Admin`);
  return res?.data;
};
export const updateGiamGia = async (data: any): Promise<any> => {
  const res = await apiClient?.put(`api/GiamGia/update`, data);
  return res?.data;
};
export const deleteGiamGia = async (id: number): Promise<any> => {
  const res = await apiClient?.delete(`api/GiamGia/delete/${id}`);
  return res?.data;
};

export const createGiamGia = async (data: any): Promise<any> => {
  const res = await apiClient?.post(`/api/GiamGia/insert`, data);
  return res?.data;
};
export const getListProInDiscount = async (id: number): Promise<any> => {
  const res = await apiClient?.get(`api/GiamGiaSanPham/GetListPro_InDiscount/${id}`);
  return res?.data;
};
export const getProductsNotInOtherDiscounts = async (id: number): Promise<any> => {
  const res = await apiClient?.get(`api/GiamGiaSanPham/LayDSSanPhamKhongThuocGiamGiaKhac/${id}`);
  return res?.data;
};

//Them moi ban ghi trong bảng SanPham_GiamGia
export const insertGiamGiaSanPham = async (data: any): Promise<any> => {
  const res = await apiClient?.post(`/api/GiamGiaSanPham/insert`, data);
  return res?.data;
};

//xóa theo mã giảm giá và mã sản phẩm
export const Delete_Input_GiamGiaId_SanPhamId = async (giamGiaId: number, sanPhamId: number): Promise<any> => {
  const res = await apiClient?.delete(`api/GiamGiaSanPham/Delete_GiamGiaId_SanPhamId/${giamGiaId}/${sanPhamId}`);
  return res?.data;
};


export const getAllGiamGia_DangHoatDong = async (): Promise<any> => {
  const res = await apiClient?.get(`api/GiamGia/get_all`);
  return res?.data;
};



