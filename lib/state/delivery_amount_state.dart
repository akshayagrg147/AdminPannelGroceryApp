import '../models/AddProductResponse.dart';
import '../repositories/Modal/AddedItemResponse.dart';
import '../repositories/Modal/AllProducts.dart';
import '../repositories/Modal/HomeProduct.dart';

abstract class DeliveryAmountState {}

class DeliveryAmountLoadingState extends DeliveryAmountState {}

class DeliveryAmountInitialState extends DeliveryAmountState {}

class DeliveryAmountLoadedState extends DeliveryAmountState {
  final AddProductResponse products;

  DeliveryAmountLoadedState(this.products);
}

class DeliveryAmountErrorState extends DeliveryAmountState {
  final String error;

  DeliveryAmountErrorState(this.error);
}
