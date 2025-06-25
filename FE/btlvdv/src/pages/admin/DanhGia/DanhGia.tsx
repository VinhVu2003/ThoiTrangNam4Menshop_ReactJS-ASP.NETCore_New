import React, { useState, useEffect } from 'react';
import { Table, Switch, Select, Space, Card, Typography, Rate, message, Button, Modal, Row, Col, Statistic, Badge } from 'antd';
import type { ColumnsType } from 'antd/es/table';
import axios from 'axios';
import { GetAllProducts } from '../../../services/product.services';

const { Title } = Typography;

interface Product {
  maSanPham: number;
  tenSanPham: string;
  gia: number;
  trangThai: boolean;
  anhDaiDien: string;
}

interface Review {
  id: number;
  sanPhamId: number;
  khachHangId: number | null;
  noiDung: string;
  soSao: number;
  thoiGianTao: string;
  trangThai: boolean;
  tenKhachHang: string;
}

const DanhGia: React.FC = () => {
  const [selectedProduct, setSelectedProduct] = useState<number | null>(null);
  const [selectedRating, setSelectedRating] = useState<number | null>(null);
  const [reviews, setReviews] = useState<Review[]>([]);
  const [products, setProducts] = useState<Product[]>([]);
  const [loading, setLoading] = useState(false);
  const [selectedReview, setSelectedReview] = useState<Review | null>(null);
  const [isModalVisible, setIsModalVisible] = useState(false);

  // Fetch reviews
  const fetchReviews = async () => {
    try {
      setLoading(true);
      const response = await axios.get('https://localhost:44381/api/DanhGiaSanPham/get-all');
      console.log('Reviews data:', response.data);
      setReviews(response.data);
    } catch (error) {
      console.error('Error fetching reviews:', error);
    } finally {
      setLoading(false);
    }
  };

  // Fetch products
  const fetchProducts = async () => {
    try {
      const response = await GetAllProducts();
      setProducts(response);
    } catch (error) {
      console.error('Error fetching products:', error);
    }
  };

  // Update review status
  const handleStatusChange = async (id: number, status: boolean) => {
    try {
      const reviewToUpdate = reviews.find(review => review.id === id);
      if (reviewToUpdate) {
        await axios.put(`https://localhost:44381/api/DanhGiaSanPham/update`, {
          id: reviewToUpdate.id,
          sanPhamId: reviewToUpdate.sanPhamId,
          khachHangId: reviewToUpdate.khachHangId,
          noiDung: reviewToUpdate.noiDung,
          soSao: reviewToUpdate.soSao,
          thoiGianTao: reviewToUpdate.thoiGianTao,
          trangThai: status,
          tenKhachHang: reviewToUpdate?.tenKhachHang || "Ẩn danh"
        });
      }
      fetchReviews(); // Refresh reviews after update
      message.success('Cập nhật trạng thái đánh giá thành công!');
    } catch (error) {
      console.error('Error updating review status:', error);
    }
  };

  const showReviewDetail = (review: Review) => {
    setSelectedReview(review);
    setIsModalVisible(true);
  };

  useEffect(() => {
    fetchReviews();
    fetchProducts();
  }, []);

  // Filter reviews based on selected product and rating
  const filteredReviews = reviews.filter(review => {
    const matchProduct = selectedProduct ? review.sanPhamId === selectedProduct : true;
    const matchRating = selectedRating ? review.soSao === selectedRating : true;
    return matchProduct && matchRating;
  });

  // Calculate statistics based on filtered reviews
  const totalReviews = filteredReviews.length;
  const badReviews = filteredReviews.filter(review => review.soSao <= 2).length;
  const averageRating = filteredReviews.reduce((acc, review) => acc + review.soSao, 0) / totalReviews || 0;

  const columns: ColumnsType<Review> = [
    {
      title: 'ID',
      dataIndex: 'id',
      key: 'id',
      width: 60,
    },
    {
      title: 'Sản phẩm',
      dataIndex: 'sanPhamId',
      key: 'sanPhamId',
      width: 150,
      render: (sanPhamId: number) => {
        const product = products.find(p => p.maSanPham === sanPhamId);
        return product ? product.tenSanPham.substring(0, 30) + '...' : sanPhamId;
      }
    },
    {
      title: 'Đánh giá',
      dataIndex: 'soSao',
      key: 'soSao',
      width: 100,
      render: (soSao: number) => (
        <div style={{ whiteSpace: 'nowrap' }}>
          <span style={{ color: '#FFD700' }}>{'★'.repeat(soSao)}</span>
          <span style={{ color: '#D3D3D3' }}>{'☆'.repeat(5 - soSao)}</span>
        </div>
      ),
    },
    {
      title: 'Bình luận',
      dataIndex: 'noiDung',
      key: 'noiDung',
      ellipsis: true,
      render: (noiDung: string, record: Review) => (
        <Space>
          <span>{noiDung.substring(0, 50)}...</span>
          <Button type="link" onClick={() => showReviewDetail(record)}>
            Xem chi tiết
          </Button>
        </Space>
      ),
    },
    {
      title: 'Ngày tạo',
      dataIndex: 'thoiGianTao',
      key: 'thoiGianTao',
      width: 120,
      render: (date: string) => new Date(date).toLocaleDateString('vi-VN'),
    },
    {
      title: 'Trạng thái',
      dataIndex: 'trangThai',
      key: 'trangThai',
      width: 100,
      render: (trangThai: boolean, record: Review) => {
        console.log('Render status for review:', record.id, 'trangThai:', trangThai);
        return (
          <Space>
            <Switch
              checked={trangThai}
              onChange={(checked) => handleStatusChange(record.id, checked)}
            />
          </Space>
        );
      },
      filters: [
        { text: 'Hiển thị', value: true },
        { text: 'Ẩn', value: false },
      ],
      onFilter: (value, record) => record.trangThai === value,
    },
  ];

  return (
    <Card>
      <Space direction="vertical" size="large" style={{ width: '100%' }}>
        <Row gutter={16}>
          <Col span={8}>
            <Card>
              <Statistic
                title="Tổng số đánh giá"
                value={totalReviews}
                suffix="đánh giá"
              />
            </Card>
          </Col>
          <Col span={8}>
            <Card>
              <Statistic
                title="Đánh giá xấu"
                value={badReviews}
                suffix="đánh giá"
                valueStyle={{ color: '#cf1322' }}
              />
            </Card>
          </Col>
          <Col span={8}>
            <Card>
              <Statistic
                title="Đánh giá trung bình"
                value={averageRating.toFixed(1)}
                suffix={
                  <div style={{ fontSize: '14px', display: 'inline-block', marginLeft: '8px' }}>
                    <Rate disabled defaultValue={Math.round(averageRating)} />
                  </div>
                }
              />
            </Card>
          </Col>
        </Row>
        
        <Space>
          <Select
            style={{ width: 300 }}
            placeholder="Lọc theo sản phẩm"
            allowClear
            onChange={(value) => {
              setSelectedProduct(value);
              setSelectedRating(null); // Reset rating filter when product changes
            }}
            options={products.map((product: Product) => ({
              label: product.tenSanPham,
              value: product.maSanPham,
            }))}
          />
          <Select
            style={{ width: 200 }}
            placeholder="Lọc theo số sao"
            allowClear
            onChange={(value) => setSelectedRating(value)}
            options={[
              { label: '5 sao', value: 5 },
              { label: '4 sao', value: 4 },
              { label: '3 sao', value: 3 },
              { label: '2 sao', value: 2 },
              { label: '1 sao', value: 1 },
            ]}
          />
        </Space>

        <Table
          columns={columns}
          dataSource={filteredReviews}
          loading={loading}
          rowKey="id"
          size="small"
          onRow={(record) => ({
            style: {
              backgroundColor: record.soSao === 1 ? '#ffccc7' : 'inherit'
            }
          })}
          pagination={{
            pageSize: 10,
            showSizeChanger: true,
            showTotal: (total) => `Tổng số ${total} đánh giá`,
          }}
        />

        <Modal
          title="Chi tiết đánh giá"
          open={isModalVisible}
          onCancel={() => setIsModalVisible(false)}
          footer={null}
          width={600}
        >
          {selectedReview && (
            <Space direction="vertical" size="large" style={{ width: '100%' }}>
              <div>
                <strong>Sản phẩm:</strong>{' '}
                {products.find(p => p.maSanPham === selectedReview.sanPhamId)?.tenSanPham}
              </div>
              <div>
                <strong>Đánh giá:</strong>{' '}
                <div style={{ fontSize: '14px', display: 'inline-block' }}>
                  <Rate disabled defaultValue={selectedReview.soSao} />
                </div>
              </div>
              <div>
                <strong>Nội dung:</strong>
                <p style={{ marginTop: 8 }}>{selectedReview.noiDung}</p>
              </div>
              {selectedReview.tenKhachHang && (
                <div>
                  <strong>Tên khách hàng:</strong>
                  <img 
                    src={selectedReview.tenKhachHang} 
                    alt="Review" 
                    style={{ maxWidth: '100%', marginTop: 8 }} 
                  />
                </div>
              )}
              <div>
                <strong>Thời gian:</strong>{' '}
                {new Date(selectedReview.thoiGianTao).toLocaleString('vi-VN')}
              </div>
            </Space>
          )}
        </Modal>
      </Space>
    </Card>
  );
};

export default DanhGia;
