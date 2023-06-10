
import '../Modal/AddedItemResponse.dart';
import '../Modal/AllProducts.dart';
import '../Modal/HomeProduct.dart';

abstract class ProductState{
}
class ProductLoadingState extends ProductState{

}
class ProductLoadedState extends ProductState{
  final List<ItemData> products;
  ProductLoadedState(this.products);


}
class ProductErrorState extends ProductState{
  final String error;
ProductErrorState(this.error);

}

