
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
  String ? quantityInstructionController;
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
        this.quantityInstructionController,
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
    productDescription = json['productDescription'];
    dashboardDisplay = json['DashboardDisplay'];
    categoryType = json['categoryType'];
    itemCategoryName = json['item_category_name'];
    itemSubcategoryName = json['item_subcategory_name'];
    quantityInstructionController= json['quantityInstructionController'];
    image1 = json['productImage1'];
    image2 = json['productImage2'];
    image3 = json['productImage3'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productName'] = this.productName;
    data['orignal_price'] = this.orignalPrice;
    data['selling_price'] = this.sellingPrice;
    data['quantity'] = this.quantity;
    data['productId'] = this.productId;
    data['productDescription'] = this.productDescription;
    data['DashboardDisplay'] = this.dashboardDisplay;
    data['categoryType'] = this.categoryType;
    data['item_category_name'] = this.itemCategoryName;
    data['item_subcategory_name'] = this.itemSubcategoryName;
    data['productImage1']=this.image1;
    data['productBestSelling'] = this.bestSellingCheckBox;
    data['productExclusiveSelling'] = this.exclusiveSellingCheckBox;
    data['quantityInstructionController'] = this.quantityInstructionController;
    data['productImage2']=this.image2;
    data['productImage3']=this.image3;

    return data;
  }
}