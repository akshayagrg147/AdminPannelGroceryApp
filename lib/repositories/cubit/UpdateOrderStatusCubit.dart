


import 'package:adminpannelgrocery/models/AddProductResponse.dart';
import 'package:adminpannelgrocery/repositories/Modal/CouponFormData.dart';
import 'package:adminpannelgrocery/state/add_category_state.dart';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/AllOrders.dart';
import '../../models/productScreenModal.dart';
import '../../state/add_coupon_state.dart';
import '../../state/add_order_state.dart';
import '../../state/add_product_state.dart';
import '../Modal/add_category_modal.dart';
import '../api/ProductRepository.dart';

class UpdateOrderStatusCubit extends Cubit<AddOrderState> {
  UpdateOrderStatusCubit() : super( AddOrderInitialState() );

  ProductRepository postRepository = ProductRepository();


void updateOrderStatus(OrderData formData) async {
  try {

    AddProductResponse posts = await postRepository.updateStatus(formData);
    emit(AddOrderLoadedState(posts));
  }
  on DioError catch(ex) {
    if(ex.type == DioErrorType.other) {
      emit( AddOrderErrorState("Can't fetch posts, please check your internet connection!") );
    }
    else {
      emit( AddOrderErrorState(ex.type.toString()) );
    }
  }
}

}




