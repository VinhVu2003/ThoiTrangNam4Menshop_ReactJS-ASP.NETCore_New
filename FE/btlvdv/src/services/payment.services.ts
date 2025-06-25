import { apiClient } from "../constant/api";
export const CreatePaymentUrlVnpay = async (
  data: {
    orderType: string;
    amount: number;
    orderDescription: string;
    name: string;
  }
): Promise<any> => {
  const res = await apiClient?.post(`/api/Payment/CreatePaymentUrlVnpay`, data);
  return res?.data;
};

export const InsertPaymentVnpay = async (data: any): Promise<any> => {
  const res = await apiClient?.post(`/api/ThanhToan/create`, data);
  return res?.data;
};
