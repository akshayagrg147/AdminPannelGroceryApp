import 'package:adminpannelgrocery/models/AddProductResponse.dart';
import 'package:adminpannelgrocery/models/AllOrders.dart';
import 'package:adminpannelgrocery/repositories/Modal/allCouponsResponse.dart';
import 'package:adminpannelgrocery/state/allCouponsState.dart';
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

class AllCouponsCubit extends Cubit<AllCouponsState> {
  AllCouponsCubit() : super(AllCouponsInitialState()) {
    fetchAllCoupons();

  }

  ProductRepository postRepository = ProductRepository();

  void fetchAllCoupons() async {
    try {
      allCouponsResponse posts = await postRepository.fetchAllCoupons();
      emit(AllCouponsLoadedState(posts));
    } on DioError catch (ex) {
      if (ex.type == DioErrorType.other) {
        emit(AllCouponsErrorState(
            "Can't fetch posts, please check your internet connection!"));
      } else {
        emit(AllCouponsErrorState(ex.type.toString()));
      }
    }
  }


}
