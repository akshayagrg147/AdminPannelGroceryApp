
class CouponFormData {
  String? couponTitle;
  String? couponCode;
  String? couponType;
  String? discountPercentage;
  String? discountedAmount;
  String? minimumPurchase;
  String? startDate;
  String? expireDate;

  CouponFormData(
      {this.couponTitle,
        this.couponCode,
        this.couponType,
        this.discountPercentage,
        this.discountedAmount,
        this.minimumPurchase,
        this.startDate,
        this.expireDate});

  CouponFormData.fromJson(Map<String, dynamic> json) {
    couponTitle = json['couponTitle'];
    couponCode = json['couponCode'];
    couponType = json['couponType'];
    discountPercentage = json['discountPercentage'];
    discountedAmount = json['discountedAmount'];
    minimumPurchase = json['minimumPurchase'];
    startDate = json['startDate'];
    expireDate = json['expireDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['couponTitle'] = this.couponTitle;
    data['couponCode'] = this.couponCode;
    data['couponType'] = this.couponType;
    data['discountPercentage'] = this.discountPercentage;
    data['discountedAmount'] = this.discountedAmount;
    data['minimumPurchase'] = this.minimumPurchase;
    data['startDate'] = this.startDate;
    data['expireDate'] = this.expireDate;
    return data;
  }
}