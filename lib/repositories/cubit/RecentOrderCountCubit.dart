
import 'package:adminpannelgrocery/repositories/Modal/RecentOrderCountResponse.dart';
import 'package:adminpannelgrocery/state/recent_order_count_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../api/ProductRepository.dart';

class RecentOrderCubit extends Cubit<RecentOrderCountState> {
  RecentOrderCubit() : super(RecentOrderCountLoadingState()) {}

  ProductRepository postRepository = ProductRepository();

  void fetchAllOrderCount() async {
    try {
      RecentOrderCountResponse orders =
          await postRepository.fetchRecentOrderCount();
      emit(RecentOrderCountLoadedState(orders));
    } on DioError catch (ex) {
      print("corsage" + ex.message);
      if (ex.type == DioErrorType.other) {
        emit(RecentOrderCountErrorState(
            "Can't fetch posts, please check your internet connection!"));
      } else {
        emit(RecentOrderCountErrorState(ex.type.toString()));
      }
    }
  }

  void updatefcmtoken(String? name, String? pincode, String? email, String? password, String? city, String? deliveryContactNumber, String? fcm_token, String? price,String ? sellerId) async{
    try {
      print("update_fcm called");
      await postRepository.updatefcmtokenRepo(name,pincode,email,password,city,deliveryContactNumber,fcm_token,price,sellerId);
      print("update_fcm called1");
    } on DioError catch (ex) {
      print("update_fcm called1${ex.message}");

    }

  }
}
