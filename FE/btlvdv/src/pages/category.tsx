import "../assets/css/aonam.css";
import { useRecoilValue } from "recoil";
import { categoryState } from "../constant/recoil";
import { useEffect, useState } from "react";
import axios from "axios";
import { Pagination } from "antd";
import { Link } from "react-router-dom";
import ScrollToTopButton from "../constant/ScrollToTopButton";
import { GetALLByMaChuyenMuc, SearchSPNew } from "../services/product.services";
import { IMAGE_BASE_PATH } from "../constant/imageBasePath ";

const Category = function () {
  const cate = useRecoilValue(categoryState);
  const [data, setData] = useState<any[]>([]);
  const [DataProductsNew, setDataProductsNew] = useState([]);
  const [currentPage, setCurrentPage] = useState(1);
  const [pageSize, setPageSize] = useState(10);
  const [totalItems, setTotalItems] = useState(0);

  async function loadData() {
    try {
      const response = await GetALLByMaChuyenMuc(cate.maChuyenMuc || 1);
      const activeProducts = response.filter(
        (product: any) => product.trangThai === true
      );

      console.log("pros chuyenmuc", response);
      setData(activeProducts);
      setTotalItems(response.length);
    } catch (error) {
      console.error("Error fetching data:", error);
    }
  }
  async function loadDataProductsNew() {
    try {
      const response = await SearchSPNew({ page: "1", pageSize: "4" });
      const uniqueProducts = response.data.reduce(
        (acc: any[], current: any) => {
          const x = acc.find((item) => item.tenSanPham === current.tenSanPham);
          if (!x) {
            return acc.concat([current]);
          } else {
            return acc;
          }
        },
        []
      );
      setDataProductsNew(uniqueProducts);
    } catch (error) {
      console.error("Error fetching data:", error);
    }
  }
  useEffect(() => {
    loadData();
    loadDataProductsNew();
  }, [cate]);

  const handlePageChange = (page: number, pageSize: number) => {
    setCurrentPage(page);
    setPageSize(pageSize);
  };

  // Tính toán dữ liệu hiển thị cho trang hiện tại
  const getCurrentPageData = () => {
    const startIndex = (currentPage - 1) * pageSize;
    const endIndex = startIndex + pageSize;
    return data.slice(startIndex, endIndex);
  };

  return (
    <>
      <ScrollToTopButton />
      <div className="cat_botom-head">
        <ul>
          <li>
            <a href="">4MEN &nbsp; / &nbsp;</a>
          </li>
          <li>
            <a href="">{cate.tenChuyenMuc}</a>
          </li>
        </ul>
      </div>
      <div className="cat_bottom">
        <div className="cat_botom-left">
          <h1>{cate.tenChuyenMuc}</h1>
        </div>
        <div className="cat_bottom-right">
          <ul>
            <li>
              <a href="">Lọc Danh Mục</a>
              <ul className="cat_sub-banner2ul">
                <li>
                  <a href="">Áo sơ mi</a>
                </li>
                <li>
                  <a href="">Áo thun</a>
                </li>
                <li>
                  <a href="">Áo polo</a>
                </li>
                <li>
                  <a href="">Áo khoác</a>
                </li>
                <li>
                  <a href="">Áo len</a>
                </li>
              </ul>
              <i className="cat_fa-solid fa-chevron-down" />
            </li>
            <li>
              <a href="">
                <span>
                  <img
                    src="./assets/anh/aonamicon.svg"
                    style={{ marginLeft: 17, width: 18, height: 18 }}
                  />{" "}
                </span>
              </a>
            </li>
            <li>
              <a href="">
                <span>
                  {" "}
                  <img
                    className="cat_aonamiconlogo"
                    src="./assets/anh/aonamicon2.svg"
                    style={{ marginLeft: 17, width: 18, height: 18 }}
                  />
                </span>
                <span>
                  {" "}
                  <img
                    className="cat_aonamicon2"
                    src="./assets/anh/aonamicon2.1.svg"
                  />
                </span>
              </a>
            </li>
          </ul>
        </div>
      </div>
      <div>
        <div className="cat_content-left">
          {data?.length === 0 ? (
            <div className="no-products-message" style={{ paddingTop: "20px" }}>
              Không có sản phẩm nào để hiển thị
            </div>
          ) : (
            getCurrentPageData().map(function (value: any, index: any) {
              return (
                <Link to={`/user/detail/${value.maSanPham}`}>
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
                          {/* <a href=""> */}
                          <img
                            src={
                              value?.anhDaiDien
                                ? IMAGE_BASE_PATH +
                                  value.anhDaiDien.split(",")[0].trim()
                                : ""
                            }
                          />

                          <div className="cat_overlayitem">
                            <span className="cat_overlayitemicon">
                              <i
                                className="fa-solid fa-cart-shopping"
                                style={{ color: "white" }}
                              />
                            </span>
                          </div>
                        </div>
                      </div>
                      <div className="cat_productimgsmall">
                        <a href="">
                          <img
                            src={
                              value?.anhDaiDien
                                ? IMAGE_BASE_PATH +
                                  value.anhDaiDien.split(",")[0].trim()
                                : ""
                            }
                            alt=""
                          />
                        </a>
                      </div>
                      <div
                        className="cat_producttext"
                        style={{ textAlign: "center" }}
                      >
                        <a
                          href=""
                          className="cat_spannote"
                          title={value.tenSanPham}
                          style={{ width: "100%" }}
                        >
                          {value.tenSanPham}
                        </a>
                      </div>
                      <div className="cat_protect-money">
                      <p style={{ color: "brown", textAlign: "center" }}>
                        {value?.giaTriGiam ? (
                          <>
                            <span style={{ color: "brown" }}>
                              {(
                                (value?.gia *
                                  (100 - value?.giaTriGiam)) /
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
                              {value?.gia?.toLocaleString(
                                "vi-VN",
                                {
                                  style: "currency",
                                  currency: "VND",
                                }
                              )}
                            </span>
                          </>
                        ) : (
                          value?.gia?.toLocaleString("vi-VN", {
                            style: "currency",
                            currency: "VND",
                          })
                        )}
                      </p>
                      </div>
                    </div>
                  </div>
                </Link>
              );
            })
          )}
          <div className="cat_like-share">
            <button>
              <i className="cat_fa-solid fa-thumbs-up" />
              Thích 711
            </button>
            <button id="share">Chia sẻ</button>
            <Pagination
              current={currentPage}
              total={totalItems}
              pageSize={pageSize}
              onChange={handlePageChange}
              style={{ textAlign: "center", marginTop: "20px" }}
            />
          </div>
        </div>
        <div className="cat_content-right">
          <div className="cat_div-search">
            <div>
              <span>
                <h5 style={{ fontSize: 14, color: "#666666" }}>
                  TÌM KIẾM{" "}
                  <hr
                    style={{
                      width: "75%",
                      float: "right",
                      padding: 0,
                      height: 1,
                      backgroundColor: "#cccccc",
                      border: 0,
                      marginTop: 8,
                    }}
                  />{" "}
                </h5>
                <br />
                <form action="" style={{ textAlign: "left" }}>
                  <label htmlFor="">Sản phẩm tại 4MEN</label>
                  <br />
                  <input type="text" placeholder="Từ khóa tìm kiếm" />
                  <button>
                    {" "}
                    <i
                      className="cat_fa-solid fa-magnifying-glass"
                      style={{ color: "gray" }}
                    />
                  </button>
                  {/* <i class="fa-solid fa-magnifying-glass"></i> */}
                </form>
              </span>
            </div>
          </div>
          <div className="cat_product-hot">
            <h5 style={{ fontSize: 14, color: "#666666" }}>
              SẢN PHẨM MỚI
              <hr
                style={{
                  width: "56%",
                  float: "right",
                  padding: 0,
                  height: 1,
                  backgroundColor: "#cccccc",
                  border: 0,
                  marginTop: 8,
                }}
              />{" "}
            </h5>
            {DataProductsNew.map(function (item: any, index: any) {
              return (
                <div className="cat_product-hot-content" key={index}>
                  <Link to={`/user/detail/${item.maSanPham}`}>
                    <div className="cat_div-img">
                      <img
                        src={
                          item?.anhDaiDien
                            ? IMAGE_BASE_PATH +
                              item.anhDaiDien.split(",")[0].trim()
                            : ""
                        }
                        alt=""
                      />
                    </div>
                    <div className="cat_div-information">
                      {item.tenSanPham}
                      <p style={{ color: "brown", fontSize: 16 }}>
                        {item.gia.toLocaleString("vi-VN", {
                          style: "currency",
                          currency: "VND",
                        })}
                      </p>
                    </div>
                  </Link>
                </div>
              );
            })}
          </div>
        </div>
      </div>
    </>
  );
};

export default Category;
