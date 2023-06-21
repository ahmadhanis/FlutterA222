class Cart {
  String? cartId;
  String? catchId;
  String? catchName;
  String? catchStatus;
  String? catchType;
  String? catchDesc;
  String? catchQty;
  String? cartPrice;
  String? userId;
  String? sellerId;
  String? cartDate;

  Cart(
      {this.cartId,
      this.catchId,
      this.catchName,
      this.catchStatus,
      this.catchType,
      this.catchDesc,
      this.catchQty,
      this.cartPrice,
      this.userId,
      this.sellerId,
      this.cartDate});

  Cart.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    catchId = json['catch_id'];
    catchName = json['catch_name'];
    catchStatus = json['catch_status'];
    catchType = json['catch_type'];
    catchDesc = json['catch_desc'];
    catchQty = json['catch_qty'];
    cartPrice = json['cart_price'];
    userId = json['user_id'];
    sellerId = json['seller_id'];
    cartDate = json['cart_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cart_id'] = cartId;
    data['catch_id'] = catchId;
    data['catch_name'] = catchName;
    data['catch_status'] = catchStatus;
    data['catch_type'] = catchType;
    data['catch_desc'] = catchDesc;
    data['catch_qty'] = catchQty;
    data['cart_price'] = cartPrice;
    data['user_id'] = userId;
    data['seller_id'] = sellerId;
    data['cart_date'] = cartDate;
    return data;
  }
}