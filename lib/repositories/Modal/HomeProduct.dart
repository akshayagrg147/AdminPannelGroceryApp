
class HomeProducts {
  String? productName;
  String ?price;
  String ?quantity;
  String? productImage1;
  String ?productImage2;
  String ?productImage3;
  String ?productId;
  String ?productDescription;
  String ?actual_price;
  bool ?dashboardDisplay;
  String ?category;

  String ?itemCategoryId;
  int? categoryType;


  HomeProducts({this.productName,
    this.price,
    this.quantity,
    this.productImage1,
    this.productImage2
    , this.productImage3,
    this.productId,
    this.productDescription,
    this.actual_price,
    this.category,
    this.itemCategoryId,
    this.categoryType});

  HomeProducts.fromJson(Map<String, dynamic> json) {
    productName = json['productName'];
    price = json['price'];
    quantity = json['quantity'];
    productImage1 = json['ProductImage1'];
    productImage2 = json['ProductImage2'];
    productImage3 = json['ProductImage3'];
    productId = json['productId'];
    productDescription = json['ProductDescription'];
    actual_price = json['actual_price'];
    category = json['category'];
    itemCategoryId = json['itemCategoryId'];
    categoryType = json['categoryType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productName'] = productName;
    data['price'] = price;
    data['quantity'] = quantity;
    data['ProductImage1'] = productImage1;
    data['ProductImage2'] = productImage2;
    data['ProductImage3'] = productImage3;
    data['productId'] = productId;
    data['ProductDescription'] = productDescription;
    data['actual_price'] = actual_price;
    data['category'] = category;
    data['itemCategoryId'] = itemCategoryId;
    data['categoryType'] = categoryType;


    return data;
  }
}