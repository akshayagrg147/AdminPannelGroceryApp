import '../models/AddProductResponse.dart';
import '../repositories/Modal/AddedItemResponse.dart';
import '../repositories/Modal/AllProducts.dart';
import '../repositories/Modal/HomeProduct.dart';

abstract class AddProductState {}

class AddProductLoadingState extends AddProductState {}

class AddProductInitialState extends AddProductState {}

class AddProductLoadedState extends AddProductState {
  final AddProductResponse products;

  AddProductLoadedState(this.products);
}

class AddProductErrorState extends AddProductState {
  final String error;

  AddProductErrorState(this.error);
}
