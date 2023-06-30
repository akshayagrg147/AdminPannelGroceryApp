


import 'package:adminpannelgrocery/models/AddProductResponse.dart';
import 'package:adminpannelgrocery/state/add_category_state.dart';
import 'package:adminpannelgrocery/state/login_response_state.dart';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/login_response.dart';
import '../../models/productScreenModal.dart';
import '../../state/add_product_state.dart';
import '../api/ProductRepository.dart';

class LoginResponseCubit extends Cubit<LoginResponseState> {
  LoginResponseCubit() : super( LoginResponseInitialState() );

  ProductRepository postRepository = ProductRepository();


void submitlogin(String email,String password) async {
  try {
    emit(LoginResponseLoadingState());
    LoginResponse response = await postRepository.login(email,password);
    emit(LoginResponseLoadedState(response));
  }
  on DioError catch(ex) {
    if(ex.type == DioErrorType.other) {
      emit( LoginResponseErrorState("Can't fetch posts, please check your internet connection!") );
    }
    else {
      emit( LoginResponseErrorState(ex.type.toString()) );
    }
  }
}

}




