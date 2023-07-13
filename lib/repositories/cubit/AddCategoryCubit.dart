


import 'package:adminpannelgrocery/models/AddProductResponse.dart';
import 'package:adminpannelgrocery/state/add_category_state.dart';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/productScreenModal.dart';
import '../../state/add_product_state.dart';
import '../Modal/add_category_modal.dart';
import '../api/ProductRepository.dart';

class AddCategoryCubit extends Cubit<AddCategoryState> {
  AddCategoryCubit() : super( AddCategoryInitialState() );

  ProductRepository postRepository = ProductRepository();


void addCategory(List<AddSubCategoryList> list,String category) async {
  try {
    emit(AddCategoryLoadingState());
    AddProductResponse posts = await postRepository.addCategory(category,list);
    emit(AddCategoryLoadedState(posts));
  }
  on DioError catch(ex) {
    if(ex.type == DioErrorType.other) {
      emit( AddCategoryErrorState("Can't fetch posts, please check your internet connection!") );
    }
    else {
      emit( AddCategoryErrorState(ex.type.toString()) );
    }
  }
}

}




