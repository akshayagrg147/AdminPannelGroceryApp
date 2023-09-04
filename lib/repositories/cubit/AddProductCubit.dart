


import 'package:adminpannelgrocery/models/AddProductResponse.dart';
import 'package:adminpannelgrocery/state/all_product_state.dart';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/productScreenModal.dart';
import '../../state/add_product_state.dart';
import '../Modal/AddedItemResponse.dart';
import '../Modal/AllProducts.dart';
import '../Modal/AllProducts.dart';
import '../Modal/AllProducts.dart';
import '../Modal/HomeProduct.dart';
import '../api/ProductRepository.dart';

class ProductCubit extends Cubit<AddProductState> {
  ProductCubit() : super( AddProductInitialState() );

  ProductRepository postRepository = ProductRepository();


void addProduct(ProductScreenModal object) async {
  try {

    AddProductResponse posts = await postRepository.addProduct(object);
    emit(AddProductLoadedState(posts));
  }
  on DioError catch(ex) {
    if(ex.type == DioErrorType.other) {
      emit( AddProductErrorState("Can't fetch posts, please check your internet connection!") );
    }
    else {
      emit( AddProductErrorState(ex.type.toString()) );
    }
  }
}

}

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit() : super( AddProductInitialState() );

  ProductRepository postRepository = ProductRepository();


  void addProduct(ProductScreenModal object) async {
    try {

      AddProductResponse posts = await postRepository.addProduct(object);
      emit(AddProductLoadedState(posts));
    }
    on DioError catch(ex) {
      if(ex.type == DioErrorType.other) {
        emit( AddProductErrorState("Can't fetch posts, please check your internet connection!") );
      }
      else {
        emit( AddProductErrorState(ex.type.toString()) );
      }
    }
  }
  void update(ProductScreenModal object) async {
    try {

      AddProductResponse posts = await postRepository.updateProduct(object);
      emit(AddProductLoadedState(posts));
    }
    on DioError catch(ex) {
      if(ex.type == DioErrorType.other) {
        emit( AddProductErrorState("Can't fetch posts, please check your internet connection!") );
      }
      else {
        emit( AddProductErrorState(ex.type.toString()) );
      }
    }
  }

  void clearProducts() {
    emit(AddProductInitialState());
  }

}


