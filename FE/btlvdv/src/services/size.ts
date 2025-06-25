
import { apiClient } from "../constant/api";

export const getAllSize = async (): Promise<any> => {
  const res = await apiClient?.get(`api/SizeCotroller/getall`);
  return res?.data;
};

export const searchSize = async (page: string, pageSize: string): Promise<any> => {
  const res = await apiClient?.post(`api/SizeCotroller/Size_Search`, {
    page,
    pageSize
  });
  return res?.data;
};
