import { Breadcrumb, theme, Image, Space, Card, Statistic, Row, Col, Progress, DatePicker } from "antd";
import {
  ShoppingCartOutlined,
  DollarOutlined,
  ShoppingOutlined,
  UserOutlined,
  CheckCircleOutlined,
  ClockCircleOutlined,
  CloseCircleOutlined,
  SyncOutlined,
  InboxOutlined,
  CarOutlined,
  RollbackOutlined
} from "@ant-design/icons";
import DashboardCard from "../../shared/ad/Dashboard/DashboardCard";
import ProductSelling from "../../shared/ad/Dashboard/TableProductSelling";
import { useEffect, useState } from "react";
import { ProductSearch } from "../../services/product.services";
import { CustomerSearch } from "../../services/customer.services";
import { Statistical } from "../../services/statistical.services";
import TopCus from "../../shared/ad/Dashboard/TableTopCus";
import axios from "axios";
import { PieChart, Pie, Cell, ResponsiveContainer, Legend, Tooltip } from 'recharts';
import dayjs from 'dayjs';
import type { Dayjs } from 'dayjs';

// import ImgUser from "../assets/anh/admin.png";
// Argon Dashboard 2 MUI example components

const AdminHome = function () {
  const [totalPro, setTotalPro] = useState<number>(0);
  const [totalCus, setTotalCus] = useState<number>(0);
  const [totalCart, setTotalCart] = useState<any>(0);
  const [revenue, setRevenue] = useState<any>(0);
  const [orderStats, setOrderStats] = useState<any[]>([]);
  const [categoryStats, setCategoryStats] = useState<any[]>([]);
  const [categoryStockStats, setCategoryStockStats] = useState<any[]>([]);
  const [startDate, setStartDate] = useState<Dayjs | null>(dayjs().startOf('month'));
  const [endDate, setEndDate] = useState<Dayjs | null>(dayjs().endOf('month'));

  const COLORS = ['#0088FE', '#00C49F', '#FFBB28', '#FF8042', '#8884D8', '#82CA9D', '#FF6B6B', '#4ECDC4'];

  const statusConfig = {
    "0": { 
      label: "Chờ xác nhận", 
      color: "#1890ff", 
      icon: <SyncOutlined />,
      description: "Khách vừa đặt hàng, chưa duyệt"
    },
    "1": { 
      label: "Đã xác nhận", 
      color: "#52c41a", 
      icon: <CheckCircleOutlined />,
      description: "Admin duyệt đơn, đã sẵn sàng xử lý"
    },
    "3": { 
      label: "Đang chuẩn bị hàng", 
      color: "#fa8c16", 
      icon: <InboxOutlined />,
      description: "Nhân viên đang chuẩn bị hàng"
    },
    "4": { 
      label: "Đang giao hàng", 
      color: "#13c2c2", 
      icon: <CarOutlined />,
      description: "Giao cho bên vận chuyển"
    },
    "5": { 
      label: "Hoàn tất", 
      color: "#52c41a", 
      icon: <CheckCircleOutlined />,
      description: "Đơn hàng đã được giao và hoàn thành"
    },
    "7": { 
      label: "Đã hủy", 
      color: "#f5222d", 
      icon: <CloseCircleOutlined />,
      description: "Đơn bị hủy bởi khách hoặc shop"
    },
    "8": { 
      label: "Trả hàng / Hoàn tiền", 
      color: "#faad14", 
      icon: <RollbackOutlined />,
      description: "Với đơn đã thanh toán online mà bị hủy/trả hàng"
    }
  };

  const loadDataCart = async () => {
    let res = await Statistical();
    setTotalCart(res.soDonHang);
    setRevenue(res.doanhThu);
  };

  const loadOrderStats = async () => {
    try {
      const response = await axios.get("https://localhost:44381/api/ThongKeDoanhThu/don-hang-theo-trang-thai");
      // Tạo mảng với tất cả các trạng thái, nếu không có dữ liệu thì số lượng = 0
      const allStatuses = Object.keys(statusConfig).map(status => ({
        trangThai: status,
        soLuongDon: 0,
        name: statusConfig[status as keyof typeof statusConfig].label,
        color: statusConfig[status as keyof typeof statusConfig].color,
        description: statusConfig[status as keyof typeof statusConfig].description
      }));

      // Cập nhật số lượng cho các trạng thái có dữ liệu
      response.data.forEach((item: any) => {
        const index = allStatuses.findIndex(status => status.trangThai === item.trangThai);
        if (index !== -1) {
          allStatuses[index].soLuongDon = item.soLuongDon;
        }
      });

      setOrderStats(allStatuses);
    } catch (error) {
      console.error("Error loading order stats:", error);
    }
  };

  const loadCategoryStats = async () => {
    try {
      const fromDate = startDate ? dayjs(startDate).format('YYYY-MM-DD') : dayjs().startOf('month').format('YYYY-MM-DD');
      const toDate = endDate ? dayjs(endDate).format('YYYY-MM-DD') : dayjs().endOf('month').format('YYYY-MM-DD');
      
      const response = await axios.get(`https://localhost:44381/api/ThongKeDoanhThu/chuyenmuc?fromDate=${fromDate}&toDate=${toDate}`);
      
      const formattedData = response.data.map((item: any, index: number) => ({
        ...item,
        name: item.tenChuyenMuc,
        value: item.tongDoanhThu,
        color: COLORS[index % COLORS.length]
      }));

      setCategoryStats(formattedData);
    } catch (error) {
      console.error("Error loading category stats:", error);
    }
  };

  const loadCategoryStockStats = async () => {
    try {
      const response = await axios.get("https://localhost:44381/api/ThongKeDoanhThu/ton-kho-theo-danh-muc");
      const formattedData = response.data.map((item: any, index: number) => ({
        ...item,
        name: item.tenChuyenMuc,
        value: item.tongSoLuongTonKho,
        color: COLORS[index % COLORS.length]
      }));
      setCategoryStockStats(formattedData);
    } catch (error) {
      console.error("Error loading category stock stats:", error);
    }
  };

  const loadDataCus = async () => {
    let result = await CustomerSearch({
      page: "1",
      pageSize: "100",
    });
    const totalQty = result.data.length;
    setTotalCus(totalQty);
  };

  useEffect(() => {
    loadDataCus();
    loadDataCart();
    loadOrderStats();
    loadCategoryStats();
    loadCategoryStockStats();
  }, [startDate, endDate]);

  const CustomTooltip = ({ active, payload }: any) => {
    if (active && payload && payload.length) {
      const data = payload[0].payload;
      return (
        <div style={{ 
          backgroundColor: 'white', 
          padding: '10px', 
          border: '1px solid #ccc',
          borderRadius: '4px',
          boxShadow: '0 2px 8px rgba(0,0,0,0.15)'
        }}>
          <p style={{ margin: 0, fontWeight: 'bold' }}>{data.name}</p>
          <p style={{ margin: '4px 0' }}>{data.description}</p>
          <p style={{ margin: '4px 0' }}>{`Số lượng: ${data.soLuongDon} đơn`}</p>
          <p style={{ margin: 0 }}>{`Tỷ lệ: ${Math.round((data.soLuongDon / totalCart) * 100)}%`}</p>
        </div>
      );
    }
    return null;
  };

  const CategoryTooltip = ({ active, payload }: any) => {
    if (active && payload && payload.length) {
      const data = payload[0].payload;
      return (
        <div style={{ 
          backgroundColor: 'white', 
          padding: '10px', 
          border: '1px solid #ccc',
          borderRadius: '4px',
          boxShadow: '0 2px 8px rgba(0,0,0,0.15)'
        }}>
          <p style={{ margin: 0, fontWeight: 'bold' }}>{data.name}</p>
          <p style={{ margin: '4px 0' }}>{`Số lượng bán: ${data.soLuongBanRa} sản phẩm`}</p>
          <p style={{ margin: '4px 0' }}>{`Doanh thu: ${new Intl.NumberFormat('vi-VN', {
            style: 'currency',
            currency: 'VND'
          }).format(data.value)}`}</p>
          <p style={{ margin: 0 }}>{`Tỷ lệ: ${Math.round((data.value / revenue) * 100)}%`}</p>
        </div>
      );
    }
    return null;
  };

  const CategoryStockTooltip = ({ active, payload }: any) => {
    if (active && payload && payload.length) {
      const data = payload[0].payload;
      return (
        <div style={{ 
          backgroundColor: 'white', 
          padding: '10px', 
          border: '1px solid #ccc',
          borderRadius: '4px',
          boxShadow: '0 2px 8px rgba(0,0,0,0.15)'
        }}>
          <p style={{ margin: 0, fontWeight: 'bold' }}>{data.name}</p>
          <p style={{ margin: '4px 0' }}>{`Tồn kho: ${data.value} sản phẩm`}</p>
        </div>
      );
    }
    return null;
  };

  const {
    token: { colorBgContainer, borderRadiusLG },
  } = theme.useToken();

  return (
    <>
      <Row gutter={[16, 16]} style={{ marginTop: 24 }}>
        {orderStats.map((status) => (
          <Col key={status.trangThai} xs={24} sm={12} md={8} lg={6} xl={6}>
            <Card
              style={{
                background: "#fff7e6",
                borderRadius: 12,
                textAlign: "center",
                boxShadow: "0 2px 8px rgba(0,0,0,0.05)",
                height: 160,
                display: "flex",
                alignItems: "center",
                justifyContent: "center"
              }}
              bodyStyle={{ padding: 0 }}
            >
              <div style={{
                width: "100%",
                display: "flex",
                flexDirection: "column",
                alignItems: "center",
                justifyContent: "center",
                padding: 16
              }}>
                <div style={{
                  background: status.color + "22",
                  borderRadius: "50%",
                  width: 48,
                  height: 48,
                  display: "flex",
                  alignItems: "center",
                  justifyContent: "center",
                  marginBottom: 8,
                  fontSize: 24,
                  color: status.color
                }}>
                  {statusConfig[status.trangThai as keyof typeof statusConfig]?.icon}
                </div>
                <div
                  style={{
                    color: "#888",
                    fontSize: 14,
                    marginBottom: 4,
                    height: 20,
                    display: "flex",
                    alignItems: "center",
                    justifyContent: "center",
                    textAlign: "center"
                  }}
                >
                  {status.name}
                </div>
                <div style={{ fontWeight: 700, fontSize: 24 }}>{status.soLuongDon}</div>
              </div>
            </Card>
          </Col>
        ))}
      </Row>

      <div style={{ width: "100%", padding: 24 }}>
        <Row gutter={[16, 16]}>
          <Col span={12}>
            <Card title="Thống kê đơn hàng theo trạng thái">
              <div style={{ height: 300, display: 'flex', justifyContent: 'center' }}>
                <ResponsiveContainer width="100%" height="100%">
                  <PieChart>
                    <Pie
                      data={orderStats}
                      cx="50%"
                      cy="50%"
                      labelLine={false}
                      outerRadius={100}
                      fill="#8884d8"
                      dataKey="soLuongDon"
                      nameKey="name"
                    >
                      {orderStats.map((entry, index) => (
                        <Cell key={`cell-${index}`} fill={entry.color} />
                      ))}
                    </Pie>
                    <Tooltip content={<CustomTooltip />} />
                    <Legend 
                      layout="vertical" 
                      align="right"
                      verticalAlign="middle"
                      formatter={(value, entry: any) => (
                        <span style={{ color: entry.color }}>{value}</span>
                      )}
                    />
                  </PieChart>
                </ResponsiveContainer>
              </div>
            </Card>
          </Col>
          <Col span={12}>
            <Card 
              title="Tồn kho theo chuyên mục"
            >
              <div style={{ height: 300, display: 'flex', justifyContent: 'center' }}>
                <ResponsiveContainer width="100%" height="100%">
                  <PieChart>
                    <Pie
                      data={categoryStockStats}
                      cx="50%"
                      cy="50%"
                      labelLine={false}
                      outerRadius={100}
                      fill="#8884d8"
                      dataKey="value"
                      nameKey="name"
                    >
                      {categoryStockStats.map((entry, index) => (
                        <Cell key={`cell-${index}`} fill={entry.color} />
                      ))}
                    </Pie>
                    <Tooltip content={<CategoryStockTooltip />} />
                    <Legend 
                      layout="vertical" 
                      align="right"
                      verticalAlign="middle"
                      formatter={(value, entry: any) => (
                        <span style={{ color: entry.color }}>{value}</span>
                      )}
                    />
                  </PieChart>
                </ResponsiveContainer>
              </div>
            </Card>
          </Col>
        </Row>
      </div>

     

      {/* <div style={{ width: "100%", padding: 24 }}>
        <TopCus />
      </div> */}
    </>
  );
};

export default AdminHome;
