


import 'package:adminpannelgrocery/models/AddProductResponse.dart';
import 'package:adminpannelgrocery/models/AllOrders.dart';
import 'package:adminpannelgrocery/repositories/Modal/RecentOrderCountResponse.dart';
import 'package:adminpannelgrocery/state/all_orders_state.dart';
import 'package:adminpannelgrocery/state/all_product_state.dart';
import 'package:adminpannelgrocery/state/recent_order_count_state.dart';

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


class RecentOrderCubit extends Cubit<RecentOrderCountState> {
  RecentOrderCubit() : super( RecentOrderCountLoadingState() ) {

  }

  ProductRepository postRepository = ProductRepository();


  void fetchAllOrderCount() async {
    try {
      RecentOrderCountResponse orders = await postRepository.fetchRecentOrderCount();
      emit(RecentOrderCountLoadedState(orders));
    }
    on DioError catch(ex) {
      print("corsage"+ex.message);
      if(ex.type == DioErrorType.other) {
        emit( RecentOrderCountErrorState("Can't fetch posts, please check your internet connection!") );
      }
      else {
        emit( RecentOrderCountErrorState(ex.type.toString()) );
      }
    }
  }




}