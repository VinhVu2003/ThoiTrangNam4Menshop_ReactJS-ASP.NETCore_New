import { apiClient } from "../constant/api";
import axios from 'axios';

export const ProductSearch = async (
    data: any,
  ): Promise<any> => {
    const res = await apiClient?.post(`/api/SanPham/search`, data);  
    return res?.data;
  };

export const GetAllProducts = async (): Promise<any> => {
    const res = await apiClient?.get(`api/SanPham/getall`);
    return res?.data;
};

export const GetProductById = async (id: string | number): Promise<any> => {
    const res = await apiClient?.get(`/api/SanPham/get/${id}`);
    return res?.data;
};

export const GetAllSizeByIdPro = async (id: string | number): Promise<any> => {
  const res = await apiClient?.get(`/api/SanPhamChiTiet/getallbymasp/${id}`);
  return res?.data;
};

export const AddViewProduct = async (id: string | number): Promise<any> => {
  const res = await apiClient?.put(`/api/SanPham/tangluotxem/${id}`);
  return res?.data;
};
export const GetALLByMaChuyenMuc = async (id: string | number): Promise<any> => {
  const res = await apiClient?.get(`/api/SanPham/GetByMaChuyenMuc/${id}`);
  return res?.data;
};
export const GetAllAvailableProducts = async (): Promise<any> => {
  const res = await apiClient?.get(`/api/SanPham/GetAllCoTrongKho`);
  return res?.data;
};
export const SearchSPNew = async (data: { page: string; pageSize: string }): Promise<any> => {
  const res = await apiClient?.post(`/api/SanPham/Search_SP_New`, data);
  return res?.data;
};
export const SearchSPBanChay = async (data: { page: string; pageSize: string }): Promise<any> => {
  const res = await apiClient?.post(`/api/SanPham/Search_SP_BanChay`, data);
  return res?.data;
};

export const GetAllProducttrongkhoAdmin = async (): Promise<any> => {
  const res = await apiClient?.get(`/api/SanPhamChiTiet/getallViewAdmin`);
  return res?.data;
};


export const SearchWithNameUser = async (data: { tenSanPham: string }): Promise<any> => {
  const res = await apiClient?.post(`/api/SanPham/searchWithName_User`, data);
  return res?.data;
};

export const UpdateProduct = async (data: any): Promise<any> => {
  const res = await apiClient?.put(`/api/SanPham/update`, data);
  return res?.data;
};
export const InsertProduct = async (data: any): Promise<any> => {
  const res = await apiClient?.post(`/api/SanPham/insert`, data);
  return res?.data;
};

export const DeleteProduct = async (id: string | number): Promise<any> => {
  const res = await apiClient?.delete(`/api/SanPham/delete/${id}`);
  return res?.data;
};


//thêm mới sản phẩm trong kho bảng SanPham_ChiTiet
export const InsertProInKho = async (data: any): Promise<any> => {
  const res = await apiClient?.post(`/api/SanPhamChiTiet/insert/`, data);
  return res?.data;
};

//cập nhật sản phẩm trong kho bảng SanPham_ChiTiet
export const UpdateProInKho = async (data: any): Promise<any> => {
  const res = await apiClient?.put(`/api/SanPhamChiTiet/update/`, data);
  return res?.data;
};

const API_URL = 'http://localhost:8080/api';

export const getProductsForDiscount = async () => {
  try {
    const response = await axios.get(`${API_URL}/products/for-discount`);
    return response.data;
  } catch (error) {
    throw error;
  }
};

export const getProductsByDiscountId = async (discountId: number) => {
  try {
    const response = await axios.get(`${API_URL}/products/by-discount/${discountId}`);
    return response.data;
  } catch (error) {
    throw error;
  }
};

export const updateProductsForDiscount = async (discountId: number, productIds: number[]) => {
  try {
    const response = await axios.post(`${API_URL}/products/update-discount`, {
      discountId,
      productIds
    });
    return response.data;
  } catch (error) {
    throw error;
  }
};
export const CongTraLaiSoLuongSP = async (productList: Array<{
  maSanPham: number;
  maSize: number;
  soLuong: number;
}>): Promise<any> => {
  try {
    const res = await apiClient?.put(`/api/SanPhamChiTiet/cong-soluong`, productList);
    return res?.data;
  } catch (error) {
    throw error;
  }
};
