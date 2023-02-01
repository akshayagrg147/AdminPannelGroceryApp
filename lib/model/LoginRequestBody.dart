
class LoginRequestBody {
  String? emailId;
  String ?password;

  LoginRequestBody({this.emailId, this.password});

  LoginRequestBody.fromJson(Map<String, dynamic> json) {
    emailId = json['EmailId'];
    password = json['Password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EmailId'] = this.emailId;
    data['Password'] = this.password;
    return data;
  }
}