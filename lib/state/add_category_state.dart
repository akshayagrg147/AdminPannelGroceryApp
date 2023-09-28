import '../models/AddProductResponse.dart';
import '../repositories/Modal/AddedItemResponse.dart';
import '../repositories/Modal/AllProducts.dart';
import '../repositories/Modal/HomeProduct.dart';

abstract class AddCategoryState {}

class AddCategoryLoadingState extends AddCategoryState {}

class AddCategoryInitialState extends AddCategoryState {}

class AddCategoryLoadedState extends AddCategoryState {
  final AddProductResponse products;

  AddCategoryLoadedState(this.products);
}

class AddCategoryErrorState extends AddCategoryState {
  final String error;

  AddCategoryErrorState(this.error);
}
