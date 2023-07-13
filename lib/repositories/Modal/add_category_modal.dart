class AddCategoryModal {
  String? category;
  List<AddSubCategoryList>? subCategoryList;

  AddCategoryModal({required this.category, required this.subCategoryList});

  AddCategoryModal.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    if (json['subCategoryList'] != null) {
      subCategoryList = <AddSubCategoryList>[];
      json['subCategoryList'].forEach((v) {
        subCategoryList!.add(new AddSubCategoryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    if (this.subCategoryList != null) {
      data['subCategoryList'] =
          this.subCategoryList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddSubCategoryList {
  String? name;

  AddSubCategoryList({this.name});

  AddSubCategoryList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}