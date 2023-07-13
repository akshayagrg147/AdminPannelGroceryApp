class ProductCategoryModal {
  List<ItemDataCategory>? itemData;
  int? statusCode;
  String? message;

  ProductCategoryModal({this.itemData, this.statusCode, this.message});

  ProductCategoryModal.fromJson(Map<String, dynamic> json) {
    if (json['itemData'] != null) {
      itemData = <ItemDataCategory>[];
      json['itemData'].forEach((v) {
        itemData!.add(new ItemDataCategory.fromJson(v));
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

class ItemDataCategory {
  String? category;
  String? imageUrl;
  List<SubCategoryList>? subCategoryList;

  ItemDataCategory({this.category, this.imageUrl, this.subCategoryList});

  ItemDataCategory.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    imageUrl = json['imageUrl'];
    if (json['subCategoryList'] != null) {
      subCategoryList = <SubCategoryList>[];
      json['subCategoryList'].forEach((v) {
        subCategoryList!.add(new SubCategoryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['imageUrl'] = this.imageUrl;
    if (this.subCategoryList != null) {
      data['subCategoryList'] =
          this.subCategoryList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategoryList {
  String? name;
  String? subCategoryUrl;

  SubCategoryList({required this.name, required this.subCategoryUrl});

  SubCategoryList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    subCategoryUrl = json['subCategoryUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['subCategoryUrl'] = this.subCategoryUrl;
    return data;
  }
}