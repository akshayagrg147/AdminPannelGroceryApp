

import 'package:adminpannelgrocery/model/LoginResponseBody.dart';
import 'package:adminpannelgrocery/repository/login_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../model/LoginRequestBody.dart';



class LoginAPI extends LoginRepository {
  static const String baseurl="https://0cb8-103-129-0-91.in.ngrok.io/";
  LoginResponseBody? responseBody;
  @override
  Future<LoginResponseBody> validateUserIdPassword(Map body) async{
    try {
      var response =
      // await Dio().get('https://jsonplaceholder.typicode.com/posts');
      await Dio().post('${baseurl}Admin/Login',data: body);

 if(response.statusCode==200)
   {
     var bodyresponse = response.data ;
     responseBody=LoginResponseBody.fromJson(bodyresponse) ;
   }
 else{
   Fluttertoast.showToast(
       msg: "${response.data['message']}",
       toastLength: Toast.LENGTH_SHORT,
       gravity: ToastGravity.CENTER,
       timeInSecForIosWeb: 1,
       backgroundColor: Colors.red,
       textColor: Colors.white,
       fontSize: 16.0
   );
 }

    } catch (exception) {
      print(exception);
    }
   return responseBody!;
  }
}
