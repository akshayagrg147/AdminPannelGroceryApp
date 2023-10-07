
import 'package:adminpannelgrocery/repositories/Modal/UserResponse.dart';


import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../state/all_user_state.dart';

import '../api/ProductRepository.dart';

class UserResponseCubit extends Cubit<AllUserState> {
  UserResponseCubit() : super(AllUserLoadingState()) {
    fetchUsers();
  }

  ProductRepository postRepository = ProductRepository();

  void fetchUsers() async {
    try {
      UserResponse posts = await postRepository.userResponse();
      emit(AllUserLoadedState(posts));
    } on DioError catch (ex) {
      if (ex.type == DioErrorType.other) {
        emit(AllUserErrorState(
            "Can't fetch posts, please check your internet connection!"));
      } else {
        emit(AllUserErrorState(ex.type.toString()));
      }
    }
  }
}
