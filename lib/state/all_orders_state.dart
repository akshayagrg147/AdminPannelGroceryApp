
import 'package:adminpannelgrocery/models/AllOrders.dart';

import '../repositories/Modal/AddedItemResponse.dart';
import '../repositories/Modal/AllProducts.dart';
import '../repositories/Modal/HomeProduct.dart';

abstract class AllOrderState{
}
class AllOrderLoadingState extends AllOrderState {

}
class AllOrderLoadedState extends AllOrderState {
  List<OrderData>? itemData;
  AllOrderLoadedState(this.itemData);


}

class AllLoadingMoreState extends AllOrderState {
  final List<OrderData> oldPosts;
  final bool isFirstFetch;

  AllLoadingMoreState(this.oldPosts, {this.isFirstFetch=false});
}
class AllOrderErrorState extends AllOrderState {
  final String error;
  AllOrderErrorState(this.error);

}

