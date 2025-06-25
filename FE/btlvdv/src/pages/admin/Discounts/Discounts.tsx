import React, { useState, useEffect } from 'react';
import {
  Table,
  Button,
  Space,
  Tag,
  Modal,
  Form,
  Input,
  InputNumber,
  DatePicker,
  Select,
  Switch,
  message,
  Transfer,
} from 'antd';
import { EditOutlined, DeleteOutlined, PlusOutlined, ShoppingOutlined } from '@ant-design/icons';
import dayjs from 'dayjs';
import type { ColumnsType } from 'antd/es/table';
import { deleteGiamGia, get_all_Admin_GiamGia, updateGiamGia, createGiamGia, getListProInDiscount, getProductsNotInOtherDiscounts, insertGiamGiaSanPham, Delete_Input_GiamGiaId_SanPhamId } from '../../../services/discount.services';
import { getProductsForDiscount, getProductsByDiscountId, updateProductsForDiscount, GetAllProducts } from '../../../services/product.services';

interface Discount {
  id: number;
  tenChuongTrinh: string;
  loaiGiamGia: 'PhanTramTheoSanPham' | 'PhanTramTheoDonHang' | 'GiaCoDinhTheoDonHang';
  giaTriGiam: number;
  maGiamGia: string | null;
  soLuongMua: number | null;
  soLuongTang: number | null;
  sanPhamTangId: number | null;
  giaTriDonToiThieu: number | null;
  apDungToanBoSanPham: boolean;
  nhomKhachHang: string | null;
  ngayBatDau: string;
  ngayKetThuc: string;
  dangHoatDong: boolean;
  ngayTao: string;
  ngayCapNhat: string;
  soLuongToiDa: number | null;
  soLuongDaDung: number;
}

