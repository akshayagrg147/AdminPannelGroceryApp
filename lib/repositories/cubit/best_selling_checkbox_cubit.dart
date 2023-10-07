import 'package:adminpannelgrocery/models/AddProductResponse.dart';

import 'package:adminpannelgrocery/state/best_selling_checkbox.dart';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../Modal/AllProducts.dart';

import '../api/ProductRepository.dart';

class BestSellingCheckBoxCubit extends Cubit<BestSellingCheckBoxState> {
  BestSellingCheckBoxCubit() : super(BestSellingCheckBoxInitialState());

  // DeleteCategoryCubit() : super( DeleteProductInitialState() );

  ProductRepository postRepository = ProductRepository();

  Future<void> updateBestSelling(ItemData data) async {
    try {
      AddProductResponse posts =
          await postRepository.updateSellingCheckBox(data);
      emit(BestSellingCheckBoxLoadedState(posts));
    } on DioError catch (ex) {
      if (ex.type == DioErrorType.other) {
        emit(BestSellingCheckBoxErrorState(
            "Can't fetch posts, please check your internet connection!"));
      } else {
        emit(BestSellingCheckBoxErrorState(ex.type.toString()));
      }
    }
  }

  void resetState() {
    emit(BestSellingCheckBoxInitialState());
  }
}
