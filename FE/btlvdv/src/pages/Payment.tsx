import React from "react";
import { useSearchParams } from "react-router-dom";
import { Result } from "antd";

function Payment() {
  const [searchParams] = useSearchParams();
  const responseCode = searchParams.get("vnp_ResponseCode");

  return (
    <div style={{ padding: "50px 0" }}>
      <Result
        status={responseCode === "00" ? "success" : "error"}
        title={responseCode === "00" ? "Thanh toán thành công!" : "Thanh toán thất bại hoặc bị huỷ"}
        subTitle={responseCode === "00" ? "Cảm ơn bạn đã mua hàng" : "Vui lòng thử lại sau"}
      />
    </div>
  );
}

export default Payment;
