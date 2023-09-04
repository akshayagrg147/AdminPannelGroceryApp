


import 'package:adminpannelgrocery/models/AddProductResponse.dart';
import 'package:adminpannelgrocery/state/all_product_state.dart';
import 'package:adminpannelgrocery/state/delete_coupon_state.dart';

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

class DeleteCouponCubit extends Cubit<DeleteCouponState> {
  DeleteCouponCubit() : super( DeleteCouponInitialState() );

  ProductRepository postRepository = ProductRepository();


void deleteCoupon(String couponName) async {
  try {

    AddProductResponse posts = await postRepository.deleteCoupon(couponName);
    emit(DeleteCouponLoadedState(posts));
  }
  on DioError catch(ex) {
    if(ex.type == DioErrorType.other) {
      emit( DeleteCouponErrorState("Can't fetch posts, please check your internet connection!") );
    }
    else {
      emit( DeleteCouponErrorState(ex.type.toString()) );
    }
  }
}

}



