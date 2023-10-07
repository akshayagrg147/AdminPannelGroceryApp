import 'package:adminpannelgrocery/models/AddProductResponse.dart';
import 'package:adminpannelgrocery/state/delete_banner_state.dart';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../api/ProductRepository.dart';

class DeleteBannerCubit extends Cubit<DeleteBannerState> {
  DeleteBannerCubit() : super(DeleteBannerLoadingState());

  ProductRepository postRepository = ProductRepository();

  void deleteBannerCategory(String productId) async {
    try {
      AddProductResponse posts =
          await postRepository.deleteBannerCategory(productId);
      emit(DeleteBannerLoadedState(posts));
    } on DioError catch (ex) {
      if (ex.type == DioErrorType.other) {
        emit(DeleteBannerErrorState(
            "Can't fetch posts, please check your internet connection!"));
      } else {
        emit(DeleteBannerErrorState(ex.type.toString()));
      }
    }
  }

  void resetState() {
    emit(DeleteBannerInitialState());
  }
}
