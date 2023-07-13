
import 'package:adminpannelgrocery/models/AllOrders.dart';

import '../repositories/Modal/AddedItemResponse.dart';
import '../repositories/Modal/AllProducts.dart';
import '../repositories/Modal/HomeProduct.dart';
import '../repositories/Modal/product_category_modal.dart';

abstract class AllCategoryState{
}
class AllCategoryLoadingState extends AllCategoryState {

}
class AllCategoryLoadedState extends AllCategoryState {
  ProductCategoryModal category;
  AllCategoryLoadedState(this.category);


}

class AllCategoryErrorState extends AllCategoryState {
  final String error;
  AllCategoryErrorState(this.error);

}

class SelectedCategoryValue extends AllCategoryState {
  final String value;
  final int index;
  SelectedCategoryValue(this.value,this.index);
}

