class LoginResponse {
  Response? response;
  int? statusCode;
  String? message;

  LoginResponse({this.response, this.statusCode, this.message});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
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

class Response {
  String? email;
  String? name;
  String? password;
  String? pincode;

  Response({this.email, this.password, this.pincode});

  Response.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    pincode = json['pincode'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['password'] = this.password;
    data['pincode'] = this.pincode;
    return data;
  }
}