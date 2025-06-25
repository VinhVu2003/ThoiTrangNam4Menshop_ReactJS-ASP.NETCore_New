import { useEffect, useState, useRef } from "react";
import "../assets/css/chitietsanpham.css";
import { Link, useParams } from "react-router-dom";
// import img from "../assets/anh/aonam4.jpg";
import { addtoCart } from "../utils/cart";
import axios from "axios";
import { useRecoilState } from "recoil";
import { cartState } from "../constant/recoil";
import ScrollToTopButton from "../constant/ScrollToTopButton";
import {
  GetProductById,
  GetAllSizeByIdPro,
  AddViewProduct,
  SearchWithNameUser,
  GetALLByMaChuyenMuc,
} from "../services/product.services";
import { getAllCategory } from "../services/category";
import { IMAGE_BASE_PATH } from "../constant/imageBasePath ";
import {
  getAllReviewsByProductId,
  APIcreateReview,
} from "../services/reviewPr";

interface Size {
  id: number;
  maSP: number;
  maSize: number;
  soLuong: number;
  trangThai: number;
  tenSize: string;
}

type Review = {
  id: number;
  sanPhamId: number;
  khachHangId: number | null;
  noiDung: string;
  soSao: number;
  thoiGianTao: string;
  trangThai: boolean;
  tenKhachHang: string | null;
};

