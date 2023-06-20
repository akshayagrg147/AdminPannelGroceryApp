
import '../models/AddProductResponse.dart';
import '../repositories/Modal/AddedItemResponse.dart';
import '../repositories/Modal/AllProducts.dart';
import '../repositories/Modal/HomeProduct.dart';

abstract class DeleteProductState{
}
class DeleteProductLoadingState  extends DeleteProductState {

}
class DeleteProductLoadedState extends DeleteProductState {
  final AddProductResponse products;
  DeleteProductLoadedState(this.products);


}
class DeleteProductErrorState  extends DeleteProductState {
  final String error;
  DeleteProductErrorState(this.error);

}


