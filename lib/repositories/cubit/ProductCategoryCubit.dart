


import 'package:adminpannelgrocery/models/AddProductResponse.dart';
import 'package:adminpannelgrocery/models/AllOrders.dart';
import 'package:adminpannelgrocery/repositories/Modal/product_category_modal.dart';
import 'package:adminpannelgrocery/state/all_product_state.dart';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/productScreenModal.dart';
import '../../state/add_product_state.dart';
import '../../state/all_category_state.dart';
import '../Modal/AddedItemResponse.dart';
import '../Modal/AllProducts.dart';
import '../Modal/AllProducts.dart';
import '../Modal/AllProducts.dart';
import '../Modal/HomeProduct.dart';
import '../api/ProductRepository.dart';


class ProductCategoryCubit extends Cubit<AllCategoryState> {
  ProductCategoryCubit() : super( AllCategoryLoadingState() ) {
    fetchCategory();
  }

  ProductRepository postRepository = ProductRepository();

  void selectCatgory(String value) {
    emit(SelectedCategoryValue(value));
  }



  void fetchCategory() async {
    try {
      ProductCategoryModal posts = await postRepository.fetchCategory();
      print('category wise data ${posts.itemData}');
      emit(AllCategoryLoadedState(posts));
    }
    on DioError catch(ex) {
      if(ex.type == DioErrorType.other) {
        emit( AllCategoryErrorState("Can't fetch posts, please check your internet connection!") );
      }
      else {
        emit( AllCategoryErrorState(ex.type.toString()) );
      }
    }
  }








}