export function addtoCart(item: any){
    if (!item.quantity) {
        item.quantity = 1;
    }
    var list;
    if(localStorage.getItem('cart') == null){
        list = [item];
        localStorage.setItem('cart',JSON.stringify(list));
        alert("Đã thêm vào giỏ hàng thành công");
    }else{
        list = JSON.parse(localStorage.getItem('cart')||'[]')
        let ok = true;
        for(let x of list){
            if(x.maSanPham == item.maSanPham && x.maSize == item.maSize){
                x.quantity += item.quantity;
                ok = false;
                break;
            }
        }
        if(ok){
            list.push(item);
            localStorage.setItem('cart',JSON.stringify(list));
            alert("Đã thêm vào giỏ hàng thành công");
        } else {
            alert("Sản phẩm đã có trong giỏ hàng");
        }
    }
}