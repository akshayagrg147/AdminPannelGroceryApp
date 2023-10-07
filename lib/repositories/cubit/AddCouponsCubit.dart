import 'package:adminpannelgrocery/models/AddProductResponse.dart';
import 'package:adminpannelgrocery/repositories/Modal/CouponFormData.dart';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../state/add_coupon_state.dart';
import '../api/ProductRepository.dart';

class AddCouponsCubit extends Cubit<AddCouponState> {
  AddCouponsCubit() : super(AddCouponInitialState());

  ProductRepository postRepository = ProductRepository();

  void addCoupon(CouponFormData formData) async {
    try {
      AddProductResponse posts = await postRepository.addCoupons(formData);
      emit(AddCouponLoadedState(posts));
    } on DioError catch (ex) {
      if (ex.type == DioErrorType.other) {
        emit(AddCouponErrorState(
            "Can't fetch posts, please check your internet connection!"));
      } else {
        emit(AddCouponErrorState(ex.type.toString()));
      }
    }
  }
}
