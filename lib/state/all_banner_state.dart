
import 'package:adminpannelgrocery/models/AllOrders.dart';

import '../repositories/Modal/AddedItemResponse.dart';
import '../repositories/Modal/AllProducts.dart';
import '../repositories/Modal/HomeProduct.dart';
import '../repositories/Modal/banner_category_modal.dart';
import '../repositories/Modal/product_category_modal.dart';

abstract class AllBannerState{
}
class AllBannerInitialState extends AllBannerState {

}
class AllBannerLoadingState extends AllBannerState {

}
class AllBannerLoadedState extends AllBannerState {
  BannerCategoryModal category;
  AllBannerLoadedState(this.category);


}

class AllBannerErrorState extends AllBannerState {
  final String error;
  AllBannerErrorState(this.error);

}

class SelectCategoryValue extends AllBannerState {
  final String value;
  final int index;
  SelectCategoryValue(this.value,this.index);
}

