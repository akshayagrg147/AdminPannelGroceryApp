class ProductCategoryModal {
  List<Category>? category;
  int? statusCode;
  String? message;

  ProductCategoryModal({this.category, this.statusCode, this.message});

  ProductCategoryModal.fromJson(Map<String, dynamic> json) {
    if (json['itemData'] != null) {
      category = <Category>[];
      json['itemData'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
    statusCode = json['statusCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.category != null) {
      data['itemData'] = this.category!.map((v) => v.toJson()).toList();
    }
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    return data;
  }
}

class Category {
  String? category;

  Category({this.category});

  Category.fromJson(Map<String, dynamic> json) {
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    return data;
  }
}