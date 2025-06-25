// import axios from 'axios';

// export const GetProvinces = async (): Promise<any> => {
//   try {
//     const res = await axios.get('https://provinces.open-api.vn/api/?depth=2');
//     return res?.data;
//   } catch (error) {
//     console.error("Error while fetching provinces:", error);
//     throw error;
//   } 
// };
// export const GetDistricts = async (provinceCode: string): Promise<any> => {
//   try {
//     const res = await axios.get(`https://provinces.open-api.vn/api/p/${provinceCode}?depth=2`);
//     console.log(res?.data);
//     return res?.data.districts;
//   } catch (error) {
//     console.error("Error while fetching districts:", error);
//     throw error;
//   }
// };
// export const GetWards = async (districtCode: string): Promise<any> => {
//   try {
//     const res = await axios.get(`https://provinces.open-api.vn/api/d/${districtCode}?depth=2`);
//     return res?.data.wards;
//   } catch (error) {
//     console.error("Error while fetching wards:", error);
//     throw error;
//   }
// };










import provincesData from '../asrc2/data/vietnam-provinces.json'; // Đường dẫn tương ứng với nơi bạn để file JSON

export const GetProvinces = async (): Promise<any> => {
  try {
    // Trả về toàn bộ danh sách tỉnh thành từ file JSON
    return provincesData;
  } catch (error) {
    console.error("Error while fetching provinces:", error);
    throw error;
  }
};

export const GetDistricts = async (provinceCode: string): Promise<any> => {
  try {
    // Tìm tỉnh theo code
    const province = provincesData.find((p: any) => p.code === provinceCode);
    if (!province) throw new Error("Province not found");
    return province.districts;
  } catch (error) {
    console.error("Error while fetching districts:", error);
    throw error;
  }
};

export const GetWards = async (districtCode: string): Promise<any> => {
  try {
    // Tìm quận/huyện trong tất cả tỉnh
    let wards: any[] = [];
    for (const province of provincesData) {
      const district = province.districts.find((d: any) => d.code === districtCode);
      if (district) {
        wards = district.wards;
        break;
      }
    }
    if (wards.length === 0) throw new Error("District not found");
    return wards;
  } catch (error) {
    console.error("Error while fetching wards:", error);
    throw error;
  }
};

