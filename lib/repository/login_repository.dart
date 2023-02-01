


import 'package:adminpannelgrocery/model/LoginResponseBody.dart';



abstract class LoginRepository {
  Future<LoginResponseBody> validateUserIdPassword(Map body);

}
