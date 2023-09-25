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
  AllProductCubit() : super(AllProductLoadingState()) {

  }

  ProductRepository postRepository = ProductRepository();

  void fetchProducts() async {
    try {
      AllProducts posts = await postRepository.fetchProducts();
      emit(AllProductLoadedState(posts));
    } on DioError catch (ex) {
      if (ex.type == DioErrorType.other) {
        emit(AllProductErrorState(
            "Can't fetch posts, please check your internet connection!"));
      } else {
        emit(AllProductErrorState(ex.type.toString()));
      }
    }
  }

  void passFilterData(List<ItemData>? list) {
    emit(AllProductLoadedState(
        AllProducts(itemData: list, statusCode: 200, message: "")));
  }
  void clearProducts() {
    emit(AllProductLoadingState());
  }
}
