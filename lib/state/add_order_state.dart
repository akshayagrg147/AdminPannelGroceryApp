
import '../models/AddProductResponse.dart';
import '../repositories/Modal/AddedItemResponse.dart';
import '../repositories/Modal/AllProducts.dart';
import '../repositories/Modal/HomeProduct.dart';

abstract class AddOrderState{
}
class  AddOrderLoadingState  extends AddOrderState {

}
class  AddOrderInitialState  extends AddOrderState {

}
class  AddOrderLoadedState extends AddOrderState {
  final AddProductResponse products;
  AddOrderLoadedState(this.products);


}
class  AddOrderErrorState  extends AddOrderState {
  final String error;
  AddOrderErrorState(this.error);

}