const Discounts: React.FC = () => {
  const [discounts, setDiscounts] = useState<Discount[]>([]);
  const [isModalVisible, setIsModalVisible] = useState(false);
  const [isProductModalVisible, setIsProductModalVisible] = useState(false);
  const [form] = Form.useForm();
  const [editingId, setEditingId] = useState<number | null>(null);
  const [selectedDiscountType, setSelectedDiscountType] = useState<string>('');
  
  const [products, setProducts] = useState<any[]>([]);
  const [selectedProducts, setSelectedProducts] = useState<string[]>([]);
  const [currentDiscountId, setCurrentDiscountId] = useState<number | null>(null);

  const columns: ColumnsType<Discount> = [
    {
      title: 'ID',
      dataIndex: 'id',
      key: 'id',
    },
    {
      title: 'Tên chương trình',
      dataIndex: 'tenChuongTrinh',
      key: 'tenChuongTrinh',
    },
    {
      title: 'Loại giảm giá',
      dataIndex: 'loaiGiamGia',
      key: 'loaiGiamGia',
      render: (text: string) => {
        const colors = {
          PhanTramTheoSanPham: 'blue',
          PhanTramTheoDonHang: 'green',
          GiaCoDinhTheoDonHang: 'purple',
        };
        return <Tag color={colors[text as keyof typeof colors]}>{text}</Tag>;
      },
    },
    {
      title: 'Giá trị giảm',
      dataIndex: 'giaTriGiam',
      key: 'giaTriGiam',
      render: (text: number, record) => (
        <span>
          {record.loaiGiamGia === 'PhanTramTheoSanPham' ? `${text}%` : text}
        </span>
      ),
    },
    {
      title: 'Mã giảm giá',
      dataIndex: 'maGiamGia',
      key: 'maGiamGia',
    },
    // {
    //   title: 'Giá trị đơn tối thiểu',
    //   dataIndex: 'giaTriDonToiThieu',
    //   key: 'giaTriDonToiThieu',
    //   render: (text: number | null) => text ? `${text.toLocaleString()}đ` : '0đ',
    // },
    {
      title: 'Nhóm khách hàng',
      dataIndex: 'nhomKhachHang',
      key: 'nhomKhachHang',
    },
    {
      title: 'Thời gian',
      key: 'thoiGian',
      render: (_, record) => (
        <span>
          {dayjs(record.ngayBatDau).format('DD/MM/YYYY')} -{' '}
          {dayjs(record.ngayKetThuc).format('DD/MM/YYYY')}
        </span>
      ),
    },
    {
      title: 'Trạng thái',
      dataIndex: 'dangHoatDong',
      key: 'dangHoatDong',
      render: (text: boolean) => (
        <Tag color={text ? 'green' : 'red'}>
          {text ? 'Đang hoạt động' : 'Không hoạt động'}
        </Tag>
      ),
    },
    {
      title: 'Thao tác',
      key: 'action',
      render: (_, record) => (
        <Space size="middle">
          <Button
            type="primary"
            icon={<EditOutlined />}
            onClick={() => handleEdit(record)}
          >
            
          </Button>
          <Button
            type="primary"
            icon={<ShoppingOutlined />}
            onClick={() => handleSelectProducts(record)}
            title="Chọn sản phẩm ảnh hưởng"
          >
            
          </Button>
          <Button
            danger
            icon={<DeleteOutlined />}
            onClick={() => handleDelete(record.id)}
          >
            
          </Button>
        </Space>
      ),
    },
  ];

  const handleEdit = (record: Discount) => {
    setEditingId(record.id);
    form.setFieldsValue({
      ...record,
      ngayBatDau: dayjs(record.ngayBatDau),
      ngayKetThuc: dayjs(record.ngayKetThuc),
    });
    setSelectedDiscountType(record.loaiGiamGia);
    setIsModalVisible(true);
  };

  const handleDelete = async (id: number) => {
    Modal.confirm({
      title: 'Xác nhận xóa',
      content: 'Bạn có chắc chắn muốn xóa chương trình khuyến mãi này?',
      onOk: async () => {
        try {
          const response = await deleteGiamGia(id);
         message.success('Xóa thành công');
          // Refresh the discounts list after deletion
          const data = await get_all_Admin_GiamGia();
          setDiscounts(data);
        } catch (error) {
          message.error('Có lỗi xảy ra khi xóa');
        }
      },
    });
  };

  const handleSelectProducts = async (record: Discount) => {
    if (record.loaiGiamGia != "PhanTramTheoSanPham") {
      message.warning('Chức năng này chỉ áp dụng mã giảm giá theo sản phẩm');
      return;
    }

    try {
      setCurrentDiscountId(record.id);
      // const [allProducts, discountProducts] = await Promise.all([
      //   getProductsNotInOtherDiscounts(record.id),
      //   getListProInDiscount(record.id)
      // ]);
      const allProducts = await getProductsNotInOtherDiscounts(record.id)
       const discountProducts = await getListProInDiscount(record.id)
      // Chuyển đổi dữ liệu sản phẩm cho Transfer component
      const formattedProducts =  allProducts.map((product: { maSanPham: number; tenSanPham: string; gia: number }) => ({
        key: product.maSanPham.toString(),
        title: product.tenSanPham,
        description: `Giá: ${product.gia.toLocaleString()}đ`,
        disabled: false
      }));
      
      // Lấy danh sách ID sản phẩm đã được chọn
      const selectedProductIds = discountProducts.map((p: any) => p.sanPhamId.toString());

      setProducts(formattedProducts);
      
      setSelectedProducts(selectedProductIds);
      setIsProductModalVisible(true);
    } catch (error) {
      message.error('Không thể tải danh sách sản phẩm');
    }
  };

  const handleProductSelectionChange = async (targetKeys: React.Key[], direction: 'left' | 'right', moveKeys: React.Key[]) => {
    console.log('Direction:', direction);
    console.log('Moved keys:', moveKeys);
    console.log('Target keys:', targetKeys);

    // Nếu đang chuyển sản phẩm sang bên phải (chọn sản phẩm)
    if (direction === 'right') {
      // Kiểm tra số lượng sản phẩm đã chọn
      if (targetKeys.length > 10) {
        message.warning('Chỉ được chọn tối đa 10 sản phẩm');
        return;
      }
      // alert(`GiamGiaId: ${currentDiscountId}\nSản phẩm được chọn: ${moveKeys.join(', ')}`);
      for (const productId of moveKeys) {
        const data = {
          giamGiaId: currentDiscountId,
          sanPhamId: parseInt(productId.toString())
        };
        try {
          await insertGiamGiaSanPham(data);
          message.success('Thêm sản phẩm vào chương trình giảm giá thành công');
        } catch (error) {
          message.error('Không thể thêm sản phẩm vào chương trình giảm giá');
        }
      }
      
    } else {
      for (const productId of moveKeys) {
        try {
          await Delete_Input_GiamGiaId_SanPhamId(currentDiscountId!, parseInt(productId.toString()));
          message.success('Xóa sản phẩm khỏi chương trình giảm giá thành công');
        } catch (error) {
          message.error('Không thể xóa sản phẩm khỏi chương trình giảm giá');
        }
      }
    }

    // Cập nhật danh sách sản phẩm đã chọn
    setSelectedProducts(targetKeys.map(String));

    // Log thông tin sản phẩm được chọn/bỏ chọn
    const movedProducts = products.filter(p => moveKeys.includes(p.key));
    console.log('Moved products:', movedProducts);
  };

  const handleSaveProducts = async () => {
    if (!currentDiscountId) return;

    try {
      // Chuyển đổi selectedProducts từ string sang number
      const productIds = selectedProducts.map(Number);
      message.success('Cập nhật sản phẩm thành công');
      setIsProductModalVisible(false);
    } catch (error) {
      message.error('Có lỗi xảy ra khi cập nhật sản phẩm');
    }
  };

  const handleCreateDiscount = async (values: any) => {
    try {
      const newDiscount: Partial<Discount> = {
        ...values,
        tenChuongTrinh: values.tenChuongTrinh,
        loaiGiamGia: values.loaiGiamGia,
        giaTriGiam: values.giaTriGiam,
        maGiamGia: values.maGiamGia || null,
        ngayBatDau: values.ngayBatDau.format('YYYY-MM-DDTHH:mm:ss'),
        ngayKetThuc: values.ngayKetThuc.format('YYYY-MM-DDTHH:mm:ss'),
        ngayTao: new Date().toISOString(),
        ngayCapNhat: new Date().toISOString(),
        soLuongDaDung: 0,
        soLuongMua: values.soLuongMua || null,
        soLuongTang: values.soLuongTang || null,
        sanPhamTangId: values.sanPhamTangId || null,
        giaTriDonToiThieu: values.giaTriDonToiThieu || null,
        apDungToanBoSanPham: values.apDungToanBoSanPham || false,
        nhomKhachHang: values.nhomKhachHang || null,
        dangHoatDong: values.dangHoatDong || false,
        soLuongToiDa: values.soLuongToiDa || null
      };

      await createGiamGia(newDiscount);
      message.success('Tạo mới thành công');
      
      // Refresh the discounts list
      const data = await get_all_Admin_GiamGia();
      setDiscounts(data);

      setIsModalVisible(false);
      form.resetFields();
      setSelectedDiscountType('');
    } catch (error) {
      message.error('Có lỗi xảy ra khi tạo mới');
    }
  };

  const handleUpdateDiscount = async (values: any) => {
    try {
      const updateData: Partial<Discount> = {
        ...values,
        id: editingId,
        ngayBatDau: values.ngayBatDau.format('YYYY-MM-DDTHH:mm:ss'),
        ngayKetThuc: values.ngayKetThuc.format('YYYY-MM-DDTHH:mm:ss'),
        ngayCapNhat: new Date().toISOString(),
        soLuongDaDung: 0,
        soLuongMua: values.soLuongMua || null,
        soLuongTang: values.soLuongTang || null,
        sanPhamTangId: values.sanPhamTangId || null,
        giaTriDonToiThieu: values.giaTriDonToiThieu || null,
        nhomKhachHang: values.nhomKhachHang || null,
        soLuongToiDa: values.soLuongToiDa || null
      };

      await updateGiamGia(updateData);
      message.success('Cập nhật thành công');

      // Refresh the discounts list
      const data = await get_all_Admin_GiamGia();
      setDiscounts(data);

      setIsModalVisible(false);
      form.resetFields();
      setEditingId(null);
      setSelectedDiscountType('');
    } catch (error) {
      message.error('Có lỗi xảy ra khi cập nhật');
    }
  };

  const handleSubmit = async (values: any) => {
    if (editingId) {
      await handleUpdateDiscount(values);
    } else {
      await handleCreateDiscount(values);
    }
  };

  useEffect(() => {
    const fetchDiscounts = async () => {
      try {
        const data = await get_all_Admin_GiamGia();
        console.log("dsgiamgia",data)
        setDiscounts(data);
      } catch (error) {
        console.error('Error fetching discounts:', error);
        message.error('Không thể tải danh sách mã giảm giá');
      }
    };
    fetchDiscounts();
  }, []);
  return (
    <div style={{ padding: '24px' }}>
      <div style={{ marginBottom: '16px' }}>
        <Button
          type="primary"
          icon={<PlusOutlined />}
          onClick={() => {
            setEditingId(null);
            form.resetFields();
            setIsModalVisible(true);
          }}
        >
          Thêm mới
        </Button>
      </div>

      <Table
        size="small"
        columns={columns}
        dataSource={discounts}
        rowKey="id"
        pagination={{ pageSize: 10 }}
      />

      <Modal
        title={editingId ? 'Chỉnh sửa khuyến mãi' : 'Thêm khuyến mãi mới'}
        open={isModalVisible}
        onCancel={() => {
          setIsModalVisible(false);
          form.resetFields();
          setEditingId(null);
          setSelectedDiscountType('');
        }}
        footer={null}
        width={800}
      >
        <Form
          form={form}
          layout="vertical"
          onFinish={handleSubmit}
        >
          <div style={{ display: 'flex', gap: '16px' }}>
            <div style={{ flex: 1 }}>
              <Form.Item
                name="loaiGiamGia"
                label="Loại giảm giá"
                rules={[{ required: true, message: 'Vui lòng chọn loại giảm giá' }]}
              >
                <Select onChange={(value) => setSelectedDiscountType(value)}>
                  <Select.Option value="PhanTramTheoSanPham">Phần trăm - Theo Sản Phẩm</Select.Option>
                  <Select.Option value="PhanTramTheoDonHang">Phần trăm - Theo Đơn Hàng</Select.Option>
                  <Select.Option value="GiaCoDinhTheoDonHang">Giá cố định - Theo Đơn Hàng</Select.Option>
                </Select>
              </Form.Item>

              <Form.Item
                name="tenChuongTrinh"
                label="Tên chương trình"
                rules={[{ required: true, message: 'Vui lòng nhập tên chương trình' }]}
              >
                <Input />
              </Form.Item>

              <Form.Item
                name="giaTriGiam"
                label="Giá trị giảm"
                rules={[{ required: true, message: 'Vui lòng nhập giá trị giảm' }]}
              >
                <InputNumber 
                  min={0} 
                  max={selectedDiscountType === 'PhanTram' ? 100 : undefined}
                  style={{ width: '100%' }} 
                />
              </Form.Item>

              {selectedDiscountType !== 'PhanTramTheoSanPham' && (
                <Form.Item
                  name="maGiamGia"
                  label="Mã giảm giá"
                  rules={[{ required: true, message: 'Vui lòng nhập mã giảm giá' }]}
                >
                  <Input 
                    addonBefore="4MENSHOP-"
                    placeholder="Nhập mã giảm giá"
                  />
                </Form.Item>
              )}

              {selectedDiscountType === 'SoLuong' && (
                <>
                  <Form.Item
                    name="soLuongMua"
                    label="Số lượng mua tối thiểu"
                    rules={[{ required: true, message: 'Vui lòng nhập số lượng mua tối thiểu' }]}
                  >
                    <InputNumber min={1} style={{ width: '100%' }} />
                  </Form.Item>

                  <Form.Item
                    name="soLuongTang"
                    label="Số lượng tặng"
                    rules={[{ required: true, message: 'Vui lòng nhập số lượng tặng' }]}
                  >
                    <InputNumber min={1} style={{ width: '100%' }} />
                  </Form.Item>
                </>
              )}

              {/* {selectedDiscountType !== 'PhanTram' && (
                <Form.Item
                  name="giaTriDonToiThieu"
                  label="Giá trị đơn tối thiểu"
                  rules={[{ required: true, message: 'Vui lòng nhập giá trị đơn tối thiểu' }]}
                >
                  <InputNumber
                    min={0}
                    formatter={(value) => `${value}`.replace(/\B(?=(\d{3})+(?!\d))/g, ',')}
                    style={{ width: '100%' }}
                  />
                </Form.Item>
              )} */}
            </div>
            
            <div style={{ flex: 1 }}>
              {selectedDiscountType !== 'PhanTramTheoSanPham' && (
                <>
                  <Form.Item  
                    name="nhomKhachHang"
                    label="Nhóm khách hàng"
                    rules={[{ required: true, message: 'Vui lòng chọn nhóm khách hàng' }]}
                  >
                    <Select>
                      <Select.Option value="VIP">VIP(Đã có tài khoản)</Select.Option>
                      <Select.Option value="THUONG">Thường(Chưa tài khoản)</Select.Option>
                    </Select>
                  </Form.Item>
                  
                  <Form.Item
                    name="soLuongToiDa"
                    label="Số lượng tối đa"
                    rules={[{ required: true, message: 'Vui lòng nhập số lượng tối đa' }]}
                  >
                    <InputNumber min={1} style={{ width: '100%' }} />
                  </Form.Item>
                </>
              )}

              <Form.Item
                name="ngayBatDau"
                label="Ngày bắt đầu"
                rules={[{ required: true, message: 'Vui lòng chọn ngày bắt đầu' }]}
              >
                <DatePicker showTime style={{ width: '100%' }} />
              </Form.Item>

              <Form.Item
                name="ngayKetThuc"
                label="Ngày kết thúc"
                rules={[{ required: true, message: 'Vui lòng chọn ngày kết thúc' }]}
              >
                <DatePicker showTime style={{ width: '100%' }} />
              </Form.Item>

              {/* <Form.Item
                name="apDungToanBoSanPham"
                label="Áp dụng toàn bộ sản phẩm"
                valuePropName="checked"
              >
                <Switch />
              </Form.Item> */}

              <Form.Item
                name="dangHoatDong"
                label="Trạng thái"
                valuePropName="checked"
              >
                <Switch />
              </Form.Item>
            </div>
          </div>

          <Form.Item>
            <Space>
              <Button type="primary" htmlType="submit">
                {editingId ? 'Cập nhật' : 'Thêm mới'}
              </Button>
              <Button
                onClick={() => {
                  setIsModalVisible(false);
                  form.resetFields();
                  setEditingId(null);
                  setSelectedDiscountType('');
                }}
              >
                Hủy
              </Button>
            </Space>
          </Form.Item>
        </Form>
      </Modal>

      <Modal
        title="Chọn sản phẩm áp dụng giảm giá"
        open={isProductModalVisible}
        onCancel={() => setIsProductModalVisible(false)}
        width={1000}
        footer={[
          <Button key="cancel" onClick={() => setIsProductModalVisible(false)}>
            Hủy
          </Button>,
          <Button key="save" type="primary" onClick={handleSaveProducts}>
            Lưu
          </Button>,
        ]}
      >
        <Transfer
          dataSource={products}
          titles={['Danh sách sản phẩm', 'Sản phẩm được chọn']}
          targetKeys={selectedProducts}
          onChange={handleProductSelectionChange}
          render={item => (
            <div style={{ 
              whiteSpace: 'normal',
              wordBreak: 'break-word',
              padding: '4px 0'
            }}>
              <div style={{ fontWeight: 500 }}>{item.title}</div>
              <div style={{ fontSize: '12px', color: '#999' }}>{item.description}</div>
            </div>
          )}
          listStyle={{
            width: 450,
            height: 400,
          }}
          operations={['', '']}
          showSearch //hàm tìm kiếm có sẵn
          filterOption={(inputValue, item) =>
            item.title.toLowerCase().indexOf(inputValue.toLowerCase()) !== -1
          }
        />
      </Modal>
    </div>
  );
};

export default Discounts;
