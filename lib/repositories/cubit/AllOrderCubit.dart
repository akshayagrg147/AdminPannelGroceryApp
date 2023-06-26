


import 'package:adminpannelgrocery/models/AddProductResponse.dart';
import 'package:adminpannelgrocery/models/AllOrders.dart';
import 'package:adminpannelgrocery/state/all_orders_state.dart';
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


class AllOrderCubit extends Cubit<AllOrderState> {
  AllOrderCubit() : super( AllOrderLoadingState() ) {
    fetchAllOrders();
  }

  ProductRepository postRepository = ProductRepository();


  void fetchAllOrders() async {
    try {
      AllOrders orders = await postRepository.fetchOrders();
      emit(AllOrderLoadedState(orders));
    }
    on DioError catch(ex) {
      if(ex.type == DioErrorType.other) {
        emit( AllOrderErrorState("Can't fetch posts, please check your internet connection!") );
      }
      else {
        emit( AllOrderErrorState(ex.type.toString()) );
      }
    }
  }




}