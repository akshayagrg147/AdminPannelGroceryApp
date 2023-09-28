class RecentOrderCountResponse {
  List<RecentOrders1>? recentOrders;
  List<CountResponse>? countResponse;
  int? statusCode;
  String? message;
  String? image;
  String? name;

  RecentOrderCountResponse(
      {this.recentOrders,
      this.countResponse,
      this.statusCode,
      this.message,
      this.image,
      this.name});

  RecentOrderCountResponse.fromJson(Map<String, dynamic> json) {
    if (json['recentOrders'] != null) {
      recentOrders = <RecentOrders1>[];
      json['recentOrders'].forEach((v) {
        recentOrders!.add(new RecentOrders1.fromJson(v));
      });
    }
    if (json['CountResponse'] != null) {
      countResponse = <CountResponse>[];
      json['CountResponse'].forEach((v) {
        countResponse!.add(new CountResponse.fromJson(v));
      });
    }
    statusCode = json['statusCode'];
    message = json['message'];
    image = json['image'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.recentOrders != null) {
      data['recentOrders'] = this.recentOrders!.map((v) => v.toJson()).toList();
    }
    if (this.countResponse != null) {
      data['CountResponse'] =
          this.countResponse!.map((v) => v.toJson()).toList();
    }
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    data['image'] = this.image;
    data['name'] = this.name;
    return data;
  }
}

class RecentOrders1 {
  List<OrderList>? orderList;
  String? totalOrderValue;
  String? paymentmode;
  String? address;
  String? mobilenumber;
  String? createdDate;
  String? orderId;

  RecentOrders1(
      {this.orderList,
      this.totalOrderValue,
      this.paymentmode,
      this.address,
      this.mobilenumber,
      this.createdDate,
      this.orderId});

  RecentOrders1.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class OrderList {
  String? productId;
  String? quantity;
  String? productprice;

  OrderList({this.productId, this.quantity, this.productprice});

  OrderList.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    quantity = json['quantity'];
    productprice = json['productprice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['quantity'] = this.quantity;
    data['productprice'] = this.productprice;
    return data;
  }
}

class CountResponse {
  String? name;
  int? count;
  String? image;

  CountResponse({this.name, this.count});

  CountResponse.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    count = json['count'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['count'] = this.count;
    data['image'] = this.image;

    return data;
  }
}
