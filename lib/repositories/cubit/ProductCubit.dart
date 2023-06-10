


import 'package:adminpannelgrocery/repositories/cubit/product_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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



  void fetchPosts() async {
    try {
      List<ItemData> posts = await postRepository.fetchPosts();
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