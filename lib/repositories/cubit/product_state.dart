
import '../Modal/AddedItemResponse.dart';
import '../Modal/AllProducts.dart';
import '../Modal/HomeProduct.dart';

abstract class ProductState<T>{
}
class ProductLoadingState<T>  extends ProductState<T> {

}
class ProductLoadedState<T> extends ProductState<T> {
  final T products;
  ProductLoadedState(this.products);


}
class ProductErrorState<T>  extends ProductState<T> {
  final String error;
ProductErrorState(this.error);

}

