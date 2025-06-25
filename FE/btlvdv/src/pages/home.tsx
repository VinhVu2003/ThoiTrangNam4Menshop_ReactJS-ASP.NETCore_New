import "../assets/css/trangchu.css";

import a from "../assets/anh/slideshow1.jpg";
import imgmid1 from "../assets/anh/productbannerleft.jpg";
import imgmid2 from "../assets/anh/productbannermid.jpg";
import imgmid3 from "../assets/anh/productbannerright.jpg";
import axios from "axios";
import { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import { useRecoilCallback, useRecoilState } from "recoil";
import { cartState } from "../constant/recoil";
import { addtoCart } from "../utils/cart";
import ScrollToTopButton from "../constant/ScrollToTopButton";
import { getAllGiamGiaSanPham } from "../services/discount.services";
import { GetAllAvailableProducts, SearchSPBanChay, SearchSPNew } from "../services/product.services";
import ProductGroupItem from "../shared/user/ProductGroupItem";
import { nhomSanPhamTheoTenChinh } from "../utils/product";
// import '../assets/js/trangchu.js'
const Home = function () {
  // Khai báo kiểu dữ liệu rõ ràng cho state data
  const [data, setData] = useState<any[]>([]);
  const [DataProductsNew, setDataProductsNew] = useState<any[]>([]);
  const [DataProductsSelling, setDataProductsSelling] =  useState<any[]>([]);

  const [danhSachGiamGia, setDanhSachGiamGia] = useState<any[]>([]); 
  const [currentIndex, setCurrentIndex] = useState(0);

  useEffect(() => {
    const fetchDiscounts = async () => {
      try {
        const response = await getAllGiamGiaSanPham();
        setDanhSachGiamGia(response); // Lưu toàn bộ dữ liệu giảm giá
        console.log(response);
      } catch (error) {
        console.error("Error fetching discounts:", error);
      }
    };
    fetchDiscounts();
  }, []);

  async function loadData() {
    try {
      const response = await GetAllAvailableProducts();
      const activeProducts = response.filter((product: any) => product.trangThai === true);

      console.log("ds Product", response);

      // Áp dụng hàm nhóm sản phẩm và lưu vào state data
      const groupedData = nhomSanPhamTheoTenChinh(activeProducts);
      console.log("locsp", groupedData);
      setData(groupedData); // <<< Lưu dữ liệu đã nhóm vào state data
    } catch (error) {
      console.error("Error fetching data:", error);
    }
  }
  async function loadDataProductsNew() {
    try {
      const response = await SearchSPNew({ page: "1", pageSize: "8" });
      const uniqueProducts = response.data.reduce((acc: any[], current: any) => {
        const x = acc.find(item => item.maSanPham === current.maSanPham);
        if (!x) {
          return acc.concat([current]);
        } else {
          return acc;
        }
      }, []);
      response.data = uniqueProducts;
      const groupedData = nhomSanPhamTheoTenChinh(response.data);

      setDataProductsNew(groupedData);
    } catch (error) {
      console.error("Error fetching data:", error);
    }
  }
  async function loadDataProductsSelling() {
    try {
      const response = await SearchSPBanChay({ page: "1", pageSize: "4" });
      const groupedData = nhomSanPhamTheoTenChinh(response.data);

      setDataProductsSelling(groupedData);
      
    } catch (error) {
      console.error("Error fetching data:", error);
    }
  }
  useEffect(() => {
    loadData();
    loadDataProductsNew();
    loadDataProductsSelling();
  }, []);
  

  // Hàm kiểm tra sản phẩm có được giảm giá không
  const kiemTraGiamGia = (maSanPham: number) => {
    const giamGia = danhSachGiamGia.find(
      (item) => item.sanPhamId === maSanPham
    );
    return giamGia && giamGia.dangHoatDong === true;
  };
  // Hàm lấy giá trị giảm giá
  const layGiaTriGiam = (maSanPham: number) => {
    const giamGia = danhSachGiamGia.find(
      (item) => item.sanPhamId === maSanPham
    );
    return giamGia ? giamGia.giaTriGiam : 0;
  };
  // Hàm tính giá sau khi giảm giá
  const tinhGiaSauGiam = (giaGoc: number, maSanPham: number) => {
    const giamGia = danhSachGiamGia.find(
      (item) => item.sanPhamId === maSanPham
    );
    if (giamGia && giamGia.dangHoatDong === true) {
      return giaGoc * (1 - giamGia.giaTriGiam / 100);
    }
    return giaGoc;
  };

  const handlePrev = () => {
    setCurrentIndex(prev => (prev > 0 ? prev - 1 : prev));
  };

  const handleNext = () => {
    setCurrentIndex(prev => (prev < DataProductsNew.length - 4 ? prev + 1 : prev));
  };

  return (
    <>
      <ScrollToTopButton />
      <div className="slideshow">
        <a href="">
          <img id="img" src={a} alt="" />
        </a>
        <button className="dieuhuong-left">
          <i className="fa-solid fa-chevron-left" />
        </button>
        <button className="dieuhuong-right">
          <i className="fa-solid fa-chevron-right" />
        </button>
      </div>
    
      <div className="content">
        <div className="product-hot">
          <h5 className="fashion-most-hot">thời trang 4menshop</h5>

          {data.slice(0,8).map(function (values: any, index:any) {
            return (
              <ProductGroupItem
              key={index}
              group={values}
              addtoCart={addtoCart}
              // setCart={setCart}
              kiemTraGiamGia={kiemTraGiamGia}
              layGiaTriGiam={layGiaTriGiam}
              tinhGiaSauGiam={tinhGiaSauGiam}
            />
            );
          })}
          <div id="CuaSo_SP">
            <div id="CuaSo_SP_DIV_IMG"></div>
          </div>
        </div>
        {/* ----------------------------------------------------------------------------------------------------------------- */}
        <div className="productbannermid">
          <div className="imgleft">
            <a href="" className="img1">
              <img src={imgmid1} alt="" />
            </a>
          </div>
          <div className="imgmid">
            <a href="" className="img2">
              <img src={imgmid2} alt="" />
            </a>
          </div>
          <div className="imgright">
            <a href="" className="img3">
              <img src={imgmid3} alt="" />
            </a>
          </div>
        </div>
        {/* ----------------------------------------------------------------------------------------------------------------------- */}
        <div className="product-new">
          <h5 className="fashion-most-new">thời trang bán chạy</h5>
          <div className="product-new-content">
            {DataProductsSelling.map(function (value: any, index) {
              return (
                <ProductGroupItem
                key={index}
                group={value}
                addtoCart={addtoCart}
                // setCart={setCart}
                kiemTraGiamGia={kiemTraGiamGia}
                layGiaTriGiam={layGiaTriGiam}
                tinhGiaSauGiam={tinhGiaSauGiam}
              />
              );
            })}
          </div>
        </div>
        {/* ------------------------------------------------------------------------------------------------------------------------------- */}
        <div className="product-selling">
          <h5 className="fashion-most-selling" style={{ textAlign: "center" }}>
            thời trang mới nhất
          </h5>
          <div className="product-selling-content" style={{ position: "relative" }}>
            {DataProductsNew.slice(currentIndex, currentIndex + 4).map(function (value: any, index: any) {
              return (
                <ProductGroupItem
                  key={index}
                  group={value}
                  addtoCart={addtoCart}
                  kiemTraGiamGia={kiemTraGiamGia}
                  layGiaTriGiam={layGiaTriGiam}
                  tinhGiaSauGiam={tinhGiaSauGiam}
                />
              );
            })}
            <button 
              onClick={handlePrev}
              style={{
                position: "absolute",
                left: "-20px",
                top: "50%",
                transform: "translateY(-50%)",
                backgroundColor: "white",
                border: "2px solid #333",
                borderRadius: "50%",
                width: "40px",
                height: "40px",
                cursor: "pointer",
                display: "flex",
                alignItems: "center",
                justifyContent: "center",
                fontSize: "24px",
                fontWeight: "bold",
                color: "#000",
                opacity: currentIndex === 0 ? 0 : 0,
                pointerEvents: currentIndex === 0 ? "none" : "auto",
                boxShadow: "0 2px 4px rgba(0,0,0,0.1)",
                transition: "opacity 0.3s ease"
              }}
              onMouseEnter={(e) => e.currentTarget.style.opacity = "1"}
              onMouseLeave={(e) => e.currentTarget.style.opacity = "0"}
            >
              ‹
            </button>
            <button 
              onClick={handleNext}
              style={{
                position: "absolute",
                right: "-20px",
                top: "50%",
                transform: "translateY(-50%)",
                backgroundColor: "white",
                border: "2px solid #333",
                borderRadius: "50%",
                width: "40px",
                height: "40px",
                cursor: "pointer",
                display: "flex",
                alignItems: "center",
                justifyContent: "center",
                fontSize: "24px",
                fontWeight: "bold",
                color: "#000",
                opacity: currentIndex >= DataProductsNew.length - 4 ? 0 : 0,
                pointerEvents: currentIndex >= DataProductsNew.length - 4 ? "none" : "auto",
                boxShadow: "0 2px 4px rgba(0,0,0,0.1)",
                transition: "opacity 0.3s ease"
              }}
              onMouseEnter={(e) => e.currentTarget.style.opacity = "1"}
              onMouseLeave={(e) => e.currentTarget.style.opacity = "0"}
            >
              ›
            </button>
          </div>
        </div>
        {/* - -------------------------------------------------------------------------------------------------------------------*/}
        <div className="footer1">
          <div className="footer1-a">
            <div className="footer1-content">
              <a href="">
                <i
                  style={{ transform: "rotate(-25deg)", fontSize: 35 }}
                  className="fa fa-plane"
                  aria-hidden="true"
                />
              </a>
              <h4>Thanh toán &amp; giao hàng</h4>
              <p>
                Miễn phí vận chuyển cho đơn hàng trên 499.000 VNĐ
                <br />
                - Giao hàng và thu tiền tận nơi
                <br />
                - Chuyển khoản và giao hàng
                <br />- Mua hàng tại shop
              </p>
            </div>
          </div>
          <div className="footer1-a">
            <div className="footer1-content">
              <a href="">
                <i
                  style={{ fontSize: 35 }}
                  className="fa fa-credit-card"
                  aria-hidden="true"
                />
              </a>
              <h4>Thẻ thành viên</h4>
              <p>
                Ché độ ưu đãi thành viên VIP:
                <br />
                - 5% cho thành viên Bạc
                <br />
                - 10% cho thành viên Vàng
                <br />- 15% cho thành viên Kim cương
              </p>
            </div>
          </div>
          <div className="footer1-a">
            <div className="footer1-content">
              <a href="">
                <i
                  style={{ fontSize: 35 }}
                  className="fa-regular fa-clock"
                  aria-hidden="true"
                />
              </a>
              <h4>Giờ mở cửa</h4>
              <p>
                8h30 đến 22:00
                <br />
                - Tất cả các ngày trong tuần
                <br />
                Áp dụng cho tất cả các chi nhánh hệ thông cửa hàng 4MEN
              </p>
            </div>
          </div>
          <div className="footer1-a">
            <div className="footer1-content">
              <a href="">
                <i
                  style={{ fontSize: 35 }}
                  className="fa fa-headphones"
                  aria-hidden="true"
                />
              </a>
              <h4>Hỗ trợ 24/7</h4>
              <p>
                Gọi ngay cho chúng tôi khi bạn có thắc mắc
                <br />- 0868.444.644
              </p>
            </div>
          </div>
        </div>
        {/* ------------------------------------------------------------------------------- */}
      </div>
    </>
  );
};
export default Home;
