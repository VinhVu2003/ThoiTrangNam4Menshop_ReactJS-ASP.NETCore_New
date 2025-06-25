import { atom ,useSetRecoilState, useRecoilValue } from 'recoil';
export const cartState = atom({
  key: 'cartState',
  default: [],
});
export const ThongTinKhachHang = atom({
  key: 'ThongTinKhachHang',
  default: {tenKH:"Chưa đăng nhập"},
});
export const categoryState = atom({
  key: 'categoryState',
  default: { maChuyenMuc: null, tenChuyenMuc: null },
});
export const dataSearch = atom({
  key: 'dataSearch',
  default: [],
});
export const thongtinTK = atom({
  key: 'thongtinTK',
  default: {mataikhoan:null,
    taikhoan:null,
    matkhau:null,
  }
    
});

export const ThongKeDonHang = atom<any[]>({
  key: 'ThongKeDonHang',
  default: []
});

export const useThongKeDonHang = () => useRecoilValue(ThongKeDonHang);
export const useSetThongKeDonHang = () => useSetRecoilState(ThongKeDonHang);

export const useSetThongTinTK = () => {
  return useSetRecoilState(thongtinTK);
};