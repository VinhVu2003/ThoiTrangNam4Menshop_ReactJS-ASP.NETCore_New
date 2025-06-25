import type { FormProps } from "antd";
import { Button, Checkbox, Form, Input } from "antd";
import { useRecoilValue } from "recoil";
import { thongtinTK } from "../constant/recoil";
import { useNavigate } from "react-router-dom";
import axios from "axios";
import { useEffect, useState } from "react";
import { Modal } from 'antd';

const InforUser = function () {
  const navigate = useNavigate();
  const infor = useRecoilValue(thongtinTK);
  // const [infor,setInfor] = useState<any>(() => {
  //   const storedData = sessionStorage.getItem('MaTaiKhoan');
  //   return storedData ? JSON.parse(storedData) : null;
  // });
  const [data, setData] = useState<any>();
  const [kh,setKhachang] = useState<any>(() => {
    const storedData = sessionStorage.getItem('ThongTinKhachHang');
    return storedData ? JSON.parse(storedData) : null;
  });
  function setInput() {
    form.setFieldsValue({ username: infor.taikhoan });
    form.setFieldsValue({ tenKH: data.tenKH  });
    form.setFieldsValue({ diachi: data.diaChi });
    form.setFieldsValue({ sdt: data.sdt  });
  }

  async function GetInforUser() {
    try {
      const response = await axios.post(
        "https://localhost:44381/api/Khach/search",
        {
          page: "1",
          pageSize: "1",
          MaTaiKhoan: infor?.mataikhoan ,
        }
      );

      const firstItem = response.data.data[0];

      setData(firstItem);
      // console.log(data)
      setInput();
    } catch {}
  }

  useEffect(() => {
    if (infor.mataikhoan) {
      GetInforUser();
    }
  }, [infor,data]);

  const [form] = Form.useForm();

  return (
    <>
      <div
        style={{ marginLeft: "20px" }}
        onClick={() => {
          alert(infor?.mataikhoan);
        }}
      >
        Thông tin tài khoản
      </div>
      <div style={{ display: "flex", justifyContent: "center" }}>
        <Form
          form={form} // Truyền form instance vào Form
          name="basic"
          labelCol={{ span: 8 }}
          wrapperCol={{ span: 16 }}
          style={{ maxWidth: 600 }}
          initialValues={{ remember: true }}
          autoComplete="off"
        >
          <Form.Item label="Tài khoản" name="username">
            <Input disabled />
          </Form.Item>
          <Form.Item label="Họ tên" name="tenKH">
            <Input disabled />
          </Form.Item>

          <Form.Item label="Địa chỉ" name="diachi">
            <Input disabled />
          </Form.Item>

          <Form.Item label="Số điện thoại" name="sdt">
            <Input disabled />
          </Form.Item>

          <Form.Item wrapperCol={{ offset: 8, span: 16 }}>
            <Button
              type="primary"
              htmlType="submit"
              onClick={() => {
                Modal.confirm({
                  title: "Bạn có muốn đăng xuất?",
                  onOk() {
                    navigate("/");
                  },
                });
              }}
            >
              Đăng xuất
            </Button>
          </Form.Item>
        </Form>
      </div>
    </>
  );
};
export default InforUser;
