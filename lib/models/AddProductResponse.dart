
class AddProductResponse {
  String? message;
  bool? status;
  int? statusCode;

  AddProductResponse({this.message, this.status, this.statusCode});

  AddProductResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    data['statusCode'] = this.statusCode;
    return data;
  }
}