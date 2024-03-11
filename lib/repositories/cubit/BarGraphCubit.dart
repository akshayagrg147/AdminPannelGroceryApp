
import 'package:adminpannelgrocery/repositories/Modal/RecentOrderCountResponse.dart';
import 'package:adminpannelgrocery/state/recent_order_count_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../state/all_admin_order_state.dart';
import '../Modal/BarGraphOrderValue.dart';
import '../api/ProductRepository.dart';

class BarGraphCubit extends Cubit<AllAdminOrderState> {
  BarGraphCubit() : super(AllAdminOrderLoadingState()) {}

  ProductRepository postRepository = ProductRepository();

  void fetchAllOrderCount(String startDate1,String endDate1) async {
    try {
      BarGraphResponse orders =
          await postRepository.fetchOrderGraphValue(startDate1,endDate1);
      emit(AllAdminOrderLoadedState(orders));
    } on DioError catch (ex) {
      print("corsage" + ex.message);
      if (ex.type == DioErrorType.other) {
        emit(AllAdminOrderErrorState(
            "Can't fetch posts, please check your internet connection!"));
      } else {
        emit(AllAdminOrderErrorState(ex.type.toString()));
      }
    }




  }
}
