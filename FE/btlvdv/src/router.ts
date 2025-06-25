import Home from "./pages/home";
import Detail from "./pages/detail";
import Cart from "./pages/cart";
import Category from "./pages/category";
import Admin from "./shared/ad";
import AdminHome from "./pages/admin/adHome";
import AdminCategory from "./pages/admin/adCategory";
import AdminProduct from "./pages/admin/adProduct";
import AdminProvider from "./pages/admin/adProvider";
import AdminSize from "./pages/admin/adSize";
import AdminCustomer from "./pages/admin/adCustomer";
import AdminStaff from "./pages/admin/adUserInfor";
import AdminExportOder from "./pages/admin/adExportOder";
import AdminImportOder from "./pages/admin/adImportOder";
import Login from "./pages/login";
import Register from "./pages/register";
import InforUser from "./pages/inforUser";
import CartHistory from "./pages/cartHistory";
import Search from "./pages/search";
import { ServerErrorPage } from "./shared/500";
import AdminInfor from "./pages/admin/adUserInfor";
import Payment from "./pages/Payment";
import ThongKeDoanhThu from "./pages/admin/ThongKe/ThongKeDoanhThu";
import AdminInventory from "./pages/admin/ProductInventory/adInventory";
import Discounts from "./pages/admin/Discounts/Discounts";
import Articles from "./pages/admin/Articles/Articles";
import ArticlesUser from "./pages/ArticlesUser";
import DanhGia from "./pages/admin/DanhGia/DanhGia";
import ThongKeLoiNhuan from "./pages/admin/ThongKe/ThongKeLoiNhuan";


export const routeAd= [
    { path: "/admin", Component: AdminHome }, 
    { path: "/admin/product", Component: AdminProduct  },
    { path: "/admin/size", Component: AdminSize  },
    { path: "/admin/customer", Component: AdminCustomer  },
    { path: "/admin/infor", Component: AdminInfor  },
    { path: "/admin/exportoder", Component: AdminExportOder  },
    { path: "/admin/importoder", Component: AdminImportOder  },
    { path: "/admin/category", Component: AdminCategory  },
    { path: "/admin/provider", Component: AdminProvider  },
    { path: "/admin/revenue-statistics", Component: ThongKeDoanhThu  },
    { path: "/admin/tonkho", Component: AdminInventory  },
    { path: "/admin/discounts", Component: Discounts  },
    { path: "/admin/articles", Component: Articles  },
    { path: "/admin/danhgia", Component: DanhGia  },
    { path: "/admin/loinhuan", Component: ThongKeLoiNhuan  },

  ];
export const routeUser = [
    { path: "/user/home", Component: Home  },
    { path: "/user/detail/:id", Component: Detail  },
    { path: "/user/cart", Component: Cart  },
    { path: "/user/category", Component: Category  },
    { path: "/user/login", Component: Login  },
    { path: "/user/infor", Component: InforUser  },
    { path: "/user/carthistory", Component: CartHistory  },
    { path: "/user/search", Component: Search  },
    { path: "/user/payment", Component: Payment  },
    { path: "/user/articles", Component: ArticlesUser  },
  ];
  
  export const routeLogin = [
    { path: "/", Component: Login  },
    { path: "/register", Component: Register  },
    { path: "/ServerErrorPage", Component: ServerErrorPage  },
  ];