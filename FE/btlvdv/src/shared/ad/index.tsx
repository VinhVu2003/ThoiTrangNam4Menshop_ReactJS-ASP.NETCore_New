import React, { useEffect, useState } from "react";
import { Link, Navigate, useLocation, useNavigate } from "react-router-dom";
import {
  MenuFoldOutlined,
  MenuUnfoldOutlined,
  OrderedListOutlined,
  UserOutlined,
  HomeOutlined,
  SkinOutlined,
  TruckOutlined,
  FileDoneOutlined,
  VideoCameraOutlined,
  TeamOutlined,
  ShopOutlined,
  AppstoreOutlined,
  ShoppingOutlined,
  TagsOutlined,
  BarChartOutlined,
  InboxOutlined,
  GiftOutlined,
  FileTextOutlined,
  StarOutlined
} from "@ant-design/icons";
import { Layout, Menu, Button, theme } from "antd";
import { useRecoilState } from "recoil";
import { thongtinTK } from "../../constant/recoil";
const { Header, Sider, Content } = Layout;

interface MenuItem {
  key: string;
  icon?: JSX.Element;
  label: React.ReactNode;
  title: string;
  link: string;
  children?: MenuItem[];
}

interface Props {
  children?: React.ReactNode;
}

const Admin = function ({ children }: Props) {
  const [tentaikhoan, settentk] = useRecoilState(thongtinTK)
  const [ten,setTen] = useState<string>("")
  const [collapsed, setCollapsed] = useState(false);
  const location = useLocation();
  const dx = useNavigate()
  useEffect(()=>{
    console.log(tentaikhoan)
  },[])
  function DangXuat(){
    const a = window.confirm("Bạn có muốn đăng xuất không?")
    if(a){
      dx("/")
    }
  }
  const {
    token: { colorBgContainer, borderRadiusLG },
  } = theme.useToken();

  const menuItems: MenuItem[] = [
    {
      key: "1",
      icon: <HomeOutlined />,
      label: "Trang chủ",
      title: "Trang chủ",
      link: "/admin",
    },
    {
      key: "2",
      icon: <UserOutlined />,
      label: "Thông tin tài khoản",
      title: "Thông tin tài khoản",
      link: "/admin/infor",
    },
    {
      key: "3",
      icon: <FileDoneOutlined />,
      label: "Quản lý đơn hàng",
      title: "Quản lý đơn hàng",
      link: "/admin/orders",
      children: [
        {
          label: "Đơn hàng bán",
          key: "3.1",
          title: "Đơn hàng bán",
          link: "/admin/exportoder",
        },
        {
          label: "Đơn hàng nhập",
          key: "3.2",
          title: "Đơn hàng nhập",
          link: "/admin/importoder",
        },
      ],
    },
    {
      key: "4",
      icon: <TeamOutlined />,
      label: "Quản lý khách hàng",
      title: "Quản lý khách hàng",
      link: "/admin/customer",
    },
    {
      key: "5",
      icon: <ShopOutlined />,
      label: "Quản lý nhà cung cấp",
      title: "Quản lý nhà cung cấp",
      link: "/admin/provider",
    },
    {
      key: "6",
      icon: <AppstoreOutlined />,
      label: "Quản lý size",
      title: "Quản lý size",
      link: "/admin/size",
    },
    {
      key: "7",
      icon: <ShoppingOutlined />,
      label: "Quản lý sản phẩm",
      title: "Quản lý sản phẩm",
      link: "/admin/product",
    },
    {
      key: "8",
      icon: <TagsOutlined />,
      label: "Quản lý chuyên mục",
      title: "Quản lý chuyên mục",
      link: "/admin/category",
    },
    {
      key: "9",
      icon: <BarChartOutlined />,
      label: "Thống kê",
      title: "Thống kê",
      link: "/admin/orders",
      children: [
        {
          label: "Doanh thu",
          key: "9.1",
          title: "Doanh thu",
          link: "/admin/revenue-statistics",
        },
        {
          label: "Lợi nhuận",
          key: "9.2",
          title: "Lợi nhuận",
          link: "/admin/loinhuan",
        },
      ],
    },
    {
      key: "10",
      icon: <InboxOutlined />,
      label: "Kho hàng",
      title: "Kho hàng",
      link: "/admin/tonkho",
    },
    {
      key: "11",
      icon: <GiftOutlined />,
      label: "Mã giảm giá",
      title: "Mã giảm giá",
      link: "/admin/discounts",
    },
    {
      key: "12",
      icon: <FileTextOutlined />,
      label: "Bài viết",
      title: "Bài viết",
      link: "/admin/Articles",
    },
    {
      key: "13",
      icon: <StarOutlined />,
      label: "Đánh giá",
      title: "Đánh giá",
      link: "/admin/danhgia",
    },
  ];

  const findChildTitle = (menuItem: MenuItem[], pathname: string): string => {
    for (let item of menuItem) {
      if (item.children && item.children.length > 0) {
        const childTitle = findChildTitle(item.children, pathname);
        if (childTitle) return childTitle;
      } else if (item.link === pathname) {
        return item.title;
      }
    }
    return "";
  };
  const pageTitle = findChildTitle(menuItems, location.pathname);

  return (
    <Layout>
      <Sider
        trigger={null}
        collapsible
        collapsed={collapsed}
        style={{
          position: "fixed",
          zIndex: 1,
          height: "100vh",
          overflowY: "auto",
        }}
      >
        <div
          className="demo-logo-vertical"
          style={{
            fontSize: "16px",
            width: collapsed ? 50 : 100,
            height: collapsed ? 50 : 100,
            float: "left",
            backgroundColor: "white",
            padding: "10px",
            borderRadius: "50%",
            marginTop: collapsed ? "6px" : "10px",
            marginLeft: collapsed ? "15px" : "50px",
          }}
        >
          <img
            style={{
              width: "100%",
              transition: "height 0.3s",
              marginTop: collapsed ? "3px" : "12px",
            }}
            src="../assets/anh/banner2.png"
            alt=""
          />
          
        </div>

        <Menu
          style={{ marginTop: collapsed ? "60px" : "120px" }}
          theme="dark"
          mode="inline"
          defaultSelectedKeys={["1"]}
          selectedKeys={[location.pathname]}
        >
          {menuItems.map((item) => {
            if (item.children && item.children.length > 0) {
              return (
                <Menu.SubMenu
                  key={`submenu_${item.key}`}
                  title={item.title}
                  icon={item.icon}
                >
                  {item.children.map((child) => (
                    <Menu.Item key={`menuitem_${child.key}`}>
                      <Link to={child.link}>{child.label}</Link>
                    </Menu.Item>
                  ))}
                </Menu.SubMenu>
              );
            } 
            else {
              return (
                <Menu.Item key={`menuitem_${item.key}`} icon={item.icon}>
                  <Link to={item.link}>{item.title}</Link>
                </Menu.Item>
              );
            }
          })}
        </Menu>
      </Sider>
      <Layout style={{ marginLeft: collapsed ? 80 : 200 }}>
        <Header
          style={{
            padding: 0,
            background: colorBgContainer,
            position: "fixed",
            zIndex: 1,

            width: "100%",
          }}
        >
          <Button
            type="text"
            icon={collapsed ? <MenuUnfoldOutlined /> : <MenuFoldOutlined />}
            onClick={() => setCollapsed(!collapsed)}
            style={{
              fontSize: "16px",
              width: 64,
              height: 64,
              float: "left",
            }}
          />
          <div
            style={{
              float: "right",
              marginRight: collapsed ? "150px" : "260px",
              display: "flex",
              alignItems: "center",
            }}
          >
            <img
              style={{ width: "40px", height: "40px", marginRight: "10px" }}
              src="../assets/anh/admin.png"
              alt=""
              onClick={DangXuat}
            />
            Vũ Đình Vinh
          </div>
          <h3>{pageTitle}</h3>
        </Header>
        <div></div>
        <Content
          style={{
            margin: "100px 16px",
            padding: 20,
            minHeight: 500,
            background: colorBgContainer,
            borderRadius: borderRadiusLG,
          }}
        >
          {children}
        </Content>
      </Layout>
    </Layout>
  );
};

export default Admin;
