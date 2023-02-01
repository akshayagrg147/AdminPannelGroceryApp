


import 'package:adminpannelgrocery/model/LoginResponseBody.dart';

class LoginViewModel {
  LoginResponseBody? modal;
  LoginViewModel( {this.modal});

  get id => modal?.status;

}
