
import '../repositories/Modal/AddedItemResponse.dart';
import '../repositories/Modal/AllProducts.dart';
import '../repositories/Modal/HomeProduct.dart';

abstract class AllProductState{
}
class AllProductLoadingState extends AllProductState {

}
class AllProductLoadedState extends AllProductState {
  final List<ItemData> products;
  AllProductLoadedState(this.products);


}
class AllProductMoreState extends AllProductState {
  final List<ItemData> productItems;
  final bool isFirstFetch;

  AllProductMoreState(this.productItems, {this.isFirstFetch=false});
}
class AllProductErrorState extends AllProductState {
  final String error;
  AllProductErrorState(this.error);

}

