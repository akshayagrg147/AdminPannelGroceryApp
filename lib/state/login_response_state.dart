import 'package:adminpannelgrocery/models/login_response.dart';

import '../models/AddProductResponse.dart';
import '../repositories/Modal/AddedItemResponse.dart';
import '../repositories/Modal/AllProducts.dart';
import '../repositories/Modal/HomeProduct.dart';

abstract class LoginResponseState {}

class LoginResponseLoadingState extends LoginResponseState {}

class LoginResponseInitialState extends LoginResponseState {}

class LoginResponseLoadedState extends LoginResponseState {
  final LoginResponse response;

  LoginResponseLoadedState(this.response);
}

class LoginResponseErrorState extends LoginResponseState {
  final String error;

  LoginResponseErrorState(this.error);
}
