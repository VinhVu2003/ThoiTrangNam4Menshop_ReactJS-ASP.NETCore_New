import { useRecoilState } from "recoil";
import "../assets/css/aonam.css";
import { dataSearch } from "../constant/recoil";
import { useEffect, useState } from "react";
import axios from "axios";
import { Pagination, Slider, Select } from "antd";
import { Link } from "react-router-dom";
import ScrollToTopButton from "../constant/ScrollToTopButton";
import { SearchWithNameUser } from "../services/product.services";
import { nhomSanPhamTheoTenChinh } from "../utils/product";
import ProItemCard from "../shared/user/ProItemCard";
import { IMAGE_BASE_PATH } from "../constant/imageBasePath ";
import { getAllCategory } from "../services/category";
const Search = function () {
  const [dtaSearch, setDataSearch] = useRecoilState<any>(dataSearch);
  const [data, setData] = useState<any[]>([]);
  const [DataProductsNew, setDataProductsNew] = useState([]);
  const [priceRange, setPriceRange] = useState<[number, number]>([0, 10000000]);
  const [selectedCategory, setSelectedCategory] = useState<string>("");
  const [sortOrder, setSortOrder] = useState<string>("");
  const [categories, setCategories] = useState<any[]>([]);

  const [pagedb, setPagedb] = useState<number>(1);
  const [pageSizedb, setPageSizedb] = useState<number>(9);
  const [totalProductsdb, setTotalProductsdb] = useState<number>(0);

  async function loadData() {
    try {
      const response = await SearchWithNameUser({
        tenSanPham: dtaSearch || "",
      });
      console.log("danhsachsanphamsearch", response);
      if (response && Array.isArray(response)) {
        const activeProducts = response.filter(
          (product: any) => product.trangThai === true
        );
        console.log("locsp", activeProducts);
        setData(activeProducts);
        setTotalProductsdb(activeProducts.length);
      }
    } catch (error) {
      console.error("Error fetching data:", error);
      setData([]);
      setTotalProductsdb(0);
    }
  }
  async function loadDataProductsNew() {
    try {
      const response = await axios.post(
        "https://localhost:44381/api/SanPham/Search_SP_New",
        {
          page: "1",
          pageSize: "100",
        }
      );
      // console.log(response.data.data);
      const data = response.data.data;
      const uniqueProducts = data.filter(
        (product: any, index: any, array: any) =>
          index ===
          array.findIndex(
            (
              p: any //sẽ tìm chỉ mục của sản phẩm đầu tiên trong mảng
            ) => p.tenSanPham === product.tenSanPham //(array), có cùng tenSanPham với sản phẩm hiện tại (product).
          )
      );
      const firstEightProducts = uniqueProducts.slice(0, 4);
      setDataProductsNew(firstEightProducts);
    } catch (error) {
      console.error("Error fetching data:", error);
    }
  }
  useEffect(() => {
    loadData();
  }, [dtaSearch]);
  useEffect(() => {
    loadDataProductsNew();
  }, []);
  const handlePageChange = (currentPage: number) => {
    setPagedb(currentPage);
  };

  const handlePriceChange = (value: number[]) => {
    setPriceRange([value[0], value[1]]);
  };

  const loadCategories = async () => {
    try {
      const response = await getAllCategory();
      if (response) {
        setCategories(response);
      }
    } catch (error) {
      console.error("Error loading categories:", error);
    }
  };

  useEffect(() => {
    loadCategories();
  }, []);

  const filteredProducts = data
    .filter(product => {
      const price = product.gia;
      const categoryMatch = !selectedCategory || product.maChuyenMuc === parseInt(selectedCategory);
      return price >= priceRange[0] && price <= priceRange[1] && categoryMatch;
    })
    .sort((a, b) => {
      if (sortOrder === "desc") {
        return b.gia - a.gia;
      } else if (sortOrder === "asc") {
        return a.gia - b.gia;
      }
      return 0;
    });

  return (
    <>
      <ScrollToTopButton />
      <div className="cat_botom-head">
        <ul>
          <li>
            <a href="">4MEN &nbsp; / &nbsp;</a>
          </li>
          <li>
            <a href="">Tìm kiếm sản phẩm</a>
          </li>
        </ul>
      </div>
      <div className="cat_bottom">
        <div className="cat_botom-left">
          <h1>Tìm kiếm sản phẩm</h1>
        </div>
        <div className="cat_bottom-right">
          <ul>
            
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
          <div style={{ paddingBottom: "10px", marginLeft: "10px" }}>
            <input
              value={dtaSearch}
              type="text"
              placeholder="Tìm kiếm"
              style={{ padding: 5, width: 400 }}
              className="ng-pristine ng-valid ng-empty ng-touched"
              onChange={(e) => setDataSearch(e.target.value)}
            />
            <button
              style={{
                padding: 5,
                position: "absolute",
                left: 420,
                backgroundColor: "#ffffff",
                border: 0,
                marginTop: 2,
              }}
            >
              <i className="fa-solid fa-magnifying-glass" />
            </button>
          </div>
          {filteredProducts?.length === 0 ? (
            <div className="no-products-message" style={{ paddingTop: "20px" }}>
              Không có sản phẩm nào để hiển thị
            </div>
          ) : (
            filteredProducts
              .slice((pagedb - 1) * pageSizedb, pagedb * pageSizedb)
              .map(function (value: any, index: any) {
                return (
                  <Link key={index} to={`/user/detail/${value.maSanPham}`}>
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
                            <img
                              src={
                                value?.anhDaiDien
                                  ? IMAGE_BASE_PATH +
                                    value.anhDaiDien.split(",")[0].trim()
                                  : ""
                              }
                            />
                            <div
                              className="cat_overlay"
                              style={{ position: "absolute" }}
                            >
                              <div className="cat_cat_hoverlay-img">
                                <a href="">
                                  <img
                                    src={
                                      "/assets/anh/" +
                                      (value?.anhDaiDien
                                        ?.split(",")[1]
                                        ?.trim() ||
                                        value?.anhDaiDien
                                          ?.split(",")[0]
                                          ?.trim())
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
                            {value?.giaTriGiam && (
                              <div className="cat_overlayitem-new-2">
                                <span className="cat_overlayitemicon-new">
                                  -{value?.giaTriGiam}%
                                </span>
                              </div>
                            )}
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
                                    (value?.gia * (100 - value?.giaTriGiam)) /
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
                                  {value?.gia?.toLocaleString("vi-VN", {
                                    style: "currency",
                                    currency: "VND",
                                  })}
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
            {/* <button>
              <i className="cat_fa-solid fa-thumbs-up" />
              Thích 711
            </button>
            <button id="share">Chia sẻ</button> */}
            <Pagination
              current={pagedb}
              total={totalProductsdb}
              pageSize={pageSizedb}
              onChange={handlePageChange}
              style={{ textAlign: "center" }}
            />
          </div>
        </div>

        <div className="cat_content-right">
          <div className="cat_price-filter" style={{ padding: '15px', backgroundColor: '#fff', borderRadius: '4px' }}>
            <h5 style={{ fontSize: 14, color: "#666666", marginBottom: '15px' }}>
              LỌC THEO DANH MỤC
              <hr
                style={{
                  width: "56%",
                  float: "right",
                  padding: 0,
                  height: 1,
                  backgroundColor: "#cccccc",
                  border: 0,
                }}
              />
            </h5>
            <Select
              style={{ width: '100%', marginBottom: '15px' }}
              placeholder="Chọn danh mục"
              value={selectedCategory}
              onChange={setSelectedCategory}
              allowClear
            >
              {categories.map((category) => (
                <Select.Option key={category.maChuyenMuc} value={category.maChuyenMuc.toString()}>
                  {category.tenChuyenMuc}
                </Select.Option>
              ))}
            </Select>

            <h5 style={{ fontSize: 14, color: "#666666", marginBottom: '15px' }}>
              SẮP XẾP THEO GIÁ
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
              />
            </h5>
            <Select
              style={{ width: '100%', marginBottom: '15px' }}
              placeholder="Sắp xếp theo giá"
              value={sortOrder}
              onChange={setSortOrder}
              allowClear
            >
              <Select.Option value="desc">Giá cao đến thấp</Select.Option>
              <Select.Option value="asc">Giá thấp đến cao</Select.Option>
            </Select>

            <h5 style={{ fontSize: 14, color: "#666666", marginBottom: '15px' }}>
              KHOẢNG GIÁ
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
              />
            </h5>
            <div style={{ padding: '0 10px' }}>
              <Slider
                range
                min={0}
                max={1500000}
                step={50000}
                value={priceRange}
                onChange={handlePriceChange}
                tooltip={{
                  formatter: (value) => `${value?.toLocaleString('vi-VN')}đ`
                }}
              />
              <div style={{ display: 'flex', justifyContent: 'space-between', marginTop: '10px' }}>
                <span>{priceRange[0].toLocaleString('vi-VN')}đ</span>
                <span>{priceRange[1].toLocaleString('vi-VN')}đ</span>
              </div>
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
                  <div className="cat_div-img">
                    <Link to={`/user/detail/${item.maSanPham}`}>
                      <img
                        src={
                          item?.anhDaiDien
                            ? IMAGE_BASE_PATH +
                              item.anhDaiDien.split(",")[0].trim()
                            : ""
                        }
                      />
                    </Link>
                  </div>
                  <div className="cat_div-information">
                    <a href="">{item.tenSanPham}</a>
                    <p style={{ color: "brown", fontSize: 16 }}>
                      {item.gia.toLocaleString("vi-VN", {
                        style: "currency",
                        currency: "VND",
                      })}
                    </p>
                  </div>
                </div>
              );
            })}
          </div>
        </div>
      </div>
    </>
  );
};
export default Search;
