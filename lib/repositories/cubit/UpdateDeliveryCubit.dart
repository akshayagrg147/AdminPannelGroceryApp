import 'package:adminpannelgrocery/models/AddProductResponse.dart';


import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../state/delivery_amount_state.dart';

import '../api/ProductRepository.dart';

class UpdateDeliveryCubit extends Cubit<DeliveryAmountState> {
  UpdateDeliveryCubit() : super(DeliveryAmountInitialState());

  ProductRepository postRepository = ProductRepository();

  void submitFreeDeliveryAmount(String amount) async {
    try {
      AddProductResponse orders =
          await postRepository.updateDeliveryAmount(amount);
      emit(DeliveryAmountLoadedState(orders));
    } on DioError catch (ex) {
      print("corsage" + ex.message);
      if (ex.type == DioErrorType.other) {
        emit(DeliveryAmountErrorState(
            "Can't fetch posts, please check your internet connection!"));
      } else {
        emit(DeliveryAmountErrorState(ex.type.toString()));
      }
    }
  }
}
