


import 'package:adminpannelgrocery/models/AddProductResponse.dart';
import 'package:adminpannelgrocery/repositories/cubit/product_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/productScreenModal.dart';
import '../Modal/AddedItemResponse.dart';
import '../Modal/AllProducts.dart';
import '../Modal/AllProducts.dart';
import '../Modal/AllProducts.dart';
import '../Modal/AllProducts.dart';
import '../Modal/HomeProduct.dart';
import '../api/ProductRepository.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super( ProductLoadingState() ) {
    fetchPosts();
  }

  ProductRepository postRepository = ProductRepository();


void addProduct(ProductScreenModal object) async {
  try {

    AddProductResponse posts = await postRepository.addProduct(object);
    emit(ProductLoadedState(posts));
  }
  on DioError catch(ex) {
    if(ex.type == DioErrorType.other) {
      emit( ProductErrorState("Can't fetch posts, please check your internet connection!") );
    }
    else {
      emit( ProductErrorState(ex.type.toString()) );
    }
  }
}
  void fetchPosts() async {
    try {

      AllProducts posts = await postRepository.fetchPosts();
      emit(ProductLoadedState(posts));
    }
    on DioError catch(ex) {
      if(ex.type == DioErrorType.other) {
        emit( ProductErrorState("Can't fetch posts, please check your internet connection!") );
      }
      else {
        emit( ProductErrorState(ex.type.toString()) );
      }
    }
  }
}