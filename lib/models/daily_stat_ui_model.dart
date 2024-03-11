import 'package:adminpannelgrocery/repositories/Modal/BarGraphOrderValue.dart';
import 'package:flutter/src/widgets/framework.dart';

var defaultDailyStat = DailyStatUiModel(
  day: 'day',
  stat: 0,

);

class DailyStatUiModel {
  String day;
  int stat;


  DailyStatUiModel(
      {required this.day,
      required this.stat
      });

  DailyStatUiModel copyWith(
          {String? day,
          int? stat,
          bool? isToday,
          bool? isSelected,
          int? dayPosition}) =>
      DailyStatUiModel(
          day: day ?? this.day,
          stat: stat ?? this.stat
          );

  factory DailyStatUiModel.fromBarGraphOrder(BarGraphOrderValue barGraphOrder) {
    return DailyStatUiModel(
      day: barGraphOrder.orderDate,
      stat: barGraphOrder.orderQuantity,
    );
  }
}
