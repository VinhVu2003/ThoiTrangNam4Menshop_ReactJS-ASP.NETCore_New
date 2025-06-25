import React, { useEffect, useState } from 'react';
import { Space, Table, Tag, Button, Modal, Form, Input, message } from 'antd';
import axios from 'axios';
import { PlusOutlined, EditOutlined, DeleteOutlined } from '@ant-design/icons';

const { Column, ColumnGroup } = Table;

const AdminSize: React.FC = () => {
  const [data, setData] = useState<any[]>([]);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [form] = Form.useForm();
  const [editingSize, setEditingSize] = useState<any>(null);

  useEffect(() => {
    loadData();
  }, []);

  const loadData = async () => {
    try {
      const response = await axios.post(
        "https://localhost:44381/api/SizeCotroller/Size_Search",
        {
          page: "1",
          pageSize: "20",
        }
      );
      const modifiedData = response.data.data.map((item:any, index:any) => ({
          ...item,
          key: item.maSize,
          index: index + 1
        }));
      setData(modifiedData);
    } catch (error) {
      console.error("Error fetching data:", error);
      message.error("Lỗi khi tải dữ liệu!");
    }
  };

  const showModal = (size?: any) => {
    if (size) {
      setEditingSize(size);
      form.setFieldsValue(size);
    } else {
      setEditingSize(null);
      form.resetFields();
    }
    setIsModalOpen(true);
  };

  const handleCancel = () => {
    setIsModalOpen(false);
    form.resetFields();
    setEditingSize(null);
  };

  const handleSubmit = async () => {
    try {
      const values = await form.validateFields();
      if (editingSize) {
        // Update
        await axios.put("https://localhost:44381/api/SizeCotroller/update", {
          maSize: editingSize.maSize,
          tenSize: values.tenSize,
          ghichu: values.ghichu || ""
        });
        message.success("Cập nhật size thành công!");
      } else {
        // Insert
        await axios.post("https://localhost:44381/api/SizeCotroller/insert", {
          tenSize: values.tenSize,
          ghichu: values.ghichu || ""
        });
        message.success("Thêm size mới thành công!");
      }
      handleCancel();
      loadData();
    } catch (error: any) {
      console.error("Error submitting form:", error);
      message.error(error.response?.data?.message || "Có lỗi xảy ra!");
    }
  };

  const handleDelete = async (maSize: number) => {
    try {
      await axios.delete(`https://localhost:44381/api/SizeCotroller/delete/${maSize}`);
      message.success("Xóa size thành công!");
      loadData();
    } catch (error: any) {
      console.error("Error deleting size:", error);
      message.error(error.response?.data?.message || "Có lỗi xảy ra khi xóa!");
    }
  };

  return (
    <>
      <Button 
        type="primary" 
        icon={<PlusOutlined />} 
        onClick={() => showModal()}
        style={{ marginBottom: 16 }}
      >
        Thêm Size
      </Button>
      

      <Table dataSource={data} rowKey="maSize">
        <Column title="STT" dataIndex="index" key="index" />
        <Column title="Tên Size" dataIndex="tenSize" key="tenSize" />
        <Column title="Ghi chú" dataIndex="ghichu" key="ghichu" />
        <Column
          title="Action"
          key="action"
          render={(_: any, record: any) => (
            <Space size="middle">
              <Button 
                type="primary" 
                icon={<EditOutlined />}
                onClick={() => showModal(record)}
              />
              <Button 
                danger 
                icon={<DeleteOutlined />}
                onClick={() => {
                  Modal.confirm({
                    title: 'Xác nhận xóa',
                    content: 'Bạn có chắc chắn muốn xóa size này?',
                    onOk: () => handleDelete(record.maSize)
                  });
                }}
              />
            </Space>
          )}
        />
      </Table>

      <Modal
        title={editingSize ? "Sửa Size" : "Thêm Size Mới"}
        open={isModalOpen}
        onOk={handleSubmit}
        onCancel={handleCancel}
        okText={editingSize ? "Cập nhật" : "Thêm mới"}
        cancelText="Hủy"
      >
        <Form
          form={form}
          layout="vertical"
        >
          <Form.Item
            name="tenSize"
            label="Tên Size"
            rules={[{ required: true, message: 'Vui lòng nhập tên size!' }]}
          >
            <Input placeholder="Nhập tên size" />
          </Form.Item>
          <Form.Item
            name="ghichu"
            label="Ghi chú"
          >
            <Input.TextArea placeholder="Nhập ghi chú" />
          </Form.Item>
        </Form>
      </Modal>
    </>
  );
};

export default AdminSize;
