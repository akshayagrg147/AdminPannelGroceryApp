
import 'package:adminpannelgrocery/repositories/Modal/product_category_modal.dart';


import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../state/all_category_state.dart';

import '../api/ProductRepository.dart';

class ProductCategoryCubit extends Cubit<AllCategoryState> {
  ProductCategoryCubit() : super(AllCategoryLoadingState());

  ProductRepository postRepository = ProductRepository();

  void selectCatgory(String value, int indexValue) {
    emit(SelectedCategoryValue(value, indexValue));
  }

  void fetchCategory() async {
    try {
      ProductCategoryModal posts = await postRepository.fetchCategory();
      print('category wise data ${posts.itemData}');
      emit(AllCategoryLoadedState(posts));
    } on DioError catch (ex) {
      print('category wise data ${ex.message}');
      if (ex.type == DioErrorType.other) {
        emit(AllCategoryErrorState(
            "Can't fetch posts, please check your internet connection!"));
      } else {
        print('category wise data ${ex.message}');
        emit(AllCategoryErrorState(ex.type.toString()));
      }
    }
  }

  void clearCategory() {
    emit(AllCategoryLoadingState());
  }
}
