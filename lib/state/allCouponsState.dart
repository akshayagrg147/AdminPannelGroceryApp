import 'package:adminpannelgrocery/repositories/Modal/allCouponsResponse.dart';

import '../models/AddProductResponse.dart';
import '../repositories/Modal/AddedItemResponse.dart';
import '../repositories/Modal/AllProducts.dart';
import '../repositories/Modal/HomeProduct.dart';

abstract class AllCouponsState {}

class AllCouponsLoadingState extends AllCouponsState {}

class AllCouponsInitialState extends AllCouponsState {}

class AllCouponsLoadedState extends AllCouponsState {
  final allCouponsResponse products;

  AllCouponsLoadedState(this.products);
}

class AllCouponsErrorState extends AllCouponsState {
  final String error;

  AllCouponsErrorState(this.error);
}
