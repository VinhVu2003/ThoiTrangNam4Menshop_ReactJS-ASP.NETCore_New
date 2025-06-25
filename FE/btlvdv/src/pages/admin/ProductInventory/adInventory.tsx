import React, { useEffect, useState } from "react";
import { Table, Card, Row, Col, Statistic, Input, Tag, Space, Button, Modal, Form, InputNumber, Select, message } from "antd";
import { EditOutlined, SearchOutlined } from "@ant-design/icons";
import { GetAllProducttrongkhoAdmin, GetAllProducts, InsertProInKho } from "../../../services/product.services";
import { IMAGE_BASE_PATH } from "../../../constant/imageBasePath ";
import { searchSize } from "../../../services/size";

const { Column } = Table;

interface InventoryItem {
  id: number;
  maSanPham: number;
  tenSanPham: string;
  anhDaiDien: string;
  gia: number;
  moTa: string | null;
  maSize: number;
  tenSize: string;
  soLuongTon: number;
  trangThai: boolean;
  maChuyenMuc: number | null;
  luotXem: number | null;
}

interface Product {
  maSanPham: number;
  tenSanPham: string;
  gia: number;
  anhDaiDien: string;
}

const AdminInventory: React.FC = () => {
  const [data, setData] = useState<InventoryItem[]>([]);
  const [products, setProducts] = useState<Product[]>([]);
  const [searchText, setSearchText] = useState("");
  const [totalValue, setTotalValue] = useState(0);
  const [totalItems, setTotalItems] = useState(0);
  const [totalQuantity, setTotalQuantity] = useState(0);
  const [pagination, setPagination] = useState({
    current: 1,
    pageSize: 5,
    total: 0,
  });
  const [sizes, setSizes] = useState<[any]>();
  const [isModalVisible, setIsModalVisible] = useState(false);
  const [form] = Form.useForm();
  
  const loadData = async () => {
    try {
      const [inventoryResponse, productsResponse] = await Promise.all([
        GetAllProducttrongkhoAdmin(),
        GetAllProducts()
      ]);

      const inventoryData = inventoryResponse?.map((item: any) => ({
        ...item,
        key: item.id
      })) || [];
      setData(inventoryData);
      setProducts(productsResponse || []);
      
      const total = inventoryData.reduce((sum: number, item: InventoryItem) => 
        sum + (item.soLuongTon * item.gia), 0);
      const totalQty = inventoryData.reduce((sum: number, item: InventoryItem) => 
        sum + item.soLuongTon, 0);
      setTotalValue(total);
      setTotalItems(inventoryData.length);
      setTotalQuantity(totalQty);
    } catch (error) {
      console.error("Error fetching data:", error);
      setData([]);
      setProducts([]);
      setTotalValue(0);
      setTotalItems(0);
      setTotalQuantity(0);
    }
  };
  useEffect(() => {
    async function getallsize() {
      try {
        const response = await searchSize("1", "50");
        setSizes(response.data)
        console.log("dssize",response.data)
      } catch (error) {
        console.error("Error fetching data:", error);
      }
    }
    getallsize();
  }, []);
  useEffect(() => {
    loadData();
  }, []);

  const filteredData = data.filter(item =>
    item.tenSanPham.toLowerCase().includes(searchText.toLowerCase()) ||
    item.tenSize.toLowerCase().includes(searchText.toLowerCase())
  );

  const handleTableChange = (newPagination: any) => {
    setPagination(newPagination);
  };
  const handleEdit = (record: InventoryItem) => {
    // TODO: Implement edit functionality
    console.log('Edit record:', record);
  };
  const handleAdd = () => {
    setIsModalVisible(true);
  };

  const handleModalOk = async () => {
    try {
      const values = await form.validateFields();
      console.log('Form values:', values);
      // TODO: Call API to add new product
      const existingProduct = data.find(
        (item: InventoryItem) => 
          item.maSanPham === values.maSanPham && 
          item.maSize === values.maSize
      );

      if (existingProduct) {
        message.error('Sản phẩm với size này đã tồn tại trong kho!');
        return;
      }
      else{
      const response = await InsertProInKho({
        maSP: values.maSanPham,
        maSize: values.maSize,
        soLuong: values.soLuongTon,
        trangThai: 1
      });
      if (response) {
        message.success('Thêm sản phẩm vào kho thành công!');
        loadData(); // Reload data after successful insertion
      }

      }
      setIsModalVisible(false);
      form.resetFields();
    } catch (error) {
      console.error('Validation failed:', error);
    }
  };

  const handleModalCancel = () => {
    setIsModalVisible(false);
    form.resetFields();
  };

  return (
    <div style={{ padding: "20px" }}>
      <Row gutter={[16, 16]}>
        <Col span={6}>
          <Card>
            <Statistic
              title="Tổng giá trị tồn kho"
              value={totalValue}
              precision={0}
              formatter={(value) => 
                new Intl.NumberFormat("vi-VN", {
                  style: "currency",
                  currency: "VND",
                }).format(Number(value))
              }
            />
          </Card>
        </Col>
        <Col span={6}>
          <Card>
            <Statistic
              title="Tổng số sản phẩm"
              value={totalItems}
            />
          </Card>
        </Col>
        <Col span={6}>
          <Card>
            <Statistic
              title="Tổng số lượng tồn"
              value={totalQuantity}
              valueStyle={{ color: '#1890ff' }}
            />
          </Card>
        </Col>
        <Col span={6}>
          <Card>
            <Statistic
              title="Số sản phẩm sắp hết hàng"
              value={data.filter(item => item.soLuongTon < 10).length}
              valueStyle={{ color: '#cf1322' }}
            />
          </Card>
        </Col>
      </Row>

      <div style={{ marginTop: "20px" }}>
        <div style={{ marginBottom: "20px", display: "flex", justifyContent: "space-between", alignItems: "center" }}>
          <Input
            placeholder="Tìm kiếm theo tên sản phẩm, size..."
            prefix={<SearchOutlined />}
            onChange={(e) => setSearchText(e.target.value)}
            style={{ width: "300px" }}
          />
          <Button 
            type="primary" 
            onClick={() => handleAdd()}
          >
            Thêm sản phẩm mới
          </Button>
        </div>

        <Table 
            size="small"
          dataSource={filteredData} 
          pagination={{
            ...pagination,
            showSizeChanger: true,
            showQuickJumper: true,
            showTotal: (total) => `Tổng số ${total} sản phẩm`,
            pageSizeOptions: ['5', '10', '20', '50', '100'],
          }}
          onChange={handleTableChange}
        >
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
         
          <Column 
            title="Tên sản phẩm" 
            dataIndex="tenSanPham" 
            key="tenSanPham"
            sorter={(a: InventoryItem, b: InventoryItem) => 
              a.tenSanPham.localeCompare(b.tenSanPham)
            }
            filterDropdown={({ setSelectedKeys, selectedKeys, confirm, clearFilters }) => (
              <div style={{ padding: 8 }}>
                <Input
                  placeholder="Tìm kiếm tên sản phẩm"
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
           
            onFilter={(value, record) =>
              record.tenSanPham.toString().toLowerCase().includes((value as string).toLowerCase())
            }
          />
          <Column 
            title="Size" 
            dataIndex="maSize" 
            key="maSize"
            render={(maSize: number) => {
              const size = sizes?.find(s => s.maSize === maSize);
              return size?.tenSize ?? maSize;
            }}
            filters={sizes?.map(size => ({
              text: size.tenSize,
              value: size.maSize
            })) ?? []}
            onFilter={(value, record) => (record as any).maSize === value}
          />
          <Column
            title="Số lượng tồn"
            dataIndex="soLuongTon"
            key="soLuongTon"
            sorter={(a: InventoryItem, b: InventoryItem) => a.soLuongTon - b.soLuongTon}
            render={(soLuongTon: number) => (
              <Tag color={soLuongTon < 10 ? "red" : "green"}>
                {soLuongTon}
              </Tag>
            )}
          />
          <Column
            title="Giá"
            dataIndex="gia"
            key="gia"
            sorter={(a: InventoryItem, b: InventoryItem) => a.gia - b.gia}
            render={(gia: number) => (
              new Intl.NumberFormat("vi-VN", {
                style: "currency",
                currency: "VND",
              }).format(gia)
            )}
          />
          <Column
            title="Tổng giá trị"
            key="totalValue"
            render={(_: unknown, record: InventoryItem) => (
              new Intl.NumberFormat("vi-VN", {
                style: "currency",
                currency: "VND",
              }).format(record.soLuongTon * record.gia)
            )}
          />
        <Column hidden
          title="Thao tác"
          key="action"
          render={(_: unknown, record: InventoryItem) => (
            <Space size="middle">
              <Button 
                type="primary"
                icon={<EditOutlined />}
                onClick={() => handleEdit(record)}
              >
                Sửa
              </Button>
            </Space>
          )}
        />
        </Table>
      </div>

      <Modal
        title="Thêm sản phẩm mới"
        open={isModalVisible}
        onOk={handleModalOk}
        onCancel={handleModalCancel}
        okText="Thêm"
        cancelText="Hủy"
      >
        <Form
          form={form}
          layout="vertical"
        >
          <Form.Item
            name="maSanPham"
            label="Sản phẩm"
            rules={[{ required: true, message: 'Vui lòng chọn sản phẩm' }]}
          >
            <Select
              showSearch
              placeholder="Chọn sản phẩm"
              optionFilterProp="children"
              filterOption={(input, option) =>
                (option?.label?.toString() ?? '').toLowerCase().includes(input.toLowerCase())
              }
            >
              {products?.map(product => (
                <Select.Option key={product.maSanPham} value={product.maSanPham} label={product.tenSanPham}>
                  <div style={{ display: 'flex', alignItems: 'center' }}>
                    <img
                      src={IMAGE_BASE_PATH + (product.anhDaiDien.includes(',') ? product.anhDaiDien.split(',')[0] : product.anhDaiDien)}
                      alt={product.tenSanPham}
                      style={{ width: 30, height: 30, marginRight: 8, objectFit: "cover" }}
                    />
                    <span>{product.tenSanPham}</span>
                  </div>
                </Select.Option>
              ))}
            </Select>
          </Form.Item>

          <Form.Item
            name="maSize"
            label="Size"
            rules={[{ required: true, message: 'Vui lòng chọn size' }]}
          >
            <Select>
              {sizes?.map((size) => (
                <Select.Option key={size.maSize} value={size.maSize}>
                  {size.tenSize}
                </Select.Option>
              ))}
            </Select>
          </Form.Item>

          <Form.Item
            name="soLuongTon"
            label="Số lượng"
            rules={[
              { required: true, message: 'Vui lòng nhập số lượng' },
              { type: 'number', message: 'Vui lòng chỉ nhập số' },
            ]}
          >
            <InputNumber 
              min={10} 
              style={{ width: '100%' }}
              controls={false}
              onKeyPress={(e) => {
                if (!/[0-9]/.test(e.key)) {
                  e.preventDefault();
                }
              }}
            />
          </Form.Item>
        </Form>
      </Modal>
    </div>
  );
};

export default AdminInventory; 