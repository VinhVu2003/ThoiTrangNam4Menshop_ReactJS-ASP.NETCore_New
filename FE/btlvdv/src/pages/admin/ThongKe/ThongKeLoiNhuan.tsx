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
import dayjs from "dayjs";
import axios from "axios";
import { SyncOutlined } from "@ant-design/icons";
import type { Dayjs } from 'dayjs';
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer, BarChart, Bar } from 'recharts';
import viVN from 'antd/lib/locale/vi_VN';

const { Option } = Select;

const ThongKeLoiNhuan: React.FC = () => {
  const [data, setData] = useState<any[]>([]);
  const [totalRevenue, setTotalRevenue] = useState<number>(0);
  const [totalCost, setTotalCost] = useState<number>(0);
  const [totalProfit, setTotalProfit] = useState<number>(0);
  const [timeRange, setTimeRange] = useState<string>("day");
  const [startDate, setStartDate] = useState<Dayjs | null>(dayjs().subtract(30, 'days'));
  const [endDate, setEndDate] = useState<Dayjs | null>(dayjs());
  const [productStats, setProductStats] = useState<any[]>([]);
  const [chartTitle, setChartTitle] = useState<string>('Biểu đồ lợi nhuận');

  const fetchData = async () => {
    try {
      let endpoint = "";
      let from = '';
      let to = '';
      
      if (timeRange === 'day') {
        if (startDate && endDate) {
          from = dayjs(startDate.toDate()).format('YYYY-MM-DD');
          to = dayjs(endDate.toDate()).format('YYYY-MM-DD');
        } else {
          from = dayjs().subtract(30, 'days').format('YYYY-MM-DD');
          to = dayjs().format('YYYY-MM-DD');
        }
        endpoint = `https://localhost:44381/api/ThongKeDoanhThu/loi-nhuan-ngay?fromDate=${from}&toDate=${to}`;
      } else if (timeRange === 'month') {
        let startMoment = startDate ? dayjs(startDate.toDate()).startOf('month') : dayjs().startOf('year');
        let endMoment = endDate ? dayjs(endDate.toDate()).endOf('month') : dayjs().endOf('year');
        from = startMoment.format('YYYY-MM-DD');
        to = endMoment.format('YYYY-MM-DD');
        endpoint = `https://localhost:44381/api/ThongKeDoanhThu/loi-nhuan-thang?fromDate=${from}&toDate=${to}`;
      }

      const response = await axios.get(endpoint);
      const processedData = Array.isArray(response.data) ? response.data : [response.data];
      
      // Tính tổng
      const total = processedData.reduce((sum: any, item: any) => ({
        doanhThu: sum.doanhThu + (Number(item.doanhThu) || 0),
        giaVon: sum.giaVon + (Number(item.giaVon) || 0),
        loiNhuan: sum.loiNhuan + (Number(item.loiNhuan) || 0)
      }), { doanhThu: 0, giaVon: 0, loiNhuan: 0 });

      setTotalRevenue(total.doanhThu);
      setTotalCost(total.giaVon);
      setTotalProfit(total.loiNhuan);
      setData(processedData);

      // Cập nhật tiêu đề biểu đồ
      if (startDate && endDate) {
        const fromStr = dayjs(startDate.toDate()).format(timeRange === 'day' ? 'DD/MM/YYYY' : 'MM/YYYY');
        const toStr = dayjs(endDate.toDate()).format(timeRange === 'day' ? 'DD/MM/YYYY' : 'MM/YYYY');
        if (fromStr === toStr) {
          setChartTitle(`Biểu đồ lợi nhuận ${timeRange === 'day' ? 'ngày' : 'tháng'} ${fromStr}`);
        } else {
          setChartTitle(`Biểu đồ lợi nhuận từ ${fromStr} đến ${toStr}`);
        }
      }
    } catch (error) {
      console.error("Error fetching data:", error);
    }
  };

  const fetchProductStats = async () => {
    try {
      const response = await axios.get("https://localhost:44381/api/ThongKeDoanhThu/loi-nhuan-theoSanPham");
      setProductStats(response.data);
    } catch (error) {
      console.error("Error fetching product stats:", error);
    }
  };

  useEffect(() => {
    fetchData();
    fetchProductStats();
  }, [timeRange, startDate, endDate]);

  const handleResetAndRefresh = () => {
    window.location.reload();
  };

  const timeColumnTitle = useMemo(() => {
    switch (timeRange) {
      case 'day': return 'Ngày';
      case 'month': return 'Tháng';
      default: return 'Thời gian';
    }
  }, [timeRange]);

  const commonTableColumns = useMemo(() => [
    {
      title: timeColumnTitle,
      dataIndex: 'giaiDoan',
      key: 'giaiDoan',
      width: '20%',
    },
    {
      title: 'Doanh thu',
      dataIndex: 'doanhThu',
      key: 'doanhThu',
      width: '25%',
      render: (value: number) => (
        <span style={{ color: '#52c41a' }}>
          {new Intl.NumberFormat("vi-VN", {
            style: "currency",
            currency: "VND",
          }).format(value)}
        </span>
      ),
    },
    {
      title: 'Giá vốn',
      dataIndex: 'giaVon',
      key: 'giaVon',
      width: '25%',
      render: (value: number) => (
        <span style={{ color: '#ff4d4f' }}>
          {new Intl.NumberFormat("vi-VN", {
            style: "currency",
            currency: "VND",
          }).format(value)}
        </span>
      ),
    },
    {
      title: 'Lợi nhuận',
      dataIndex: 'loiNhuan',
      key: 'loiNhuan',
      width: '30%',
      render: (value: number) => (
        <span style={{ color: value >= 0 ? '#52c41a' : '#ff4d4f' }}>
          {new Intl.NumberFormat("vi-VN", {
            style: "currency",
            currency: "VND",
          }).format(value)}
        </span>
      ),
    }
  ], [timeColumnTitle]);

  const productTableColumns = [
    {
      title: 'Sản phẩm',
      dataIndex: 'tenSanPham',
      key: 'tenSanPham',
      width: '40%',
    },
    {
      title: 'Doanh thu',
      dataIndex: 'doanhThu',
      key: 'doanhThu',
      width: '20%',
      render: (value: number) => (
        <span style={{ color: '#52c41a' }}>
          {new Intl.NumberFormat("vi-VN", {
            style: "currency",
            currency: "VND",
          }).format(value)}
        </span>
      ),
    },
    {
      title: 'Giá vốn',
      dataIndex: 'giaVon',
      key: 'giaVon',
      width: '20%',
      render: (value: number) => (
        <span style={{ color: '#ff4d4f' }}>
          {new Intl.NumberFormat("vi-VN", {
            style: "currency",
            currency: "VND",
          }).format(value)}
        </span>
      ),
    },
    {
      title: 'Lợi nhuận',
      dataIndex: 'loiNhuan',
      key: 'loiNhuan',
      width: '20%',
      render: (value: number) => (
        <span style={{ color: value >= 0 ? '#52c41a' : '#ff4d4f' }}>
          {new Intl.NumberFormat("vi-VN", {
            style: "currency",
            currency: "VND",
          }).format(value)}
        </span>
      ),
    }
  ];

  const CustomTooltip = ({ active, payload, label }: any) => {
    if (active && payload && payload.length) {
      return (
        <div style={{ 
          backgroundColor: 'white', 
          padding: '10px', 
          border: '1px solid #ccc',
          borderRadius: '4px',
          boxShadow: '0 2px 8px rgba(0,0,0,0.15)'
        }}>
          <p style={{ margin: 0, fontWeight: 'bold' }}>{label}</p>
          {payload.map((entry: any, index: number) => (
            <p key={index} style={{ margin: '4px 0', color: entry.color }}>
              {`${entry.name}: ${new Intl.NumberFormat('vi-VN', {
                style: 'currency',
                currency: 'VND'
              }).format(entry.value)}`}
            </p>
          ))}
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

                <Select
                  defaultValue="day"
                  style={{ width: 120 }}
                  onChange={(value) => setTimeRange(value)}
                >
                  <Option value="day">Theo ngày</Option>
                  <Option value="month">Theo tháng</Option>
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
            <Row gutter={[16, 16]}>
              <Col span={8}>
                <Card>
                  <Statistic
                    title="Tổng doanh thu"
                    value={totalRevenue}
                    precision={0}
                    formatter={(value) => (
                      <span style={{ color: '#52c41a' }}>
                        {new Intl.NumberFormat("vi-VN", {
                          style: "currency",
                          currency: "VND",
                        }).format(value as number)}
                      </span>
                    )}
                  />
                </Card>
              </Col>
              <Col span={8}>
                <Card>
                  <Statistic
                    title="Tổng giá vốn"
                    value={totalCost}
                    precision={0}
                    formatter={(value) => (
                      <span style={{ color: '#ff4d4f' }}>
                        {new Intl.NumberFormat("vi-VN", {
                          style: "currency",
                          currency: "VND",
                        }).format(value as number)}
                      </span>
                    )}
                  />
                </Card>
              </Col>
              <Col span={8}>
                <Card>
                  <Statistic
                    title="Tổng lợi nhuận"
                    value={totalProfit}
                    precision={0}
                    formatter={(value) => (
                      <span style={{ color: totalProfit >= 0 ? '#52c41a' : '#ff4d4f' }}>
                        {new Intl.NumberFormat("vi-VN", {
                          style: "currency",
                          currency: "VND",
                        }).format(value as number)}
                      </span>
                    )}
                  />
                </Card>
              </Col>
            </Row>
          </Col>

          <Col span={24}>
            <Card title={chartTitle}>
              <div style={{ height: 400 }}>
                <ResponsiveContainer width="100%" height="100%">
                  <LineChart
                    data={data}
                    margin={{
                      top: 20,
                      right: 30,
                      left: 20,
                      bottom: 20,
                    }}
                  >
                    <CartesianGrid strokeDasharray="3 3" />
                    <XAxis 
                      dataKey="giaiDoan"
                      tickFormatter={(value) => timeRange === 'day' ? dayjs(value).format('DD/MM/YYYY') : value}
                    />
                    <YAxis
                      tickFormatter={(value) => new Intl.NumberFormat('vi-VN', {
                        notation: 'compact',
                        maximumFractionDigits: 1
                      }).format(value)}
                    />
                    <Tooltip content={<CustomTooltip />} />
                    <Legend />
                    <Line
                      type="monotone"
                      dataKey="doanhThu"
                      name="Doanh thu"
                      stroke="#52c41a"
                      activeDot={{ r: 8 }}
                    />
                    <Line
                      type="monotone"
                      dataKey="giaVon"
                      name="Giá vốn"
                      stroke="#ff4d4f"
                    />
                    <Line
                      type="monotone"
                      dataKey="loiNhuan"
                      name="Lợi nhuận"
                      stroke="#1890ff"
                    />
                  </LineChart>
                </ResponsiveContainer>
              </div>
            </Card>
          </Col>

          <Col span={24}>
            <Card title={`Chi tiết lợi nhuận theo ${timeColumnTitle.toLowerCase()}`}>
              <div style={{ overflowX: 'auto' }}>
                <Table
                  columns={commonTableColumns}
                  dataSource={data}
                  rowKey="giaiDoan"
                  pagination={false}
                  scroll={{ x: 'max-content' }}
                  summary={(pageData) => {
                    const total = pageData.reduce((sum, record: any) => ({
                      doanhThu: sum.doanhThu + (Number(record.doanhThu) || 0),
                      giaVon: sum.giaVon + (Number(record.giaVon) || 0),
                      loiNhuan: sum.loiNhuan + (Number(record.loiNhuan) || 0)
                    }), { doanhThu: 0, giaVon: 0, loiNhuan: 0 });

                    return (
                      <Table.Summary.Row>
                        <Table.Summary.Cell index={0}>Tổng cộng</Table.Summary.Cell>
                        <Table.Summary.Cell index={1}>
                          <span style={{ color: '#52c41a', fontWeight: 'bold' }}>
                            {new Intl.NumberFormat("vi-VN", {
                              style: "currency",
                              currency: "VND",
                            }).format(total.doanhThu)}
                          </span>
                        </Table.Summary.Cell>
                        <Table.Summary.Cell index={2}>
                          <span style={{ color: '#ff4d4f', fontWeight: 'bold' }}>
                            {new Intl.NumberFormat("vi-VN", {
                              style: "currency",
                              currency: "VND",
                            }).format(total.giaVon)}
                          </span>
                        </Table.Summary.Cell>
                        <Table.Summary.Cell index={3}>
                          <span style={{ color: total.loiNhuan >= 0 ? '#52c41a' : '#ff4d4f', fontWeight: 'bold' }}>
                            {new Intl.NumberFormat("vi-VN", {
                              style: "currency",
                              currency: "VND",
                            }).format(total.loiNhuan)}
                          </span>
                        </Table.Summary.Cell>
                      </Table.Summary.Row>
                    );
                  }}
                />
              </div>
            </Card>
          </Col>

          <Col span={24}>
            <Card title="Lợi nhuận theo sản phẩm">
              <div style={{ overflowX: 'auto' }}>
                <Table
                  columns={productTableColumns}
                  dataSource={productStats}
                  rowKey="maSanPham"
                  pagination={false}
                  scroll={{ x: 'max-content' }}
                  summary={(pageData) => {
                    const total = pageData.reduce((sum, record: any) => ({
                      doanhThu: sum.doanhThu + (Number(record.doanhThu) || 0),
                      giaVon: sum.giaVon + (Number(record.giaVon) || 0),
                      loiNhuan: sum.loiNhuan + (Number(record.loiNhuan) || 0)
                    }), { doanhThu: 0, giaVon: 0, loiNhuan: 0 });

                    return (
                      <Table.Summary.Row>
                        <Table.Summary.Cell index={0}>Tổng cộng</Table.Summary.Cell>
                        <Table.Summary.Cell index={1}>
                          <span style={{ color: '#52c41a', fontWeight: 'bold' }}>
                            {new Intl.NumberFormat("vi-VN", {
                              style: "currency",
                              currency: "VND",
                            }).format(total.doanhThu)}
                          </span>
                        </Table.Summary.Cell>
                        <Table.Summary.Cell index={2}>
                          <span style={{ color: '#ff4d4f', fontWeight: 'bold' }}>
                            {new Intl.NumberFormat("vi-VN", {
                              style: "currency",
                              currency: "VND",
                            }).format(total.giaVon)}
                          </span>
                        </Table.Summary.Cell>
                        <Table.Summary.Cell index={3}>
                          <span style={{ color: total.loiNhuan >= 0 ? '#52c41a' : '#ff4d4f', fontWeight: 'bold' }}>
                            {new Intl.NumberFormat("vi-VN", {
                              style: "currency",
                              currency: "VND",
                            }).format(total.loiNhuan)}
                          </span>
                        </Table.Summary.Cell>
                      </Table.Summary.Row>
                    );
                  }}
                />
              </div>
            </Card>
          </Col>
        </Row>
      </div>
    </ConfigProvider>
  );
};

export default ThongKeLoiNhuan;
