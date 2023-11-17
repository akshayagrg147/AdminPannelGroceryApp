class LoginResponse {
  ResponseLogin? response;
  int? statusCode;
  String? message;

  LoginResponse({this.response, this.statusCode, this.message});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    response = json['response'] != null
        ? new ResponseLogin.fromJson(json['response'])
        : null;
    statusCode = json['statusCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.response != null) {
      data['response'] = this.response!.toJson();
    }
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    return data;
  }
}

class ResponseLogin {
  String? email;
  String? name;
  String? password;
  String? pincode;
  String? price;
  String? fcm_token;
  String? city;
  String? deliveryContactNumber;
  String? generateToken;
  String? sellerId;




  ResponseLogin(
      {this.email,
      this.name,
      this.password,
      this.pincode,
      this.price,
       this. fcm_token,
        this.city,
        this.deliveryContactNumber,
        this.generateToken,
        this.sellerId
      });

  ResponseLogin.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    pincode = json['pincode'];
    name = json['name'];
    price = json['price'];
    fcm_token = json['fcm_token'];
    city = json['city'];
    deliveryContactNumber = json['deliveryContactNumber'];
    generateToken = json['generateToken'];
    sellerId= json['sellerId'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['password'] = this.password;
    data['pincode'] = this.pincode;
    data['price'] = this.price;
    data['fcm_token'] = this.fcm_token;
    data['city'] = this.city;
    data['deliveryContactNumber'] = this.deliveryContactNumber;
    data['generateToken'] = this.generateToken;
    data['sellerId'] = this.sellerId;

    return data;
  }
}
