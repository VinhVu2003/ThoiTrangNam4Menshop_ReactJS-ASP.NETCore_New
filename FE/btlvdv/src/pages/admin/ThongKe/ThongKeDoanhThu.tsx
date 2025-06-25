import React, { useEffect, useState, useMemo } from "react";
import {
  Card,
  DatePicker,
  Table,
  Space,
  Select,
  Row,
  Col,
  Statistic,
  Button,
  ConfigProvider
} from "antd";
import { Line } from "@ant-design/plots";
import moment from "moment";
import axios from "axios";
import { SyncOutlined } from "@ant-design/icons";
import type { Dayjs } from 'dayjs';
import { PieChart, Pie, Cell, ResponsiveContainer, Legend as RechartsLegend, Tooltip as RechartsTooltip, BarChart, Bar, XAxis, YAxis, CartesianGrid } from 'recharts';

// Import chart.js and react-chartjs-2
import { Line as ReactChartjsLine } from 'react-chartjs-2';
import { Chart as ChartJS, CategoryScale, LinearScale, PointElement, LineElement, Title, Tooltip as ChartTooltip, Legend as ChartLegend } from 'chart.js';
// Import Vietnamese locale for Ant Design
  import viVN from 'antd/lib/locale/vi_VN';
// Register chart.js components
ChartJS.register(
  CategoryScale,
  LinearScale,
  
  PointElement,
  LineElement,
  Title,
  ChartTooltip,
  ChartLegend
);


const { Option } = Select;

