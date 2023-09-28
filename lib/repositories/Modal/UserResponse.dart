class UserResponse {
  List<UserData>? userData;
  int? statusCode;
  String? message;

  UserResponse({this.userData, this.statusCode, this.message});

  UserResponse.fromJson(Map<String, dynamic> json) {
    if (json['itemData'] != null) {
      userData = <UserData>[];
      json['itemData'].forEach((v) {
        userData!.add(new UserData.fromJson(v));
      });
    }
    statusCode = json['statusCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userData != null) {
      data['itemData'] = this.userData!.map((v) => v.toJson()).toList();
    }
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    return data;
  }
}

class UserData {
  String? userId;
  String? email;
  String? name;
  String? phone;
  String? profileImage;

  UserData({this.userId, this.email, this.name, this.phone, this.profileImage});

  UserData.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['email'] = this.email;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['profileImage'] = this.profileImage;
    return data;
  }
}
