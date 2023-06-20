
import '../repositories/Modal/AddedItemResponse.dart';
import '../repositories/Modal/AllProducts.dart';
import '../repositories/Modal/HomeProduct.dart';

abstract class AllProductState{
}
class AllProductLoadingState extends AllProductState {

}
class AllProductLoadedState extends AllProductState {
  final AllProducts products;
  AllProductLoadedState(this.products);


}
class AllProductErrorState extends AllProductState {
  final String error;
  AllProductErrorState(this.error);

}

