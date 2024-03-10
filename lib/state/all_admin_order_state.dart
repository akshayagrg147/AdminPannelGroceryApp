import 'package:adminpannelgrocery/repositories/Modal/UserResponse.dart';

import '../repositories/Modal/AddedItemResponse.dart';
import '../repositories/Modal/AllProducts.dart';
import '../repositories/Modal/BarGraphOrderValue.dart';
import '../repositories/Modal/HomeProduct.dart';

abstract class AllAdminOrderState {}

class AllAdminOrderLoadingState extends AllAdminOrderState {}


class AllAdminOrderLoadedState extends AllAdminOrderState {
  final BarGraphOrderValue orderValue;

  AllAdminOrderLoadedState(this.orderValue);
}

class AllAdminOrderErrorState extends AllAdminOrderState {
  final String error;

  AllAdminOrderErrorState(this.error);
}
