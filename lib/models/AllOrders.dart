class AllOrders {
  List<OrderData>? itemData;
  int? statusCode;
  String? message;

  AllOrders({this.itemData, this.statusCode, this.message});

  AllOrders.fromJson(Map<String, dynamic> json) {
    if (json['itemData'] != null) {
      itemData = <OrderData>[];
      json['itemData'].forEach((v) {
        itemData!.add(new OrderData.fromJson(v));
      });
    }
    statusCode = json['statusCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.itemData != null) {
      data['itemData'] = this.itemData!.map((v) => v.toJson()).toList();
    }
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    return data;
  }
}

class OrderData {
  List<OrderList>? orderList;
  String? totalOrderValue;
  String? paymentmode;
  String? address;
  String? mobilenumber;
  String? createdDate;
  String? orderId;
  String? orderStatus;
  String? pincode;

  OrderData(
      {this.orderList,
        this.totalOrderValue,
        this.paymentmode,
        this.address,
        this.mobilenumber,
        this.createdDate,
        this.orderId,
      this.orderStatus,
      this.pincode});

  OrderData.fromJson(Map<String, dynamic> json) {
    if (json['orderList'] != null) {
      orderList = <OrderList>[];
      json['orderList'].forEach((v) {
        orderList!.add(new OrderList.fromJson(v));
      });
    }
    totalOrderValue = json['totalOrderValue'];
    paymentmode = json['paymentmode'];
    address = json['address'];
    mobilenumber = json['mobilenumber'];
    createdDate = json['createdDate'];
    orderId = json['orderId'];
    orderStatus=json['orderStatus'];
    pincode=json['pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderList != null) {
      data['orderList'] = this.orderList!.map((v) => v.toJson()).toList();
    }
    data['totalOrderValue'] = this.totalOrderValue;
    data['paymentmode'] = this.paymentmode;
    data['address'] = this.address;
    data['mobilenumber'] = this.mobilenumber;
    data['createdDate'] = this.createdDate;
    data['orderId'] = this.orderId;
    data['orderStatus'] = this.orderStatus;
    data['pincode'] = this.pincode;

    return data;
  }
}

class OrderList {
  String? productId;
  String? quantity;
  String? productprice;
  String? productName;

  OrderList(
      {this.productId, this.quantity, this.productprice, this.productName});

  OrderList.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    quantity = json['quantity'];
    productprice = json['productprice'];
    productName = json['productName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['quantity'] = this.quantity;
    data['productprice'] = this.productprice;
    data['productName'] = this.productName;
    return data;
  }
}