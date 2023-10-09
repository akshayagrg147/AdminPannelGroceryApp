import 'package:adminpannelgrocery/models/AddProductResponse.dart';


import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/AllOrders.dart';

import '../../sharedpreference/PreferencesUtil.dart';

import '../../state/add_order_state.dart';

import '../api/ProductRepository.dart';

class UpdateOrderStatusCubit extends Cubit<AddOrderState> {
  UpdateOrderStatusCubit() : super(AddOrderInitialState());

  ProductRepository postRepository = ProductRepository();

  void updateOrderStatus(OrderData formData) async {
    try {
      formData.pincode = await PreferencesUtil.getString('pincode');
      AddProductResponse posts = await postRepository.updateStatus(formData);
      emit(AddOrderLoadedState(posts));
    } on DioError catch (ex) {
      if (ex.type == DioErrorType.other) {
        emit(AddOrderErrorState(
            "Can't fetch posts, please check your internet connection!"));
      } else {
        emit(AddOrderErrorState(ex.type.toString()));
      }
    }
  }
  void resetState() {
    print('state_is resetState AddOrderLoadedState');
    emit(AddOrderInitialState());
  }
}