const Detail = function () {
  const { id } = useParams();
  const [data, setData] = useState<any>([]);
  const [DataSameCategory, setDataSameCategory] = useState([]);
  const [sizes, setSizes] = useState<Size[]>([]);
  const [selectedSize, setSelectedSize] = useState<Size | null>(null);
  const [quantity, setQuantity] = useState<number>(1);
  const [cart, setCart] = useRecoilState(cartState);
  const [categories, setCategories] = useState<any[]>([]);
  const [sameNameProducts, setSameNameProducts] = useState<any[]>([]);
  const [rating, setRating] = useState<number>(0);
  const thongTinKhachHang = JSON.parse(
    sessionStorage.getItem("ThongTinKhachHang") || "null"
  );
  const [reviews, setReviews] = useState<Review[]>([]);
  const [tenNguoiDanhGia, setTenNguoiDanhGia] = useState("");
  const [reviewContent, setReviewContent] = useState("");
  const [currentImageIndex, setCurrentImageIndex] = useState(0);
  const [isTransitioning, setIsTransitioning] = useState(false);
  const [activeTab, setActiveTab] = useState("keyword"); // "review" hoặc "keyword"

  useEffect(() => {
    if (data?.maChuyenMuc) {
      GetALLByMaChuyenMuc(data.maChuyenMuc)
        .then((res) => {
          setDataSameCategory(res);
          console.log("spcungchuyenmuc", res);
        })
        .catch((error) => {
          console.error("Error loading products in same category:", error);
        });
    }
  }, [data.maChuyenMuc]);


  const loadSameNameProducts = async () => {
    if (!data.tenSanPham) return;
    try {
      // Extract product name before color and remove color suffix
      const productName = data.tenSanPham
        .split(" - ")[0]
        .replace(/ Màu [^]*$/, "");
      const response = await SearchWithNameUser({ tenSanPham: productName });
      const activeProducts = response.filter(
        (product: any) => product.trangThai === true
      );

      console.log("optin sp", response);
      setSameNameProducts(activeProducts);
    } catch (error) {
      console.error("Error loading same name products:", error);
    }
  };
  
  useEffect(() => {
    if (data.tenSanPham) {
      loadSameNameProducts();
    }
  }, [data.tenSanPham]);

  async function loaddata() {
    if (!id) return;
    const res = await GetProductById(id);
    setData(res);
    console.log("chitietsp", res);
    GetallSize(res);
  }

  async function loadCategories() {
    try {
      const res = await getAllCategory();
      setCategories(res);
    } catch (error) {
      console.error("Error loading categories:", error);
    }
  }

  const handleSelectChange = (event: React.ChangeEvent<HTMLSelectElement>) => {
    const sizeId = parseInt(event.target.value);
    const size = sizes.find((s) => s.id === sizeId);
    setSelectedSize(size || null);
  };

  const handleQuantityChange = (
    event: React.ChangeEvent<HTMLSelectElement>
  ) => {
    setQuantity(parseInt(event.target.value));
  };

  async function GetallSize(data: any) {
    try {
      const response = await GetAllSizeByIdPro(data.maSanPham);
      console.log("allSize", response);
      setSizes(response.filter((size: any) => size.soLuong > 0));
    } catch (error) {
      console.error("Error fetching sizes:", error);
    }
  }

  async function DatHang() {
    if (!selectedSize) {
      alert("Vui lòng chọn size trước khi thêm vào giỏ hàng");
      return;
    }
    if (quantity > selectedSize.soLuong) {
      alert(`Chỉ còn ${selectedSize.soLuong} sản phẩm trong kho`);
      return;
    }
    try {
      addtoCart({
        maSanPham: data.maSanPham,
        anhDaiDien: data.anhDaiDien,
        tenSanPham: data.tenSanPham,
        tenSize: selectedSize.tenSize,
        maSize: selectedSize.maSize,
        gia:
          data.giamGiaId && data.giaTriGiam
            ? (data.gia || 0) * (1 - (data.giaTriGiam || 0) / 100)
            : data.gia,
        quantity: quantity,
        maSPcotrongKho: selectedSize.id,
        soLuongSPtrongKho: selectedSize.soLuong,
      });
      let list = JSON.parse(localStorage.getItem("cart") || "[]");
      setCart(list);
    } catch (error) {
      console.error("Error adding to cart:", error);
    }
  }

  useEffect(() => {
    loaddata();
    loadCategories();
  }, [id]);

  // Tách riêng việc tăng lượt xem
  useEffect(() => {
    const updateViewCount = async () => {
      if (id) {
        await AddViewProduct(id);
      }
    };
    updateViewCount();
  }, []);
  // getall review đánh giá
  useEffect(() => {
    const loadReviews = async () => {
      if (data?.maSanPham) {
        try {
          const response = await getAllReviewsByProductId(data?.maSanPham);
          setReviews(response);
        } catch (error) {
          console.error("Error loading reviews:", error);
        }
      }
    };
    loadReviews();
  }, [data.maSanPham]);

  const daDanhGia = thongTinKhachHang
    ? reviews.some(
        (r) =>
          r.khachHangId === thongTinKhachHang.maKH &&
          r.sanPhamId === data.maSanPham
      )
    : false;

  async function createReview() {
    if (rating === 0) {
      alert("Vui lòng chọn số sao đánh giá!");
      return;
    }
    if (!reviewContent.trim()) {
      alert("Vui lòng nhập nội dung đánh giá!");
      return;
    }

    const reviewData: any = {
      sanPhamId: data.maSanPham,
      khachHangId: thongTinKhachHang ? thongTinKhachHang.maKH : null,
      noiDung: reviewContent,
      soSao: rating,
      thoiGianTao: new Date().toISOString(),
      trangThai: thongTinKhachHang ? true : false,
      tenKhachHang: thongTinKhachHang
        ? thongTinKhachHang.tenKH
        : tenNguoiDanhGia,
    };

    try {
      // Gửi lên server (thay bằng API thực tế của bạn)
      // await axios.post('/api/reviews', reviewData);
      // hoặc gọi service: await createReviewService(reviewData);
      const response = await APIcreateReview(reviewData);
      if (response) {
        alert("Gửi đánh giá thành công!");
        window.location.reload();
      }
      // Reset form nếu muốn
      setRating(0);
      setReviewContent("");
      setTenNguoiDanhGia("");
      // Có thể reload lại danh sách đánh giá nếu muốn
      // loadReviews();
    } catch (error) {
      alert("Gửi đánh giá thất bại!");
      console.error(error);
    }
  }

  const handlePrevImage = () => {
    if (!data?.anhDaiDien || isTransitioning) return;
    const images = data.anhDaiDien.split(",");
    setIsTransitioning(true);
    setTimeout(() => {
      setCurrentImageIndex((prev) =>
        prev === 0 ? images.length - 1 : prev - 1
      );
      setIsTransitioning(false);
    }, 300);
  };

  const handleNextImage = () => {
    if (!data?.anhDaiDien || isTransitioning) return;
    const images = data.anhDaiDien.split(",");
    setIsTransitioning(true);
    setTimeout(() => {
      setCurrentImageIndex((prev) =>
        prev === images.length - 1 ? 0 : prev + 1
      );
      setIsTransitioning(false);
    }, 300);
  };

  const handleThumbnailClick = (index: number) => {
    if (isTransitioning) return;
    if (index === currentImageIndex) return;

    setIsTransitioning(true);
    setTimeout(() => {
      setCurrentImageIndex(index);
      setIsTransitioning(false);
    }, 300);
  };

  return (
    <>
      <ScrollToTopButton />
      {data && (
        <div
          id="chitietsanpham"
          style={{ height: "auto", borderBottom: "none" }}
        >
          <div className="botom-head">
            <ul>
              <li>
                <a href="">4MEN &nbsp; / &nbsp;</a>
              </li>
              <li>
                <a href="">Áo Nam &nbsp; / &nbsp;</a>
              </li>
              <li>
                <a href="">{data.tenSanPham}</a>
              </li>
            </ul>
          </div>
          <div className="content" style={{ borderBottom: "none" }}>
            <div
              className="content-left"
              style={{ height: "auto", borderRight: "none" }}
            >
              <div
                id="content-left-right"
                style={{
                  // backgroundColor: "#000000",
                  height: "auto",
                }}
              >
                <div
                  className="img-main-container"
                  style={{
                    display: "flex",
                    flexDirection: "row",
                    alignItems: "flex-start",
                    width: "100%",
                    position: "relative",
                  }}
                >
                  <div
                    className="img-list-container"
                    style={{
                      display: "flex",
                      flexDirection: "column",
                      gap: "10px",
                      marginRight: "15px",
                    }}
                  >
                    {data?.anhDaiDien
                      ?.split(",")
                      .map((img: string, index: number) => (
                        <div
                          key={index}
                          className="img-thumbnail"
                          style={{
                            width: "80px",
                            height: "80px",
                            border: "1px solid #ddd",
                            cursor: "pointer",
                            overflow: "hidden",
                            opacity: index === currentImageIndex ? 0.7 : 1,
                          }}
                          onClick={() => handleThumbnailClick(index)}
                        >
                          <img
                            src={IMAGE_BASE_PATH + img.trim()}
                            alt={`Thumbnail ${index + 1}`}
                            style={{
                              width: "100%",
                              height: "100%",
                              objectFit: "cover",
                            }}
                          />
                        </div>
                      ))}
                  </div>
                  <div
                    style={{
                      position: "relative",
                      width: "80%",
                      overflow: "hidden",
                    }}
                  >
                    <div
                      style={{
                        display: "flex",
                        width: "100%",
                        transition: "transform 0.3s ease-in-out",
                        transform: `translateX(-${currentImageIndex * 100}%)`,
                      }}
                    >
                      {data?.anhDaiDien
                        ?.split(",")
                        .map((img: string, index: number) => (
                          <img
                            key={index}
                            style={{
                              width: "100%",
                              flexShrink: 0,
                            }}
                            src={IMAGE_BASE_PATH + img.trim()}
                            alt={`${data?.tenSanPham || ""} - ${index + 1}`}
                          />
                        ))}
                    </div>
                    <button
                      onClick={handlePrevImage}
                      style={{
                        position: "absolute",
                        left: "10px",
                        top: "50%",
                        transform: "translateY(-50%)",
                        backgroundColor: "rgba(255, 255, 255, 0.7)",
                        border: "none",
                        borderRadius: "50%",
                        width: "40px",
                        height: "40px",
                        cursor: "pointer",
                        display: "flex",
                        alignItems: "center",
                        justifyContent: "center",
                        fontSize: "20px",
                        color: "#333",
                        transition: "all 0.3s ease",
                        zIndex: 2,
                      }}
                      onMouseOver={(e) => {
                        e.currentTarget.style.backgroundColor =
                          "rgba(255, 255, 255, 0.9)";
                        e.currentTarget.style.transform =
                          "translateY(-50%) scale(1.1)";
                      }}
                      onMouseOut={(e) => {
                        e.currentTarget.style.backgroundColor =
                          "rgba(255, 255, 255, 0.7)";
                        e.currentTarget.style.transform =
                          "translateY(-50%) scale(1)";
                      }}
                    >
                      ‹
                    </button>
                    <button
                      onClick={handleNextImage}
                      style={{
                        position: "absolute",
                        right: "10px",
                        top: "50%",
                        transform: "translateY(-50%)",
                        backgroundColor: "rgba(255, 255, 255, 0.7)",
                        border: "none",
                        borderRadius: "50%",
                        width: "40px",
                        height: "40px",
                        cursor: "pointer",
                        display: "flex",
                        alignItems: "center",
                        justifyContent: "center",
                        fontSize: "20px",
                        color: "#333",
                        transition: "all 0.3s ease",
                        zIndex: 2,
                      }}
                      onMouseOver={(e) => {
                        e.currentTarget.style.backgroundColor =
                          "rgba(255, 255, 255, 0.9)";
                        e.currentTarget.style.transform =
                          "translateY(-50%) scale(1.1)";
                      }}
                      onMouseOut={(e) => {
                        e.currentTarget.style.backgroundColor =
                          "rgba(255, 255, 255, 0.7)";
                        e.currentTarget.style.transform =
                          "translateY(-50%) scale(1)";
                      }}
                    >
                      ›
                    </button>
                  </div>
                </div>
              </div>
            </div>

            <div className="content-right" style={{ height: "auto" }}>
              <div className="content-right-header" style={{ height: "auto" }}>
                <h1 style={{ position: "relative" }}>
                  {data.tenSanPham}
                  {data?.giaTriGiam &&
                    data?.dangHoatDong === 1 &&
                    data?.trangThaiGiamGia === "Đang diễn ra" && (
                      <span
                        style={{
                          position: "absolute",
                          top: 0,
                          right: 0,
                          backgroundColor: "#666666",
                          color: "white",
                          padding: "4px 8px",
                          borderRadius: "50%",
                          fontSize: "14px",
                          display: "inline-flex",
                          alignItems: "center",
                          justifyContent: "center",
                          minWidth: "50px",
                          height: "50px",
                          aspectRatio: "1/1",
                        }}
                      >
                        -{data.giaTriGiam}%
                      </span>
                    )}
                  {/* {data.maSanPham} */}
                </h1>

                <div className="feadback">
                  <i
                    className="fa-solid fa-star"
                    style={{ color: "yellow", fontSize: 12 }}
                  />
                  <i
                    className="fa-solid fa-star"
                    style={{ color: "yellow", fontSize: 12 }}
                  />
                  <i
                    className="fa-solid fa-star"
                    style={{ color: "yellow", fontSize: 12 }}
                  />
                  <i
                    className="fa-solid fa-star"
                    style={{ color: "yellow", fontSize: 12 }}
                  />
                  <i
                    className="fa-solid fa-star"
                    style={{ color: "yellow", fontSize: 12 }}
                  />
                  {/* <span>(35 đánh giá / 78 lượt mua)</span> */}
                  <span style={{ marginLeft: "10px" }}>
                    <i
                      className="fa-solid fa-eye"
                      style={{ color: "#666666", fontSize: 12 }}
                    ></i>
                    <span style={{ marginLeft: "4px", fontSize: 12 }}>
                      {data.luotXem || 0}
                    </span>
                  </span>
                </div>
                <div className="money-left">
                  <span style={{ fontSize: 14, marginTop: 10 }}>
                    <u>Giá bán:</u>
                  </span>
                </div>
                <div
                  className="money-right"
                  style={{ display: "flex", alignItems: "center", gap: "10px" }}
                >
                  {data?.giaTriGiam &&
                  data?.dangHoatDong === 1 &&
                  data?.trangThaiGiamGia === "Đang diễn ra" ? (
                    <>
                      <span
                        style={{
                          fontSize: 22,
                          color: "#c80204",
                        }}
                      >
                        {(
                          (data?.gia || 0) *
                          (1 - (data?.giaTriGiam || 0) / 100)
                        ).toLocaleString("vi-VN", {
                          style: "currency",
                          currency: "VND",
                        })}
                      </span>
                      <span
                        style={{
                          fontSize: 14,
                          color: "#666666",
                          textDecoration: "line-through",
                        }}
                      >
                        Giá gốc:{" "}
                        {(data?.gia || 0).toLocaleString("vi-VN", {
                          style: "currency",
                          currency: "VND",
                        })}
                      </span>
                    </>
                  ) : (
                    <span
                      style={{
                        fontSize: 22,
                        color: "#c80204",
                      }}
                    >
                      {(data?.gia || 0).toLocaleString("vi-VN", {
                        style: "currency",
                        currency: "VND",
                      })}
                    </span>
                  )}
                </div>
                <div
                  style={{
                    paddingLeft: "1px",
                    width: "100%",
                    height: "auto",
                    margin: "5px 0px",
                    display: "block",
                    clear: "both",
                    marginBottom: "10px",
                    marginTop: "10px",
                    marginLeft: "14px",
                  }}
                >
                  {sameNameProducts.length > 1 && (
                    <div style={{ marginTop: "10px" }}>
                      <div style={{ marginBottom: "5px", fontSize: "14px" }}>
                        Màu khác:
                      </div>
                      <div
                        style={{
                          display: "flex",
                          gap: "10px",
                          flexWrap: "wrap",
                        }}
                      >
                        {sameNameProducts.map((product) => (
                          <Link
                            key={product.maSanPham}
                            to={`/user/detail/${product.maSanPham}`}
                            style={{
                              padding: "5px 10px",
                              border: "1px solid #ddd",
                              borderRadius: "4px",
                              textDecoration: "none",
                              color: "#333",
                              fontSize: "14px",
                              display: "flex",
                              alignItems: "center",
                              gap: "8px",
                            }}
                          >
                            <img
                              src={
                                IMAGE_BASE_PATH +
                                product?.anhDaiDien?.split(",")[0].trim()
                              }
                              // src={IMAGE_BASE_PATH + product?.anhDaiDien?.split(',')[0].trim()}

                              alt={""}
                              style={{
                                width: "50px",
                                height: "50px",
                                objectFit: "cover",
                                borderRadius: "2px",
                              }}
                            />
                            <span>{product.mauSac}</span>
                          </Link>
                        ))}
                      </div>
                    </div>
                  )}
                </div>
                <div className="size" style={{ width: "50%" }}>
                  <div>
                    SIZE*
                    <a href="">
                      <em>Hướng dẫn chọn size</em>
                    </a>
                  </div>
                  <select
                    style={{ width: "100%" }}
                    className="chosen-select"
                    onChange={handleSelectChange}
                    required
                  >
                    <option value="0" selected disabled>
                      Chọn size
                    </option>
                    {sizes.map((size) => (
                      <option key={size.id} value={size.id}>
                        {size.tenSize} - Còn {size.soLuong} sản phẩm
                      </option>
                    ))}
                  </select>
                  <button style={{ width: "100%" }} onClick={DatHang}>
                    <i
                      className="fa fa-shopping-cart"
                      style={{ marginRight: 10 }}
                    />
                    Thêm vào giỏ hàng
                  </button>
                </div>
                <div className="number">
                  <div>SỐ LƯỢNG*</div>
                  <select
                    name="quantity"
                    id="quantity"
                    value={quantity}
                    onChange={handleQuantityChange}
                    style={{ width: "100%", padding: "8px" }}
                  >
                    {[1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map((num) => (
                      <option key={num} value={num}>
                        {num}
                      </option>
                    ))}
                  </select>
                  <span style={{ marginLeft: 15 }}>
                    <a href="./giohang.html">Đăng kí mua</a>
                  </span>
                </div>
              </div>
              
              <div
                className="product-description"
                // style={{ marginLeft: "25px" }}
              >
                <div style={{ 
                  marginLeft: "15px",
                  color: "#555", 
                  fontWeight: 500, 
                  fontSize: 15, 
                  marginBottom: 10, 
                  letterSpacing: 0.2,
                  fontFamily: "'Times New Roman', Times, serif"
                }}>
                  ĐIỂM NỔI BẬT
                </div>
                <div
                  className="description-content"
                  style={{
                    marginLeft: "25px",

                    whiteSpace: "pre-wrap",
                    wordBreak: "break-word",
                    fontSize: "12px",
                    lineHeight: "1.8",
                    fontFamily: "'Times New Roman', Times, serif",
                    color: "#222",
                    fontWeight: 400,
                    letterSpacing: "0.2px",
                  }}
                  dangerouslySetInnerHTML={{
                    __html: data?.moTa?.replace(/\n/g, "<br/>") || "",
                  }}
                />
              </div>
            </div>
          </div>

          <div
            style={{
              margin: "20px 10px",
              border: "0.5px solid #ddd",
              borderRadius: "6px",
              background: "#fff",
              overflow: "hidden"
            }}
          >
            {/* Tabs */}
            <div style={{ display: "flex", marginLeft: 20, marginTop: 20 }}>
              {["keyword", "review"].map((tab) => (
                <button
                  key={tab}
                  style={{
                    padding: "14px 36px",
                    border: "1px solid #ddd",
                    borderBottom: activeTab === tab ? "none" : "1px solid #ddd",
                    borderTopLeftRadius: 4,
                    borderTopRightRadius: 4,
                    background: activeTab === tab ? "#fff" : "#fafafa",
                    color: activeTab === tab ? "#222" : "#666",
                    fontWeight: 500,
                    fontSize: 10,
                    marginRight: 2,
                    marginBottom: -1,
                    zIndex: activeTab === tab ? 2 : 1,
                    position: "relative",
                    outline: "none",
                    cursor: "pointer",
                  }}
                  onClick={() => setActiveTab(tab)}
                >
                  {tab === "keyword" && "TỪ KHÓA"}
                  {tab === "review" && "ĐÁNH GIÁ"}
                </button>
              ))}
            </div>

            {/* Nội dung có border */}
            <div
              style={{
                border: "1px solid #ddd",
                borderRadius: 4,
                background: "#fff",
                margin: "0 20px 15px 20px",
                padding: "5px 24px",
                minHeight: 10,
                position: "relative",
                top: -1,
                zIndex: 1,
              }}
            >
              {activeTab === "keyword" && (
                <div>{data.tuKhoa || "N/A"}</div>
              )}
              {activeTab === "review" && (
                <div>
                  <div className="product-reviews" style={{ margin: "10px 0px 0px 0px" }}>
                    
                    {thongTinKhachHang ? (
                      daDanhGia ? (
                        <div
                          style={{
                            padding: "10px",
                            backgroundColor: "#f9f9f9",
                            borderRadius: "8px",
                            boxShadow: "0 2px 4px rgba(0,0,0,0.05)",
                          }}
                        >
                          <div style={{ marginBottom: 8, fontSize: "14px" }}>
                            Xin chào, <b>{thongTinKhachHang.tenKH}</b>
                          </div>
                          <div
                            style={{
                              color: "#2e7d32",
                              marginBottom: 8,
                              fontSize: "14px",
                              display: "flex",
                              alignItems: "center",
                              gap: "8px",
                            }}
                          >
                            <i
                              className="fa-solid fa-circle-check"
                              style={{ color: "#2e7d32" }}
                            ></i>
                            Bạn đã đánh giá sản phẩm này.
                          </div>
                        </div>
                      ) : (
                        <div
                          style={{
                            padding: "20px",
                            backgroundColor: "#f9f9f9",
                            borderRadius: "8px",
                            boxShadow: "0 2px 4px rgba(0,0,0,0.05)",
                          }}
                        >
                          <div style={{ marginBottom: 15, fontSize: "14px" }}>
                            Xin chào, <b>{thongTinKhachHang.tenKH}</b>
                          </div>
                          <div style={{ marginBottom: "15px" }}>
                            <div
                              style={{
                                marginBottom: "10px",
                                fontSize: "14px",
                                fontWeight: "500",
                              }}
                            >
                              Đánh giá của bạn:
                            </div>
                            <div
                              style={{
                                display: "flex",
                                flexDirection: "column",
                                gap: "2px",
                                backgroundColor: "white",
                                padding: "10px",
                                borderRadius: "6px",
                              }}
                            >
                              {[1, 2, 3, 4, 5].map((num) => (
                                <label
                                  key={num}
                                  style={{
                                    display: "flex",
                                    alignItems: "center",
                                    justifyContent: "center",
                                    cursor: "pointer",
                                    height: "25px",
                                    transition: "all 0.2s ease",
                                    padding: "2px",
                                    borderRadius: "4px",
                                  }}
                                  className="rating-label"
                                >
                                  <input
                                    type="radio"
                                    name="rating"
                                    value={num}
                                    checked={rating === num}
                                    onChange={() => setRating(num)}
                                    style={{ marginRight: 6 }}
                                  />
                                  <div
                                    style={{
                                      display: "flex",
                                      justifyContent: "center",
                                      alignItems: "center",
                                    }}
                                  >
                                    {[...Array(num)].map((_, idx) => (
                                      <i
                                        key={idx}
                                        className="fa-solid fa-star"
                                        style={{
                                          color: rating === num ? "#ff6600" : "#ffb566",
                                          fontSize: 12,
                                          marginRight: 1,
                                        }}
                                      />
                                    ))}
                                  </div>
                                </label>
                              ))}
                            </div>
                          </div>
                          <textarea
                            placeholder="Viết đánh giá của bạn về sản phẩm này..."
                            style={{
                              width: "100%",
                              padding: "12px",
                              borderRadius: "6px",
                              border: "1px solid #ddd",
                              minHeight: "100px",
                              marginBottom: "15px",
                              fontSize: "14px",
                              resize: "vertical",
                              transition: "border-color 0.2s ease",
                            }}
                            className="review-textarea"
                            value={reviewContent}
                            onChange={(e) => setReviewContent(e.target.value)}
                          />
                          <button
                            style={{
                              padding: "10px 20px",
                              backgroundColor: "#b31f2a",
                              color: "white",
                              border: "none",
                              borderRadius: "6px",
                              cursor: "pointer",
                              fontSize: "14px",
                              fontWeight: "500",
                              transition: "all 0.2s ease",
                            }}
                            className="submit-review-btn"
                            onClick={createReview}
                          >
                            Gửi đánh giá
                          </button>
                        </div>
                      )
                    ) : (
                      <div
                        style={{
                          padding: "20px",
                          backgroundColor: "#f9f9f9",
                          borderRadius: "8px",
                          boxShadow: "0 2px 4px rgba(0,0,0,0.05)",
                        }}
                      >
                        <div style={{ marginBottom: "15px" }}>
                          <div
                            style={{
                              marginBottom: "10px",
                              fontSize: "14px",
                              fontWeight: "500",
                            }}
                          >
                            Đánh giá của bạn:
                          </div>
                          <div
                            style={{
                              display: "flex",
                              flexDirection: "column",
                              gap: "2px",
                              backgroundColor: "white",
                              padding: "10px",
                              borderRadius: "6px",
                            }}
                          >
                            {[1, 2, 3, 4, 5].map((num) => (
                              <label
                                key={num}
                                style={{
                                  display: "flex",
                                  alignItems: "center",
                                  justifyContent: "center",
                                  cursor: "pointer",
                                  height: "25px",
                                  transition: "all 0.2s ease",
                                  padding: "2px",
                                  borderRadius: "4px",
                                }}
                                className="rating-label"
                              >
                                <input
                                  type="radio"
                                  name="rating"
                                  value={num}
                                  checked={rating === num}
                                  onChange={() => setRating(num)}
                                  style={{ marginRight: 6 }}
                                />
                                <div
                                  style={{
                                    display: "flex",
                                    justifyContent: "center",
                                    alignItems: "center",
                                  }}
                                >
                                  {[...Array(num)].map((_, idx) => (
                                    <i
                                      key={idx}
                                      className="fa-solid fa-star"
                                      style={{
                                        color: rating === num ? "#ff6600" : "#ffb566",
                                        fontSize: 12,
                                        marginRight: 1,
                                      }}
                                    />
                                  ))}
                                </div>
                              </label>
                            ))}
                          </div>
                        </div>
                        <input
                          type="text"
                          placeholder="Nhập tên của bạn"
                          value={tenNguoiDanhGia}
                          onChange={(e) => setTenNguoiDanhGia(e.target.value)}
                          style={{
                            marginBottom: 15,
                            width: "30%",
                            padding: "10px",
                            fontSize: "14px",
                            borderRadius: "6px",
                            border: "1px solid #ddd",
                            transition: "border-color 0.2s ease",
                          }}
                          className="review-textarea"
                        />
                        <textarea
                          placeholder="Viết đánh giá của bạn về sản phẩm này..."
                          style={{
                            width: "100%",
                            padding: "12px",
                            borderRadius: "6px",
                            border: "1px solid #ddd",
                            minHeight: "100px",
                            marginBottom: "15px",
                            fontSize: "14px",
                            resize: "vertical",
                            transition: "border-color 0.2s ease",
                          }}
                          className="review-textarea"
                          value={reviewContent}
                          onChange={(e) => setReviewContent(e.target.value)}
                        />
                        <button
                          style={{
                            padding: "10px 20px",
                            backgroundColor: "#b31f2a",
                            color: "white",
                            border: "none",
                            borderRadius: "6px",
                            cursor: "pointer",
                            fontSize: "14px",
                            fontWeight: "500",
                            transition: "all 0.2s ease",
                          }}
                          className="submit-review-btn"
                          onClick={createReview}
                        >
                          Gửi đánh giá
                        </button>
                      </div>
                    )}

                    {/* Reviews List */}
                    <div className="reviews-list" style={{ marginTop: "15px" }}>
                      {reviews.length === 0 ? (
                        <div
                          style={{
                            color: "#666",
                            padding: "10px",
                            fontSize: "14px",
                            textAlign: "center",
                            backgroundColor: "#f9f9f9",
                            borderRadius: "8px",
                          }}
                        >
                          Chưa có đánh giá nào cho sản phẩm này.
                        </div>
                      ) : (
                        <div style={{ maxHeight: "200px", overflowY: "auto" }}>
                          {reviews.map((review: any, idx: any) => (
                            <div
                              className="review-item"
                              key={idx}
                              style={{
                                paddingLeft: "20px",
                                paddingRight: "10px",
                                borderBottom: "1px solid #eee",
                                marginBottom: "8px",
                                backgroundColor: "white",
                                borderRadius: "6px",
                                boxShadow: "0 1px 3px rgba(0,0,0,0.05)",
                              }}
                            >
                              <div
                                style={{
                                  display: "flex",
                                  alignItems: "center",
                                  marginBottom: "8px",
                                }}
                              >
                                <div
                                  className="user-avatar"
                                  style={{
                                    width: "30px",
                                    height: "30px",
                                    borderRadius: "50%",
                                    backgroundColor: "#e0e0e0",
                                    marginRight: "8px",
                                    display: "flex",
                                    alignItems: "center",
                                    justifyContent: "center",
                                    color: "#666",
                                    fontSize: "14px",
                                  }}
                                >
                                  <i className="fa-solid fa-user"></i>
                                </div>
                                <div>
                                  <div style={{ fontWeight: "500", fontSize: "13px" }}>
                                    {review.tenKhachHang || "Khách"}
                                  </div>
                                  <div style={{ color: "#666", fontSize: "11px" }}>
                                    {review.thoiGianTao
                                      ? new Date(
                                          review.thoiGianTao
                                        ).toLocaleDateString()
                                      : ""}
                                  </div>
                                </div>
                              </div>
                              <div
                                className="rating-stars"
                                style={{ marginBottom: "8px", fontSize: "12px" }}
                              >
                                {[1, 2, 3, 4, 5].map((star) => (
                                  <i
                                    key={star}
                                    className={
                                      star <= review.soSao
                                        ? "fa-solid fa-star"
                                        : "fa-regular fa-star"
                                    }
                                    style={{ color: "#ffd700", marginRight: "1px", fontSize: 12 }}
                                  />
                                ))}
                              </div>
                              <p
                                style={{
                                  color: "#333",
                                  lineHeight: "1.4",
                                  fontSize: "13px",
                                  margin: 0,
                                }}
                              >
                                {review.noiDung}
                              </p>
                            </div>
                          ))}
                        </div>
                      )}
                    </div>
                  </div>
                </div>
              )}
            </div>

          </div>

          <h3 style={{ marginLeft: "60px" }}>SẢN PHẨM CÙNG DANH MỤC</h3>
          <div className="product-selling ">
            <div className="product-selling-content">
              {DataSameCategory.slice(0, 4).map(function (value: any, index: any) {
                return (
                  <div className="contentsmall-selling" key={index}>
                    <div className="productimg-selling">
                      <div className="productimgpig-selling">
                        <div
                          style={{
                            width: "100%",
                            height: "100%",
                            position: "absolute",
                          }}
                        >
                          <a href="">
                          <img src={value?.anhDaiDien ? IMAGE_BASE_PATH + value.anhDaiDien.split(',')[0].trim() : ''} />
                          </a>

                          <div className="overlayitem-selling">
                            <span className="overlayitemicon-selling">
                              <i
                                className="fa-solid fa-cart-shopping"
                                style={{ color: "white", rotate: "0deg;" }}
                              ></i>
                            </span>
                          </div>
                        </div>
                      </div>
                      <div className="productimgsmall-selling">
                        <a href="">
                        <img src={value?.anhDaiDien ? IMAGE_BASE_PATH + value.anhDaiDien.split(',')[0].trim() : ''} />
                        </a>
                      </div>
                      <div
                        className="producttext-selling"
                        style={{ width: "100%", textAlign: "center" }}
                      >
                        <a
                          href=""
                          className="spannote"
                          title="Áo Khoác Dạ Regular Phối sọc AK405 Màu Be"
                        >
                          {value.tenSanPham}
                        </a>
                      </div>
                      <div className="protect-money-selling">
                        <p style={{ color: "brown", textAlign: "center" }}>
                          {value.gia.toLocaleString("vi-VN", {
                            style: "currency",
                            currency: "VND",
                          })}
                        </p>
                      </div>
                    </div>
                  </div>
                );
              })}
            </div>

          </div>
        </div>
      )}
    </>
  );
};

export default Detail;
