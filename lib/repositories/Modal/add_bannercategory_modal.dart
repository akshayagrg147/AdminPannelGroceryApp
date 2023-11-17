class AddBannerCategoryModal {
  String? banner1;
  String? imageUrl1;
  String? banner2;
  String? imageUrl2;
  String? banner3;
  String? imageUrl3;
  List<SubBannerCategoryList>? subCategoryList;
  String? pincode;
  String? sellerId;


  AddBannerCategoryModal(
      {this.banner1,
      this.imageUrl1,
      this.banner2,
      this.imageUrl2,
      this.banner3,
      this.imageUrl3,
      this.subCategoryList,
      this.pincode,this.sellerId});

  AddBannerCategoryModal.fromJson(Map<String, dynamic> json) {
    banner1 = json['bannercategory1'];
    imageUrl1 = json['imageUrl1'];
    banner2 = json['bannercategory2'];
    imageUrl2 = json['imageUrl2'];
    banner3 = json['bannercategory3'];
    imageUrl3 = json['imageUrl3'];
    pincode = json['pincode'];
    sellerId= json['sellerId'];
    if (json['subCategoryList'] != null) {
      subCategoryList = <SubBannerCategoryList>[];
      json['subCategoryList'].forEach((v) {
        subCategoryList!.add(new SubBannerCategoryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bannercategory1'] = this.banner1;
    data['imageUrl1'] = this.imageUrl1;
    data['bannercategory2'] = this.banner2;
    data['imageUrl2'] = this.imageUrl2;
    data['bannercategory3'] = this.banner3;
    data['imageUrl3'] = this.imageUrl3;
    data['pincode'] = this.pincode;
    data['sellerId'] = this.sellerId;
    if (this.subCategoryList != null) {
      data['subCategoryList'] =
          this.subCategoryList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubBannerCategoryList {
  String? name;
  String? image;

  SubBannerCategoryList({this.name, this.image});

  SubBannerCategoryList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['subCategoryUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['subCategoryUrl'] = this.image;
    return data;
  }
}
