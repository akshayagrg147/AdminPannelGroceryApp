import 'package:adminpannelgrocery/repositories/Modal/RecentOrderCountResponse.dart';

import '../repositories/Modal/AddedItemResponse.dart';
import '../repositories/Modal/AllProducts.dart';
import '../repositories/Modal/HomeProduct.dart';

abstract class RecentOrderCountState {}

class RecentOrderCountLoadingState extends RecentOrderCountState {}

class RecentOrderCountLoadedState extends RecentOrderCountState {
  final RecentOrderCountResponse response;

  RecentOrderCountLoadedState(this.response);
}

class RecentOrderCountErrorState extends RecentOrderCountState {
  final String error;

  RecentOrderCountErrorState(this.error);
}
