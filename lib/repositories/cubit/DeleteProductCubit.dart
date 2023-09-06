


import 'package:adminpannelgrocery/models/AddProductResponse.dart';
import 'package:adminpannelgrocery/state/all_product_state.dart';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/productScreenModal.dart';
import '../../state/add_product_state.dart';
import '../../state/delete_product_state.dart';
import '../Modal/AddedItemResponse.dart';
import '../Modal/AllProducts.dart';
import '../Modal/AllProducts.dart';
import '../Modal/AllProducts.dart';
import '../Modal/HomeProduct.dart';
import '../api/ProductRepository.dart';

class DeleteProductCubit extends Cubit<DeleteProductState> {
  DeleteProductCubit() : super( DeleteProductLoadingState() );

  ProductRepository postRepository = ProductRepository();


void deleteProduct(String productId) async {
  try {

    AddProductResponse posts = await postRepository.deleteProduct(productId);
    emit(DeleteProductLoadedState(posts));
  }
  on DioError catch(ex) {
    if(ex.type == DioErrorType.other) {
      emit( DeleteProductErrorState("Can't fetch posts, please check your internet connection!") );
    }
    else {
      emit( DeleteProductErrorState(ex.type.toString()) );
    }
  }
}

}



