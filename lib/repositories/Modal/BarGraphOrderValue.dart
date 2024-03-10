class BarGraphOrderValue {
  String orderDate;
  int orderQuantity;

  BarGraphOrderValue({
    required this.orderDate,
    required this.orderQuantity,
  });

  factory BarGraphOrderValue.fromJson(Map<String, dynamic> json) {
    return BarGraphOrderValue(
      orderDate: json['orderDate'] ?? "", // Provide a default value or handle accordingly
      orderQuantity: json['orderQuantity'] ?? 0, // Provide a default value or handle accordingly
    );
  }
}

class BarGraphResponse {
  List<BarGraphOrderValue> itemData;
  int statusCode;
  String message;

  BarGraphResponse({
    required this.itemData,
    required this.statusCode,
    required this.message,
  });

  factory BarGraphResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic>? itemDataList = json['itemData'];
    List<BarGraphOrderValue> parsedItemData = itemDataList != null
        ? List<BarGraphOrderValue>.from(itemDataList.map((item) => BarGraphOrderValue.fromJson(item)))
        : [];

    return BarGraphResponse(
      itemData: parsedItemData,
      statusCode: json['statusCode'] ?? 0, // Provide a default value or handle accordingly
      message: json['message'] ?? "", // Provide a default value or handle accordingly
    );
  }
}
