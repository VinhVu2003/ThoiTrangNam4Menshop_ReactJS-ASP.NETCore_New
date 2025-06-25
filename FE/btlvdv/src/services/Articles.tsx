import { apiClient } from "../constant/api";
export const createArticle = async (data: any): Promise<any> => {
  const res = await apiClient?.post(`/api/BaiViet/create`, data);
  return res?.data;
};
export const getAllArticles = async (): Promise<any> => {
  const res = await apiClient?.get(`/api/BaiViet/get-all`);
  return res?.data;
};
export const deleteArticle = async (id: number): Promise<any> => {
  const res = await apiClient?.delete(`/api/BaiViet/delete?id=${id}`);
  return res?.data;
};

