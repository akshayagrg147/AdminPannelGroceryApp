

import 'package:adminpannelgrocery/model/LoginResponseBody.dart';
import 'package:adminpannelgrocery/repository/login_repository.dart';
import 'package:dio/dio.dart';



class LoginAPI extends LoginRepository {
  static const String baseurl="https://jsonplaceholder.typicode.com/";
  LoginResponseBody? responseBody;
  @override
  Future<LoginResponseBody> validateUserIdPassword(Map body) async{
    try {
      var response =
      // await Dio().get('https://jsonplaceholder.typicode.com/posts');
      await Dio().post('${baseurl}posts',data: body);
      var bodyresponse = response.data as LoginResponseBody;
      responseBody=bodyresponse;
    } catch (exception) {
      print(exception);
    }
   return responseBody!;
  }
}
