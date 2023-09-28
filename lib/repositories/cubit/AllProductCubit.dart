import 'package:adminpannelgrocery/models/AddProductResponse.dart';
import 'package:adminpannelgrocery/models/AllOrders.dart';
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

class AllProductCubit extends Cubit<AllProductState> {
  int skip = 0;
  AllProductCubit() : super(AllProductLoadingState());

  ProductRepository postRepository = ProductRepository();



  void loadProducts() {
    if (state is AllProductMoreState) return;
    final currentState = state;
    List<ItemData> oldOrders = [];

    if (currentState is AllProductLoadedState) {
      oldOrders = List.from(currentState.products ?? []);
    }

    emit(AllProductMoreState(oldOrders, isFirstFetch: skip == 0));

    postRepository.fetchProducts(skip, 10).then((newOrders) {
      skip=skip+10;

      final List<ItemData> orders = List.from(oldOrders);
      orders.addAll(newOrders.itemData!);
      print("order_lengt_is ${orders.length}");

      emit(AllProductLoadedState(orders));
    });
  }


  void callProductSearch(String query)async {
    try {
      emit(AllProductLoadingState());
      AllProducts products = await postRepository.fetchSearchProductWise(query);
      print('category wise data success ${products.itemData}');
      emit(AllProductLoadedState(products.itemData??[]));
    }
    on DioError catch(ex) {
      print('category wise data __ ${ex.message}');
      if(ex.type == DioErrorType.other) {
        emit( AllProductErrorState("Can't fetch posts, please check your internet connection!") );
      }
      else {
        print('category wise data __ ${ex.message}');
        emit( AllProductErrorState(ex.type.toString()) );
      }
    }
  }

  // void fetchProducts() async {
  //   try {
  //     AllProducts posts = await postRepository.fetchProducts();
  //     emit(AllProductLoadedState(posts.itemData??[]));
  //   } on DioError catch (ex) {
  //     if (ex.type == DioErrorType.other) {
  //       emit(AllProductErrorState(
  //           "Can't fetch posts, please check your internet connection!"));
  //     } else {
  //       emit(AllProductErrorState(ex.type.toString()));
  //     }
  //   }
  // }

  void passFilterData(List<ItemData>? list) {
    emit(AllProductLoadedState(
        list!));
  }
  void clearProducts() {
    skip=0;
    emit(AllProductLoadingState());
  }
}
