import { Link } from "react-router-dom";
import { IMAGE_BASE_PATH } from "../../constant/imageBasePath ";
import "../../assets/css/aonam.css";

const ProItemCard: React.FC<any> = ({ value, index }) => {
  return (
    <div className="cat_contentsmall" key={index}>
      <div className="cat_productimg">
        <div className="cat_productimgpig">
          <div
            style={{
              width: "100%",
              height: "100%",
              position: "absolute",
            }}
          >
            <a href="">
              <img
                src={
                  IMAGE_BASE_PATH +
                  value?.sanPhams?.[0]?.anhDaiDien?.split(",")?.[0]?.trim()
                }
                alt=""
              />
            </a>
            <div className="cat_overlay" style={{ position: "absolute" }}>
              <div className="cat_hoverlay-img">
                <a href="">
                  <img
                    src={
                      IMAGE_BASE_PATH +
                      (value?.sanPhams?.[0]?.anhDaiDien
                        ?.split(",")[1]
                        ?.trim() ||
                        value?.sanPhams?.[0]?.anhDaiDien?.split(",")[0]?.trim())
                    }
                    alt=""
                  />
                </a>
              </div>
            </div>
            <div className="cat_overlayitem">
              <span className="cat_overlayitemicon">
                <i
                  className="fa-solid fa-cart-shopping"
                  style={{ color: "white" }}
                />
              </span>
            </div>
            {value?.sanPhams[0]?.giaTriGiam && (
              <div className="overlayitem-new-2">
                <span className="overlayitemicon-new">
                  -{value?.sanPhams[0]?.giaTriGiam}%
                </span>
              </div>
            )}
          </div>
        </div>
        <div className="cat_productimgsmall">
          {value?.sanPhams?.slice(0, 4).map((product: any, idx: any) => (
            <Link key={idx} to={`/user/detail/${product.maSanPham}`}>
              <img
                src={
                  IMAGE_BASE_PATH + product?.anhDaiDien?.split(",")[0].trim()
                }
                alt=""
              />
            </Link>
          ))}
        </div>
        <div className="cat_producttext" style={{ textAlign: "center" }}>
          <a
            ng-click="product(x)"
            href=""
            className="cat_spannote"
            title="Áo Khoác Dạ Regular Phối sọc AK405 Màu Be"
            style={{ width: "100%" }}
          >
            {value?.sanPhams[0]?.tenSanPham}
          </a>
        </div>
        <div className="cat_protect-money">
          <p style={{ color: "brown", textAlign: "center" }}>
            {value?.sanPhams[0]?.giaTriGiam ? (
              <>
                <span style={{ color: "brown" }}>
                  {(
                    (value?.sanPhams[0]?.gia *
                      (100 - value?.sanPhams[0]?.giaTriGiam)) /
                    100
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
                  {value?.sanPhams[0]?.gia?.toLocaleString("vi-VN", {
                    style: "currency",
                    currency: "VND",
                  })}
                </span>
              </>
            ) : (
              value?.sanPhams[0]?.gia?.toLocaleString("vi-VN", {
                style: "currency",
                currency: "VND",
              })
            )}
          </p>
        </div>
      </div>
    </div>
  );
};
export default ProItemCard;
