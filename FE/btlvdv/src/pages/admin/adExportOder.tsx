import "../../assets/css/exportCart.css";
import React, { useEffect, useState } from "react";
import { Col, Row, Steps } from "antd";

import {
  Input,
  Modal,
  Space,
  Table,
  Tag,
  Form,
  Button,
  Radio,
  Select,
  Dropdown,
  MenuProps,
  message,
  Spin,
  Card,
  Divider,
} from "antd";
import NumberFormat from "react-number-format";
import moment from "moment";
import axios from "axios";
import { values } from "../../assets/anh/fontawesome-free-6.4.0-web/js/v4-shims";
import {
  CarOutlined,
  CheckCircleOutlined,
  CloseCircleOutlined,
  DollarOutlined,
  DownOutlined,
  InboxOutlined,
  LoadingOutlined,
  ReloadOutlined,
  RollbackOutlined,
  SyncOutlined,
  FilterOutlined,
  EyeOutlined,
  EditOutlined,
  DeleteOutlined,
} from "@ant-design/icons";
import { SearchProps } from "antd/es/input";
import { IMAGE_BASE_PATH } from "../../constant/imageBasePath ";
import { sendOrderStatusEmail } from "../../utils/emailService";
import { CongTraLaiSoLuongSP } from "../../services/product.services";

const { Column, ColumnGroup } = Table;

