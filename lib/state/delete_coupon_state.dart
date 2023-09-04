
import '../models/AddProductResponse.dart';
import '../repositories/Modal/AddedItemResponse.dart';
import '../repositories/Modal/AllProducts.dart';
import '../repositories/Modal/HomeProduct.dart';

abstract class DeleteCouponState{
}

class DeleteCouponLoadingState  extends DeleteCouponState {

}
class DeleteCouponInitialState  extends DeleteCouponState {

}
class DeleteCouponLoadedState extends DeleteCouponState {
  final AddProductResponse products;
  DeleteCouponLoadedState(this.products);


}
class DeleteCouponErrorState  extends DeleteCouponState {
  final String error;
  DeleteCouponErrorState(this.error);

}


