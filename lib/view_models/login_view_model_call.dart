



import 'package:adminpannelgrocery/model/LoginResponseBody.dart';

import '../repository/login_repository.dart';
import 'login_view_model.dart';

class LoginViewModalCall {
  final String title = "All Posts";
  LoginRepository? postsRepository;
  LoginViewModalCall({this.postsRepository});

  Future<LoginViewModel> validateIdPassword(Map body) async {
    LoginResponseBody data = await postsRepository!.validateUserIdPassword(body);
    return  LoginViewModel(modal:data);
  }
}