const ThongKeDoanhThu: React.FC = () => {
  const [data, setData] = useState<any[]>([]);
  const [totalRevenue, setTotalRevenue] = useState<number>(0);
  const [chartData, setChartData] = useState<any[]>([]);
  const [timeRange, setTimeRange] = useState<string>("year");
  const [startDate, setStartDate] = useState<Dayjs | null>(null);
  const [endDate, setEndDate] = useState<Dayjs | null>(null);
  const [chartTitle, setChartTitle] = useState<string>('Biểu đồ doanh thu');
  const [categoryStats, setCategoryStats] = useState<any[]>([]);
  const [topProducts, setTopProducts] = useState<any[]>([]);
  const COLORS = ['#0088FE', '#00C49F', '#FFBB28', '#FF8042', '#8884D8', '#82CA9D', '#FF6B6B', '#4ECDC4'];

  // Hàm lấy dữ liệu thống kê
  const fetchData = async () => {
    try {
      let endpoint = "";
      let from = '';
      let to = '';
      
      // Determine date range based on timeRange and corresponding picker value
      if (timeRange === 'day') {
        if (startDate && endDate) { // Check if both start and end dates are selected
          from = moment(startDate.toDate()).format('YYYY-MM-DD'); // Convert Dayjs to Moment then format
          to = moment(endDate.toDate()).format('YYYY-MM-DD'); // Convert Dayjs to Moment then format
        } else {
           // Default to last 30 days if no date range selected
           from = moment().subtract(30, 'days').format('YYYY-MM-DD');
           to = moment().format('YYYY-MM-DD');
        }
         endpoint = `https://localhost:44381/api/ThongKeDoanhThu/doanh-thu-ngay?from=${from}&to=${to}`;

      } else if (timeRange === 'month') {
         // Use startDate and endDate as boundary for months if available, otherwise default
         let startMoment = startDate ? moment(startDate.toDate()).startOf('month') : moment().startOf('year');
         let endMoment = endDate ? moment(endDate.toDate()).endOf('month') : moment().endOf('year');

         from = startMoment.format('YYYY-MM-DD');
         to = endMoment.format('YYYY-MM-DD');

          endpoint = `https://localhost:44381/api/ThongKeDoanhThu/doanh-thu-thang?from=${from}&to=${to}`; // Check API endpoint case

      } else if (timeRange === 'year') {
         // Use startDate and endDate as boundary for years if available, otherwise default
          let startMoment = startDate ? moment(startDate.toDate()).startOf('year') : moment().subtract(5, 'years').startOf('year');
          let endMoment = endDate ? moment(endDate.toDate()).endOf('year') : moment().endOf('year');

          from = startMoment.format('YYYY-MM-DD');
          to = endMoment.format('YYYY-MM-DD');

           endpoint = `https://localhost:44381/api/ThongKeDoanhThu/doanh-thu-nam?from=${from}&to=${to}`;
      }

      console.log('Time Range:', timeRange);
      console.log('Effective Date Range:', { from, to });
      console.log('Calling API:', endpoint);

      const response = await axios.get(endpoint);
      console.log('API Response:', response.data);

      if (!response.data) {
        console.log('No data received from API');
        setData([]);
        setTotalRevenue(0);
        setChartData([]);
        setChartTitle('Biểu đồ doanh thu');
        return;
      }

      // Xử lý dữ liệu theo từng loại thống kê
      let processedData;
      let aggregatedChartData: any[] = [];
      let total = 0;
      let title = 'Biểu đồ doanh thu';

      if (timeRange === 'year') {
        // Dữ liệu theo năm: { nam: 2025, doanhThu: 1010000 }
        processedData = Array.isArray(response.data) ? response.data : [response.data];
        setData(processedData);
        total = processedData.reduce((sum: number, item: any) => sum + (Number(item.doanhThu) || 0), 0);
        aggregatedChartData = processedData.map((item: any) => ({
          date: item.nam.toString(),
          revenue: Number(item.doanhThu) || 0
        }));
         if (startDate && endDate) {
             const from = moment(startDate.toDate()).format('YYYY');
             const to = moment(endDate.toDate()).format('YYYY');
              if (from === to) {
                title = `Biểu đồ doanh thu năm ${from}`;
              } else {
                title = `Biểu đồ doanh thu từ năm ${from} đến ${to}`;
              }
           } else {
             const year = moment().format('YYYY');
             title = `Biểu đồ doanh thu năm ${year}`;
           }

      } else if (timeRange === 'month') {
        // Dữ liệu theo tháng: { nam: 2025, thang: 5, doanhThu: 1010000 }
        processedData = Array.isArray(response.data) ? response.data : [response.data];
        setData(processedData);
        total = processedData.reduce((sum: number, item: any) => sum + (Number(item.doanhThu) || 0), 0);
        aggregatedChartData = processedData.map((item: any) => ({
          date: `${item.thang}/${item.nam}`,
          revenue: Number(item.doanhThu) || 0
        }));
           if (startDate && endDate) {
             const from = moment(startDate.toDate()).format('MM/YYYY');
             const to = moment(endDate.toDate()).format('MM/YYYY');
             title = `Biểu đồ doanh thu theo tháng từ ${from} đến ${to}`;
           } else {
             const year = moment().format('YYYY');
             title = `Biểu đồ doanh thu theo tháng năm ${year}`;
           }

      } else { // timeRange === 'day'
        // Dữ liệu theo ngày: [{ ngay: "2025-05-25T00:00:00", doanhThu: 0 }, ...]
        processedData = Array.isArray(response.data) ? response.data : [response.data];
        setData(processedData);
        total = processedData.reduce((sum: number, item: any) => sum + (Number(item.doanhThu) || 0), 0);

        // Nhóm dữ liệu theo ngày và tính tổng doanh thu
        const dailyRevenueMap = new Map<string, number>();
        processedData.forEach((item: any) => {
          const date = moment(item.ngay).format('DD/MM/YYYY');
          const currentRevenue = dailyRevenueMap.get(date) || 0;
          dailyRevenueMap.set(date, currentRevenue + (Number(item.doanhThu) || 0));
        });

        // Tạo danh sách đầy đủ các ngày trong khoảng thời gian đã chọn
        const allDates: string[] = [];
        if (startDate && endDate) {
          let currentDate = moment(startDate.toDate());
          const endDateMoment = moment(endDate.toDate());
          while (currentDate.isSameOrBefore(endDateMoment, 'day')) {
            allDates.push(currentDate.format('DD/MM/YYYY'));
            currentDate.add(1, 'day');
          }
        } else { // Default to last 30 days if no date range selected for day view
           let currentDate = moment().subtract(30, 'days');
           const endDate = moment();
           while (currentDate.isSameOrBefore(endDate, 'day')) {
             allDates.push(currentDate.format('DD/MM/YYYY'));
             currentDate.add(1, 'day');
           }
        }

        // Kết hợp dữ liệu từ API với danh sách đầy đủ các ngày
        const finalChartData: { date: string; revenue: number }[] = allDates.map(date => ({
          date,
          revenue: dailyRevenueMap.get(date) || 0 // Get revenue from map, default to 0 if not exists
        }));

        aggregatedChartData = finalChartData.sort((a, b) => moment(a.date, 'DD/MM/YYYY').valueOf() - moment(b.date, 'DD/MM/YYYY').valueOf()); // Sắp xếp theo ngày
        
         if (startDate && endDate) {
           const from = moment(startDate.toDate()).format('DD/MM/YYYY');
           const to = moment(endDate.toDate()).format('DD/MM/YYYY');
           if (from === to) {
             title = `Biểu đồ doanh thu ngày ${from}`;
           } else {
             title = `Biểu đồ doanh thu từ ${from} đến ${to}`;
           }
         } else {
           const from = moment().subtract(30, 'days').format('DD/MM/YYYY');
           const to = moment().format('DD/MM/YYYY');
           title = `Biểu đồ doanh thu 30 ngày gần nhất (${from} - ${to})`;
         }
      }

      setTotalRevenue(total);
      console.log('Chart Data:', aggregatedChartData);
      setChartData(aggregatedChartData);
      setChartTitle(title);

    } catch (error: any) {
      console.error("Error fetching data:", error);
      if (error.response) {
        console.error("Error response:", error.response.data);
        console.error("Error status:", error.response.status);
      }
      alert("Có lỗi xảy ra khi tải dữ liệu. Vui lòng thử lại sau.");
    }
  };

  const loadCategoryStats = async () => {
    try {
      const fromDate = startDate ? moment(startDate.toDate()).format('YYYY-MM-DD') : moment().startOf('month').format('YYYY-MM-DD');
      const toDate = endDate ? moment(endDate.toDate()).format('YYYY-MM-DD') : moment().endOf('month').format('YYYY-MM-DD');
      
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

  const loadTopProducts = async () => {
    try {
      const fromDate = startDate ? moment(startDate.toDate()).format('YYYY-MM-DD') : moment().startOf('month').format('YYYY-MM-DD');
      const toDate = endDate ? moment(endDate.toDate()).format('YYYY-MM-DD') : moment().endOf('month').format('YYYY-MM-DD');
      
      const response = await axios.get(`https://localhost:44381/api/ThongKeDoanhThu/sanphamban?fromDate=${fromDate}&toDate=${toDate}&top=10`);
      
      const formattedData = response.data.map((item: any) => ({
        ...item,
        name: item.tenSanPham,
        sales: item.soLuongBanRa,
        revenue: item.tongDoanhThu
      }));

      setTopProducts(formattedData);
    } catch (error) {
      console.error("Error loading top products:", error);
    }
  };

  useEffect(() => {
    fetchData();
    loadCategoryStats();
    loadTopProducts();
  }, [timeRange, startDate, endDate]);

  // Hàm xử lý khi click nút Làm mới
  const handleResetAndRefresh = () => {
    // setStartDate(null);
    // setEndDate(null);
    // setTimeRange('year'); // Đặt lại loại thống kê về mặc định
    window.location.reload();
    // Không cần gọi fetchData ở đây, useEffect sẽ tự động chạy khi state thay đổi
  };

  // Xác định tiêu đề cột đầu tiên của bảng dựa trên timeRange
  const timeColumnTitle = useMemo(() => {
    switch (timeRange) {
      case 'day': return 'Ngày';
      case 'month': return 'Tháng';
      case 'year': return 'Năm';
      default: return 'Thời gian';
    }
  }, [timeRange]);

  // Cấu hình cột chung cho bảng
  const commonTableColumns = useMemo(() => [
    {
      title: timeColumnTitle,
      dataIndex: 'date',
      key: 'date',
      width: '30%',
    },
    {
      title: 'Doanh thu',
      dataIndex: 'revenue',
      key: 'revenue',
      width: '35%',
      render: (value: number) => (
        <span style={{ color: value > 0 ? '#52c41a' : '#ff4d4f' }}>
          {new Intl.NumberFormat("vi-VN", {
            style: "currency",
            currency: "VND",
          }).format(value)}
        </span>
      ),
    },
    {
      title: 'Tỷ lệ',
      key: 'percentage',
      width: '35%',
      render: (record: { date: string; revenue: number }) => {
        const total = chartData.reduce((sum: number, item: any) => sum + item.revenue, 0);
        const percentage = total > 0 ? ((Number(record.revenue) || 0) / total * 100).toFixed(2) : 0;
        return (
          <span>
            {percentage}%
          </span>
        );
      }
    }
  ], [timeColumnTitle, chartData]); // Thêm chartData vào dependencies để tính lại tỷ lệ khi data thay đổi

  // Cấu hình biểu đồ cho Chart.js
  const chartJsData = {
    labels: chartData.map(item => item.date),
    datasets: [
      {
        label: 'Doanh thu',
        data: chartData.map(item => item.revenue),
        borderColor: 'rgb(75, 192, 192)',
        backgroundColor: 'rgba(75, 192, 192, 0.5)',
        tension: 0.1,
      },
    ],
  };

  const options = {
    responsive: true,
    maintainAspectRatio: false, // Allow chart to adjust size
    plugins: {
      legend: {
        position: 'top' as const,
      },
      title: {
        display: true,
        text: chartTitle,
      },
      tooltip: {
        callbacks: {
          label: function(context: any) {
            let label = context.dataset.label || '';

            if (label) {
              label += ': ';
            }
            if (context.parsed.y !== null) {
              label += new Intl.NumberFormat('vi-VN', {
                style: 'currency',
                currency: 'VND',
                maximumFractionDigits: 0
              }).format(context.parsed.y);
            }
            return label;
          }
        }
      }
    },
    scales: {
        y: {
            ticks: {
                callback: function(value: any) {
                    return new Intl.NumberFormat('vi-VN', {
                        style: 'currency',
                        currency: 'VND',
                        maximumFractionDigits: 0
                    }).format(value);
                }
            }
        }
    }
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
          <p style={{ margin: 0 }}>{`Tỷ lệ: ${Math.round((data.value / totalRevenue) * 100)}%`}</p>
        </div>
      );
    }
    return null;
  };

  const ProductTooltip = ({ active, payload }: any) => {
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
          <p style={{ margin: '4px 0' }}>{`Số lượng bán: ${data.sales} sản phẩm`}</p>
          <p style={{ margin: '4px 0' }}>{`Doanh thu: ${new Intl.NumberFormat('vi-VN', {
            style: 'currency',
            currency: 'VND'
          }).format(data.revenue)}`}</p>
        </div>
      );
    }
    return null;
  };

  return (
    <ConfigProvider locale={viVN}>
      <div style={{ padding: "20px" }}>
        <Row gutter={[16, 16]}>
          <Col span={24}>
            <Card>
              <Space style={{ marginBottom: 16 }}>
                {/* Date pickers for range (always visible) */}
                <Space>
                   <DatePicker 
                     placeholder="Từ ngày"
                     format="DD/MM/YYYY"
                     value={startDate}
                     onChange={(date) => setStartDate(date)}
                   />
                   <DatePicker 
                     placeholder="Đến ngày"
                     format="DD/MM/YYYY"
                     value={endDate}
                     onChange={(date) => setEndDate(date)}
                   />
                </Space>

                {/* Select for Type (Day/Month/Year) */}
                <Select
                  defaultValue="year"
                  style={{ width: 120 }}
                  onChange={(value) => {
                    setTimeRange(value);
                    // Có thể reset date pickers khi chuyển loại thống kê nếu muốn
                    // setStartDate(null);
                    // setEndDate(null);
                  }}
                >
                  <Option value="day">Theo ngày</Option>
                  <Option value="month">Theo tháng</Option>
                  <Option value="year">Theo năm</Option>
                </Select>
                <Button
                  type="primary"
                  icon={<SyncOutlined />}
                  onClick={handleResetAndRefresh}
                >
                  Làm mới
                </Button>
              </Space>
            </Card>
          </Col>

          <Col span={24}>
            <Card>
              <Statistic
                title="Tổng doanh thu"
                value={totalRevenue}
                precision={0}
                formatter={(value) => (
                  <span>
                    {new Intl.NumberFormat("vi-VN", {
                      style: "currency",
                      currency: "VND",
                    }).format(value as number)}
                  </span>
                )}
              />
            </Card>
          </Col>

          {/* Render Chart và Table chung cho cả 3 loại thống kê */}
          <Col span={24}>
            <Card title={chartTitle}> {/* Sử dụng chartTitle dynamic */}
              <div style={{ height: 300, width: '80%', margin: '0 auto' }}>
                 {/* Biểu đồ sử dụng Chart.js */}
                 <ReactChartjsLine data={chartJsData} options={options} />
              </div>
            </Card>
            {/* Tiêu đề bảng chi tiết cũng thay đổi theo timeRange */}
            <Card title={`Chi tiết doanh thu theo ${timeColumnTitle.toLowerCase()}`} style={{ marginTop: 16 }}>
              <div style={{ overflowX: 'auto' }}>
                <Table
                  columns={commonTableColumns}
                  dataSource={chartData}
                  rowKey="date"
                  pagination={false}
                  scroll={{ x: 'max-content' }}
                  summary={(pageData) => {
                    const total = pageData.reduce((sum, record: any) => sum + (Number(record.revenue) || 0), 0);
                    return (
                      <Table.Summary.Row>
                        <Table.Summary.Cell index={0}>Tổng cộng</Table.Summary.Cell>
                        <Table.Summary.Cell index={1}>
                          <span style={{ fontWeight: 'bold' }}>
                            {new Intl.NumberFormat("vi-VN", {
                              style: "currency",
                              currency: "VND",
                            }).format(total)}
                          </span>
                        </Table.Summary.Cell>
                        <Table.Summary.Cell index={2}>100%</Table.Summary.Cell>
                      </Table.Summary.Row>
                    );
                  }}
                />
              </div>
            </Card>
          </Col>

          <Col span={12}>
            <Card title="Thống kê doanh thu theo chuyên mục">
              <div style={{ height: 500, display: 'flex', justifyContent: 'center' }}>
                <ResponsiveContainer width="100%" height="100%">
                  <PieChart>
                    <Pie
                      data={categoryStats}
                      cx="50%"
                      cy="50%"
                      labelLine={false}
                      outerRadius={150}
                      fill="#8884d8"
                      dataKey="value"
                      nameKey="name"
                    >
                      {categoryStats.map((entry, index) => (
                        <Cell key={`cell-${index}`} fill={entry.color} />
                      ))}
                    </Pie>
                    <RechartsTooltip content={<CategoryTooltip />} />
                    <RechartsLegend 
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
            <Card title="Top sản phẩm bán chạy">
              <div style={{ height: 500, display: 'flex', justifyContent: 'center' }}>
                <ResponsiveContainer width="100%" height="100%">
                  <BarChart
                    data={topProducts}
                    margin={{
                      top: 20,
                      right: 30,
                      left: 20,
                      bottom: 100,
                    }}
                  >
                    <CartesianGrid strokeDasharray="3 3" />
                    <XAxis 
                      dataKey="name" 
                      angle={-45}
                      textAnchor="end"
                      height={100}
                      interval={0}
                      tick={{ fontSize: 12 }}
                    />
                    <YAxis 
                      yAxisId="left"
                      orientation="left"
                      label={{ value: 'Số lượng bán', angle: -90, position: 'insideLeft' }}
                    />
                    <YAxis 
                      yAxisId="right"
                      orientation="right"
                      label={{ value: 'Doanh thu (VNĐ)', angle: 90, position: 'insideRight' }}
                      tickFormatter={(value) => new Intl.NumberFormat('vi-VN', {
                        notation: 'compact',
                        maximumFractionDigits: 1
                      }).format(value)}
                    />
                    <RechartsTooltip content={<ProductTooltip />} />
                    <Bar 
                      yAxisId="left"
                      dataKey="sales" 
                      name="Số lượng bán"
                      fill="#8884d8" 
                    />
                    <Bar 
                      yAxisId="right"
                      dataKey="revenue" 
                      name="Doanh thu"
                      fill="#82ca9d" 
                    />
                    <RechartsLegend />
                  </BarChart>
                </ResponsiveContainer>
              </div>
            </Card>
          </Col>

        </Row>
      </div>
    </ConfigProvider>
  );
};

export default ThongKeDoanhThu;
