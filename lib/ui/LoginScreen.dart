import 'package:adminpannelgrocery/model/LoginResponseBody.dart';
import 'package:adminpannelgrocery/repository/login_api.dart';
import 'package:adminpannelgrocery/view_models/login_view_model.dart';
import 'package:adminpannelgrocery/view_models/login_view_model_call.dart';
import 'package:flutter/material.dart';

import 'package:form_field_validator/form_field_validator.dart';
// function to start app building

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var postsViewModel = LoginViewModalCall(postsRepository: LoginAPI());
  String _textprovider = "";
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            //   mainAxisAlignment: MainAxisAlignment.center,
            // children: <Widget>[
            child: Column(
              children: [


                //space
                const SizedBox(
                  height: 20,
                  width: 10,
                ),

                //login
                const SizedBox(
                  height: 20,
                  // width: 200.0,
                  child: Text(
                    "",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                  ),

                  //space
                ),
                const SizedBox(
                  height: 0,
                  width: 10,
                ),

                // to enter the number

                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: TextFormField(
                      controller: emailcontroller,
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.5),
                              borderRadius: BorderRadius.all(
                                Radius.circular(3),
                              )),
                          labelText: 'email',
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 16.0)),
                      keyboardType: TextInputType.text,
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Required **"),
                        EmailValidator(errorText: "Wrong Email")
                      ])),
                ),

                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordcontroller,
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.all(
                              Radius.circular(3),
                            )),
                        labelText: 'Pass',
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 16.0)),
                    keyboardType: TextInputType.number,
                    validator: MinLengthValidator(6,
                        errorText: "should be  atleast 6 digit length"),
                  ),
                ),

                //send otp button
                ElevatedButton(
                  onPressed: () {
                    FutureBuilder<LoginViewModel>(
                      future: postsViewModel.validateIdPassword({
                        "email": emailcontroller.text,
                        "password": passwordcontroller.text
                      }),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else {
                          var responsebody = snapshot.data;
                          print("messageresponse $responsebody");
                          return Text(responsebody?.modal?.message ?? "null",
                            style: const TextStyle(
                                fontSize: 35,
                                color: Colors.purple,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.italic,
                                letterSpacing: 8,
                                wordSpacing: 20,
                                backgroundColor: Colors.yellow,
                                shadows: [
                                  Shadow(color: Colors.blueAccent, offset: Offset(2,1), blurRadius:10)
                                ]
                            ), );
                        }
                      },
                    );

                    Navigator.pushNamed(context, "otp");
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 140.0, vertical: 15.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0)),
                      backgroundColor: Colors.green),
                  child: const Text(
                    "Log in",
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),

                const SizedBox(
                  height: 30,
                  width: 15,
                ),

                Text('$_textprovider')
              ],
            )

            //    ], //<Widget>[]
            ), //Column
      ), //Center
    );
  }
}
