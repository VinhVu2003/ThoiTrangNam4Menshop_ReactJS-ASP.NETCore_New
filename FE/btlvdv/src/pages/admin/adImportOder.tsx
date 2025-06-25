import React, { useEffect, useState } from "react";
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
  Row,
  Col,
  InputNumber,
} from "antd";
import moment from "moment";
import axios from "axios";
import { IMAGE_BASE_PATH } from "../../constant/imageBasePath ";
import {  EditOutlined, DeleteOutlined, EyeOutlined } from "@ant-design/icons";

const { Column, ColumnGroup } = Table;

const AdminImportOder: React.FC = () => {
  const [data, setData] = useState<any[]>([]);
  const [dataCTHD, setdataCTHD] = useState<any[]>([]);
  const [providers, setProvider] = useState<any[]>([]);
  const [products, setProduct] = useState<any[]>([]);
  const [selectedProducts, setSelectedProducts] = useState<any[]>([]);
  const [sizes, setSizes] = useState<any[]>([]);
  const [openModal, setOpenModal] = useState<boolean>(false);
  const [openDetailModal, setOpenDetailModal] = useState<boolean>(false);
  const [selectedOrder, setSelectedOrder] = useState<any>(null);
  const [isAdd, setIsAdd] = useState<boolean>(false);
  const [isEdit, setIsEdit] = useState<boolean>(false);
  const [currentPrice, setCurrentPrice] = useState<number>(0);
  const [form] = Form.useForm();
  const [productForm] = Form.useForm();
  const [priceWarning, setPriceWarning] = useState<boolean>(false);
  // const [isFormCTDHHidden, setIsFormCTDHHidden] = useState<boolean>(false);

  async function onEditOder(oder: any) {
    setOpenModal(true);
    setIsEdit(true);
    setIsAdd(false);
    form.setFieldsValue(oder);
    try {
      const response = await axios.get(
        "https://localhost:44381/api/HoaDonNhap/List_CTHDN_Getbyid?id=" +
          oder.maHoaDon
      );
      const formattedData = response.data.map((item: any) => ({
        ...item,
        tenSize: sizes.find(s => s.maSize === item.maSize)?.tenSize || '',
        key: Date.now() + Math.random()
      }));
      setSelectedProducts(formattedData);
    } catch (error) {
      console.error("Error fetching data:", error);
    }
  }
  
  const onFinish = async (values: any) => {
    if (isAdd) {
      const currentDate = new Date().toISOString();
      try {
        const response = await axios.post(
          "https://localhost:44381/api/HoaDonNhap/HoaDonNhap_Create",
          {
            maNhaPhanPhoi: values.maNhaPhanPhoi,
            ngayTao: currentDate,
            kieuThanhToan: values.kieuThanhToan,
            maTaiKhoan: 1,
            tongTien: selectedProducts.reduce((sum, item) => sum + (item.soLuong * item.giaNhap), 0),
            list_js_ChitietHDN: selectedProducts.map(item => ({
              maSanPham: item.maSanPham,
              maSize: item.maSize,
              soLuong: item.soLuong,
              donViTinh: item.donViTinh,
              giaNhap: item.giaNhap,
              tongTien: item.soLuong * item.giaNhap,
            })),
          }
        );
        if (response.status === 200) {
          alert("Thêm thành công");
          loadData();
          setOpenModal(false);
          form.resetFields();
          productForm.resetFields();
          setSelectedProducts([]);
        } else {
          alert("Có lỗi xảy ra khi thêm dữ liệu");
        }
      } catch (error) {
        console.error("Error fetching data:", error);
        alert("Có lỗi xảy ra khi kết nối tới máy chủ");
      }
    } else {
      try {
        console.log("Form values:", values);
        console.log("Selected products:", selectedProducts);
        const formattedDate = new Date(values.ngayTao).toISOString();
        console.log("Formatted date:", formattedDate);
        const response = await axios.post(
          "https://localhost:44381/api/HoaDonNhap/HoaDonNhap_Update",
          {
            maHoaDon: values.maHoaDon,
            maNhaPhanPhoi: values.maNhaPhanPhoi,
            ngayTao: formattedDate,
            kieuThanhToan: values.kieuThanhToan,
            maTaiKhoan: 1,
            tongTien: selectedProducts.reduce((sum, item) => sum + (item.soLuong * item.giaNhap), 0),
            list_js_ChitietHDN: selectedProducts.map(item => ({
              // id: item.id,
              maHoaDon: values.maHoaDon,
              maSanPham: item.maSanPham,
              maSize: item.maSize,
              soLuong: item.soLuong,
              donViTinh: item.donViTinh,
              giaNhap: item.giaNhap,
              tongTien: item.soLuong * item.giaNhap,
              status: 0
            })),
          }
        );
        if (response.status === 200) {
          alert("Cập nhật thành công");
          loadData();
          setOpenModal(false);
          form.resetFields();
          productForm.resetFields();
          setSelectedProducts([]);
          setIsEdit(false);
        } else {
          alert("Có lỗi xảy ra khi cập nhật dữ liệu");
        }
      } catch (error) {
        console.error("Error updating data:", error);
        alert("Có lỗi xảy ra khi kết nối tới máy chủ");
      }
    }
  };

  const handleAddProduct = (values: any) => {
    const selectedProduct = products.find(p => p.maSanPham === values.maSanPham);
    if (selectedProduct) {
      const newProducts = values.sizes.map((item: any) => ({
        maSanPham: values.maSanPham,
        maSize: item.size,
        soLuong: item.quantity,
        donViTinh: values.donViTinh,
        giaNhap: values.giaNhap,
        tenSanPham: selectedProduct.tenSanPham,
        tenSize: sizes.find(s => s.maSize === item.size)?.tenSize || '',
        key: Date.now() + Math.random()
      }));

      setSelectedProducts([...selectedProducts, ...newProducts]);
      productForm.resetFields();
    }
  };

  const handleRemoveProduct = (key: number) => {
    setSelectedProducts(selectedProducts.filter(item => item.key !== key));
  };

  const handleDelete = async (record: any) => {
    const shouldDelete = window.confirm("Bạn có chắc chắn muốn xóa không?");
    if (shouldDelete) {
      // Xử lý logic xóa ở đây
      const maHoaDon = record.maHoaDon;
      // console.log(maHoaDon);
      try {
        const response = await axios.delete(
          "https://localhost:44381/api/HoaDonNhap/HoaDon_Delete?id=" + maHoaDon
        );
        response && alert("Xóa thành công");
        loadData();
      } catch (error) {
        console.error("Error fetching data:", error);
      }
    }
  };

  const handleViewDetails = async (record: any) => {
    setSelectedOrder(record);
    try {
      const response = await axios.get(
        "https://localhost:44381/api/HoaDonNhap/List_CTHDN_Getbyid?id=" + record.maHoaDon
      );
      const formattedData = response.data.map((item: any) => ({
        ...item,
        tenSize: sizes.find(s => s.maSize === item.maSize)?.tenSize || '',
        key: Date.now() + Math.random()
      }));
      setdataCTHD(formattedData);
      setOpenDetailModal(true);
    } catch (error) {
      console.error("Error fetching data:", error);
    }
  };

  async function loadData() {
    try {
      const response = await axios.post(
        "https://localhost:44381/api/HoaDonNhap/HoaDonNhap_Search",
        {
          page: "1",
          pageSize: "100",
        }
      );
      const modifiedData = response.data.data.map((item: any, index: any) => ({
        ...item,
        key: index + 1, // Tính số thứ tự và cộng 1
        ngayTao: formatDate(item.ngayTao),
      }));
      setData(modifiedData);
      // console.log(modifiedData);
    } catch (error) {
      console.error("Error fetching data:", error);
    }
  }
  useEffect(() => {
    loadData();
  }, []);
  useEffect(() => {
    async function loadDataProvider() {
      try {
        const response = await axios.post(
          "https://localhost:44381/api/NhaPhanPhoi/NhaPhanPhoi_Search",
          {
            page: "1",
            pageSize: "100",
          }
        );
        const modifiedData = response.data.data.map(
          (item: any, index: any) => ({
            ...item,
            index: index + 1, // Tính số thứ tự và cộng 1
          })
        );
        setProvider(modifiedData);
        // console.log(response.data.data);
      } catch (error) {
        console.error("Error fetching data:", error);
      }
    }
    loadDataProvider();
  }, []);
  useEffect(() => {
    async function loadDataProduct() {
      try {
        const response = await axios.get(
          "https://localhost:44381/api/SanPham/getall");
        const modifiedData = response.data.map(
          (item: any, index: any) => ({
            ...item,
            index: index + 1, // Tính số thứ tự và cộng 1
          })
        );
        setProduct(modifiedData);
        // console.log(response.data.data);
      } catch (error) {
        console.error("Error fetching data:", error);
      }
    }
    loadDataProduct();
  }, []);
  useEffect(() => {
    async function loadDataSize() {
      try {
        const response = await axios.post(
          "https://localhost:44381/api/SizeCotroller/Size_Search",
          {
            page: "1",
            pageSize: "100",
          }
        );
        const modifiedData = response.data.data.map((item: any, index: any) => ({
          ...item,
          index: index + 1
        }));
        setSizes(modifiedData);
      } catch (error) {
        console.error("Error fetching sizes:", error);
      }
    }
    loadDataSize();
  }, []);
  function formatDate(dateString: string) {
    return moment(dateString).format("DD/MM/YYYY HH:mm:ss");
  }
  return (
    <>
      <Button
        style={{
          float: "right",
          marginBottom: "20px",
          backgroundColor: "blue",
          color: "white",
        }}
        onClick={() => {
          setIsAdd(true);
          setOpenModal(true);
          setIsEdit(false);
          // setIsFormCTDHHidden(true)
        }}
      >
        Thêm mới
      </Button>
      <Table dataSource={data}>
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
        <Column
          title="Nhà phân phối"
          dataIndex="tenNhaPhanPhoi"
          key="tenNhaPhanPhoi"
          filterDropdown={({ setSelectedKeys, selectedKeys, confirm, clearFilters }) => (
            <div style={{ padding: 8 }}>
              <Select
                showSearch
                style={{ width: 188, marginBottom: 8 }}
                placeholder="Chọn nhà phân phối"
                value={selectedKeys[0]}
                onChange={value => setSelectedKeys(value ? [value] : [])}
                options={Array.from(new Set(data.map(item => item.tenNhaPhanPhoi)))
                  .map(name => ({ value: name, label: name }))}
                filterOption={(input, option) =>
                  (option?.label ?? '').toLowerCase().includes(input.toLowerCase())
                }
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
                  onClick={() => clearFilters?.()}
                  size="small"
                  style={{ width: 90 }}
                >
                  Đặt lại
                </Button>
              </Space>
            </div>
          )}
          onFilter={(value, record: { tenNhaPhanPhoi: string }) => 
            record.tenNhaPhanPhoi.toLowerCase().includes(value.toString().toLowerCase())
          }
        />
        <Column
          title="Kiểu thanh toán"
          dataIndex="kieuThanhToan"
          key="kieuThanhToan"
        />
        <Column 
          title="Ngày đặt hàng" 
          dataIndex="ngayTao" 
          key="ngayTao"
          render={(date) => formatDate(date)}
          filters={[
            { text: 'Hôm nay', value: 'today' },
            { text: 'Hôm qua', value: 'yesterday' },
            { text: 'Tuần này', value: 'thisWeek' },
            { text: 'Tuần trước', value: 'lastWeek' },
            { text: 'Tháng này', value: 'thisMonth' },
            { text: 'Tháng trước', value: 'lastMonth' },
            { text: 'Năm nay', value: 'thisYear' },
            { text: 'Năm trước', value: 'lastYear' }
          ]}
          onFilter={(value, record: { ngayTao: string }) => {
            const today = moment().startOf('day');
            const recordDate = moment(record.ngayTao);
            
            switch(value) {
              case 'today':
                return recordDate.isSame(today, 'day');
              case 'yesterday':
                return recordDate.isSame(today.clone().subtract(1, 'day'), 'day');
              case 'thisWeek':
                return recordDate.isSame(today, 'week');
              case 'lastWeek':
                return recordDate.isSame(today.clone().subtract(1, 'week'), 'week');
              case 'thisMonth':
                return recordDate.isSame(today, 'month');
              case 'lastMonth':
                return recordDate.isSame(today.clone().subtract(1, 'month'), 'month');
              case 'thisYear':
                return recordDate.isSame(today, 'year');
              case 'lastYear':
                return recordDate.isSame(today.clone().subtract(1, 'year'), 'year');
              default:
                return true;
            }
          }}
        />
        <Column
          title="Tổng tiền"
          dataIndex="tongTien"
          key="tongTien"
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
              <a onClick={() => onEditOder(record)}><EditOutlined /> </a>
              <a onClick={() => handleDelete(record)}><DeleteOutlined /> </a>
              <a onClick={() => handleViewDetails(record)}><EyeOutlined /> </a>
            </Space>
          )}
        />
      </Table>

      <Modal
        title={isAdd ? "Thêm đơn hàng " : "Sửa đơn hàng"}
        open={openModal}
        width={800}
        style={{ top: 20 }}
        bodyStyle={{ maxHeight: 'calc(100vh - 200px)', overflow: 'auto', padding: '12px 24px' }}
        okText="Lưu"
        onCancel={() => {
          form.resetFields();
          productForm.resetFields();
          setSelectedProducts([]);
          setOpenModal(false);
        }}
        onOk={() => {
          form.submit();
        }}
        cancelText="Hủy"
      >
        <Form
          form={form}
          name="nest-messages"
          onFinish={onFinish}
          style={{ maxWidth: 800 }}
          layout="vertical"
          size="small"
        >
          <Form.Item name={"maHoaDon"} initialValue={0} hidden={isAdd} label="Mã hóa đơn">
            <Input disabled />
          </Form.Item>

          <Row gutter={4}>
            <Col span={12}>
              <Form.Item 
                label="Nhà phân phối" 
                name="maNhaPhanPhoi" 
                rules={[{ required: true, message: 'Vui lòng chọn nhà phân phối' }]}
                style={{ marginBottom: 8 }}
              >
                <Select placeholder="Chọn nhà phân phối">
                  {providers.map((p) => (
                    <Select.Option key={p.maNhaPhanPhoi} value={p.maNhaPhanPhoi}>
                      {p.tenNhaPhanPhoi}
                    </Select.Option>
                  ))}
                </Select>
              </Form.Item>
            </Col>
            <Col span={12}>
              <Form.Item
                name="kieuThanhToan"
                label="Kiểu thanh toán"
                rules={[{ required: true, message: 'Vui lòng chọn kiểu thanh toán' }]}
                style={{ marginBottom: 8 }}
              >
                <Select placeholder="Chọn kiểu thanh toán">
                  <Select.Option value="Tiền mặt">Tiền mặt</Select.Option>
                  <Select.Option value="Thẻ">Thẻ</Select.Option>
                </Select>
              </Form.Item>
            </Col>
          </Row>

          {!isAdd && (
            <Row gutter={4}>
              <Col span={12}>
                <Form.Item name={"ngayTao"} label="Ngày đặt hàng" style={{ marginBottom: 8 }}>
                  <Input disabled />
                </Form.Item>
              </Col>
            </Row>
          )}
        </Form>
          

        <>
          <h3 style={{ paddingBottom: "8px", marginTop: 0 }}>Thêm sản phẩm</h3>
          <Form
            form={productForm}
            onFinish={handleAddProduct}
            style={{ marginBottom: "12px" }}
            layout="vertical"
            size="small"
          >
            <Row gutter={4}>
              <Col span={12}>
                <Form.Item label="Sản phẩm" name="maSanPham" rules={[{ required: true, message: 'Vui lòng chọn sản phẩm' }]} style={{ marginBottom: 8 }}>
                  <Select
                    showSearch
                    placeholder="Chọn sản phẩm"
                    optionFilterProp="children"
                    filterOption={(input, option) =>
                      (option?.label?.toString() ?? '').toLowerCase().includes(input.toLowerCase())
                    }
                    onChange={(value) => {
                      const selectedProduct = products.find(p => p.maSanPham === value);
                      if (selectedProduct) {
                        setCurrentPrice(selectedProduct.gia);
                        setPriceWarning(selectedProduct.gia)
                        productForm.setFieldsValue({
                          giaNhap: selectedProduct.gia
                        });
                      }
                    }}
                  >
                    {products.map((p) => (
                      <Select.Option key={p.maSanPham} value={p.maSanPham} label={p.tenSanPham}>
                        {p.tenSanPham}
                      </Select.Option>
                    ))}
                  </Select>
                </Form.Item>
              </Col>
              <Col span={12}>
                <Form.Item
                  name="donViTinh"
                  label="Đơn vị tính"
                  rules={[{ required: true, message: 'Vui lòng chọn đơn vị tính' }]}
                  style={{ marginBottom: 8 }}
                >
                  <Select placeholder="Chọn đơn vị tính">
                    <Select.Option value="cái">Cái</Select.Option>
                    <Select.Option value="bộ">Bộ</Select.Option>
                  </Select>
                </Form.Item>
              </Col>
            </Row>

              <Row gutter={4}>
                <Col span={12}>
                  <Form.Item
                    name={"giaNhap"}
                    label="Giá nhập"
                    rules={[
                      { required: true, message: 'Vui lòng nhập giá nhập' }
                    ]}
                    style={{ marginBottom: 8 }}
                    validateStatus={priceWarning ? 'warning' : undefined}
                    help={priceWarning ? 'Giá nhập không được lớn hơn giá bán hiện tại' : undefined}
                  >
                    <InputNumber
                      style={{ width: '100%' }}
                      formatter={(value) => `${value}`.replace(/\B(?=(\d{3})+(?!\d))/g, ',')}
                      parser={(value) => value!.replace(/\$\s?|(,*)/g, '')}
                      placeholder="Nhập giá nhập"
                      onChange={(value) => {
                        const numValue = Number(value);
                        setPriceWarning(numValue >= currentPrice);
                      }}
                    />
                  </Form.Item>
                </Col>
                <Col span={12}>
                  <Form.Item
                    label="Giá bán hiện tại"
                    style={{ marginBottom: 8 }}
                  >
                    <Input 
                      disabled 
                      value={currentPrice ? new Intl.NumberFormat("vi-VN", {
                        style: "currency",
                        currency: "VND",
                      }).format(currentPrice) : ''}
                    />
                  </Form.Item>
                </Col>
              </Row>

              <Form.Item
                style={{ marginBottom: 8 }}
                // validateStatus="warning"
                // help="Vui lòng thêm ít nhất một size và số lượng"
              >
                <Form.List name="sizes" rules={[
                  {
                    validator: async (_, value) => {
                      if (!value || value.length === 0) {
                        return Promise.reject(new Error('Vui lòng thêm ít nhất một size và số lượng'));
                      }
                    },
                  },
                ]}>
                  {(fields, { add, remove }) => (
                    <>
                      {fields.map(({ key, name, ...restField }) => (
                        <Row key={key} gutter={4} style={{ marginBottom: 2 }}>
                          <Col span={11}>
                            <Form.Item
                              {...restField}
                              name={[name, 'size']}
                              rules={[{ required: true, message: 'Vui lòng chọn size' }]}
                              style={{ marginBottom: 4 }}
                            >
                              <Select placeholder="Chọn size">
                                {sizes.map((s) => (
                                  <Select.Option key={s.maSize} value={s.maSize}>
                                    {s.tenSize}
                                  </Select.Option>
                                ))}
                              </Select>
                            </Form.Item>
                          </Col>
                          <Col span={11}>
                            <Form.Item
                              {...restField}
                              name={[name, 'quantity']}
                              rules={[{ required: true, message: 'Vui lòng nhập số lượng' }]}
                              style={{ marginBottom: 4 }}
                            >
                              <Input type="number" placeholder="Số lượng" />
                            </Form.Item>
                          </Col>
                          <Col span={2}>
                            <Button type="link" danger onClick={() => remove(name)} style={{ padding: 0, height: '100%', display: 'flex', alignItems: 'center' }}>
                              Xóa
                            </Button>
                          </Col>
                        </Row>
                      ))}
                      <Form.Item style={{ marginBottom: 4 }}>
                        <Button type="dashed" onClick={() => add()} block size="small">
                          + Thêm size
                        </Button>
                      </Form.Item>
                    </>
                  )}
                </Form.List>
              </Form.Item>

              <Form.Item style={{ marginBottom: 0 }}>
                <Button type="primary" htmlType="submit" size="small">
                  Thêm sản phẩm
                </Button>
              </Form.Item>
            </Form>

          <Table dataSource={selectedProducts} size="small" pagination={false}>
            <Column title="Tên sản phẩm" dataIndex="tenSanPham" key="tenSanPham" width="20%" />
            <Column title="Size" dataIndex="tenSize" key="tenSize" width="10%" />
            <Column 
              title="Số lượng" 
              dataIndex="soLuong" 
              key="soLuong" 
              width="10%"
              render={(value, record: { key: number }) => (
                <InputNumber
                  min={1}
                  value={value}
                  onChange={(newValue) => {
                    const newProducts = selectedProducts.map(item => {
                      if (item.key === record.key) {
                        return { ...item, soLuong: newValue || 1 };
                      }
                      return item;
                    });
                    setSelectedProducts(newProducts);
                  }}
                  style={{ width: '100%' }}
                />
              )}
            />
            <Column title="Đơn vị tính" dataIndex="donViTinh" key="donViTinh" width="10%" />
            <Column 
              title="Giá nhập" 
              dataIndex="giaNhap" 
              key="giaNhap"
              width="15%"
              render={(giaNhap: number) => (
                <span>
                  {new Intl.NumberFormat("vi-VN", {
                    style: "currency",
                    currency: "VND",
                  }).format(giaNhap)}
                </span>
              )}
            />
            <Column
              title="Tổng tiền"
              key="tongTien"
              width="15%"
              render={(_: any, record: { soLuong: number; giaNhap: number }) => (
                <span>
                  {new Intl.NumberFormat("vi-VN", {
                    style: "currency",
                    currency: "VND",
                  }).format(record.soLuong * record.giaNhap)}
                </span>
              )}
            />
            <Column
              title="Action"
              key="action"
              width="10%"
              render={(_: any, record: { key: number }) => (
                <Button type="link" danger onClick={() => handleRemoveProduct(record.key)}>
                  Xóa
                </Button>
              )}
            />
          </Table>

          <div style={{ 
            textAlign: 'right', 
            padding: '16px', 
            backgroundColor: '#f5f5f5', 
            borderRadius: '8px',
            marginTop: '16px'
          }}>
            <div style={{ fontSize: '18px', fontWeight: 'bold' }}>
              Tổng tiền đơn hàng: {new Intl.NumberFormat("vi-VN", {
                style: "currency",
                currency: "VND",
              }).format(selectedProducts.reduce((sum, item) => sum + (item.soLuong * item.giaNhap), 0))}
            </div>
          </div>
        </>

        {/* <div hidden={isAdd}>
          <h3 style={{ paddingBottom: "10px" }}>Chi tiết đơn hàng</h3>
          <Table dataSource={dataCTHD}
            size="small"
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
              render={(anhDaiDien: string) => {
                  const imageList = anhDaiDien.split(',');
                return (
                  <img
                    src={IMAGE_BASE_PATH + imageList[0].trim()}
                    alt="Ảnh"
                    style={{ width: 30, height: "auto" }}
                  />
                );
              }}
            />
            <Column title="Số lượng" dataIndex="soLuong" key="soLuong" />
            <Column title="Size" dataIndex="tenSize" key="tenSize" />
            <Column
              title="Tổng tiền"
              dataIndex="tongTien"
              key="tongTien"
              render={(tongTien: number) => (
                <span>
                  {new Intl.NumberFormat("vi-VN", {
                    style: "currency",
                    currency: "VND",
                  }).format(tongTien)}
                </span>
              )}
            />
            <Column
              title="Action"
              key="action"
              render={(_: any, record: any) => (
                <Space size="middle">
                  <a>Xóa</a>
                </Space>
              )}
            />
          </Table>
        </div> */}
      </Modal>

      {/* Modal Chi tiết đơn hàng */}
      <Modal
        title={
          <div style={{ textAlign: 'center', fontSize: '20px', fontWeight: 'bold' }}>
            Chi tiết đơn hàng
          </div>
        }
        open={openDetailModal}
        onCancel={() => setOpenDetailModal(false)}
        footer={null}
        width={800}
        style={{ top: 20 }}
        bodyStyle={{ maxHeight: 'calc(100vh - 200px)', overflow: 'auto', padding: '24px' }}
      >
        {selectedOrder && (
          <div>
            <div style={{ marginBottom: '24px', padding: '16px', backgroundColor: '#f5f5f5', borderRadius: '8px' }}>
              <Row gutter={[16, 16]}>
                <Col span={12}>
                  <div style={{ marginBottom: '8px' }}>
                    <span style={{ fontWeight: 'bold' }}>Mã đơn hàng: </span>
                    <span>{selectedOrder.maHoaDon}</span>
                  </div>
                  <div style={{ marginBottom: '8px' }}>
                    <span style={{ fontWeight: 'bold' }}>Nhà phân phối: </span>
                    <span>{selectedOrder.tenNhaPhanPhoi}</span>
                  </div>
                </Col>
                <Col span={12}>
                  <div style={{ marginBottom: '8px' }}>
                    <span style={{ fontWeight: 'bold' }}>Ngày đặt hàng: </span>
                    <span>{formatDate(selectedOrder.ngayTao)}</span>
                  </div>
                  <div style={{ marginBottom: '8px' }}>
                    <span style={{ fontWeight: 'bold' }}>Kiểu thanh toán: </span>
                    <span>{selectedOrder.kieuThanhToan}</span>
                  </div>
                </Col>
              </Row>
            </div>

            <Table 
              dataSource={dataCTHD} 
              size="small" 
              pagination={false}
              style={{ marginBottom: '24px' }}
            >
              <Column 
                title="Ảnh" 
                dataIndex="anhDaiDien" 
                key="anhDaiDien"
                width="10%"
                render={(anhDaiDien: string) => (
                  <img
                    src={IMAGE_BASE_PATH + (anhDaiDien?.includes(",") ? anhDaiDien.split(",")[0] : anhDaiDien)}
                    alt="Ảnh sản phẩm"
                    style={{ 
                      width: '50px', 
                      height: '50px', 
                      objectFit: 'cover',
                      borderRadius: '4px'
                    }}
                  />
                )}
              />
              <Column 
                title="Tên sản phẩm" 
                dataIndex="tenSanPham" 
                key="tenSanPham"
                width="25%"
              />
              <Column 
                title="Size" 
                dataIndex="tenSize" 
                key="tenSize"
                width="10%"
              />
              <Column 
                title="Số lượng" 
                dataIndex="soLuong" 
                key="soLuong"
                width="10%"
              />
              <Column 
                title="Đơn vị tính" 
                dataIndex="donViTinh" 
                key="donViTinh"
                width="10%"
              />
              <Column 
                title="Giá nhập" 
                dataIndex="giaNhap" 
                key="giaNhap"
                width="15%"
                render={(giaNhap: number) => (
                  <span>
                    {new Intl.NumberFormat("vi-VN", {
                      style: "currency",
                      currency: "VND",
                    }).format(giaNhap)}
                  </span>
                )}
              />
              <Column 
                title="Thành tiền" 
                key="thanhTien"
                width="15%"
                render={(_: any, record: any) => (
                  <span>
                    {new Intl.NumberFormat("vi-VN", {
                      style: "currency",
                      currency: "VND",
                    }).format(record.soLuong * record.giaNhap)}
                  </span>
                )}
              />
            </Table>

            <div style={{ textAlign: 'right', padding: '16px', backgroundColor: '#f5f5f5', borderRadius: '8px' }}>
              <div style={{ fontSize: '18px', fontWeight: 'bold', marginBottom: '8px' }}>
                Tổng tiền: {new Intl.NumberFormat("vi-VN", {
                  style: "currency",
                  currency: "VND",
                }).format(selectedOrder.tongTien)}
              </div>
            </div>
          </div>
        )}
      </Modal>
    </>
  );
};

export default AdminImportOder;
