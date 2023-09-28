import '../models/AddProductResponse.dart';
import '../repositories/Modal/AddedItemResponse.dart';
import '../repositories/Modal/AllProducts.dart';
import '../repositories/Modal/HomeProduct.dart';

abstract class DeleteBannerState {}

class DeleteBannerLoadingState extends DeleteBannerState {}

class DeleteBannerInitialState extends DeleteBannerState {}

class DeleteBannerLoadedState extends DeleteBannerState {
  final AddProductResponse products;

  DeleteBannerLoadedState(this.products);
}

class DeleteBannerErrorState extends DeleteBannerState {
  final String error;

  DeleteBannerErrorState(this.error);
}
