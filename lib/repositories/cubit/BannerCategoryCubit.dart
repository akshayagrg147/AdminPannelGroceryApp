
import 'package:adminpannelgrocery/repositories/Modal/banner_category_modal.dart';


import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../state/all_banner_state.dart';

import '../api/ProductRepository.dart';

class BannerCategoryCubit extends Cubit<AllBannerState> {
  BannerCategoryCubit() : super(AllBannerLoadingState());

  ProductRepository postRepository = ProductRepository();

  void fetchBannerCategory() async {
    try {
      BannerCategoryModal posts = await postRepository.fetchBannerCategory();
      emit(AllBannerLoadedState(posts));
    } on DioError catch (ex) {
      print('category wise data __ ${ex.message}');
      if (ex.type == DioErrorType.other) {
        emit(AllBannerErrorState(
            "Can't fetch posts, please check your internet connection!"));
      } else {
        print('category wise data __ ${ex.message}');
        emit(AllBannerErrorState(ex.type.toString()));
      }
    }
  }

  void clearCategory() {
    emit(AllBannerLoadingState());
  }

  void selectCatgory(String value, int indexValue) {
    emit(SelectBannerCategoryValue(value, indexValue));
  }

  void deleteImage(String fileId) async {
    await postRepository.deleteImageKit(fileId);
  }
}

class SelectBannerCategoryValue extends AllBannerState {
  final String value;
  final int index;

  SelectBannerCategoryValue(this.value, this.index);
}
