import { apiClient } from "../constant/api";

export const getAllCategory = async (): Promise<any> => {  
  const res = await apiClient?.get(`/api/ChuyenMuc/ChuyenMuc_Getall`);
  return res?.data;
};