import { useEffect, useRef, useState } from "react";
import "../assets/css/giohang.css";
import { cartState, thongtinTK } from "../constant/recoil";
import { useRecoilState, useRecoilValue } from "recoil";
import {
  Button,
  Form,
  Input,
  message,
  Space,
  Table,
  Tag,
  Modal,
  Select,
} from "antd";
import axios from "axios";
import { useNavigate, useNavigation } from "react-router-dom";
import {
  GetProvinces,
  GetDistricts,
  GetWards,
} from "../services/provinces.services";
import {
  CreatePaymentUrlVnpay,
  InsertPaymentVnpay,
} from "../services/payment.services";
import { useSearchParams } from "react-router-dom";
import { IMAGE_BASE_PATH } from "../constant/imageBasePath ";
import { getAllGiamGia_DangHoatDong } from "../services/discount.services";
import { sendOrderStatusEmail } from "../utils/emailService";

interface CartItem {
  maSanPham: string;
  anhDaiDien: string;
  tenSanPham: string;
  tenSize: string;
  maSize: number;
  gia: number;
  quantity: number;
}

const Cart: React.FC = () => {
  let infor: any = null;
  try {
    const rawData = sessionStorage.getItem("ThongTinKhachHang");
    if (rawData && rawData !== "undefined" && rawData !== "null") {
      infor = JSON.parse(rawData);
    }
  } catch (error) {
    console.error("Lỗi parse ThongTinKhachHang:", error);
  }

  const [form] = Form.useForm();
  const [MaDonHang, setMaDonHang] = useState<number>(0);
  const [cartRecoil, setCartRecoil] = useRecoilState(cartState);
  const [cart, setCart] = useState<any[]>([]);
  const [totalPrice, setTotalPrice] = useState<Number>(0);
  const [dataKH, setDataKH] = useState<any>();
  const [diaChi, setDiaChi] = useState("");
  const [provinces, setProvinces] = useState<any[]>([]); //tỉnh
  const [districts, setDistricts] = useState<any[]>([]); //huyện
  const [wards, setWards] = useState<any[]>([]); //xã
  const [selectedProvince, setSelectedProvince] = useState<string>("");
  const [selectedDistrict, setSelectedDistrict] = useState<string>("");
  const [selectedWard, setSelectedWard] = useState<string>("");
  const [streetAddress, setStreetAddress] = useState<string>("");
  const [selectedPaymentMethod, setSelectedPaymentMethod] =
    useState<string>("");
  const [discounts, setDiscounts] = useState<any[]>([]);
  const [selectedDiscountCode, setSelectedDiscountCode] = useState<string>("");
  // const [appliedDiscount, setAppliedDiscount] = useState<any>(null);
  const { Option } = Select;

  //bắt sự kiện trả về của VNPAY
  const [searchParams] = useSearchParams();
  const responseCode = searchParams.get("vnp_ResponseCode");
  const notificationShownRef = useRef(false);
  useEffect(() => {
    const fetchDiscounts = async () => {
      try {
        const response = await getAllGiamGia_DangHoatDong();

        const currentDate = new Date();
        const filteredDiscounts = response.filter((discount: any) => {
          const startDate = new Date(discount.ngayBatDau);
          const endDate = new Date(discount.ngayKetThuc);
          return (
            discount.maGiamGia !== null &&
            currentDate >= startDate &&
            currentDate <= endDate
          );
        });
        console.log("danh sách giảm gia", filteredDiscounts);
        setDiscounts(filteredDiscounts);
      } catch (error) {
        console.error("Error fetching active discounts:", error);
      }
    };
    fetchDiscounts();
  }, []);

  //tỉnh
  useEffect(() => {
    const fetchProvinces = async () => {
      try {
        const provincesData = await GetProvinces();
        setProvinces(provincesData);
      } catch (error) {
        console.error("Error fetching provinces:", error);
      }
    };
    fetchProvinces();
  }, []);
  //huyện
  useEffect(() => {
    const fetchDistricts = async () => {
      if (selectedProvince) {
        try {
          const districtsData = await GetDistricts(selectedProvince);
          setDistricts(districtsData);
        } catch (error) {
          console.error("Error fetching districts:", error);
        }
      } else {
        setDistricts([]);
      }
    };
    fetchDistricts();
  }, [selectedProvince]);
  //xã
  useEffect(() => {
    const fetchWards = async () => {
      if (selectedProvince) {
        setWards([]);
      }
      if (selectedDistrict) {
        try {
          const wardsData = await GetWards(selectedDistrict);
          setWards(wardsData);
        } catch (error) {
          console.error("Error fetching wards:", error);
        }
      } else {
        setWards([]);
      }
    };
    fetchWards();
  }, [selectedDistrict, selectedProvince]);

  useEffect(() => {
    const handlePayment = async () => {
      if (responseCode && !notificationShownRef.current) {
        notificationShownRef.current = true;

        if (responseCode === "00") {
          const urlParams = new URLSearchParams(window.location.search);
          const transactionInfo = {
            amount: urlParams.get("vnp_Amount"),
            bankCode: urlParams.get("vnp_BankCode"),
            bankTranNo: urlParams.get("vnp_BankTranNo"),
            cardType: urlParams.get("vnp_CardType"),
            orderInfo: urlParams.get("vnp_OrderInfo"),
            payDate: urlParams.get("vnp_PayDate"),
            responseCode: urlParams.get("vnp_ResponseCode"),
            tmnCode: urlParams.get("vnp_TmnCode"),
            transactionNo: urlParams.get("vnp_TransactionNo"),
            transactionStatus: urlParams.get("vnp_TransactionStatus"),
            txnRef: urlParams.get("vnp_TxnRef"),
          };
          const now = new Date().toISOString(); // Ngày tạo hiện tại

          const paymentRequest = {
            maGiaoDich: 0, // Mặc định, nếu backend tự sinh ID
            soTien: Number(transactionInfo.amount) / 100, // Vì VNPAY trả * 100
            maNganHang: transactionInfo.bankCode,
            maGiaoDichNganHang: transactionInfo.bankTranNo,
            loaiThe: transactionInfo.cardType,
            thongTinDonHang: transactionInfo.orderInfo,
            ngayThanhToan: transactionInfo.payDate,
            maPhanHoi: transactionInfo.responseCode,
            maWebsite: transactionInfo.tmnCode,
            maGiaoDichVNPay: transactionInfo.transactionNo,
            trangThaiGiaoDich: transactionInfo.transactionStatus,
            maThamChieu: transactionInfo.txnRef,
            ngayTao: now,
            maHoaDon: Number(localStorage.getItem("maHoaDon")) || 0, // Tạm thời là 0, cập nhật nếu bạn có mã hóa đơn
          };
          localStorage.setItem(
            "transactionInfo",
            JSON.stringify(transactionInfo)
          );
          localStorage.setItem("cart", JSON.stringify([]));

          // Gọi API insert thanh toán
          await InsertPaymentVnpay(paymentRequest);

          Modal.success({
            title: "Thanh toán thành công!",
            content: (
              <div>
                <p style={{ marginBottom: "16px" }}>Cảm ơn bạn đã mua hàng</p>
                <div
                  style={{ borderTop: "1px solid #e8e8e8", paddingTop: "16px" }}
                >
                  <h4>Thông tin giao dịch:</h4>
                  <p>Số tiền: {Number(transactionInfo.amount) / 100} VNĐ</p>
                  <p>Mã ngân hàng: {transactionInfo.bankCode}</p>
                  <p>Mã giao dịch ngân hàng: {transactionInfo.bankTranNo}</p>
                  <p>Loại thẻ: {transactionInfo.cardType}</p>
                  <p>Nội dung thanh toán: {transactionInfo.orderInfo}</p>
                  <p>Thời gian thanh toán: {transactionInfo.payDate}</p>
                  <p>Mã giao dịch: {transactionInfo.transactionNo}</p>
                  <p>Mã tham chiếu: {transactionInfo.txnRef}</p>
                </div>
              </div>
            ),
            okText: "Tiếp tục mua sắm",
            onOk: () => {
              chuyentrang("/user/home");
            },
          });
        } else {
          const urlParams = new URLSearchParams(window.location.search);

          Modal.error({
            title: "Thanh toán thất bại",
            content: "Đã có lỗi xảy ra trong quá trình thanh toán. Vui lòng thử lại.",
            okText: "Ok",
            onOk: async () => {
            const maHoaDon = JSON?.parse(localStorage?.getItem("maHoaDonCanHuy") || "null");
            if (maHoaDon) {
              try {
                await axios.post(
                  "https://localhost:44381/api/HoaDonBan/Update_Hoadon",
                  {
                    maHoaDon: maHoaDon,
                    trangThai: "9", // Trạng thái hủy
                    ngayTao: new Date().toISOString(),
                    diaChiGiaoHang: "null",
                    tongGia: 0,
                    maKH: 64,
                    list_json_ChiTietHD: [],
                  }
                );
                localStorage.removeItem("maHoaDonCanHuy");
              } catch (error) {
                console.error("Error canceling order:", error);
              }
            }
            chuyentrang("/user/cart");
            }
          });
        }
      }
    };

    handlePayment(); // Gọi hàm async bên trong useEffect
  }, [responseCode]);

  const chuyentrang = useNavigate();

  // Hàm lấy địa chỉ đầy đủ
  const getFullAddress = () => {
    // Tìm kiếm với nhiều trường hợp khác nhau
    const province = provinces.find(
      (p) => String(p.code) === String(selectedProvince)
    );
    const district = districts.find(
      (d) => String(d.code) === String(selectedDistrict)
    );
    const ward = wards.find((w) => String(w.code) === String(selectedWard));

    if (!province || !district || !ward || !streetAddress) {
      alert("Vui lòng chọn đầy đủ địa chỉ");
      return "null";
    }

    const provinceName = province.name;
    const districtName = district.name;
    const wardName = ward.name;

    // Chỉ thêm các phần tử không rỗng vào địa chỉ
    const addressParts = [
      streetAddress,
      wardName,
      districtName,
      provinceName,
    ].filter((part) => part.trim() !== "");

    return addressParts.join(", ");
  };

  async function order() {
    if (
      !selectedProvince ||
      !selectedDistrict ||
      !selectedWard ||
      !streetAddress
    ) {
      alert("Vui lòng nhập đầy đủ địa chỉ");
      return;
    }

    if (!selectedPaymentMethod) {
      alert("Vui lòng chọn phương thức thanh toán");
      return;
    }

    if (cart.length === 0) {
      alert("Giỏ hàng trống");
      return;
    }
    if (!selectedPaymentMethod) {
      alert("Vui lòng chọn phương thức thanh toán");
      return;
    }
    const fullAddress = getFullAddress(); // full địa chỉ
    const formData = form.getFieldsValue(); //thông tin khách hàng

    // Kiểm tra các trường bắt buộc
    if (!formData.tenKH || !formData.sdt || !formData.email) {
      alert("Vui lòng điền đầy đủ thông tin khách hàng");
      return;
    }
    const customerInfo = {
      tenKH: formData.tenKH,
      sdt: formData.sdt,
      diaChi: fullAddress || "trống",
      email: formData.email,
    };
    console.log("thong tin kH", customerInfo);
    const MaKHInput = await axios.post(
      "https://localhost:44381/api/KhachHang/them-moi",
      {
        tenKH: customerInfo.tenKH,
        diaChi: customerInfo.diaChi,
        sdt: customerInfo.sdt,
        email: customerInfo.email,
      }
    );
    const maKH = MaKHInput.data.maKhachHang;
    let listCTHDB: any[] = []; // danh sách sản phẩm
    cart.map(function (item: any, index) {
      var obj = {
        maSanPham: item.maSanPham,
        soLuong: item.quantity,
        tongGia: item.quantity * item.gia,
        giamGia: "không có",
        maSize: item.maSize,
        status: 0,
      };
      listCTHDB.push(obj);
    });
    const today = new Date();
    const formattedDate = today.toISOString();

    if (!infor) {
      //chọn phương thức COde
      if (selectedPaymentMethod === "cod") {
        try {
          const response = await axios.post(
            "https://localhost:44381/api/HoaDonBan/Create_HoaDon",
            {
              trangThai: "0",
              ngayTao: formattedDate,
              diaChiGiaoHang: fullAddress,
              tongGia: totalPrice,
              maKH: maKH,
              list_json_ChiTietHD: listCTHDB,
            }
          );
          if (response.status === 200) {
            alert("Đặt hàng thành công!");
            const MAHOADON = response.data?.maHoaDon;

            const emailParams = {
              to_name: formData.tenKH,
              to_email: formData.email,
              from_name: "Thời trang nam 4MENSHOP",
              message: `Chi tiết đơn hàng gồm: ${cart
                .map(
                  (item: any) =>
                    `\n- ${item.tenSanPham} (${item.quantity} cái, Size: ${
                      item.tenSize
                    }, Giá: ${new Intl.NumberFormat("vi-VN", {
                      style: "currency",
                      currency: "VND",
                    }).format(item.quantity * item.gia)})`
                )
                .join("")}`,
              reply_to: "shop@example.com",
              order_id: MAHOADON,
              order_status: "Chờ xác nhận",
              order_total: new Intl.NumberFormat("vi-VN", {
                style: "currency",
                currency: "VND",
              }).format(Number(totalPrice)),
            };
            try {
              const emailResult = await sendOrderStatusEmail(emailParams);
              // console.log("Email Result:", emailResult);
            } catch (emailError) {
              console.error("Email Error:", emailError);
            }
            localStorage.setItem("cart", JSON.stringify([]));
            window.location.href = "/user/home";
          }
        } catch (error) {
          console.error("Error fetching data:", error);
        }
      } else {
        //chọn phương thức thanh toán online
        let MAHOADON: any;
        try {
          const response = await axios.post(
            "https://localhost:44381/api/HoaDonBan/Create_HoaDon",
            {
              trangThai: "0",
              ngayTao: formattedDate,
              diaChiGiaoHang: fullAddress,
              tongGia: totalPrice,
              maKH: maKH,
              list_json_ChiTietHD: listCTHDB,
            }
          );
          if (response.status === 200) {
            MAHOADON = response.data?.maHoaDon;
            localStorage.setItem("maHoaDonCanHuy", String(MAHOADON));
            const emailParams = {
              to_name: formData.tenKH,
              to_email: formData.email,
              from_name: "Thời trang nam 4MENSHOP",
              message: `Chi tiết đơn hàng gồm: ${cart
                .map(
                  (item: any) =>
                    `\n- ${item.tenSanPham} (${item.quantity} cái, Size: ${
                      item.tenSize
                    }, Giá: ${new Intl.NumberFormat("vi-VN", {
                      style: "currency",
                      currency: "VND",
                    }).format(item.quantity * item.gia)})`
                )
                .join("")}`,
              reply_to: "shop@example.com",
              order_id: MAHOADON,
              order_status: "Chờ xác nhận",
              order_total: new Intl.NumberFormat("vi-VN", {
                style: "currency",
                currency: "VND",
              }).format(Number(totalPrice)),
            };

            try {
              const emailResult = await sendOrderStatusEmail(emailParams);
              // console.log("Email Result:", emailResult);
            } catch (emailError) {
              console.error("Email Error:", emailError);
            }
            alert("Đặt hàng thành công!");
            // localStorage.setItem('cart',JSON.stringify([]));
          }
        } catch (error) {
          console.error("Error fetching data:", error);
        }

        const paymentData = {
          orderType: "fashion",
          amount: Number(totalPrice), // Convert to number primitive
          orderDescription: "Thanh toan don hang",
          name: formData.tenKH || "Khach hang",
        };
        try {
          const response = await CreatePaymentUrlVnpay(paymentData);
          console.log(response);
          if (response?.paymentUrl) {
            // Gắn mã hóa đơn vào localStorage để gửi về sau khi thanh toán thành công
            localStorage.setItem("maHoaDon", String(MAHOADON));
            window.location.href = response.paymentUrl;
          } else {
            alert("Không thể tạo URL thanh toán");
          }
        } catch (error) {
          console.error("Error creating payment URL:", error);
          alert("Có lỗi xảy ra khi tạo URL thanh toán");
        }
      }
    } else {
      // if (selectedPaymentMethod === "cod") {
      //   // alert("thanh toan trực tiếp")
      //   CreateCart()
      // } else {
      //   const maHoaDon = await CreateCartThanhToanOnline();
      //   console.log("Mã hóa đơn:", maHoaDon);
      //   // alert("Online")
      //   const paymentData = {
      //     orderType: "fashion",
      //     amount: Number(totalPrice), // Convert to number primitive
      //     orderDescription: "Thanh toan don hang",
      //     name: infor?.tenKH || "Khach hang"
      //   };
      //   try {
      //     const response = await CreatePaymentUrlVnpay(paymentData);
      //     console.log(response)
      //     if (response?.paymentUrl) {
      //       // Gắn mã hóa đơn vào localStorage để gửi về sau khi thanh toán thành công
      //       localStorage.setItem("maHoaDon", String(maHoaDon));
      //       window.location.href = response.paymentUrl;
      //     } else {
      //       alert("Không thể tạo URL thanh toán");
      //     }
      //   } catch (error) {
      //     console.error("Error creating payment URL:", error);
      //     alert("Có lỗi xảy ra khi tạo URL thanh toán");
      //   }
      // }
    }
  }

  // async function CreateCart() {
  //   if (infor == null) {
  //     alert("Vui lòng đăng nhập");
  //   } else {
  //     const fullAddress = getFullAddress();

  //     console.log("Địa chỉ đầy đủ:", fullAddress);
  //     console.log("Mã Khách hàng:", infor.maKH);
  //     // Tiếp tục xử lý đặt hàng với địa chỉ đầy đủ
  //     const diaChiInputValue = fullAddress;
  //     if (diaChiInputValue === "null") {
  //       return;
  //     }
  //     let listCTHDB: any[] = [];
  //     cart.map(function (item: any, index) {
  //       var obj = {
  //         maSanPham: item.maSanPham,
  //         soLuong: item.quantity,
  //         tongGia: item.quantity * item.gia,
  //         giamGia: "không có",
  //         maSize: item.maSize,
  //         status: 0,
  //       };
  //       listCTHDB.push(obj);
  //     });
  //     const today = new Date();
  //     const formattedDate = today.toISOString();
  //     try {
  //       const response = await axios.post(
  //         "https://localhost:44381/api/HoaDonBan/Create_HoaDon",
  //         {
  //           trangThai: "0",
  //           ngayTao: formattedDate,
  //           diaChiGiaoHang: diaChiInputValue,
  //           tongGia: totalPrice,
  //           maKH: infor?.maKH || "null",
  //           list_json_ChiTietHD: listCTHDB,
  //         }
  //       );
  //       if (response.status === 200) {
  //         alert("Đặt hàng thành công!");
  //         localStorage.setItem("cart", JSON.stringify([]));
  //       }
  //     } catch (error) {
  //       console.error("Error fetching data:", error);
  //     }
  //   }
  // }
  // async function CreateCartThanhToanOnline() {
  //   const fullAddress = getFullAddress();

  //   // Tiếp tục xử lý đặt hàng với địa chỉ đầy đủ
  //   const diaChiInputValue = fullAddress;
  //   if (diaChiInputValue === "null") {
  //     return;
  //   }
  //   let listCTHDB: any[] = [];
  //   cart.map(function (item: any, index) {
  //     var obj = {
  //       maSanPham: item.maSanPham,
  //       soLuong: item.quantity,
  //       tongGia: item.quantity * item.gia,
  //       giamGia: "không có",
  //       maSize: item.maSize,
  //       status: 0,
  //     };
  //     listCTHDB.push(obj);
  //   });
  //   const today = new Date();
  //   const formattedDate = today.toISOString();
  //   try {
  //     const response = await axios.post(
  //       "https://localhost:44381/api/HoaDonBan/Create_HoaDon",
  //       {
  //         trangThai: "0",
  //         ngayTao: formattedDate,
  //         diaChiGiaoHang: diaChiInputValue,
  //         tongGia: totalPrice,
  //         maKH: infor?.maKH || "null",
  //         list_json_ChiTietHD: listCTHDB,
  //       }
  //     );
  //     if (response.status === 200) {
  //       const maHoaDon = response.data?.maHoaDon;
  //       if (maHoaDon) {
  //         console.log("Đặt hàng thành công, mã hóa đơn:", maHoaDon);
  //         return maHoaDon;
  //       }
  //       alert("Đặt hàng thành công!");
  //       // localStorage.setItem('cart',JSON.stringify([]));
  //     }
  //   } catch (error) {
  //     console.error("Error fetching data:", error);
  //   }
  // }

  useEffect(() => {
    if (infor) {
      form.setFieldsValue({
        maKH: infor.maKH,
        tenKH: infor.tenKH,
        diaChi: infor.diaChi,
        sdt: infor.sdt,
      });
    }
  }, []);

  useEffect(() => {
    let isFirstRender = true;
    try {
      const cartData = localStorage.getItem("cart");
      if (cartData && isFirstRender) {
        const parsedCart = JSON.parse(cartData);
        console.log("ThongtinGioHang", parsedCart);
        setCart(parsedCart);
        setCartRecoil(parsedCart);
        if (parsedCart.length === 0) {
          setCart([]);
          setCartRecoil([]);
          alert("Giỏ hàng của bạn đang trống!");
          chuyentrang("/user/home");
          return;
        }
      } else {
        setCart([]);
        setCartRecoil([]);
      }
    } catch (error) {
      console.error("Error loading cart data:", error);
      setCart([]);
      setCartRecoil([]);
    }
    return () => {
      isFirstRender = false;
    };
  }, []);

  useEffect(() => {
    const totalPriceCalculated = cart.reduce(
      (total, item) => total + item.gia * item.quantity,
      0
    );

    setTotalPrice(totalPriceCalculated);
  }, [cart]);

  const handleDecreaseQuantity = (index: number) => {
    const updatedCart = cart.map((item, i) => {
      if (i === index && item.quantity > 1) {
        return {
          ...item, //tạo một bản sao của phần tử hiện tại
          quantity: item.quantity - 1,
        };
      }
      return item;
    });
    setCart(updatedCart);
    localStorage.setItem("cart", JSON.stringify(updatedCart));
  };

  const handleIncreaseQuantity = (index: number) => {
    const updatedCart = cart.map((item, i) => {
      if (i === index) {
        if (item.quantity >= item.soLuongSPtrongKho) {
          alert(`Chỉ còn ${item.soLuongSPtrongKho} sản phẩm trong kho`);
          return item;
        }
        return {
          ...item,
          quantity: item.quantity + 1,
        };
      }
      return item;
    });
    setCart(updatedCart);
    localStorage.setItem("cart", JSON.stringify(updatedCart));
  };

  const handleRemoveItem = (index: number) => {
    const updatedCart = cart.filter((_, i) => i !== index);
    setCart(updatedCart);
    localStorage.setItem("cart", JSON.stringify(updatedCart));

    let list: CartItem[] = JSON.parse(localStorage.getItem("cart") || "[]");
    const a: any = list;
    setCartRecoil(a);
  };
  function ChuyenCartHistory() {
    chuyentrang("/user/carthistory");
  }

  // Function to apply discount code
  const handleApplyDiscount = async () => {
    if (!selectedDiscountCode) {
      message.warning("Vui lòng chọn mã giảm giá");
      return;
    }
    console.log(selectedDiscountCode);
    try {
      const selectedDiscount = discounts.find(
        (d) => d.maGiamGia === selectedDiscountCode
      );
      if (!selectedDiscount) {
        message.error("Mã giảm giá không hợp lệ");
        return;
      }

      const discountValue = selectedDiscount.giaTriGiam;
      const discountType = selectedDiscount.loaiGiamGia;

      // Calculate total price before discount
      const totalBeforeDiscount = cart.reduce(
        (total, item) => total + item.gia * item.quantity,
        0
      );

      // Apply discount based on type
      let finalPrice = totalBeforeDiscount;
      if (discountType === "PhanTramTheoDonHang") {
        finalPrice = totalBeforeDiscount * (1 - discountValue / 100);
      } else {
        finalPrice = totalBeforeDiscount - discountValue;
      }
      const discountAmount = totalBeforeDiscount - finalPrice;
      message.success(
        `Áp dụng mã giảm giá thành công! Đã giảm ${discountAmount.toLocaleString(
          "vi-VN"
        )}đ`
      );
      setTotalPrice(finalPrice);
    } catch (error) {
      console.error("Error applying discount:", error);
      message.error("Có lỗi xảy ra khi áp dụng mã giảm giá");
    }
  };

  return (
    <>
      {/* Hello world */}
      <div className="botom-head">
        <ul>
          <li>
            <a href="">4MEN &nbsp; / &nbsp;</a>
          </li>
          <li>
            <a href="">Đơn đặt hàng&nbsp; / &nbsp;</a>
            <a onClick={ChuyenCartHistory}>Đơn hàng đã đặt</a>
          </li>
        </ul>
      </div>
      <div className="content">
        <div className="content-left">
          <Form form={form} style={{ maxWidth: 600 }}>
            <legend>Thông tin khách hàng</legend>
            <Form.Item name={"maKH"} label="Mã khách hàng" hidden>
              <Input />
            </Form.Item>
            <Form.Item
              name={"tenKH"}
              label="Họ và tên"
              rules={[{ required: true, message: "Vui lòng nhập họ và tên!" }]}
            >
              <Input />
            </Form.Item>

            <Form.Item
              name={"sdt"}
              label="Số điện thoại"
              rules={[
                { required: true, message: "Vui lòng nhập số điện thoại!" },
                {
                  pattern: /^[0-9]{10}$/,
                  message: "Số điện thoại phải có 10 chữ số!",
                },
              ]}
            >
              <Input />
            </Form.Item>
            <Form.Item
              name={"email"}
              label="Email"
              rules={[
                { required: true, message: "Vui lòng nhập email!" },
                { type: "email", message: "Email không hợp lệ!" },
              ]}
            >
              <Input />
            </Form.Item>
          </Form>

          <form>
            <legend>Địa chỉ giao hàng</legend>

            <Form.Item name="province" label="Tỉnh/Thành phố">
              <select
                onChange={(e) => {
                  setSelectedProvince(e.target.value);
                }}
                style={{ width: "100%", height: "38px" }}
                value={selectedProvince}
              >
                <option value="">Chọn tỉnh/thành phố</option>
                {provinces.map((province) => (
                  <option key={province.code} value={province.code}>
                    {province.name}
                  </option>
                ))}
              </select>
            </Form.Item>

            <Form.Item name="district" label="Huyện/Quận">
              <select
                onChange={(e) => {
                  setSelectedDistrict(e.target.value);
                }}
                style={{ width: "100%", height: "38px" }}
                value={selectedDistrict}
              >
                <option value="">Chọn huyện/quận</option>
                {districts.map((district) => (
                  <option key={district.code} value={district.code}>
                    {district.name}
                  </option>
                ))}
              </select>
            </Form.Item>
            <Form.Item name="ward" label="Xã/Phường">
              <select
                onChange={(e) => {
                  setSelectedWard(e.target.value);
                }}
                style={{ width: "100%", height: "38px" }}
                value={selectedWard}
              >
                <option value="">Chọn xã/phường</option>
                {wards.map((ward) => (
                  <option key={ward.code} value={ward.code}>
                    {ward.name}
                  </option>
                ))}
              </select>
            </Form.Item>

            <Form.Item name="street" label="Số nhà, tên đường">
              <Input
                placeholder="Nhập số nhà, tên đường"
                style={{ width: "100%", height: "38px" }}
                onChange={(e) => setStreetAddress(e.target.value)}
              />
            </Form.Item>
          </form>

          <form style={{ marginTop: 30 }}>
            <legend>Hình thức thanh toán</legend>
            <div className="thanh_toan">
              <label htmlFor="cod" className="COD">
                <input
                  type="radio"
                  id="cod"
                  name="payment"
                  value="cod"
                  onChange={(e) => setSelectedPaymentMethod(e.target.value)}
                />
                <span>
                  <img
                    style={{ width: 56, height: 31, marginTop: 6 }}
                    src="../assets/anh/giohang-radio1.svg"
                    alt="COD"
                  />
                </span>
                <div style={{ width: "70%", marginTop: 5, float: "right" }}>
                  COD
                  <br />
                  <em>Thanh toán khi nhận hàng</em>
                </div>
              </label>

              <label htmlFor="money" className="COD">
                <input
                  type="radio"
                  id="money"
                  name="payment"
                  value="money"
                  onChange={(e) => setSelectedPaymentMethod(e.target.value)}
                />
                <span>
                  <img
                    style={{ width: 56, height: 31, marginTop: 6 }}
                    src="../assets/anh/money.png"
                    alt="Money"
                  />
                </span>
                <div style={{ width: "70%", marginTop: 5, float: "right" }}>
                  COD
                  <br />
                  <em>Thanh toán online</em>
                </div>
              </label>
            </div>
          </form>
          <button className="thanh-toan" onClick={order}>
            THANH TOÁN
          </button>
        </div>
        <div className="content-right">
          <form>
            <legend>Giỏ hàng của bạn</legend>
            <table className="content-right-giohang">
              <thead>
                <tr>
                  <th>Hình</th>
                  <th>Thông tin sản phẩm</th>
                  <th style={{ width: 40 }}>SL</th>
                  <th>Size</th>
                  <th style={{ width: 70 }}>Đơn giá</th>
                  <th style={{ width: 50 }}>Xóa</th>
                </tr>
              </thead>
              <tbody className="parentListCart">
                {cart.map((x: any, index: any) => (
                  <tr key={index}>
                    <td>
                      <img
                        src={
                          x?.anhDaiDien
                            ? IMAGE_BASE_PATH +
                              x.anhDaiDien.split(",")[0].trim()
                            : ""
                        }
                        style={{ width: 50 }}
                      />
                    </td>
                    <td>
                      <p>
                        <span className="TTSP">{x.tenSanPham}</span>
                      </p>
                    </td>
                    <td style={{ display: "flex", marginTop: 25 }}>
                      <div>
                        <button
                          style={{ width: 18 }}
                          className="tang"
                          type="button"
                          onClick={() => handleIncreaseQuantity(index)}
                        >
                          +
                        </button>
                      </div>
                      <input
                        style={{ textAlign: "center" }}
                        className="sl"
                        type="text"
                        value={x.quantity}
                        min={1}
                      />
                      <div>
                        <button
                          style={{ width: 18 }}
                          className="giam"
                          type="button"
                          onClick={() => handleDecreaseQuantity(index)}
                        >
                          -
                        </button>
                      </div>
                    </td>
                    <td>
                      {x.tenSize}
                      {/* {x.maSize} */}
                    </td>
                    <td>
                      <p>
                        <span className="gia">
                          {x.gia.toLocaleString("vi-VN", {
                            style: "currency",
                            currency: "VND",
                          })}
                        </span>
                        {/* {x.maSanPham} */}
                      </p>
                    </td>
                    <td>
                      <button
                        onClick={() => handleRemoveItem(index)}
                        className="xoa"
                      >
                        Xóa
                      </button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </form>
          <form action="">
            <legend>Mã giảm giá (nếu có)</legend>
            <div style={{ marginBottom: "16px" }}>
              <Select
                style={{ width: "100%" }}
                placeholder="Chọn mã giảm giá"
                onChange={(value) => setSelectedDiscountCode(value)}
                value={selectedDiscountCode || undefined}
              >
                {discounts.map((discount) => (
                  <Option key={discount.id} value={discount.maGiamGia}>
                    <div
                      style={{
                        display: "flex",
                        justifyContent: "space-between",
                        alignItems: "center",
                        gap: "8px",
                      }}
                    >
                      <div style={{ fontWeight: "bold" }}>
                        {discount.maGiamGia}
                      </div>
                      <div style={{ color: "green", flexShrink: 0 }}>
                        {discount.loaiGiamGia === "PhanTramTheoDonHang"
                          ? `Giảm ${discount.giaTriGiam}%`
                          : `Giảm ${discount.giaTriGiam?.toLocaleString(
                              "vi-VN"
                            )}đ`}
                      </div>
                      <div
                        style={{
                          fontSize: "12px",
                          color: "#666",
                          textAlign: "right",
                          flexShrink: 0,
                        }}
                      >
                        HSD:{" "}
                        {new Date(discount.ngayKetThuc).toLocaleDateString(
                          "vi-VN"
                        )}
                      </div>
                    </div>
                  </Option>
                ))}
              </Select>
            </div>
            <div className="form-group">
              <div className="form-group-input" style={{ padding: 0 }}>
                <input
                  type="text"
                  className="content-left-input"
                  placeholder="Nhập mã giảm giá"
                  value={selectedDiscountCode}
                  readOnly
                  style={{ backgroundColor: "#f0f0f0" }}
                />
              </div>
              <button
                type="button"
                className="apdung"
                onClick={handleApplyDiscount}
              >
                Áp dụng
              </button>
            </div>
          </form>
          <form>
            {/* <div style="width: 100%;height: 30px;font-size: 14px; border-bottom: 1px solid gray;padding: 5px;">Số tiền mua sản phẩm:
                  <span class="totalProduct" style="float: right;"></span>
              </div> */}
            <div
              style={{
                width: "100%",
                height: 30,
                fontSize: 14,
                borderBottom: "1px solid gray",
                padding: 5,
                textAlign: "left",
              }}
            >
              Chi tiết giảm giá
            </div>
            <div
              className="tongcong"
              style={{
                width: "100%",
                height: 30,
                fontSize: 14,
                borderTop: "1px solid gray",
                padding: 5,
                fontWeight: "bold",
                textAlign: "left",
              }}
            >
              Tổng tiền thanh toán
              <span style={{ float: "right" }}>
                {Number(totalPrice).toLocaleString("vi-VN", {
                  style: "currency",
                  currency: "VND",
                })}
              </span>
            </div>
          </form>
        </div>
      </div>
    </>
  );
};
export default Cart;
