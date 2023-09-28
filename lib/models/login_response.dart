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
  String? freeDeliveryAmount;
  String? privatekey;
  String? publickey;

  ResponseLogin(
      {this.email,
      this.name,
      this.password,
      this.pincode,
      this.freeDeliveryAmount,
      privatekey,
      publickey});

  ResponseLogin.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    pincode = json['pincode'];
    name = json['name'];
    freeDeliveryAmount = json['price'];
    privatekey = json['privatekey'];
    publickey = json['publickey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['password'] = this.password;
    data['pincode'] = this.pincode;
    data['price'] = this.freeDeliveryAmount;
    data['privatekey'] = this.privatekey;
    data['publickey'] = this.publickey;
    return data;
  }
}