const AdminExportOder: React.FC = () => {
  const statusSteps = [
    {
      value: "0",
      label: "Chờ xác nhận",
      description: "Khách vừa đặt hàng, chưa duyệt",
      icon: <SyncOutlined />,
      color: "#1890ff",
    },
    {
      value: "1",
      label: "Đã xác nhận",
      description: "Admin duyệt đơn, đã sẵn sàng xử lý",
      icon: <CheckCircleOutlined />,
      color: "#52c41a",
    },
    {
      value: "3",
      label: "Đang chuẩn bị hàng",
      description: "Nhân viên đang chuẩn bị hàng",
      icon: <InboxOutlined />,
      color: "#fa8c16",
    },
    {
      value: "4",
      label: "Đang giao hàng",
      description: "Giao cho bên vận chuyển",
      icon: <CarOutlined />,
      color: "#13c2c2",
    },
    {
      value: "5",
      label: "Hoàn tất",
      description: "Đơn hàng đã được giao và hoàn thành",
      icon: <CheckCircleOutlined />,
      color: "#52c41a",
    },
  ];

  const cancelSteps = [
    {
      value: "7",
      label: "Đã hủy",
      description: "Đơn bị hủy bởi khách hoặc shop",
      icon: <CloseCircleOutlined />,
      color: "#f5222d",
    },
    {
      value: "8",
      label: "Trả hàng / Hoàn tiền",
      description: "Với đơn đã thanh toán online mà bị hủy/trả hàng",
      icon: <RollbackOutlined />,
      color: "#faad14",
    },
  ];

  const [oderAll, setOderAll] = useState<any[]>([]);
  const [data, setData] = useState<any[]>([]);
  const [dataCTHD, setdataCTHD] = useState<any[]>([]);
  const [openModal, setOpenModal] = useState<boolean>(false);
  const [selectedProductPrice, setSelectedProductPrice] = useState<number>(0); // State để lưu giá sản phẩm được chọn
  const [products, setProduct] = useState<any[]>([]);
  const [isAdd, setIsAdd] = useState<boolean>(false);
  const [form] = Form.useForm();
  const [formCTDH] = Form.useForm();
  const [isStatusModalOpen, setIsStatusModalOpen] = useState<boolean>(false);
  const [isDetailModalOpen, setIsDetailModalOpen] = useState<boolean>(false);
  const [selectedOrder, setSelectedOrder] = useState<any>(null);
  const [selectedRowKeys, setSelectedRowKeys] = useState<React.Key[]>([]);
  const [loading, setLoading] = useState(false);
  const [dateFilter, setDateFilter] = useState<string>("all");

  const getDateRange = (filter: string) => {
    const now = new Date();
    const startOfDay = new Date(
      now.getFullYear(),
      now.getMonth(),
      now.getDate()
    );
    const endOfDay = new Date(
      now.getFullYear(),
      now.getMonth(),
      now.getDate(),
      23,
      59,
      59
    );

    switch (filter) {
      case "today":
        return { start: startOfDay, end: endOfDay };
      case "yesterday":
        const yesterday = new Date(startOfDay);
        yesterday.setDate(yesterday.getDate() - 1);
        return {
          start: yesterday,
          end: new Date(
            yesterday.getFullYear(),
            yesterday.getMonth(),
            yesterday.getDate(),
            23,
            59,
            59
          ),
        };
      case "thisWeek":
        const startOfWeek = new Date(startOfDay);
        startOfWeek.setDate(startOfWeek.getDate() - startOfWeek.getDay());
        return { start: startOfWeek, end: endOfDay };
      case "lastWeek":
        const lastWeekStart = new Date(startOfDay);
        lastWeekStart.setDate(
          lastWeekStart.getDate() - lastWeekStart.getDay() - 7
        );
        const lastWeekEnd = new Date(lastWeekStart);
        lastWeekEnd.setDate(lastWeekEnd.getDate() + 6);
        lastWeekEnd.setHours(23, 59, 59);
        return { start: lastWeekStart, end: lastWeekEnd };
      case "thisMonth":
        const startOfMonth = new Date(now.getFullYear(), now.getMonth(), 1);
        return { start: startOfMonth, end: endOfDay };
      case "lastMonth":
        const lastMonthStart = new Date(
          now.getFullYear(),
          now.getMonth() - 1,
          1
        );
        const lastMonthEnd = new Date(
          now.getFullYear(),
          now.getMonth(),
          0,
          23,
          59,
          59
        );
        return { start: lastMonthStart, end: lastMonthEnd };
      default:
        return null;
    }
  };

  const filterDataByDate = (data: any[]) => {
    if (dateFilter === "all") return data;

    const range = getDateRange(dateFilter);
    if (!range) return data;

    return data.filter((item) => {
      const orderDate = new Date(item.ngayTao);
      return orderDate >= range.start && orderDate <= range.end;
    });
  };

  const dateFilterOptions: MenuProps["items"] = [
    { key: "all", label: "Tất cả" },
    { key: "today", label: "Hôm nay" },
    { key: "yesterday", label: "Hôm qua" },
    { key: "thisWeek", label: "Tuần này" },
    { key: "lastWeek", label: "Tuần trước" },
    { key: "thisMonth", label: "Tháng này" },
    { key: "lastMonth", label: "Tháng trước" },
  ];

  async function UpdateOderWithDeleteCTHD(record: any) {
    const oder = form.getFieldsValue();
    const data = dataCTHD.length;
    if (data == 1) {
      alert("Không thể xóa!");
    } else {
      try {
        const response = await axios.post(
          "https://localhost:44381/api/HoaDonBan/Update_Hoadon",
          {
            maHoaDon: oder.maHoaDon,
            trangThai: oder.trangThai,
            ngayTao: oder.ngayTao,
            diaChiGiaoHang: oder.diaChiGiaoHang,
            tongGia: oder.tongGia,
            maKH: oder.maKH,
            list_json_ChiTietHD: [
              {
                maChiTietHoaDon: record.maChiTietHoaDon,
                giamGia: "",
                status: 3,
              },
            ],
          }
        );
        response && alert("Cập nhật chi tiết hóa đơn thành công!");
        GetAllCTHD(oder);

        // setdataCTHD(response.data)
      } catch {}
    }
  }

  const onFinish = async (values: any) => {
    const oder = form.getFieldsValue();
    const listCTHD = dataCTHD;
    if (isAdd) {
      // console.log(values.tenChuyenMuc);
    } else {
      try {
        const res = await axios.post(
          "https://localhost:44381/api/HoaDonBan/Update_Hoadon",
          {
            maHoaDon: oder.maHoaDon,
            trangThai: oder.trangThai,
            ngayTao: oder.ngayTao,
            diaChiGiaoHang: oder.diaChiGiaoHang,
            tongGia: oder.tongGia,
            maKH: oder.maKH,
            list_json_ChiTietHD: [],
          }
        );
        alert("Cập nhật thành công!");
        loadData();
        setOpenModal(false);
      } catch {}
    }
  };
  async function loadData() {
    try {
      const response = await axios.get(
        "https://localhost:44381/api/HoaDonBan/getall_with-thanh-toan"
      );
      const modifiedData = response.data.map((item: any, index: any) => ({
        ...item,
        index: index + 1, // Tính số thứ tự và cộng 1
      }));
      setData(modifiedData);
      setOderAll(modifiedData);
      console.log(response.data);
    } catch (error) {
      console.error("Error fetching data:", error);
    }
  }
  async function GetAllCTHD(oder: any) {
    try {
      const response = await axios.get(
        "https://localhost:44381/api/HoaDonBan/List_CTHD_Getbyid?id=" +
          oder.maHoaDon
      );
      setdataCTHD(response.data);

      const listCTHD = response.data;
      let total = 0;
      listCTHD.map((item: any, index: any) => {
        total = total + item.tongGia;
      });
      console.log("tong:" + total);
      // setTotalOder(total);
      // console.log(totalOder)
      form.setFieldsValue({ tongGia: total });
    } catch (error) {
      console.error("Error fetching data:", error);
    }
  }
  const handleDelete = async (record: any) => {
    const shouldDelete = window.confirm("Bạn có chắc chắn muốn xóa không?");
    if (shouldDelete) {
      // Xử lý logic xóa ở đây
      alert(record.maHoaDon);
      const maHoaDon = record.maHoaDon;
      try {
        const response = await axios.delete(
          "https://localhost:44381/api/HoaDonBan/HoaDon_Delete?id=" + maHoaDon
        );
        response && alert("Xóa thành công");
        loadData();
      } catch (error) {
        console.error("Error fetching data:", error);
      }
    }
  };
  useEffect(() => {
    loadData();
  }, []); //Sử dụng useEffect để gọi hàm loadData() trong trường hợp này là cách
  // phổ biến để khởi tạo dữ liệu khi component được render lần đầu tiên
  // useEffect(() => {
  //   async function loadDataProduct() {
  //     try {
  //       const response = await axios.post(
  //         "https://localhost:44381/api/SanPham/search",
  //         {
  //           page: "1",
  //           pageSize: "100",
  //         }
  //       );
  //       const modifiedData = response.data.data.map(
  //         (item: any, index: any) => ({
  //           ...item,
  //           index: index + 1, // Tính số thứ tự và cộng 1
  //         })
  //       );
  //       setProduct(modifiedData);
  //       // console.log(response.data.data);
  //     } catch (error) {
  //       console.error("Error fetching data:", error);
  //     }
  //   }
  //   loadDataProduct();
  // }, []);
  useEffect(() => {
    formCTDH.setFieldsValue({ gia: selectedProductPrice });
  }, [selectedProductPrice]);

  function handleSoLuongChange(value: number) {
    const TongTien = value * selectedProductPrice;
    // console.log(TongTien);
    formCTDH.setFieldsValue({ tongGia: TongTien });
  }

  //dropdown
  const filterData = (key: string) => {
    if (key == "Tất cả") {
      setData(oderAll);
    }
    if (key == "0") {
      const datanew = oderAll.filter((values: any) => {
        return values.trangThai == "0";
      });
      setData(datanew);
    }
    if (key == "1") {
      const datanew = oderAll.filter((values: any) => {
        return values.trangThai == "1";
      });
      setData(datanew);
    }
    if (key == "2") {
      const datanew = oderAll.filter((values: any) => {
        return values.trangThai == "2";
      });
      setData(datanew);
    }
    if (key == "3") {
      const datanew = oderAll.filter((values: any) => {
        return values.trangThai == "3";
      });
      setData(datanew);
    }
  };

  //lọc theo trạng thái
  const onClick: MenuProps["onClick"] = ({ key }) => {
    if (key === "Tất cả") {
      setData(oderAll);
    } else {
      const filteredData = oderAll.filter((order) => order.trangThai === key);
      setData(filteredData);
    }
  };
  const items: MenuProps["items"] = [
    {
      label: "Tất cả",
      key: "Tất cả",
    },
    {
      label: "Chờ xác nhận",
      key: "0",
    },
    {
      label: "Đã xác nhận",
      key: "1", 
    },
    {
      label: "Đang chuẩn bị hàng",
      key: "3",
    },
    {
      label: "Đang giao hàng",
      key: "4",
    },
    {
      label: "Hoàn tất",
      key: "5",
    },
    {
      label: "Đã hủy",
      key: "7",
    },
    {
      label: "Trả hàng / Hoàn tiền",
      key: "8",
    }
  ];

  //Xác nhận đơn hàng
  async function received(value: any) {
    const a = window.confirm("Xác nhận đơn hàng?");
    if (a) {
      try {
        const response = await axios.post(
          "https://localhost:44381/api/HoaDonBan/Update_Hoadon",
          {
            maHoaDon: value.maHoaDon,
            trangThai: "1",
            ngayTao: value.ngayTao,
            diaChiGiaoHang: value.diaChiGiaoHang,
            tongGia: value.tongGia,
            maKH: value.maKH,
            list_json_ChiTietHD: [],
          }
        );
        if (response.status === 200) {
          alert("Xác nhận nhận hàng!");
        }
        loadData();
        // filterData("0");
      } catch (error) {
        console.error("Error fetching data:", error);
      }
    }
  }

  //search
  const { Search } = Input;
  const onSearch: SearchProps["onSearch"] = async (value, _e, info) => {
    try {
      const response = await axios.post(
        "https://localhost:44381/api/HoaDonBan/HoaDon_Search",
        {
          page: "1",
          pageSize: "100",
          TenKH: value,
        }
      );
      const modifiedData = response.data.data.map((item: any, index: any) => ({
        ...item,
        index: index + 1,
      }));
      setData(modifiedData);
    } catch (error) {
      console.error("Error fetching data:", error);
    }
  };

  const handleStatusChange = async (status: string) => {
    if (!selectedOrder) return;

    try {
      setLoading(true);
      console.log("Selected Order:", selectedOrder);
      console.log("Status to update:", status);
      
      const requestData = {
        maHoaDon: selectedOrder.maHoaDon,
        trangThai: status,
        ngayTao: selectedOrder.ngayTao,
        diaChiGiaoHang: selectedOrder.diaChiGiaoHang,
        tongGia: selectedOrder.tongGia,
        maKH: selectedOrder.maKH,
        list_json_ChiTietHD: [],
      };
      
      console.log("Request data:", requestData);
      
      const response = await axios.post(
        "https://localhost:44381/api/HoaDonBan/Update_Hoadon",
        requestData
      );
      if (response.status === 200) {
        message.success("Cập nhật trạng thái thành công!");
        setIsStatusModalOpen(false);
        loadData();
      }
    } catch (error) {
      message.error("Có lỗi xảy ra khi cập nhật trạng thái!");
      console.error("Error updating status:", error);
    } finally {
      setLoading(false);
    }
  };

  const handleStatusChangeInTable = async (record: any, newStatus: string) => {
    try {
      // Kiểm tra nếu trạng thái mới là "Đã hủy"
      if (newStatus === "7" || newStatus === "8") {
        // Lấy chi tiết đơn hàng

        const responseCTHD = await axios.get(
          `https://localhost:44381/api/HoaDonBan/List_CTHD_Getbyid?id=${record.maHoaDon}`
        );
        const chiTietDonHang = responseCTHD.data;
        console.log("Chi tiết đơn hàng:", chiTietDonHang);
        const productList = chiTietDonHang.map((item: any) => ({
          maSanPham: item.maSanPham,
          maSize: item.maSize,
          soLuong: item.soLuong,
        }));
        try {
          await CongTraLaiSoLuongSP(productList);
          message.success("Đã trả số lượng sản phẩm về kho thành công!");
        } catch (error) {
          message.error("Có lỗi xảy ra khi trả số lượng về kho!");
          console.error("Error returning products to inventory:", error);
        }
        console.log("Danh sách sản phẩm cần trả về kho:", productList);
        // Gọi hàm trả số lượng sản phẩm về kho ở đây
        // alert("Đơn hàng bị hủy, cần trả số lượng về kho:");
        // TODO: Gọi API trả số lượng về kho
      }

      const response = await axios.post(
        "https://localhost:44381/api/HoaDonBan/Update_Hoadon",
        {
          maHoaDon: record.maHoaDon,
          trangThai: newStatus,
          ngayTao: record.ngayTao,
          diaChiGiaoHang: record.diaChiGiaoHang,
          tongGia: record.tongGia,
          maKH: record.maKH,
          list_json_ChiTietHD: [],
        }
      );
      if (response.status === 200) {
        // alert("gửi thông báo email");
        // Gửi email thông báo
        const statusInfo = [...statusSteps, ...cancelSteps].find(
          (s) => s.value === newStatus
        );

        // const emailParams = {
        //   to_name: record.tenKH,
        //   to_email: record.email,
        //   from_name: "Thời trang nam 4MENSHOP",
        //   message: `Chi tiết đơn hàng gồm: ${dataCTHD
        //     ?.map(
        //       (item: any) =>
        //         `\n- ${item.tenSanPham} (${item.soLuong} cái, Size: ${
        //           item.tenSize
        //         }, Giá: ${new Intl.NumberFormat("vi-VN", {
        //           style: "currency",
        //           currency: "VND",
        //         }).format(item.tongGia)})`
        //     )
        //     .join("")}`,
        //   reply_to: "shop@example.com",
        //   order_id: record.maHoaDon,
        //   order_status: statusInfo?.label,
        //   order_total: new Intl.NumberFormat("vi-VN", {
        //     style: "currency",
        //     currency: "VND",
        //   }).format(record.tongGia),
        // };

        // try {
        //   const emailResult = await sendOrderStatusEmail(emailParams);
        //   // console.log("Email Result:", emailResult);
        // } catch (emailError) {
        //   console.error("Email Error:", emailError);
        // }

        message.success("Cập nhật trạng thái thành công!");
        loadData();
      }
    } catch (error) {
      message.error("Có lỗi xảy ra khi cập nhật trạng thái!");
      console.error("Error updating status:", error);
    } finally {
      setLoading(false);
    }
  };

  const showStatusModal = (oder: any) => {
    setSelectedOrder(oder);
    setIsStatusModalOpen(true);
  };

  const showDetailModal = (oder: any) => {
    setSelectedOrder(oder);
    setIsDetailModalOpen(true);
    GetAllCTHD(oder);
  };

  const handleBulkAction = async (action: string) => {
    if (selectedRowKeys.length === 0) {
      message.warning("Vui lòng chọn ít nhất một đơn hàng!");
      return;
    }

    const statusMap = {
      confirm: "1",
      cancel: "7",
      prepare: "3",
      shipping: "4",
      complete: "5",
    };

    const confirmMessage = {
      confirm: "Xác nhận các đơn hàng đã chọn?",
      cancel: "Hủy các đơn hàng đã chọn?",
      prepare: "Chuyển các đơn hàng đã chọn sang trạng thái chuẩn bị hàng?",
      shipping: "Chuyển các đơn hàng đã chọn sang trạng thái đang giao hàng?",
      complete: "Hoàn tất các đơn hàng đã chọn?",
    }[action];

    if (!window.confirm(confirmMessage)) return;

    setLoading(true);
    try {
      const promises = selectedRowKeys.map((key) => {
        const order = data.find((item) => item.maHoaDon === key);
        if (!order) return Promise.resolve();

        return axios.post(
          "https://localhost:44381/api/HoaDonBan/Update_Hoadon",
          {
            maHoaDon: order.maHoaDon,
            trangThai: statusMap[action as keyof typeof statusMap],
            ngayTao: order.ngayTao,
            diaChiGiaoHang: order.diaChiGiaoHang,
            tongGia: order.tongGia,
            maKH: order.maKH,
            list_json_ChiTietHD: [],
          }
        );
      });

      await Promise.all(promises);
      message.success("Cập nhật trạng thái thành công!");
      setSelectedRowKeys([]);
      loadData();
    } catch (error) {
      message.error("Có lỗi xảy ra khi cập nhật trạng thái!");
      console.error("Error updating status:", error);
    } finally {
      setLoading(false);
    }
  };

  const rowSelection = {
    selectedRowKeys,
    onChange: (newSelectedRowKeys: React.Key[]) => {
      setSelectedRowKeys(newSelectedRowKeys);
    },
  };

  return (
    <>
      {/* <div style={{ marginBottom: 16 }}>
        <Space>
          <Button
            type="primary"
            onClick={() => handleBulkAction("confirm")}
            disabled={!selectedRowKeys.length}
            loading={loading}
            icon={<CheckCircleOutlined />}
          >
            Xác nhận đơn hàng
          </Button>
          <Button
            type="primary"
            onClick={() => handleBulkAction("prepare")}
            disabled={!selectedRowKeys.length}
            loading={loading}
            icon={<InboxOutlined />}
          >
            Chuẩn bị hàng
          </Button>
          <Button
            type="primary"
            onClick={() => handleBulkAction("shipping")}
            disabled={!selectedRowKeys.length}
            loading={loading}
            icon={<CarOutlined />}
          >
            Giao hàng
          </Button>
          <Button
            type="primary"
            onClick={() => handleBulkAction("complete")}
            disabled={!selectedRowKeys.length}
            loading={loading}
            icon={<CheckCircleOutlined />}
          >
            Hoàn tất
          </Button>
          <Button
            danger
            onClick={() => handleBulkAction("cancel")}
            disabled={!selectedRowKeys.length}
            loading={loading}
            icon={<CloseCircleOutlined />}
          >
            Hủy đơn hàng
          </Button>
          <span style={{ marginLeft: 8 }}>
            {selectedRowKeys.length
              ? `Đã chọn ${selectedRowKeys.length} đơn hàng`
              : ""}
          </span>
        </Space>
      </div> */}

      <Tag>
        <Dropdown menu={{ items, onClick }}>
          <a onClick={(e) => e.preventDefault()}>
            <Space>
              Sắp xếp
              <DownOutlined />
            </Space>
          </a>
        </Dropdown>
      </Tag>
      
      <Tag
        onClick={() => loadData()}
        icon={<SyncOutlined />}
        color="processing"
        style={{ cursor: "pointer" }}
      >
        Làm mới
      </Tag>

      {/* <Button
        style={{
          float: "right",
          marginBottom: "20px",
          backgroundColor: "blue",
          color: "white",
        }}
        onClick={() => {
          alert("Không thành công!");
        }}
      >
        Thêm mới
      </Button> */}
      <Search
        placeholder="Nhập khách hàng"
        onSearch={onSearch}
        enterButton
        style={{ width: "30%", float: "right", marginRight: "10px" }}
      />
      <Table
        size="small"
        dataSource={filterDataByDate(data)}
        rowKey="maHoaDon"
        rowSelection={rowSelection}
        loading={loading}
      >
        <Column 
          title="Mã" 
          dataIndex="maHoaDon" 
          key="maHoaDon"
          render={(text) => `#${text}`}
          filterDropdown={({ setSelectedKeys, selectedKeys, confirm, clearFilters }) => (
            <div style={{ padding: 8 }}>
              <Input
                placeholder="Nhập mã"
                value={selectedKeys[0]}
                onChange={e => setSelectedKeys(e.target.value ? [e.target.value] : [])}
                onPressEnter={() => confirm()}
                style={{ width: 188, marginBottom: 8, display: 'block' }}
              />
              <Space>
                <Button
                  type="primary"
                  onClick={() => confirm()}
                  size="small"
                  style={{ width: 90 }}
                >
                  Tìm kiếm
                </Button>
                <Button
                  onClick={() => clearFilters && clearFilters()}
                  size="small"
                  style={{ width: 90 }}
                >
                  Đặt lại
                </Button>
              </Space>
            </div>
          )}
          onFilter={(value, record: { maHoaDon: number }) => 
            record.maHoaDon.toString().toLowerCase().includes(value.toString().toLowerCase())
          }
        />
        <Column title="Tên khách hàng" dataIndex="tenKH" key="tenKH" />
        {/* <Column title="Email" dataIndex="email" key="email" /> */}

        <Column
          title="Địa chỉ giao hàng"
          dataIndex="diaChiGiaoHang"
          key="diaChiGiaoHang"
        />
        <Column
          title={
            <Space>
              Ngày đặt hàng
              <Dropdown
                menu={{
                  items: dateFilterOptions,
                  onClick: ({ key }) => setDateFilter(key),
                }}
                trigger={["click"]}
              >
                <Button type="text" icon={<FilterOutlined />} />
              </Dropdown>
            </Space>
          }
          dataIndex="ngayTao"
          key="ngayTao"
          render={(text) => moment(text).format("DD/MM/YYYY HH:mm")}
          sorter={(a: any, b: any) =>
            moment(a.ngayTao).unix() - moment(b.ngayTao).unix()
          }
          filteredValue={dateFilter === "all" ? null : [dateFilter]}
          onFilter={(value, record) => {
            const range = getDateRange(value as string);
            if (!range) return true;
            const orderDate = new Date(record.ngayTao);
            return orderDate >= range.start && orderDate <= range.end;
          }}
        />
        <Column
          title="Thanh toán"
          dataIndex="maGiaoDich"
          key="maGiaoDich"
          render={(maGiaoDich: string) => (
            <Tag color={maGiaoDich ? "green" : "blue"}>
              {maGiaoDich ? "Online" : "COD"}
            </Tag>
          )}
        />
        <Column
          title="Tổng tiền"
          dataIndex="tongGia"
          key="tongGia"
          render={(tongGia: number) => (
            <span>
              {new Intl.NumberFormat("vi-VN", {
                style: "currency",
                currency: "VND",
              }).format(tongGia)}
            </span>
          )}
        />
        <Column
          title="Trạng thái"
          dataIndex="trangThai"
          key="trangThai"
          
          render={(trangThai: string, record: any) => {
            const getStatusButtons = () => {
              switch (trangThai) {
                case "0": // Chờ xác nhận
                  return (
                    <Space direction="vertical">
                      <Tag icon={<SyncOutlined />} color="processing">
                        Chờ xác nhận
                      </Tag>
                      <Space>
                        <Button
                          type="primary"
                          size="small"
                          icon={<CheckCircleOutlined />}
                          onClick={() => {
                            Modal.confirm({
                              title: "Xác nhận đơn hàng",
                              content:
                                "Bạn có chắc chắn muốn xác nhận đơn hàng này?",
                              onOk: () =>
                                handleStatusChangeInTable(record, "1"),
                            });
                          }}
                        >
                          Xác nhận
                        </Button>
                        <Button
                          danger
                          size="small"
                          icon={<CloseCircleOutlined />}
                          onClick={() => {
                            Modal.confirm({
                              title: "Hủy đơn hàng",
                              content:
                                "Bạn có chắc chắn muốn hủy đơn hàng này?",
                              onOk: () =>
                                handleStatusChangeInTable(record, "7"),
                            });
                          }}
                        >
                          Hủy
                        </Button>
                      </Space>
                    </Space>
                  );
                case "1": // Đã xác nhận
                  return (
                    <Space direction="vertical">
                      <Tag icon={<CheckCircleOutlined />} color="success">
                        Đã xác nhận
                      </Tag>
                      <Button
                        type="primary"
                        size="small"
                        icon={<InboxOutlined />}
                        onClick={() => {
                          Modal.confirm({
                            title: "Chuẩn bị hàng",
                            content:
                              "Bạn có chắc chắn muốn chuyển sang trạng thái chuẩn bị hàng?",
                            onOk: () => handleStatusChangeInTable(record, "3"),
                          });
                        }}
                      >
                        Chuẩn bị hàng
                      </Button>
                    </Space>
                  );
                case "3": // Đang chuẩn bị hàng
                  return (
                    <Space direction="vertical">
                      <Tag icon={<InboxOutlined />} color="processing">
                        Đang chuẩn bị hàng
                      </Tag>
                      <Button
                        type="primary"
                        size="small"
                        icon={<CarOutlined />}
                        onClick={() => {
                          Modal.confirm({
                            title: "Giao hàng",
                            content:
                              "Bạn có chắc chắn muốn chuyển sang trạng thái đang giao hàng?",
                            onOk: () => handleStatusChangeInTable(record, "4"),
                          });
                        }}
                      >
                        Giao hàng
                      </Button>
                    </Space>
                  );
                case "4": // Đang giao hàng
                  return (
                    <Space direction="vertical">
                      <Tag icon={<CarOutlined />} color="processing">
                        Đang giao hàng
                      </Tag>
                      <Space>
                        <Button
                          type="primary"
                          size="small"
                          icon={<CheckCircleOutlined />}
                          onClick={() => {
                            Modal.confirm({
                              title: "Hoàn tất đơn hàng",
                              content:
                                "Bạn có chắc chắn đơn hàng đã được giao thành công?",
                              onOk: () =>
                                handleStatusChangeInTable(record, "5"),
                            });
                          }}
                        >
                          Hoàn tất
                        </Button>
                        <Button
                          danger
                          size="small"
                          icon={<RollbackOutlined />}
                          onClick={() => {
                            Modal.confirm({
                              title: "Trả hàng/Hoàn tiền",
                              content:
                                "Bạn có chắc chắn muốn chuyển sang trạng thái trả hàng/hoàn tiền?",
                              onOk: () =>
                                handleStatusChangeInTable(record, "8"),
                            });
                          }}
                        >
                          Trả hàng
                        </Button>
                      </Space>
                    </Space>
                  );
                case "5": // Hoàn tất
                  return (
                    <Tag icon={<CheckCircleOutlined />} color="success">
                      Hoàn tất
                    </Tag>
                  );
                case "7": // Đã hủy
                  return (
                    <Tag icon={<CloseCircleOutlined />} color="error">
                      Đã hủy
                    </Tag>
                  );
                case "8": // Trả hàng/Hoàn tiền
                  return (
                    <Tag icon={<RollbackOutlined />} color="warning">
                      Trả hàng/Hoàn tiền
                    </Tag>
                  );
                default:
                  return <Tag>Hủy thanh toán</Tag>;
              }
            };

            return getStatusButtons();
          }}
        />
        <Column
          title="Action"
          key="action"
          render={(_: any, record: any) => (
            <Space size="middle">
              <a onClick={() => showStatusModal(record)}><EditOutlined /></a>
              <a onClick={() => handleDelete(record)}><DeleteOutlined /></a>
              <a onClick={() => showDetailModal(record)}><EyeOutlined /></a>
            </Space>
          )}
        />
      </Table>

      {/* <Modal
        centered
        title={isAdd ? "Chi tiết đơn hàng " : "Sửa đơn hàng"}
        open={openModal}
        onCancel={() => {
          form.resetFields();
          setOpenModal(false);
          formCTDH.resetFields();
        }}
        onOk={() => {
          form.submit();
        }}
        cancelText="Đóng"
        width={700}
        style={{ textAlign: "center" }}
      >
        <Form
          name="HoaDon"
          form={form}
          onFinish={onFinish}
          layout="vertical"
          style={{ maxWidth: 800, margin: "auto" }}
        >
          <Row gutter={16}>
            {!isAdd && (
              <Col span={12}>
                <Form.Item
                  name={"maHoaDon"}
                  initialValue={0}
                  label="Mã hóa đơn"
                >
                  <Input disabled />
                </Form.Item>
              </Col>
            )}
            <Col span={12}>
              <Form.Item name={"tenKH"} label="Tên khách hàng">
                <Input />
              </Form.Item>
            </Col>

            <Form.Item name="maKH" hidden>
              <Input />
            </Form.Item>
          </Row>

          <Row gutter={16}>
            <Col span={12}>
              <Form.Item name={"diaChiGiaoHang"} label="Địa chỉ giao hàng">
                <Input />
              </Form.Item>
            </Col>
            <Col span={12}>
              <Form.Item name={"ngayTao"} label="Ngày đặt hàng">
                <Input disabled />
              </Form.Item>
            </Col>
          </Row>

          <Row gutter={16}>
            <Col span={12}>
              <Form.Item name={"tongGia"} label="Tổng tiền">
                <Input disabled />
              </Form.Item>
            </Col>
            <Col span={12}>
              <Form.Item label="Trạng thái" name="trangThai">
                <Radio.Group buttonStyle="solid">
                  <Radio.Button value="0">Chờ xác nhận</Radio.Button>
                  <Radio.Button value="1">Đã xác nhận</Radio.Button>
                  <Radio.Button value="3">Chuẩn bị hàng</Radio.Button>
                  <Radio.Button value="4">Đang giao</Radio.Button>
                  <Radio.Button value="5">Hoàn tất</Radio.Button>
                  <Radio.Button value="7">Đã hủy</Radio.Button>
                  <Radio.Button value="8">Hoàn tiền</Radio.Button>
                </Radio.Group>
              </Form.Item>
            </Col>
          </Row>
        </Form>

        <h3 style={{ paddingBottom: "10px" }}>Chi tiết đơn hàng</h3>

        <Table
          dataSource={dataCTHD}
          scroll={{ x: 100 }} // Cho phép cuộn ngang khi tổng độ rộng cột vượt 600px
          size="small" // Làm bảng gọn gàng hơn
          pagination={false} // Ẩn phân trang nếu không cần
          style={{ maxWidth: "100%", overflowX: "auto" }}
        >
          <Column
            title="Tên sản phẩm"
            dataIndex="tenSanPham"
            key="tenSanPham"
          />
          <Column
            title="Ảnh"
            dataIndex="anhDaiDien"
            key="anhDaiDien"
            render={(value: any) => (
              <img
                src={
                  IMAGE_BASE_PATH +
                  (value?.includes(",") ? value.split(",")[0] : value)
                }
                alt="Ảnh"
                style={{ width: 30, height: "auto" }}
              />
            )}
          />
          <Column title="Số lượng" dataIndex="soLuong" key="soLuong" />
          <Column title="Size" dataIndex="tenSize" key="tenSize" />
          <Column
            title="Tổng tiền"
            dataIndex="tongGia"
            key="tongGia"
            render={(tongGia: number) => (
              <span>
                {new Intl.NumberFormat("vi-VN", {
                  style: "currency",
                  currency: "VND",
                }).format(tongGia)}
              </span>
            )}
          />
          <Column
            title="Action"
            key="action"
            render={(_: any, record: any) => (
              <Space size="middle">
                <a>Sửa </a>
                <a onClick={() => UpdateOderWithDeleteCTHD(record)}>Xóa</a>
              </Space>
            )}
          />
        </Table>
      </Modal> */}

      <Modal
        title="Chuyển trạng thái đơn hàng"
        open={isStatusModalOpen}
        onCancel={() => setIsStatusModalOpen(false)}
        footer={null}
        width={400}
        centered
      >
        {selectedOrder && (
          <div>
            <div style={{ marginBottom: 16 }}>
              <div
                style={{
                  textAlign: "center",
                  padding: "12px",
                  backgroundColor: "#f5f5f5",
                  borderRadius: "8px",
                  marginBottom: "16px",
                }}
              >
                <p style={{ margin: 0, fontSize: "14px", color: "#666" }}>
                  Trạng thái hiện tại:
                </p>
                {(() => {
                  const currentStatus = [...statusSteps, ...cancelSteps].find(
                    (s) => s.value === selectedOrder.trangThai
                  );
                  return currentStatus ? (
                    <div
                      style={{
                        display: "flex",
                        alignItems: "center",
                        justifyContent: "center",
                        gap: "8px",
                      }}
                    >
                      {currentStatus.icon}
                      <span
                        style={{
                          color: currentStatus.color,
                          fontWeight: "bold",
                          fontSize: "16px",
                        }}
                      >
                        {currentStatus.label}
                      </span>
                    </div>
                  ) : null;
                })()}
              </div>
            </div>

            <div
              style={{
                display: "grid",
                gridTemplateColumns: "repeat(2, 1fr)",
                gap: "8px",
                marginBottom: "16px",
              }}
            >
              {statusSteps.map((step) => (
                <div
                  key={step.value}
                  onClick={() => handleStatusChange(step.value)}
                  style={{
                    padding: "12px",
                    border: "1px solid #d9d9d9",
                    borderRadius: "8px",
                    cursor: "pointer",
                    transition: "all 0.3s",
                    backgroundColor:
                      selectedOrder.trangThai === step.value
                        ? "#e6f7ff"
                        : "white",
                    borderColor:
                      selectedOrder.trangThai === step.value
                        ? "#1890ff"
                        : "#d9d9d9",
                  }}
                  onMouseEnter={(e) => {
                    e.currentTarget.style.borderColor = "#1890ff";
                    e.currentTarget.style.boxShadow =
                      "0 2px 8px rgba(0,0,0,0.09)";
                  }}
                  onMouseLeave={(e) => {
                    e.currentTarget.style.borderColor =
                      selectedOrder.trangThai === step.value
                        ? "#1890ff"
                        : "#d9d9d9";
                    e.currentTarget.style.boxShadow = "none";
                  }}
                >
                  <div
                    style={{
                      display: "flex",
                      alignItems: "center",
                      gap: "8px",
                      marginBottom: "4px",
                    }}
                  >
                    {step.icon}
                    <span
                      style={{
                        color: step.color,
                        fontWeight: "bold",
                      }}
                    >
                      {step.label}
                    </span>
                  </div>
                  <p
                    style={{
                      margin: 0,
                      fontSize: "12px",
                      color: "#666",
                    }}
                  >
                    {step.description}
                  </p>
                </div>
              ))}
            </div>

            <Divider style={{ margin: "16px 0" }}>Trạng thái hủy</Divider>

            <div
              style={{
                display: "grid",
                gridTemplateColumns: "repeat(2, 1fr)",
                gap: "8px",
              }}
            >
              {cancelSteps.map((step) => (
                <div
                  key={step.value}
                  onClick={() => handleStatusChange(step.value)}
                  style={{
                    padding: "12px",
                    border: "1px solid #d9d9d9",
                    borderRadius: "8px",
                    cursor: "pointer",
                    transition: "all 0.3s",
                    backgroundColor:
                      selectedOrder.trangThai === step.value
                        ? "#fff1f0"
                        : "white",
                    borderColor:
                      selectedOrder.trangThai === step.value
                        ? "#ff4d4f"
                        : "#d9d9d9",
                  }}
                  onMouseEnter={(e) => {
                    e.currentTarget.style.borderColor = "#ff4d4f";
                    e.currentTarget.style.boxShadow =
                      "0 2px 8px rgba(0,0,0,0.09)";
                  }}
                  onMouseLeave={(e) => {
                    e.currentTarget.style.borderColor =
                      selectedOrder.trangThai === step.value
                        ? "#ff4d4f"
                        : "#d9d9d9";
                    e.currentTarget.style.boxShadow = "none";
                  }}
                >
                  <div
                    style={{
                      display: "flex",
                      alignItems: "center",
                      gap: "8px",
                      marginBottom: "4px",
                    }}
                  >
                    {step.icon}
                    <span
                      style={{
                        color: step.color,
                        fontWeight: "bold",
                      }}
                    >
                      {step.label}
                    </span>
                  </div>
                  <p
                    style={{
                      margin: 0,
                      fontSize: "12px",
                      color: "#666",
                    }}
                  >
                    {step.description}
                  </p>
                </div>
              ))}
            </div>
          </div>
        )}
      </Modal>

      <Modal
        title="Chi tiết đơn hàng"
        open={isDetailModalOpen}
        onCancel={() => setIsDetailModalOpen(false)}
        footer={null}
        width={800}
        centered
      style={{
        maxHeight: '80vh',
        overflowY: 'auto'
      }}
      >
        {selectedOrder && (
          <div>
            <Row gutter={[24, 24]}>
              <Col span={12}>
                <Card title="Thông tin đơn hàng" bordered={false}>
                  <p>
                    <strong>Mã đơn hàng:</strong> {selectedOrder.maHoaDon}
                  </p>
                  <p>
                    <strong>Khách hàng:</strong> {selectedOrder.tenKH}
                  </p>
                  <p>
                    <strong>Email:</strong> {selectedOrder.email}
                  </p>
                  <p>
                    <strong>SDT:</strong> {selectedOrder.sdt}
                  </p>
                  <p>
                    <strong>Ngày đặt:</strong>{" "}
                    {moment(selectedOrder.ngayTao).format(
                      "DD/MM/YYYY HH:mm:ss"
                    )}
                  </p>
                  <p>
                    <strong>Địa chỉ:</strong> {selectedOrder.diaChiGiaoHang}
                  </p>  
                  <p>
                    <strong>Tổng tiền:</strong>{" "}
                    {new Intl.NumberFormat("vi-VN", {
                      style: "currency",
                      currency: "VND",
                    }).format(selectedOrder.tongGia)}
                  </p>
                </Card>
              </Col>
              <Col span={12}>
                <Card title="Trạng thái đơn hàng" bordered={false}>
                  {(() => {
                    const currentStatus = [...statusSteps, ...cancelSteps].find(
                      (s) => s.value === selectedOrder.trangThai
                    );
                    return currentStatus ? (
                      <div style={{ textAlign: "center", padding: "20px 0" }}>
                        {currentStatus.icon}
                        <h2
                          style={{
                            margin: "16px 0",
                            color: currentStatus.color,
                          }}
                        >
                          {currentStatus.label}
                        </h2>
                        <p style={{ color: "#666" }}>
                          {currentStatus.description}
                        </p>
                      </div>
                    ) : null;
                  })()}
                </Card>
              </Col>
            </Row>

            {selectedOrder.maGiaoDich && (
              <>
                <Divider>Thông tin thanh toán VNPay</Divider>
                <Card bordered={false}>
                  <Row gutter={[16, 16]}>
                    <Col span={12}>
                      <p><strong>Mã giao dịch:</strong> {selectedOrder.maGiaoDich}</p>
                      <p><strong>Số tiền:</strong> {new Intl.NumberFormat("vi-VN", {
                        style: "currency",
                        currency: "VND",
                      }).format(selectedOrder.soTien)}</p>
                      <p><strong>Ngân hàng:</strong> {selectedOrder.maNganHang}</p>
                      <p><strong>Loại thẻ:</strong> {selectedOrder.loaiThe}</p>
                    </Col>
                    <Col span={12}>
                      <p><strong>Mã giao dịch VNPay:</strong> {selectedOrder.maGiaoDichVNPay}</p>
                      <p><strong>Trạng thái giao dịch:</strong> {selectedOrder.trangThaiGiaoDich}</p>
                      <p><strong>Ngày thanh toán:</strong> {moment(selectedOrder.ngayThanhToan, "YYYYMMDDHHmmss").format("DD/MM/YYYY HH:mm:ss")}</p>
                      <p><strong>Thông tin đơn hàng:</strong> {selectedOrder.thongTinDonHang}</p>
                    </Col>
                  </Row>
                </Card>
              </>
            )}

            <Divider>Chi tiết sản phẩm</Divider>

            <Table
              dataSource={dataCTHD}
              scroll={{ x: 100 }}
              size="small"
              pagination={false}
              style={{ maxWidth: "100%", overflowX: "auto" }}
            >
              <Column
                title="Tên sản phẩm"
                dataIndex="tenSanPham"
                key="tenSanPham"
              />
              <Column
                title="Ảnh"
                dataIndex="anhDaiDien"
                key="anhDaiDien"
                render={(value: any) => (
                  <img
                    src={
                      IMAGE_BASE_PATH +
                      (value?.includes(",") ? value.split(",")[0] : value)
                    }
                    alt="Ảnh"
                    style={{ width: 30, height: "auto" }}
                  />
                )}
              />
              <Column title="Số lượng" dataIndex="soLuong" key="soLuong" />
              <Column title="Size" dataIndex="tenSize" key="tenSize" />
              <Column
                title="Tổng tiền"
                dataIndex="tongGia"
                key="tongGia"
                render={(tongGia: number) => (
                  <span>
                    {new Intl.NumberFormat("vi-VN", {
                      style: "currency",
                      currency: "VND",
                    }).format(tongGia)}
                  </span>
                )}
              />
            </Table>
          </div>
        )}
      </Modal>
    </>
  );
};

export default AdminExportOder;
