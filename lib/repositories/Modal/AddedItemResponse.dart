class AddedItemResponse {
  String? message;
  bool? status;
  int? statusCode;

  AddedItemResponse({this.message, this.status, this.statusCode});

  AddedItemResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = message;
    data['status'] = status;
    data['statusCode'] = statusCode;
    return data;
  }
}