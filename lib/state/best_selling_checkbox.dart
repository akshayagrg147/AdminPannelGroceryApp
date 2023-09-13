
import '../models/AddProductResponse.dart';
import '../repositories/Modal/AddedItemResponse.dart';
import '../repositories/Modal/AllProducts.dart';
import '../repositories/Modal/HomeProduct.dart';

abstract class BestSellingCheckBoxState{
}

class BestSellingCheckBoxLoadingState  extends BestSellingCheckBoxState {

}
class BestSellingCheckBoxInitialState  extends BestSellingCheckBoxState {

}
class BestSellingCheckBoxLoadedState extends BestSellingCheckBoxState {
  final AddProductResponse products;
  BestSellingCheckBoxLoadedState(this.products);


}
class BestSellingCheckBoxErrorState  extends BestSellingCheckBoxState {
  final String error;
  BestSellingCheckBoxErrorState(this.error);

}


