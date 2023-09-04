class AddCategoryModal {
  String? category;
    String? imageUrl;
  List<SubCategoryListData>? subCategoryList;

  AddCategoryModal({this.category, this.imageUrl, this.subCategoryList});

  AddCategoryModal.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    imageUrl = json['imageUrl'];
    if (json['subCategoryList'] != null) {
      subCategoryList = <SubCategoryListData>[];
      json['subCategoryList'].forEach((v) {
        subCategoryList!.add(new SubCategoryListData.fromJson(v));
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

class SubCategoryListData {
  String? name;
  String? image;

  SubCategoryListData({this.name, this.image});

  SubCategoryListData.fromJson(Map<String, dynamic> json) {
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