import React from "react";
import { Link } from "react-router-dom";
import { IMAGE_BASE_PATH } from "../../constant/imageBasePath ";

type Product = {
  maSanPham: number;
  tenSanPham: string;
  gia: number;
  anhDaiDien: string;
  maSize?: string | null;
  tenSize?: string | null;
};

type Props = {
  group: {
    tenChinh: string;
    sanPhams: Product[];
  };
  addtoCart: (item: Product) => void;
  kiemTraGiamGia: (maSanPham: number) => boolean;
  layGiaTriGiam: (maSanPham: number) => number;
  tinhGiaSauGiam: (gia: number, maSanPham: number) => number;
};

const ProductGroupItem: React.FC<Props> = ({
  group, //danh sach san pham
  addtoCart,
  //   setCart,
  kiemTraGiamGia,
  layGiaTriGiam,
  tinhGiaSauGiam,
}) => {
  const mainProduct = group.sanPhams?.[0] || "null";
  console.log("itemcart", mainProduct);
  return (
    <div className="contentsmall">
      <div className="productimg">
          <Link to={`/user/detail/${mainProduct.maSanPham}`}>
        <div className="productimgpig">
            <img
              src={
                "/assets/anh/" + mainProduct?.anhDaiDien?.split(",")[0].trim()
              }
            />
          <div className="overlay" style={{ position: "absolute" }}>
            <div className="hoverlay-img">
              <a href="">
                <img
                  src={
                    "/assets/anh/" +
                     (
                      mainProduct?.anhDaiDien?.split(",")[1]?.trim() ||
                      mainProduct?.anhDaiDien?.split(",")[0]?.trim()
                    )
                  }
                  alt=""
                />
              </a>
            </div>
            
          </div>
          

          <div className="overlayitem">
            <span className="overlayitemicon">
              <i
                onClick={() => {
                  //   addtoCart(mainProduct);
                  console.log(mainProduct);
                  const list = JSON.parse(localStorage.getItem("cart") || "[]");
                  //   setCart(list);
                }}
                className="fa-solid fa-cart-shopping"
                style={{ color: "white", rotate: "-20deg" }}
              />
            </span>
          </div>
          {kiemTraGiamGia(mainProduct.maSanPham) && (
            <div className="overlayitem-new-2">
              <span className="overlayitemicon-new">
                -{layGiaTriGiam(mainProduct.maSanPham)}%
              </span>
            </div>
          )}
        </div>
                      </Link>

        <div className="productimgsmall">
          {group?.sanPhams?.slice(0, 4).map((product, idx) => (
            <Link key={idx} to={`/user/detail/${product.maSanPham}`}>
              <img
                src={
                  IMAGE_BASE_PATH + product?.anhDaiDien?.split(",")[0].trim()
                }
              />
            </Link>
          ))}
        </div>

        <div className="producttext">
          <a
            href={`/user/detail/${mainProduct.maSanPham}`}
            className="spannote"
            title={mainProduct.tenSanPham}
          >
            {mainProduct.tenSanPham}
          </a>
        </div>

        <div className="protect-money">
          {kiemTraGiamGia(mainProduct.maSanPham) ? (
            <p>
              <span style={{ color: "brown" }}>
                {tinhGiaSauGiam(
                  mainProduct.gia,
                  mainProduct.maSanPham
                )?.toLocaleString("vi-VN", {
                  style: "currency",
                  currency: "VND",
                })}
              </span>
              <span
                style={{
                  textDecoration: "line-through",
                  fontSize: "0.8em",
                  color: "#666",
                  marginLeft: "5px",
                }}
              >
                {mainProduct.gia?.toLocaleString("vi-VN", {
                  style: "currency",
                  currency: "VND",
                })}
              </span>
            </p>
          ) : (
            <p>
              {mainProduct.gia?.toLocaleString("vi-VN", {
                style: "currency",
                currency: "VND",
              })}
            </p>
          )}
        </div>
      </div>
    </div>
  );
};

export default ProductGroupItem;
