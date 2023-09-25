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
    List<ItemData> products = [];
    print("stateis from cubit ${currentState}");
    if (currentState is AllProductLoadedState) {
      products = List.from(currentState.products ?? []);
    }
    print("itemcountis from cubit ${products.length}");
   emit(AllProductMoreState(products, isFirstFetch: skip == 0));

    postRepository.fetchProducts(skip, 10).then((newOrders) {
      skip=skip+10;

      final List<ItemData> product = List.from(products);
      product.addAll(newOrders.itemData!);

      emit(AllProductLoadedState(product));
    });
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
    emit(AllProductLoadingState());
  }
}
