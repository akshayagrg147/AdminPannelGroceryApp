


import 'package:adminpannelgrocery/models/AddProductResponse.dart';
import 'package:adminpannelgrocery/state/all_product_state.dart';
import 'package:adminpannelgrocery/state/best_selling_checkbox.dart';
import 'package:adminpannelgrocery/state/exclusive_selling_checkbox.dart';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/productScreenModal.dart';
import '../../state/add_product_state.dart';
import '../../state/delete_product_state.dart';
import '../Modal/AddedItemResponse.dart';
import '../Modal/AllProducts.dart';
import '../Modal/AllProducts.dart';
import '../Modal/AllProducts.dart';
import '../Modal/HomeProduct.dart';
import '../api/ProductRepository.dart';

class ExclusiveCheckBoxCubit extends Cubit<ExclusiveCheckBoxState> {
  ExclusiveCheckBoxCubit() : super( ExclusiveCheckBoxInitialState() );

  // DeleteCategoryCubit() : super( DeleteProductInitialState() );

  ProductRepository postRepository = ProductRepository();


Future<void> updateExclusiveSelling(ItemData data) async {
  try {
    print("delete_category_id $data");
    AddProductResponse posts = await postRepository.updateSellingCheckBox(data);
    emit(ExclusiveCheckBoxLoadedState(posts));
  }
  on DioError catch(ex) {
    if(ex.type == DioErrorType.other) {
      emit( ExclusiveCheckBoxErrorState("Can't fetch posts, please check your internet connection!") );
    }
    else {
      emit( ExclusiveCheckBoxErrorState(ex.type.toString()) );
    }
  }
}
  void resetState() {
    emit(ExclusiveCheckBoxInitialState());
  }


}



