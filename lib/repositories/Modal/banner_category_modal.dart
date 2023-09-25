class BannerCategoryModal {
  List<ItemBannerCategory>? itemData;
  int? statusCode;
  String? message;
  bool? status;

  BannerCategoryModal({this.itemData, this.statusCode, this.message,this.status});

  BannerCategoryModal.fromJson(Map<String, dynamic> json) {
    if (json['itemData'] != null) {
      itemData = <ItemBannerCategory>[];
      json['itemData'].forEach((v) {
        itemData!.add(new ItemBannerCategory.fromJson(v));
      });
    }
    statusCode = json['statusCode'];
    message = json['message'];
    status= json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.itemData != null) {
      data['itemData'] = this.itemData!.map((v) => v.toJson()).toList();
    }
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class ItemBannerCategory {
  String? bannercategory1;
  String? imageUrl1;
  String? bannercategory2;
  String? imageUrl2;
  String? bannercategory3;
  String? imageUrl3;
  List<SubCategoryList>? subCategoryList;

  ItemBannerCategory({this.bannercategory1, this.imageUrl1,this.bannercategory2, this.imageUrl2,this.bannercategory3, this.imageUrl3, this.subCategoryList});

  ItemBannerCategory.fromJson(Map<String, dynamic> json) {
    bannercategory1 = json['bannercategory1'];
    imageUrl1 = json['imageUrl1'];
    bannercategory2 = json['bannercategory2'];
    imageUrl2 = json['imageUrl2'];
    bannercategory3 = json['bannercategory3'];
    imageUrl3 = json['imageUrl3'];

    if (json['subCategoryList'] != null) {
      subCategoryList = <SubCategoryList>[];
      json['subCategoryList'].forEach((v) {
        subCategoryList!.add(new SubCategoryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bannercategory1'] = this.bannercategory1;
    data['imageUrl1'] = this.imageUrl1;
    data['bannercategory2'] = this.bannercategory2;
    data['imageUrl2'] = this.imageUrl2;
    data['bannercategory3'] = this.bannercategory3;
    data['imageUrl3'] = this.imageUrl3;
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