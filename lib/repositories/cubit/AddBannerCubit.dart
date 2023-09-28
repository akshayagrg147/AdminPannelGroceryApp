import 'package:adminpannelgrocery/models/AddProductResponse.dart';
import 'package:adminpannelgrocery/state/add_category_state.dart';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/productScreenModal.dart';
import '../../state/add_banner_category_state.dart';
import '../../state/add_product_state.dart';
import '../Modal/add_bannercategory_modal.dart';
import '../Modal/add_category_modal.dart';
import '../api/ProductRepository.dart';

class AddBannerCubit extends Cubit<AddBannerCategoryState> {
  AddBannerCubit() : super(AddBannerInitialState());

  ProductRepository postRepository = ProductRepository();

  void addBannerCategory(
      List<SubBannerCategoryList> list,
      String banner1,
      String bannerImage1,
      String banner2,
      String bannerImage2,
      String banner3,
      String bannerImage3) async {
    try {
      emit(AddBannerLoadingState());
      AddProductResponse posts = await postRepository.addBannerCategory(banner1,
          bannerImage1, banner2, bannerImage2, banner3, bannerImage3, list);
      emit(AddBannerLoadedState(posts));
    } on DioError catch (ex) {
      if (ex.type == DioErrorType.other) {
        emit(AddBannerErrorState(
            "Can't fetch posts, please check your internet connection!"));
      } else {
        emit(AddBannerErrorState(ex.type.toString()));
      }
    }
  }

  void updateCategory(
      List<SubBannerCategoryList> list,
      String banner1,
      String bannerImage1,
      String banner2,
      String bannerImage2,
      String banner3,
      String bannerImage3) async {
    try {
      emit(AddBannerLoadingState());
      AddProductResponse posts = await postRepository.updateBannerCategory(
          banner1,
          bannerImage1,
          banner2,
          bannerImage2,
          banner3,
          bannerImage3,
          list);
      emit(AddBannerLoadedState(posts));
    } on DioError catch (ex) {
      if (ex.type == DioErrorType.other) {
        emit(AddBannerErrorState(
            "Can't fetch posts, please check your internet connection!"));
      } else {
        emit(AddBannerErrorState(ex.type.toString()));
      }
    }
  }
}
