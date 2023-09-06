
class ProductScreenModal {
  String? productName;
  String? orignalPrice;
  String? sellingPrice;
  String? quantity;
  String? productId;
  String? productDescription;
  bool? dashboardDisplay;
  int? categoryType;
  String? itemCategoryName;
  String? itemSubcategoryName;
  bool ? bestSellingCheckBox;
  bool ? exclusiveSellingCheckBox;
  String? image1;
  String? image2;
  String? image3;


  ProductScreenModal(
      {this.productName,
        this.orignalPrice,
        this.sellingPrice,
        this.quantity,
        this.productId,
        this.productDescription,
        this.dashboardDisplay,
        this.categoryType,
        this.itemCategoryName,
        this.itemSubcategoryName,
        this. bestSellingCheckBox,
        this.  exclusiveSellingCheckBox,
      this.image1,
      this.image2,
      this.image3});

  ProductScreenModal.fromJson(Map<String, dynamic> json) {
    productName = json['productName'];
    orignalPrice = json['orignal_price'];
    sellingPrice = json['selling_price'];
    quantity = json['quantity'];
                productId = json['productId'];
    bestSellingCheckBox = json['productBestSelling'];
    exclusiveSellingCheckBox = json['productExclusiveSelling'];
    productDescription = json['ProductDescription'];
    dashboardDisplay = json['DashboardDisplay'];
    categoryType = json['categoryType'];
    itemCategoryName = json['item_category_name'];
    itemSubcategoryName = json['item_subcategory_name'];
    image1 = json['ProductImage1'];
    image2 = json['ProductImage2'];
    image3 = json['ProductImage3'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productName'] = this.productName;
    data['orignal_price'] = this.orignalPrice;
    data['selling_price'] = this.sellingPrice;
    data['quantity'] = this.quantity;
    data['productId'] = this.productId;
    data['ProductDescription'] = this.productDescription;
    data['DashboardDisplay'] = this.dashboardDisplay;
    data['categoryType'] = this.categoryType;
    data['item_category_name'] = this.itemCategoryName;
    data['item_subcategory_name'] = this.itemSubcategoryName;
    data['ProductImage1']=this.image1;
    data['productBestSelling'] = this.bestSellingCheckBox;
    data['productExclusiveSelling'] = this.exclusiveSellingCheckBox;
    data['ProductImage2']=this.image2;
    data['ProductImage3']=this.image3;

    return data;
  }
}