


import 'package:adminpannelgrocery/models/AddProductResponse.dart';
import 'package:adminpannelgrocery/state/all_product_state.dart';
import 'package:adminpannelgrocery/state/delete_banner_state.dart';

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

class DeleteBannerCubit extends Cubit<DeleteBannerState> {
  DeleteBannerCubit() : super( DeleteBannerLoadingState() );

  ProductRepository postRepository = ProductRepository();


void deleteProduct(String productId) async {
  try {

    AddProductResponse posts = await postRepository.deleteProduct(productId);
    emit(DeleteBannerLoadedState(posts));
  }
  on DioError catch(ex) {
    if(ex.type == DioErrorType.other) {
      emit( DeleteBannerErrorState("Can't fetch posts, please check your internet connection!") );
    }
    else {
      emit( DeleteBannerErrorState(ex.type.toString()) );
    }
  }
}

}



