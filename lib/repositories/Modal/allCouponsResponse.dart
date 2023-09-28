class allCouponsResponse {
  List<ItemDataa>? itemData;
  int? statusCode;
  String? message;

  allCouponsResponse({this.itemData, this.statusCode, this.message});

  allCouponsResponse.fromJson(Map<String, dynamic> json) {
    if (json['itemData'] != null) {
      itemData = <ItemDataa>[];
      json['itemData'].forEach((v) {
        itemData!.add(new ItemDataa.fromJson(v));
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

class ItemDataa {
  String? couponTitle;
  String? couponCode;
  String? discountPercentage;
  String? discountedAmount;
  String? minimumPurchase;
  String? startDate;
  String? expireDate;

  ItemDataa(
      {this.couponTitle,
      this.couponCode,
      this.discountPercentage,
      this.discountedAmount,
      this.minimumPurchase,
      this.startDate,
      this.expireDate});

  ItemDataa.fromJson(Map<String, dynamic> json) {
    couponTitle = json['couponTitle'];
    couponCode = json['couponCode'];
    discountPercentage = json['discountPercentage'];
    discountedAmount = json['discountedAmount'];
    minimumPurchase = json['minimumPurchase'];
    startDate = json['startDate'];
    expireDate = json['expireDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['couponTitle'] = this.couponTitle;
    data['couponCode'] = this.couponCode;
    data['discountPercentage'] = this.discountPercentage;
    data['discountedAmount'] = this.discountedAmount;
    data['minimumPurchase'] = this.minimumPurchase;
    data['startDate'] = this.startDate;
    data['expireDate'] = this.expireDate;
    return data;
  }
}
