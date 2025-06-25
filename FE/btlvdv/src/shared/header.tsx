import banner from "../assets/anh/banner2.png";
import { Link, useNavigate } from "react-router-dom";
import { useEffect, useState } from "react";
import { useRef } from 'react';//sử dụng useRefhook để thao tác trực tiếp kiểu của phần tử đầu vào
import "../assets/css/trangchu.css";
//cho phép bạn sửa đổi các thuộc tính CSS của đầu vào
import { useRecoilCallback, useRecoilState } from "recoil";
import axios from "axios";
import {
  ThongTinKhachHang,
  cartState,
  categoryState,
  dataSearch,
} from "../constant/recoil";
import { json } from "stream/consumers";
import { getAllCategory } from "../services/category";

const Header = function () {
  const navigate = useNavigate()
  const [categories, setCategories] = useState<any[]>([]);
  const [cate, setCate] = useRecoilState(categoryState);
  const [dtSearch, setDataSearch] = useRecoilState<any>(dataSearch);
  const [kh,setKhachang] = useState<any>(() => {
    try {
      const storedData = sessionStorage.getItem('ThongTinKhachHang');
      return (storedData && storedData !== 'undefined') ? JSON.parse(storedData) : null;
    } catch (error) {
      console.error('Error parsing session storage data:', error);
      return null;
    }
  });

  // const [tenKH, setTenKH] = useState<string>("");
  const [cart, setCart] = useRecoilState(cartState);

  const inputRef = useRef<HTMLInputElement>(null);
  const [input,setInput] = useState(false)

  // Thêm state để force render
  const [forceRender, setForceRender] = useState(0);

  // useRef để lưu trữ interval ID
  const intervalRef = useRef<number | null>(null);

  // useEffect để thiết lập và dừng interval cho việc render định kỳ (1 giây / 5 giây)
  useEffect(() => {
    let count = 0;
    const duration = 3000; // 5 giây
    const intervalTime = 1000; // 1 giây
    const maxIntervals = duration / intervalTime;

    intervalRef.current = window.setInterval(() => {
      count++;
      setForceRender(prev => prev + 1); // Cập nhật state để force render
      console.log(`Rendering due to interval: ${count} / ${maxIntervals}`);

      if (count >= maxIntervals) {
        clearInterval(intervalRef.current!); // Dừng interval sau 5 giây
        intervalRef.current = null;
        console.log('Interval stopped after 5 seconds.');
      }
    }, intervalTime);

    // Cleanup function để xóa interval khi component unmount
    return () => {
      if (intervalRef.current !== null) {
        clearInterval(intervalRef.current);
        intervalRef.current = null;
        console.log('Interval cleared on unmount.');
      }
    };
  }, []); // Empty dependency array means this runs only once on mount

  function onSearch(){
    if (inputRef.current) {
      if(input){
        inputRef.current.style.height = '45px'; 
        inputRef.current.style.border = '1px solid #131313'; 
      }
      else{
        inputRef.current.style.height = '0px'; 
        inputRef.current.style.border = 'none'; 
      }
      setInput(!input)
    }
    
  }
  
  const handleKeyDown = (event: React.KeyboardEvent<HTMLInputElement>) => {
    if (event.key === 'Enter') {
      // Perform desired action when Enter is pressed
      // console.log('Enter key pressed:', inputRef.current?.value);
      navigate("/user/search") 
    }
  };

  function handleInputChange(){
    if (inputRef.current) {
      // console.log(inputRef.current.value);
      setDataSearch(inputRef.current.value)
    }
  }

  // Hàm tổ chức danh mục thành cấu trúc cây
  const organizeCategories = (categories: any[]) => {
    const categoryMap = new Map();
    const rootCategories: any[] = [];

    // Tạo map cho tất cả danh mục
    categories.forEach(category => {
      if (category.tenChuyenMuc) { // Chỉ thêm danh mục có tên
        categoryMap.set(category.maChuyenMuc, {
          ...category,
          children: []
        });
      }
    });

    // Tổ chức cấu trúc cây
    categories.forEach(category => {
      if (category.tenChuyenMuc) { // Chỉ xử lý danh mục có tên
        const categoryWithChildren = categoryMap.get(category.maChuyenMuc);
        if (category.idCapCha === null) {
          rootCategories.push(categoryWithChildren);
        } else {
          const parentCategory = categoryMap.get(category.idCapCha);
          if (parentCategory) {
            parentCategory.children.push(categoryWithChildren);
          }
        }
      }
    });

    return rootCategories;
  };

  async function loadCategories() {
    try {
      const res = await getAllCategory();
      console.log("chuyenmuc", res);
      setCategories(res);
    } catch (error) {
      console.error("Error loading categories:", error);
    }
  }

  function onCategory(category: any) {
    const newCategory: any = {
      maChuyenMuc: category.maChuyenMuc,
      tenChuyenMuc: category.tenChuyenMuc,
    };
    setCate(newCategory);
  }

  function logout(){
    const confirm = window.confirm("Bạn có muốn đăng xuất không?")
    if(confirm){
      sessionStorage.removeItem('ThongTinKhachHang');
      sessionStorage.removeItem('MaTaiKhoan');
      navigate("/")
    }
  }
  
  useEffect(() => {
    loadCategories();
  }, []);
  
  

  useEffect(() => {
    let count = 0;
    const maxChecks = 3; // Giới hạn số lần kiểm tra
    const intervalTime = 1000; // 1 giây

    const interval = setInterval(() => {
      count++;
      // console.log(`Session storage check: ${count} / ${maxChecks}`); // Thêm log để theo dõi
      const storedKhachHang = sessionStorage.getItem('ThongTinKhachHang');
      if (storedKhachHang && storedKhachHang !== 'undefined') {
        try {
          const parsedData = JSON.parse(storedKhachHang);
          if (JSON.stringify(parsedData) !== JSON.stringify(kh)) {
            setKhachang(parsedData);
          }
        } catch (error) {
          // console.error('Error parsing session storage data during polling:', error, 'Value:', storedKhachHang);
          // Có thể chọn setKhachang(null) ở đây nếu dữ liệu bị hỏng
        }
      } else if (kh !== null) { // Nếu storedKhachHang bị xóa và state hiện tại không phải null
         setKhachang(null); // Đặt state về null
      }

      if (count >= maxChecks) {
        clearInterval(interval); // Dừng interval sau khi đủ số lần kiểm tra
        // console.log('Session storage polling stopped after reaching limit.');
      }
    }, intervalTime);

    // Cleanup function để xóa interval khi component unmount
    return () => {
      clearInterval(interval);
      console.log('Session storage polling cleared on unmount.');
    };
  }, []); // Dependency array rỗng để chỉ chạy một lần khi mount

  return (
    <div className="header">
      <>
        <div className="header1">
          <div className="left">
            <i className="fa-solid fa-phone" style={{ color: "white" }} />
            &nbsp; Hotline:
            <a href="tel:0868444644" title="4MEN Hot Line" rel="nofollow">
              0868.444.644
            </a>
          </div>
          <div className="right">
            <ul>
              <li>
                <a href="">Cách chọn size</a>
              </li>
              <li>
                <a href="">Chính sách khách vip</a>
              </li>
              <li>
                <a href="">Giới thiệu</a>
              </li>
              <li>
                <div className="inforCustomerlogo">
                  <Link to={`/user/infor`}>
                    <i className="fa-solid fa-user" />
                  </Link>
                  {kh?.tenKH || ""}
                </div>
                <div className="inforCustomer">
                  <div className="inforCustomer2" onClick={()=>{navigate("/user/infor")}}>Thông tin của tôi</div>
                  <div className="inforCustomer2" onClick={()=>{navigate("/user/carthistory")}}>Đơn mua</div>
                  {kh ? (
                    <div className="inforCustomer2" onClick={logout}>Đăng xuất</div>
                  ) : (
                    <div className="inforCustomer2" onClick={()=>{navigate("/")}}>Đăng nhập</div>
                  )}
                </div>
              </li>
            </ul>
          </div>
        </div>
        <div className="header2">
          <a>
            <Link to={`/user/home`}>
              <img className="logo" src={banner} alt="" />
            </Link>
          </a>
          <div className="header2div">
            <ul className="banner2ul">
              <li>
                <div>
                  <a href="">
                    Khuyến mãi
                    <div className="banneritem1">
                      <span className="hot" style={{ color: "white" }}>
                        Hot
                      </span>
                    </div>
                  </a>
                </div>
                <a href=""></a>
              </li>
              <li>
                <a href="">
                  Hàng mới về
                  <div className="banneritem2">
                    <span className="hot" style={{ color: "white" }}>
                      Hot
                    </span>
                  </div>
                </a>
              </li>
              {organizeCategories(categories).map(category => (
                <li key={category.maChuyenMuc}>
                  <a href="">{category.tenChuyenMuc}</a>
                  {category.children.length > 0 && (
                    <ul className="sub-banner2ul">
                      {category.children.map((child: any) => (
                        <li key={child.maChuyenMuc} onClick={() => onCategory(child)}>
                          <Link to={`/user/category`}>{child.tenChuyenMuc}</Link>
                        </li>
                      ))}
                    </ul>
                  )}
                </li>
              ))}
              <li>
                
                <a href="/user/articles">
                  Bài viết
                  <div className="banneritem2">
                    <span className="hot" style={{ color: "white" }}>
                      Hot
                    </span>
                  </div>
                </a>
              </li>
            </ul>
          </div>
          <div className="banner2right">
            <div className="b1">
              <span className="banner2span">
                <Link to={`/user/cart`}>
                  <i
                    className="fa-solid fa-cart-shopping"
                    style={{ color: "brown" }}
                  />
                  <span
                    style={{
                      color: "brown",
                      position: "absolute",
                      top: "13px",
                    }}
                  >
                    {cart.length}
                  </span>
                </Link>
{/* 
                <div className="giohang">
                  <h4 style={{ margin: 10 }}>Sản phẩm trong giỏ hàng</h4>
                  <hr />
                  <div className="giohang-chung"></div>
                  <div className="price-total">
                    Tổng: <span>0</span>
                    <sup>đ</sup>
                  </div>
                  <a href="">
                    <button className="guidonhang">Gửi đơn hàng</button>
                  </a>
                </div> */}
              </span>
            </div>
            <div className="b1">
              <span className="banner3span" onClick={onSearch}>
                <i
                  className="fa-solid fa-magnifying-glass"
                  style={{ color: "brown" }}
                />
              </span>
              <input className="input_Search" type="text" ref={inputRef} onChange={handleInputChange} onKeyDown={handleKeyDown}></input>
              {/* <div className="inputContainer">
                <input
                  ng-model="inputData"
                  ng-keypress="checkEnterKey($event)"
                  id="Search"
                  type="text"
                  placeholder="Tìm kiếm"
                />
              </div> */}
            </div>
          </div>
        </div>
      </>
    </div>
  );
};
export default Header;
