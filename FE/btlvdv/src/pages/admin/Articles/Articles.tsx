import React, { useState, useEffect } from 'react';
import {
  Table,
  Button,
  Modal,
  Form,
  Input,
  Space,
  Popconfirm,
  message,
  Typography,
} from 'antd';
import { PlusOutlined, EditOutlined, DeleteOutlined } from '@ant-design/icons';
import dayjs from 'dayjs';
import ReactQuill from 'react-quill';
import 'react-quill/dist/quill.snow.css';
import { createArticle, deleteArticle, getAllArticles } from '../../../services/Articles';

const { Title } = Typography;

interface Article {
  baiVietID: number;
  tieuDe: string;
  noiDung: string;
  ngayTao: string;
  taiKhoanID: number;
}

const Articles: React.FC = () => {
  const [articles, setArticles] = useState<Article[]>([]);
  const [isModalVisible, setIsModalVisible] = useState(false);
  const [form] = Form.useForm();
  const [editingId, setEditingId] = useState<number | null>(null);
  const [editorContent, setEditorContent] = useState('');

  // Fetch articles on component mount
  useEffect(() => {
    fetchArticles();
  }, []);

  const fetchArticles = async () => {
    try {
      const response = await getAllArticles();
      setArticles(response);
    } catch (error) {
      message.error('Không thể tải danh sách bài viết');
    }
  };

  const handleAdd = () => {
    setEditingId(null);
    form.resetFields();
    setEditorContent('');
    setIsModalVisible(true);
  };

  const handleEdit = (record: Article) => {
    setEditingId(record.baiVietID);
    form.setFieldsValue({
      tieuDe: record.tieuDe,
    });
    setEditorContent(record.noiDung);
    setIsModalVisible(true);
  };

  const handleDelete = async (id: number) => {
    try {
      await deleteArticle(id);
      message.success('Xóa bài viết thành công');
      fetchArticles();
    } catch (error) {
      message.error('Không thể xóa bài viết');
    }
  };

  const handleModalOk = async () => {
    try {
      const values = await form.validateFields();
      const articleData = {
        baiVietID: editingId || 0,
        tieuDe: values.tieuDe,
        noiDung: editorContent,
        ngayTao: new Date().toISOString(),
        taiKhoanID: 1,
      };

      if (editingId === null) {
        await createArticle(articleData);
        message.success('Thêm bài viết thành công');
      } else {
        await fetch(`/api/articles/${editingId}`, {
          method: 'PUT',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify(articleData),
        });
        message.success('Cập nhật bài viết thành công');
      }
      setIsModalVisible(false);
      fetchArticles();
    } catch (error) {
      message.error('Không thể lưu bài viết');
    }
  };

  const columns = [
    {
      title: 'Tiêu đề',
      dataIndex: 'tieuDe',
      key: 'tieuDe',
    },
    {
      title: 'Nội dung',
      dataIndex: 'noiDung',
      key: 'noiDung',
      ellipsis: true,
    },
    {
      title: 'Ngày tạo',
      dataIndex: 'ngayTao',
      key: 'ngayTao',
      render: (date: string) => dayjs(date).format('DD/MM/YYYY HH:mm'),
    },
    {
      title: 'Thao tác',
      key: 'actions',
      render: (_: any, record: Article) => (
        <Space>
          <Button
            type="primary"
            icon={<EditOutlined />}
            onClick={() => handleEdit(record)}
          >
          </Button>
          <Popconfirm
            title="Bạn có chắc chắn muốn xóa bài viết này?"
            onConfirm={() => handleDelete(record.baiVietID)}
            okText="Có"
            cancelText="Không"
          >
            <Button type="primary" danger icon={<DeleteOutlined />}>
            </Button>
          </Popconfirm>
        </Space>
      ),
    },
  ];

  return (
    <div style={{ padding: '24px' }}>
      <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '16px' }}>
        <Title level={2}>Quản lý bài viết</Title>
        <Button
          type="primary"
          icon={<PlusOutlined />}
          onClick={handleAdd}
        >
          Thêm bài viết mới
        </Button>
      </div>

      <Table
        columns={columns}
        dataSource={articles}
        rowKey="baiVietID"
        pagination={{ 
          pageSize: 10,
          showSizeChanger: true,
          showTotal: (total) => `Tổng số ${total} bài viết`,
          pageSizeOptions: ['10', '20', '50'],
          locale: {
            items_per_page: 'bài viết/trang',
          }
        }}
      />

      <Modal
        title={editingId === null ? 'Thêm bài viết mới' : 'Sửa bài viết'}
        open={isModalVisible}
        onOk={handleModalOk}
        onCancel={() => setIsModalVisible(false)}
        width={800}
        okText="Lưu"
        cancelText="Hủy"
      >
        <Form
          form={form}
          layout="vertical"
        >
          <Form.Item
            name="tieuDe"
            label="Tiêu đề"
            rules={[{ required: true, message: 'Vui lòng nhập tiêu đề!' }]}
          >
            <Input placeholder="Nhập tiêu đề bài viết" />
          </Form.Item>
          <Form.Item
            label="Nội dung"
            required
            tooltip="Đây là trường bắt buộc"
          >
            <div style={{ border: '1px solid #d9d9d9', borderRadius: '2px' }}>
              <ReactQuill
                value={editorContent}
                onChange={setEditorContent}
                modules={{
                  toolbar: [
                    [{ 'header': [1, 2, 3, false] }],
                    ['bold', 'italic', 'underline'],
                    [{ 'list': 'ordered'}, { 'list': 'bullet' }],
                    ['link', 'image'],
                    ['clean']
                  ]
                }}
                placeholder="Nhập nội dung bài viết..."
              />
            </div>
          </Form.Item>
        </Form>
      </Modal>
    </div>
  );
};

export default Articles;
