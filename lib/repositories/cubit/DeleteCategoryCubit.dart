import 'package:adminpannelgrocery/models/AddProductResponse.dart';


import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../state/delete_product_state.dart';

import '../api/ProductRepository.dart';

class DeleteCategoryCubit extends Cubit<DeleteProductState> {
  DeleteCategoryCubit(super.initialState);

  // DeleteCategoryCubit() : super( DeleteProductInitialState() );

  ProductRepository postRepository = ProductRepository();

  Future<void> deleteCategory(String categoryId) async {
    try {
      print("delete_category_id $categoryId");
      AddProductResponse posts =
          await postRepository.deleteCategory(categoryId);
      emit(DeleteProductLoadedState(posts));
    } on DioError catch (ex) {
      if (ex.type == DioErrorType.other) {
        emit(DeleteProductErrorState(
            "Can't fetch posts, please check your internet connection!"));
      } else {
        emit(DeleteProductErrorState(ex.type.toString()));
      }
    }
  }

  void resetState() {
    emit(DeleteProductInitialState());
  }
}
