import 'package:adminpannelgrocery/models/login_response.dart';
import 'package:adminpannelgrocery/repositories/cubit/login_response_cubit.dart';
import 'package:adminpannelgrocery/state/login_response_state.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../commonWidget/common_text_field_widget.dart';
import '../../../constants.dart';

import '../../../controllers/DrawerController.dart';
import '../../../sharedpreference/PreferencesUtil.dart';
import '../../main/main_screen.dart';

class LoginForm extends StatefulWidget {

  LoginForm({
    Key? key,
  }) : super(key: key){


  }
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController username = TextEditingController();

  TextEditingController password = TextEditingController();
  String? token;
  String? savedemail;
  String? savedpassword;


  Future<void> _initializeToken() async {
    token = await gettoken();
    savedemail = await PreferencesUtil.getString('email');
    savedpassword = await PreferencesUtil.getString('password');
    username.text=savedemail??"";
    password.text=savedpassword??"";
  }




  @override
  Widget build(BuildContext context) {


    return FutureBuilder<void>(
        future: _initializeToken(),
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    // Show a loading indicator while waiting for the token.
    return const Center(
      child: SizedBox(
        width: 24.0, // Set the desired width
        height: 24.0, // Set the desired height
        child: CircularProgressIndicator(
          strokeWidth: 2.0, // Adjust the strokeWidth as needed
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue), // Customize the color
        ),
      ),
    )
    ;
    } else if (snapshot.hasError) {
    // Handle the error if token generation fails.
    return Center(child: Text('Error: ${snapshot.error}'));
    } else {
      return Form(
        child: Column(
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 200,
              height: 200,
            ),
            Text(
              "Login Screen",
              style: TextStyle(
                fontSize: 26,
                fontFamily: 'YourFontFamily',
                // Replace with your desired font family
                fontWeight: FontWeight.bold, // Set the font weight to bold
              ),
            ),
            SizedBox(
              height: 20,
            ),
            commonTextFieldWidget(
              secondaryColor: Colors.white,
              type: TextInputType.text,
              controller: username,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              hintText: "Your email",
              icon: Icons.mail,
              labelText: "Enter your email",
              onChanged: (val) {},
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                child: commonTextFieldWidget(
                  secondaryColor: Colors.white,
                  type: TextInputType.text,
                  controller: password,
                  icon: Icons.lock,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  hintText: "Your password",
                  labelText: "Enter your password",
                  onChanged: (val) {},
                )),
            const SizedBox(height: defaultPadding),
            BlocConsumer<LoginResponseCubit, LoginResponseState>(
                builder: (context, state) {
                  if (state is LoginResponseLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Hero(
                    tag: "login_btn",
                    child: ElevatedButton(
                      onPressed: () async {
                        BlocProvider.of<LoginResponseCubit>(context)
                            .submitlogin(username.text, password.text);
                      },
                      child: Text(
                        "Login".toUpperCase(),
                      ),
                    ),
                  );
                }, listener: (context, state) {
              if (state is LoginResponseErrorState) {
                SnackBar snackBar = SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.red,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else if (state is LoginResponseLoadedState) {
                callingMainScreen(
                  context,
                  state.response.response?.pincode,
                  state.response.response?.email,
                  state.response.response?.name,
                  state.response.response?.password,
                  state.response.response?.city,
                  state.response.response?.deliveryContactNumber,
                  token,
                  state.response.response?.price,
                  state.response.response?.generateToken

                );
              }
            }),
            const SizedBox(height: defaultPadding),
          ],
        ),
      );
    }
  });}

  Future<String?> gettoken() async {
    print("Device token generation started");
    try {
      String? deviceToken = await FirebaseMessaging.instance.getToken();
      print("Device token: $deviceToken");
      return deviceToken; // Return the device token
    } catch (e) {
      print("Error getting device token: $e");
      return null; // Return null in case of an error
    }
  }

  Future<void> callingMainScreen(
      BuildContext context,
      String? pincode,
      String? email,
      String? name,
      String? password,
      String? city,
      String? deliveryContactNumber,
      String? fcm_token,
      String? price,
          String? generateToken

    ) async {
    print("generateToken_fcm ${generateToken}");
    await PreferencesUtil.saveString('pincode', pincode ?? "");
    await PreferencesUtil.saveString('email', email ?? "");
    await PreferencesUtil.saveString('name', name ?? "");
    await PreferencesUtil.saveString('password', password ?? "");
    await PreferencesUtil.saveString('city', city ?? "");
    await PreferencesUtil.saveString('deliveryContactNumber', deliveryContactNumber ?? "");
    await PreferencesUtil.saveString('fcm_token', fcm_token ?? "");
    await PreferencesUtil.saveString('price', price ?? "");
    await PreferencesUtil.saveString('generateToken', generateToken ?? "");




    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider<DrawController>(
          create: (context) => DrawController(),
          child: const MainScreen(),
        ),
      ),
    );
  }
}
