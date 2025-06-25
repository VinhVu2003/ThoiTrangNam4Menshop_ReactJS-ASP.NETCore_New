import React, { useEffect, useState } from "react";
import {
  Button,
  Dropdown,
  Form,
  Input,
  MenuProps,
  Modal,
  Select,
  Space,
  Table,
  Tag,
  Upload,
  message,
  Switch,
  Row,
  Col,
} from "antd";
import axios from "axios";
import { DeleteOutlined, DownOutlined, EditOutlined, PlusOutlined, SettingOutlined, SyncOutlined, HistoryOutlined } from "@ant-design/icons";
import { SearchProps } from "antd/es/input";
import { DeleteProduct, GetAllProducts, InsertProduct, UpdateProduct } from "../../services/product.services";
import { getAllCategory } from "../../services/category";
import { uploadMultipleFiles } from "../../services/uploadFiles";
import ReactQuill from 'react-quill';
import 'react-quill/dist/quill.snow.css';
const { Column, ColumnGroup } = Table;

const AdminProduct: React.FC = () => {
  const [ProductAll, setProductAll] = useState<any[]>([]);
  const [data, setData] = useState<any[]>([]);
  const [openModal, setOpenModal] = useState<boolean>(false);
  const [openUpdateModal, setOpenUpdateModal] = useState<boolean>(false);
  const [OpenCapNhatGiaModel, setOpenCapNhatGiaModel] = useState<boolean>(false);
  const [isAdd, setIsAdd] = useState<boolean>(false);
  const [form] = Form.useForm();
  const [updateForm] = Form.useForm();
  const [CapnhatGiaForm] = Form.useForm();
  const [categories, setCategories] = useState<any[]>([]);
  const [loading, setLoading] = useState(false);
  const [selectedProduct, setSelectedProduct] = useState<any>(null);
  const [importPrices, setImportPrices] = useState<{[key: number]: number}>({});
  const [openHistoryModal, setOpenHistoryModal] = useState<boolean>(false);
  const [priceHistory, setPriceHistory] = useState<any[]>([]);
  const [selectedProductName, setSelectedProductName] = useState<string>('');

  async function loadDataCategory() {
    try {
      const response = await getAllCategory();
      setCategories(response);
      console.log("DSChuyenMuc",response);
    } catch (error) {
      console.error("Error fetching data:", error);
    }
  }

  async function loadData() {
    try {
      const response = await GetAllProducts();
      const modifiedData = response.map((item: any, index: any) => ({
        ...item,
        index: index + 1,
      }));
      setData(modifiedData);
      setProductAll(modifiedData);
    } catch (error) {
      console.error("Error fetching data:", error);
    }
  }

  const onFinish = async (values: any) => {
    if (isAdd) {
      try {
        setLoading(true);
        console.log("Starting product addition with values:", values);

        // Validate required fields
        if (!values.tenSanPham || !values.maChuyenMuc || !values.gia || !values.moTa) {
          message.error("Vui lòng điền đầy đủ thông tin sản phẩm!");
          return;
        }

        // Validate image upload
        if (!values.fileList || values.fileList.length === 0) {
          message.error("Vui lòng chọn ít nhất một ảnh cho sản phẩm!");
          return;
        }

        // Upload images
        const imageFiles = values.fileList.map((file: any) => file.originFileObj);
        console.log("Image files to upload:", imageFiles);

        const uploadedUrls = await uploadMultipleFiles(imageFiles);
        console.log("Uploaded image URLs:", uploadedUrls);

        if (!uploadedUrls || uploadedUrls.length === 0) {
          message.error("Không thể tải lên ảnh sản phẩm!");
          return;
        }

        // Prepare product data
        const productData = {
          maChuyenMuc: values.maChuyenMuc,
          tenSanPham: values.tenSanPham,
          anhDaiDien: uploadedUrls.join(','),
          gia: parseInt(values.gia),
          moTa: values.moTa,
          trangThai: false
        };

        console.log("Sending product data:", productData);

        // Insert product
        const response = await InsertProduct(productData);
        console.log("Insert product response:", response);

        if (response) {
          message.success("Thêm sản phẩm thành công!");
          await loadData();
          setOpenModal(false);
          form.resetFields();
        } else {
          message.error("Thêm sản phẩm thất bại!");
        }
      } catch (error) {
        console.error("Error adding product:", error);
        message.error("Đã xảy ra lỗi khi thêm sản phẩm: " + (error as Error).message);
      } finally {
        setLoading(false);
      }
    }
  };

  const handleDeleteProduct = async function (record: any) {
    const confirmDelete = window.confirm("Bạn có chắc chắn muốn xóa không?");
    if (confirmDelete) {
      const maSanPham = record.maSanPham;
      try {
        await DeleteProduct(maSanPham);
        message.success("Xóa sản phẩm thành công");
        loadData();
      } catch (error) {
        console.error("Error deleting product:", error);
        message.error("Xóa sản phẩm thất bại");
      }
    }
  };

  const onEdit = function (product: any) {
    setSelectedProduct(product);
    setOpenUpdateModal(true);
    
    let existingImages = [];
    if (product.anhDaiDien) {
      existingImages = product.anhDaiDien.split(',').map((path: string) => {
        const fileName = path.split('/').pop();
        return {
          uid: `-${Math.random()}`,
          name: fileName,
          status: 'done',
          url: "../assets/anh/" + fileName
        };
      });
    }

    updateForm.setFieldsValue({
      ...product,
      fileList: existingImages,
      anhDaiDien: product.anhDaiDien ? product.anhDaiDien.split('/').pop() : ''
    });
  };

  const oncapnhatgia = function (product: any) {
    setSelectedProduct(product);
    setOpenCapNhatGiaModel(true);
    
    // Convert existing image paths to fileList format
    const existingImages = product.anhDaiDien.split(',').map((path: string) => {
      const fileName = path.split('/').pop();
      return {
        uid: `-${Math.random()}`,
        name: fileName,
        status: 'done',
        url: "../assets/anh/" + fileName
      };
    });

    CapnhatGiaForm.setFieldsValue({
      ...product,
      fileList: existingImages,
      anhDaiDien: product.anhDaiDien.split('/').pop() // Remove /anh/ prefix
    });
  };
  //hàm cập nhật sản phẩm
  const handleUpdate = async (values: any) => {
    try {
      // Khởi tạo biến lưu trữ đường dẫn ảnh
      let anhDaiDien = '';
      
      // Lọc và lấy tên file từ các ảnh cũ (không có originFileObj)
      // originFileObj chỉ tồn tại khi file mới được chọn
      const existingImages = values.fileList
        .filter((file: any) => !file.originFileObj && file.url)
        .map((file: any) => file.url.split('/').pop());
      
      // Kiểm tra nếu có file được chọn
      if (values.fileList && values.fileList.length > 0) {
        // Lọc ra các file mới được chọn (có originFileObj)
        const newFiles = values.fileList
          .filter((file: any) => file.originFileObj)
          .map((file: any) => file.originFileObj);
        
        console.log("New files to upload:", newFiles);
        
        // Nếu có file mới được chọn
        if (newFiles.length > 0) {
          // Upload các file mới lên server
          const uploadedUrls = await uploadMultipleFiles(newFiles);
          console.log("Uploaded URLs response:", uploadedUrls);
          
          // Nếu upload thành công
          if (uploadedUrls && uploadedUrls.length > 0) {
            // Kết hợp đường dẫn ảnh cũ và mới, phân cách bằng dấu phẩy
            anhDaiDien = [...existingImages, ...uploadedUrls].join(',');
            console.log("Combined image URLs:", anhDaiDien);
          }
        } else {
          // Trường hợp không có file mới, chỉ sử dụng ảnh cũ
          anhDaiDien = existingImages.join(',');
        }
      }      
      console.log("Tên ảnh cuối cùng:", anhDaiDien);
      console.log("valuesupdate",values)
      const response = await UpdateProduct({
        maSanPham: values.maSanPham,
        maChuyenMuc: values.maChuyenMuc,
        anhDaiDien: anhDaiDien,
        tenSanPham: values.tenSanPham,
        gia: values.gia,
        moTa: values.moTa,
        trangThai: values.trangThai
      });
      response && alert("Sửa thành công!");
      loadData();
      setOpenUpdateModal(false);
      updateForm.resetFields();
    } catch (error) {
      console.error("Error updating product:", error);
      alert("Đã xảy ra lỗi khi cập nhật sản phẩm");
    }
  };

  //hàm set giá và bật trạng thái sản phẩm
  const CapNhatGiaLuu = async (values: any) => {
    try {
      // Khởi tạo biến lưu trữ đường dẫn ảnh
      let anhDaiDien = '';
      
      // Lọc và lấy tên file từ các ảnh cũ (không có originFileObj)
      // originFileObj chỉ tồn tại khi file mới được chọn
      const existingImages = values.fileList
        .filter((file: any) => !file.originFileObj && file.url)
        .map((file: any) => file.url.split('/').pop());
      
      // Kiểm tra nếu có file được chọn
      if (values.fileList && values.fileList.length > 0) {
        // Lọc ra các file mới được chọn (có originFileObj)
        const newFiles = values.fileList
          .filter((file: any) => file.originFileObj)
          .map((file: any) => file.originFileObj);
        
        console.log("New files to upload:", newFiles);
        
        // Nếu có file mới được chọn
        if (newFiles.length > 0) {
          // Upload các file mới lên server
          const uploadedUrls = await uploadMultipleFiles(newFiles);
          console.log("Uploaded URLs response:", uploadedUrls);
          
          // Nếu upload thành công
          if (uploadedUrls && uploadedUrls.length > 0) {
            // Kết hợp đường dẫn ảnh cũ và mới, phân cách bằng dấu phẩy
            anhDaiDien = [...existingImages, ...uploadedUrls].join(',');
            console.log("Combined image URLs:", anhDaiDien);
          }
        } else {
          // Trường hợp không có file mới, chỉ sử dụng ảnh cũ
          anhDaiDien = existingImages.join(',');
        }
      }      
      console.log("Tên ảnh cuối cùng:", anhDaiDien);
      console.log("valuesupdate",values.trangThai)
      const response = await UpdateProduct({
        maSanPham: values.maSanPham,
        maChuyenMuc: values.maChuyenMuc,
        anhDaiDien: anhDaiDien,
        tenSanPham: values.tenSanPham,
        gia: values.gia,
        moTa: values.moTa,
        trangThai: values.trangThai
      });
      response && alert("Sửa thành công!");
      loadData();
      setOpenCapNhatGiaModel(false);
      updateForm.resetFields();
    } catch (error) {
      console.error("Error updating product:", error);
      alert("Đã xảy ra lỗi khi cập nhật sản phẩm");
    }
  };

  // Hàm lấy giá nhập cho một sản phẩm
  const fetchImportPrice = async (maSanPham: number) => {
    try {
      const response = await fetch(`https://localhost:44381/api/SanPham/getlichsugianhap/${maSanPham}`);
      const data = await response.json();
      if (data && data.length > 0) {
        const latestImport = data.reduce((latest: any, current: any) => {
          return new Date(current.ngayNhap) > new Date(latest.ngayNhap) ? current : latest;
        });
        setImportPrices(prev => ({
          ...prev,
          [maSanPham]: latestImport.giaNhap
        }));
      }
    } catch (error) {
      console.error("Error fetching import price:", error);
    }
  };

  // Cập nhật giá nhập khi data thay đổi
  useEffect(() => {
    if (data.length > 0) {
      data.forEach(product => {
        fetchImportPrice(product.maSanPham);
      });
    }
  }, [data]);

  useEffect(() => {
    loadData();
  }, []);
  useEffect(() => {
    loadDataCategory();
  }, []);
  

  const normFile = (e: any) => {
    if (Array.isArray(e)) {
      return e;
    }
    return e?.fileList;
  };

  const handleUploadChange = ({ fileList }: any) => {
    const imageUrls = fileList.map((file: any) => {
      if (file.originFileObj) {
        return file.name;
      }
      if (file.url) {
        return file.url.split('/').pop() || '';
      }
      return '';
    }).filter((url: string) => url);
    
    form.setFieldsValue({ 
      fileList,
      anhDaiDien: imageUrls.join(',')
    });
  };

  const handleViewPriceHistory = async (maSanPham: number, tenSanPham: string) => {
    try {
      const response = await fetch(`https://localhost:44381/api/SanPham/getlichsugianhap/${maSanPham}`);
      const data = await response.json();
      
      // Gom nhóm dữ liệu theo maHoaDon
      const groupedData = data.reduce((acc: any, curr: any) => {
        if (!acc[curr.maHoaDon]) {
          acc[curr.maHoaDon] = {
            maHoaDon: curr.maHoaDon,
            ngayNhap: curr.ngayNhap,
            chiTiet: []
          };
        }
        acc[curr.maHoaDon].chiTiet.push({
          maSize: curr.maSize,
          tenSize: curr.maSize === 1 ? 'S' : 
                  curr.maSize === 2 ? 'M' : 
                  curr.maSize === 3 ? 'L' : 
                  curr.maSize === 4 ? 'XL' : 
                  curr.maSize === 5 ? 'XXL' : 'Không xác định',
          soLuong: curr.soLuong,
          giaNhap: curr.giaNhap,
          tongTien: curr.tongTien,
          donViTinh: curr.donViTinh
        });
        return acc;
      }, {});

      // Chuyển đổi object thành array và sắp xếp theo ngày nhập mới nhất
      const sortedData = Object.values(groupedData).sort((a: any, b: any) => 
        new Date(b.ngayNhap).getTime() - new Date(a.ngayNhap).getTime()
      );

      setPriceHistory(sortedData);
      setSelectedProductName(tenSanPham);
      setOpenHistoryModal(true);
    } catch (error) {
      console.error("Error fetching price history:", error);
      message.error("Không thể lấy lịch sử giá nhập");
    }
  };

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
        }}
      >
        Thêm mới
      </Button>
    
      <Table 
        dataSource={data}
        loading={loading}
        size="small"
        rowKey="maSanPham"
        pagination={{
          defaultPageSize: 5,
          showSizeChanger: true,
          showQuickJumper: true,
          showTotal: (total) => `Tổng số ${total} sản phẩm`,
          pageSizeOptions: ['5', '10', '20', '50', '100'],
          locale: {
            items_per_page: 'sản phẩm/trang',
            jump_to: 'Đến trang',
            jump_to_confirm: 'Xác nhận',
            page: 'Trang',
            prev_page: 'Trang trước',
            next_page: 'Trang sau',
            prev_5: '5 trang trước',
            next_5: '5 trang sau',
            prev_3: '3 trang trước',
            next_3: '3 trang sau',
          }
          
        }}
        onRow={(record) => {
          const importPrice = importPrices[record.maSanPham];
          const sellingPrice = record.gia;
          const hasHighPrice = importPrice && sellingPrice && importPrice > sellingPrice;
          return {
            style: hasHighPrice ? { backgroundColor: '#ffcccc' } : {}
          };
        }}
      >
        <Column title="STT" dataIndex="index" key="index" />
        <Column 
          title="Chuyên mục" 
          dataIndex="maChuyenMuc" 
          key="maChuyenMuc"
          render={(maChuyenMuc: number) => {
            const category = categories.find(cat => cat.maChuyenMuc === maChuyenMuc);
            return category ? category.tenChuyenMuc : maChuyenMuc;
          }}
          filters={categories.map(cat => ({
            text: cat.tenChuyenMuc,
            value: cat.maChuyenMuc
          }))}
          onFilter={(value, record) => (record as any).maChuyenMuc === value}
        />
        <Column
          title="Ảnh"
          dataIndex="anhDaiDien"
          key="anhDaiDien"
          render={(anhDaiDien: string | null | undefined) => {
            if (!anhDaiDien) {
              return <div style={{ display: 'flex', gap: '8px' }}>Không có ảnh</div>;
            }
            try {
              const imageList = anhDaiDien.split(',');
              return (
                <div style={{ display: 'flex', gap: '8px' }}>
                  {imageList.map((image, index) => (
                    <img
                      key={index}
                      src={"../assets/anh/" + image.trim()}
                      alt={`Ảnh ${index + 1}`}
                      style={{ width: 30, height: "auto" }}
                    />
                  ))}
                </div>
              );
            } catch (error) {
              console.error('Error rendering images:', error);
              return <div style={{ display: 'flex', gap: '8px' }}>Lỗi hiển thị ảnh</div>;
            }
          }}
        />
        <Column 
          title="Tên sản phẩm" 
          dataIndex="tenSanPham" 
          key="tenSanPham"
          sorter={(a: any, b: any) => a.tenSanPham.localeCompare(b.tenSanPham)}
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
            record.tenSanPham.toLowerCase().includes((value as string).toLowerCase())
          }
        />
        <Column
          title="Giá nhập gần nhất"
          dataIndex="maSanPham"
          key="giaNhap"
          render={(maSanPham: number, record: any) => {
            const importPrice = importPrices[maSanPham];
            return (
              <Space>
                {importPrice ? (
                  <span>
                    {importPrice.toLocaleString("vi-VN", {
                      style: "currency",
                      currency: "VND",
                    })}
                  </span>
                ) : (
                  <span style={{ color: 'red' }}>Chưa nhập</span>
                )}
                <Button 
                  type="link" 
                  icon={<HistoryOutlined />} 
                  onClick={() => handleViewPriceHistory(maSanPham, record.tenSanPham)}
                  title="Xem lịch sử giá nhập"
                />
              </Space>
            );
          }}
        />
      


        <Column
          title="Giá bán"
          dataIndex="gia"
          key="gia"
          sorter={(a: any, b: any) => a.gia - b.gia}
          render={(gia: number | null) => (
            <span style={{ color: gia == 0 ? 'red' : undefined }}>
              {gia != 0
                ? gia?.toLocaleString("vi-VN", {
                    style: "currency",
                    currency: "VND",
                  })
                : 'Chưa đặt giá bán'}
            </span>
          )}
        />
         <Column
          title="Trạng thái" 
          dataIndex="trangThai" 
          key="trangThai"
          render={(value) => (
            <Tag color={value ? "green" : "red"}>
              {value ? "Hoạt động" : "Không hoạt động"}
            </Tag>
          )}
          filters={[
            { text: 'Hoạt động', value: true },
            { text: 'Không hoạt động', value: false },
          ]}
          onFilter={(value, record: any) => record.trangThai === value}
        />
        <Column
          title="Action"
          key="action"
          render={(_: any, record: any) => (
            <Space size="middle">
                <a onClick={() => onEdit(record)} title="Sửa">
                  <EditOutlined style={{ color: '#1890ff', fontSize: '16px' }} />
                </a>
                {/* <a onClick={() => oncapnhatgia(record)} title="Cài đặt">
                  <SettingOutlined style={{ color: '#8c8c8c', fontSize: '16px' }} />
                </a> */}
                <a onClick={() => handleDeleteProduct(record)} title="Xóa">
                  <DeleteOutlined style={{ color: 'red', fontSize: '16px' }} />
                </a>
              </Space>
          )}
        />
      </Table>

      <Modal
        title={isAdd ? "Thêm sản phẩm" : "Sửa sản phẩm"}
        open={openModal}
        okText="Lưu"
        onCancel={() => {
          form.resetFields();
          setOpenModal(false);
        }}
        onOk={() => {
          form.validateFields()
            .then((values) => {
              onFinish(values);
            })
            .catch((errorInfo) => {
              console.log('Validation failed:', errorInfo);
            });
        }}
        cancelText="Hủy"
        width={700}
        style={{ top: 20 }}
      >
        <Form
          form={form}
          name="nest-messages"
          onFinish={(values) => {
            onFinish(values);
          }}
          style={{ maxWidth: 700 }}
          layout="vertical"
        >
          <Row gutter={16}>
            <Col span={12}>
              {/* <Form.Item
                name={"maSanPham"}
                initialValue={0}
                hidden={isAdd}
                label="Mã sản phẩm"
              >
                <Input disabled />
              </Form.Item> */}
              <Form.Item 
                name={"tenSanPham"} 
                label="Tên sản phẩm"
                rules={[{ required: true, message: 'Vui lòng nhập tên sản phẩm!' }]}
              >
                <Input />
              </Form.Item>
            </Col>
            <Col span={12}>
            <Form.Item 
                label="Chuyên mục" 
                name="maChuyenMuc"
                rules={[{ required: true, message: 'Vui lòng chọn chuyên mục!' }]}
              >
                <Select>
                  {categories.map((category) => (
                    <Select.Option
                      key={category.maChuyenMuc}
                      value={category.maChuyenMuc}
                    >
                      {category.tenChuyenMuc}
                    </Select.Option>
                  ))}
                </Select>
              </Form.Item>
            </Col>
          </Row>

          <Row gutter={16}>
            <Col span={12}>
              
              <Form.Item 
                name={"gia"} 
                label="Giá"
                rules={[
                  { required: true, message: 'Vui lòng nhập giá sản phẩm!' },
                  { 
                    validator: (_, value) => {
                      if (isNaN(value) || value < 0) {
                        return Promise.reject('Giá phải là số và lớn hơn 0!');
                      }
                      return Promise.resolve();
                    }
                  }
                ]}
              >
                <Input type="number" min={0} />
              </Form.Item>
            </Col>
            <Col span={12}>
            </Col>
          </Row>
          
          <Form.Item 
            label="Mô tả" 
            name="moTa"
            rules={[{ required: true, message: 'Vui lòng nhập mô tả sản phẩm!' }]}
          >
            <ReactQuill 
              theme="snow"
              style={{ height: '150px', marginBottom: '30px' }}
              modules={{
                toolbar: [
                  [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
                  ['bold', 'italic', 'underline', 'strike'],
                  [{ 'list': 'ordered'}, { 'list': 'bullet' }],
                  [{ 'color': [] }, { 'background': [] }],
                  ['link', 'image'],
                  ['clean']
                ],
              }}
              onChange={(content) => {
                form.setFieldsValue({ moTa: content });
              }}
            />
          </Form.Item>

          <Form.Item 
            label="Ảnh" 
            name="fileList"
            valuePropName="fileList"
            getValueFromEvent={normFile}
            rules={[{ required: true, message: 'Vui lòng chọn ít nhất một ảnh!' }]}
          >
            <Upload
              listType="picture-card"
              multiple={true}
              maxCount={5}
              beforeUpload={() => false}
              accept="image/*"
              onChange={handleUploadChange}
              customRequest={({ onSuccess }) => {
                setTimeout(() => {
                  onSuccess?.("ok");
                }, 0);
              }}
              showUploadList={{
                showPreviewIcon: true,
                showRemoveIcon: true,
                showDownloadIcon: false
              }}
            >
              {form.getFieldValue('fileList')?.length >= 5 ? null : (
                <div>
                  <PlusOutlined />
                  <div style={{ marginTop: 8 }}>Thêm ảnh</div>
                </div>
              )}
            </Upload>
          </Form.Item>
        </Form>
      </Modal>

      <Modal
        title="Cập nhật sản phẩm"
        open={openUpdateModal}
        okText="Lưu"
        onCancel={() => {
          updateForm.resetFields();
          setOpenUpdateModal(false);
        }}
        onOk={() => {
          updateForm.validateFields().then((values) => {
            handleUpdate(values);
          });
        }}
        cancelText="Hủy"
        width={700}
      >
        <Form
          form={updateForm}
          name="update-form"
          onFinish={(values) => {
            handleUpdate(values);
            return false;
          }}
          style={{ maxWidth: 900 }}
        >
          <Row gutter={24}>
            <Col span={12}>
              <Form.Item
                name="maSanPham"
                label="Mã sản phẩm"
              >
                <Input disabled />
              </Form.Item>
            </Col>
            <Col span={12}>
              <Form.Item label="Chuyên mục" name="maChuyenMuc">
                <Select>
                  {categories.map((category) => (
                    <Select.Option
                      key={category.maChuyenMuc}
                      value={category.maChuyenMuc}
                    >
                      {category.tenChuyenMuc}
                    </Select.Option>
                  ))}
                </Select>
              </Form.Item>
            </Col>
          </Row>

          <Row gutter={24}>
            <Col span={15}>
              <Form.Item name="tenSanPham" label="Tên sản phẩm">
                <Input />
              </Form.Item>
            </Col>
            <Col span={9}>
              <Form.Item name="gia" label="Giá bán">
                <Input 
                  type="text"
                
                  placeholder="Nhập giá bán"
                />
              </Form.Item>
            </Col>
          </Row>

          <Form.Item name="moTa" label="Mô tả">
            <ReactQuill 
              theme="snow"
              style={{ height: '200px', marginBottom: '50px' }}
              modules={{
                toolbar: [
                  [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
                  ['bold', 'italic', 'underline', 'strike'],
                  [{ 'list': 'ordered'}, { 'list': 'bullet' }],
                  [{ 'color': [] }, { 'background': [] }],
                  ['link', 'image'],
                  ['clean']
                ],
              }}
              value={updateForm.getFieldValue('moTa')}
              onChange={(content) => {
                updateForm.setFieldsValue({ moTa: content });
              }}
            />
          </Form.Item>

          <Row gutter={16}>
            <Col span={6}>
              <Form.Item name="trangThai" label="Trạng thái" valuePropName="checked">
                <Switch defaultChecked={false} />
              </Form.Item>
            </Col>
            <Col span={18}>
              <Form.Item 
                label="Ảnh" 
                name="fileList"
                valuePropName="fileList"
                getValueFromEvent={normFile}
              >
                <Upload
                  listType="picture-card"
                  multiple={true}
                  maxCount={5}
                  style={{ width: '100%' }}
                  className="custom-upload"
                  showUploadList={{
                    showPreviewIcon: true,
                    showRemoveIcon: true,
                    showDownloadIcon: false
                  }}
                  beforeUpload={(file) => {
                    const isImage = file.type.startsWith('image/');
                    if (!isImage) {
                      message.error('Bạn chỉ có thể tải lên file ảnh!');
                    }
                    return false;
                  }}
                  onChange={({ fileList }) => {
                    const imageUrls = fileList.map(file => {
                      if (file.originFileObj) {
                        return file.name;
                      }
                      if (file.url) {
                        return file.url.split('/').pop() || '';
                      }
                      return '';
                    }).filter(url => url);
                    
                    updateForm.setFieldsValue({ 
                      fileList,
                      anhDaiDien: imageUrls.join(',')
                    });
                  }}
                >
                  {updateForm.getFieldValue('fileList')?.length >= 5 ? null : (
                    <div style={{ padding: '8px' }}>
                      <PlusOutlined style={{ fontSize: '16px' }} />
                      <div style={{ marginTop: 4, fontSize: '12px' }}>Thêm ảnh</div>
                    </div>
                  )}
                </Upload>
              </Form.Item>
            </Col>
          </Row>
        </Form>
      </Modal>

      <Modal
        title="Đặt giá bán cho sản phẩm"
        open={OpenCapNhatGiaModel}
        okText="Lưu"
        onCancel={() => {
          CapnhatGiaForm.resetFields();
          setOpenCapNhatGiaModel(false);
        }}
        onOk={() => {
          CapnhatGiaForm.validateFields().then((values) => {
            CapNhatGiaLuu(values);
          });
        }}
        cancelText="Hủy"
      >
        <Form
          form={CapnhatGiaForm}
          name="update-form"
          onFinish={(values) => {
            CapNhatGiaLuu(values);
            return false;
          }}
          style={{ maxWidth: 600 }}
        >
        
        
          <Form.Item
            name="maSanPham"
            label="Mã sản phẩm" 
          >
            <Input disabled />
          </Form.Item>
          <Form.Item label="Chuyên mục" name="maChuyenMuc" hidden>
            <Select>
              {categories.map((category) => (
                <Select.Option
                  key={category.maChuyenMuc}
                  value={category.maChuyenMuc}
                >
                  {category.tenChuyenMuc}
                </Select.Option>
              ))}
            </Select>
          </Form.Item>
          <Form.Item name="tenSanPham" label="Tên sản phẩm" hidden>
            <Input />
          </Form.Item>
          <Form.Item name="gia" label="Giá">
            <Input />
          </Form.Item>
          <Form.Item name="moTa" label="Mô tả" hidden>
            <ReactQuill 
              theme="snow"
              style={{ height: '200px', marginBottom: '50px' }}
              modules={{
                toolbar: [
                  [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
                  ['bold', 'italic', 'underline', 'strike'],
                  [{ 'list': 'ordered'}, { 'list': 'bullet' }],
                  [{ 'color': [] }, { 'background': [] }],
                  ['link', 'image'],
                  ['clean']
                ],
              }}
              onChange={(content) => {
                CapnhatGiaForm.setFieldsValue({ moTa: content });
              }}
            />
          </Form.Item>
          <Form.Item name="trangThai" label="Trạng thái">
            <Select>
              <Select.Option value={true}>Hoạt động</Select.Option>
              <Select.Option value={false}>Không hoạt động</Select.Option>
            </Select>
          </Form.Item>
          <Form.Item 
            label="Ảnh sản phẩm" 
            name="fileList"
            valuePropName="fileList"
            getValueFromEvent={normFile}
            hidden
          >
            <Upload
              listType="picture-card"
              multiple={true}
              maxCount={5}
              showUploadList={{
                showPreviewIcon: true,
                showRemoveIcon: true,
                showDownloadIcon: false
              }}
              beforeUpload={(file) => {
                const isImage = file.type.startsWith('image/');
                if (!isImage) {
                  message.error('Bạn chỉ có thể tải lên file ảnh!');
                }
                return false;
              }}
              onChange={({ fileList }) => {
                // Convert fileList to string format with comma separator
                const imageUrls = fileList.map(file => {
                  if (file.originFileObj) {
                    return file.name;
                  }
                  // Keep existing image path if it's an old image
                  if (file.url) {
                    return file.url.split('/').pop() || '';
                  }
                  return '';
                }).filter(url => url);
                
                updateForm.setFieldsValue({ 
                  fileList,
                  anhDaiDien: imageUrls.join(',')
                });
              }}
            >
              {updateForm.getFieldValue('fileList')?.length >= 5 ? null : (
                <div>
                  <PlusOutlined />
                  <div style={{ marginTop: 8 }}>Thêm ảnh</div>
                </div>
              )}
            </Upload>
          </Form.Item>
         
        </Form>
      </Modal>

      <Modal
        title={`Lịch sử giá nhập - ${selectedProductName}`}
        open={openHistoryModal}
        onCancel={() => setOpenHistoryModal(false)}
        footer={null}
        width={800}
        style={{ maxHeight: '80vh' }}
        bodyStyle={{ 
          maxHeight: 'calc(80vh - 110px)', 
          overflowY: 'auto',
          padding: '24px'
        }}
      >
        {priceHistory.map((invoice: any) => (
          <div key={invoice.maHoaDon} style={{ marginBottom: '20px' }}>
            <div style={{ 
              backgroundColor: '#f5f5f5', 
              padding: '8px 16px',
              marginBottom: '8px',
              borderRadius: '4px',
              display: 'flex',
              justifyContent: 'space-between',
              alignItems: 'center'
            }}>
              <div>
                <strong>Hóa đơn #{invoice.maHoaDon}</strong>
              </div>
              <div>
                Ngày nhập: {new Date(invoice.ngayNhap).toLocaleDateString('vi-VN')}
              </div>
            </div>
            <Table
              dataSource={invoice.chiTiet}
              rowKey="maSize"
              pagination={false}
              size="small"
            >
              <Column
                title="Size"
                dataIndex="tenSize"
                key="tenSize"
                width="15%"
              />
              <Column
                title="Số lượng"
                dataIndex="soLuong"
                key="soLuong"
                width="15%"
                render={(soLuong: number, record: { donViTinh: string }) => `${soLuong} ${record.donViTinh}`}
              />
              <Column
                title="Giá nhập"
                dataIndex="giaNhap"
                key="giaNhap"
                width="35%"
                render={(price: number) => (
                  <span>
                    {price.toLocaleString("vi-VN", {
                      style: "currency",
                      currency: "VND",
                    })}
                  </span>
                )}
              />
              <Column
                title="Tổng tiền"
                dataIndex="tongTien"
                key="tongTien"
                width="35%"
                render={(price: number) => (
                  <span>
                    {price.toLocaleString("vi-VN", {
                      style: "currency",
                      currency: "VND",
                    })}
                  </span>
                )}
              />
            </Table>
          </div>
        ))}
      </Modal>
    </>
  );
};

export default AdminProduct;
