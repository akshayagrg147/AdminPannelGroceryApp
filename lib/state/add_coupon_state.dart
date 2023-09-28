import '../models/AddProductResponse.dart';
import '../repositories/Modal/AddedItemResponse.dart';
import '../repositories/Modal/AllProducts.dart';
import '../repositories/Modal/HomeProduct.dart';

abstract class AddCouponState {}

class AddCouponLoadingState extends AddCouponState {}

class AddCouponInitialState extends AddCouponState {}

class AddCouponLoadedState extends AddCouponState {
  final AddProductResponse products;

  AddCouponLoadedState(this.products);
}

class AddCouponErrorState extends AddCouponState {
  final String error;

  AddCouponErrorState(this.error);
}
