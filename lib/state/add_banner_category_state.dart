
import 'package:adminpannelgrocery/models/AllOrders.dart';

import '../models/AddProductResponse.dart';
import '../repositories/Modal/AddedItemResponse.dart';
import '../repositories/Modal/AllProducts.dart';
import '../repositories/Modal/HomeProduct.dart';
import '../repositories/Modal/add_bannercategory_modal.dart';
import '../repositories/Modal/product_category_modal.dart';

abstract class AddBannerCategoryState{
}
class AddBannerInitialState extends AddBannerCategoryState {

}
class AddBannerLoadingState extends AddBannerCategoryState {

}
class AddBannerLoadedState extends AddBannerCategoryState {
  AddProductResponse category;
  AddBannerLoadedState(this.category);


}

class AddBannerErrorState extends AddBannerCategoryState {
  final String error;
  AddBannerErrorState(this.error);

}

class SelectedCategoryValue extends AddBannerCategoryState {
  final String value;
  final int index;
  SelectedCategoryValue(this.value,this.index);
}

