
class LoginResponseBody {
  int ?status;
  String ?success;

  LoginResponseBody({this.status, this.success});

  LoginResponseBody.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    return data;
  }
}