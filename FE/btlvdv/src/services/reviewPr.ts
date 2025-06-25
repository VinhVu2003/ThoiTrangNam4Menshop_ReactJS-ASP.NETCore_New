import { apiClient } from "../constant/api";

export const getAllReviewsByProductId = async (productId: number): Promise<any> => {
  const res = await apiClient?.get(`/api/DanhGiaSanPham/get-all/${productId}`);
  return res?.data;
};

export const APIcreateReview = async (data: any): Promise<any> => {
  const res = await apiClient?.post(`/api/DanhGiaSanPham/create`, data);
  return res?.data;
};
