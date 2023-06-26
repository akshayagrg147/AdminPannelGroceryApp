
import 'package:adminpannelgrocery/models/AllOrders.dart';

import '../repositories/Modal/AddedItemResponse.dart';
import '../repositories/Modal/AllProducts.dart';
import '../repositories/Modal/HomeProduct.dart';

abstract class AllOrderState{
}
class AllOrderLoadingState extends AllOrderState {

}
class AllOrderLoadedState extends AllOrderState {
  final AllOrders orders;
  AllOrderLoadedState(this.orders);


}
class AllOrderErrorState extends AllOrderState {
  final String error;
  AllOrderErrorState(this.error);

}

