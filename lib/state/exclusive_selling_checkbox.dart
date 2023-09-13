
import '../models/AddProductResponse.dart';
import '../repositories/Modal/AddedItemResponse.dart';
import '../repositories/Modal/AllProducts.dart';
import '../repositories/Modal/HomeProduct.dart';

abstract class ExclusiveCheckBoxState{
}

class ExclusiveCheckBoxLoadingState  extends ExclusiveCheckBoxState {

}
class ExclusiveCheckBoxInitialState  extends ExclusiveCheckBoxState {

}
class ExclusiveCheckBoxLoadedState extends ExclusiveCheckBoxState {
  final AddProductResponse products;
  ExclusiveCheckBoxLoadedState(this.products);


}
class ExclusiveCheckBoxErrorState  extends ExclusiveCheckBoxState {
  final String error;
  ExclusiveCheckBoxErrorState(this.error);

}


