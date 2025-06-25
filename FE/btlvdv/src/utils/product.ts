
//nhóm các sản phẩm có cùng tên, chỉ khác màu
export function nhomSanPhamTheoTenChinh(
    danhSachSanPham: any[]
  ): { tenChinh: string; sanPhams: any[] }[] {
    const getTenChinh = (tenSanPham: string): string =>
      tenSanPham.replace(/\sMàu.+$/, "").trim();
  
    const nhom: { [tenChinh: string]: any[] } = {};
  
    danhSachSanPham.forEach((sp) => {
      const tenChinh = getTenChinh(sp.tenSanPham);
      if (!nhom[tenChinh]) {
        nhom[tenChinh] = [];
      }
      nhom[tenChinh].push(sp);
    });
  
    return Object.entries(nhom).map(([tenChinh, sanPhams]) => ({
      tenChinh,
      sanPhams,
    }));
  }
  