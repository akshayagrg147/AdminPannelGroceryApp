
class AllProducts {
  List<ItemData>? itemData;
  int? statusCode;
  String? message;

  AllProducts({required this.itemData,required this.statusCode, required this.message});

  AllProducts.fromJson(Map<String, dynamic> json) {
    if (json['itemData'] != null) {
      itemData = <ItemData>[];
      json['itemData'].forEach((v) {
        itemData!.add(ItemData.fromJson(v));
      });
    }
    statusCode = json['statusCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (itemData != null) {
      data['itemData'] = itemData!.map((v) => v.toJson()).toList();
    }
    data['statusCode'] = statusCode;
    data['message'] = message;
    return data;
  }
}

class ItemData {
  String? productName;
  String? selling_price;
  String? quantity;
  String? productImage1;
  String? productImage2;
  String? productImage3;
  String? productId;
  String? productDescription;
  String? orignal_price;
  bool? dashboardDisplay;
  String? category;
  List<Rating>? rating;
  String? itemCategoryId;
  int? categoryType;

  ItemData(
      {this.productName,
        this.selling_price,
        this.quantity,
        this.productImage1,
        this.productImage2,
        this.productImage3,
        this.productId,
        this.productDescription,
        this.orignal_price,
        this.dashboardDisplay,
        this.category,
        this.rating,
        this.itemCategoryId,
        this.categoryType});

  ItemData.fromJson(Map<String, dynamic> json) {
    productName = json['productName'];
    selling_price = json['selling_price'];
    quantity = json['quantity'];
    productImage1 = json['ProductImage1'];
    productImage2 = json['ProductImage2'];
    productImage3 = json['ProductImage3'];
    productId = json['productId'];
    productDescription = json['ProductDescription'];
    orignal_price = json['orignal_price'];
    dashboardDisplay = json['DashboardDisplay'];
    category = json['category'];
    if (json['rating'] != null) {
      rating = <Rating>[];
      json['rating'].forEach((v) {
        rating!.add(new Rating.fromJson(v));
      });
    }
    itemCategoryId = json['itemCategoryId'];
    categoryType = json['categoryType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productName'] = this.productName;
    data['orignal_price'] = this.orignal_price;
    data['quantity'] = this.quantity;
    data['ProductImage1'] = this.productImage1;
    data['ProductImage2'] = this.productImage2;
    data['ProductImage3'] = this.productImage3;
    data['productId'] = this.productId;
    data['ProductDescription'] = this.productDescription;
    data['selling_price'] = this.selling_price;
    data['DashboardDisplay'] = this.dashboardDisplay;
    data['category'] = this.category;
    if (this.rating != null) {
      data['rating'] = this.rating!.map((v) => v.toJson()).toList();
    }
    data['itemCategoryId'] = this.itemCategoryId;
    data['categoryType'] = this.categoryType;
    return data;
  }
}

class Rating {
  String? remark;
  String? rating;
  String? name;
  String? customerId;

  Rating({this.remark, this.rating, this.name, this.customerId});

  Rating.fromJson(Map<String, dynamic> json) {
    remark = json['remark'];
    rating = json['rating'];
    name = json['name'];
    customerId = json['customerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['remark'] = this.remark;
    data['rating'] = this.rating;
    data['name'] = this.name;
    data['customerId'] = this.customerId;
    return data;
  }
}