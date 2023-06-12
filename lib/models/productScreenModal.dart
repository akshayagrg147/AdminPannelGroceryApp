
class ProductScreenModal {
  String? productName;
  String? price;
  String? quantity;
  String? actualPrice;
  String? productId;
  String? productDescription;
  bool? dashboardDisplay;
  String? itemCategoryId;
  int? categoryType;

  ProductScreenModal(
      {this.productName,
        this.price,
        this.quantity,
        this.actualPrice,
        this.productId,
        this.productDescription,
        this.dashboardDisplay,
        this.itemCategoryId,
        this.categoryType});

  ProductScreenModal.fromJson(Map<String, dynamic> json) {
    productName = json['productName'];
    price = json['price'];
    quantity = json['quantity'];
    actualPrice = json['actual_price'];
    productId = json['productId'];
    productDescription = json['ProductDescription'];
    dashboardDisplay = json['DashboardDisplay'];
    itemCategoryId = json['itemCategoryId'];
    categoryType = json['categoryType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productName'] = this.productName;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['actual_price'] = this.actualPrice;
    data['productId'] = this.productId;
    data['ProductDescription'] = this.productDescription;
    data['DashboardDisplay'] = this.dashboardDisplay;
    data['itemCategoryId'] = this.itemCategoryId;
    data['categoryType'] = this.categoryType;
    return data;
  }
}
