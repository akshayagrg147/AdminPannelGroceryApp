import 'package:adminpannelgrocery/repositories/Modal/UserResponse.dart';

import '../repositories/Modal/AddedItemResponse.dart';
import '../repositories/Modal/AllProducts.dart';
import '../repositories/Modal/HomeProduct.dart';

abstract class AllUserState {}

class AllUserLoadingState extends AllUserState {}

class AllUserLoadedState extends AllUserState {
  final UserResponse products;

  AllUserLoadedState(this.products);
}

class AllUserErrorState extends AllUserState {
  final String error;

  AllUserErrorState(this.error);
}
