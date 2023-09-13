import 'package:adminpannelgrocery/models/login_response.dart';
import 'package:adminpannelgrocery/repositories/cubit/login_response_cubit.dart';
import 'package:adminpannelgrocery/state/login_response_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../commonWidget/common_text_field_widget.dart';
import '../../../constants.dart';

import '../../../controllers/DrawerController.dart';
import '../../../sharedpreference/PreferencesUtil.dart';
import '../../main/main_screen.dart';

class LoginForm extends StatelessWidget {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              fontFamily: 'YourFontFamily', // Replace with your desired font family
              fontWeight: FontWeight.bold, // Set the font weight to bold
            ),
          ),
           SizedBox(height: 20,),

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
            child:
            commonTextFieldWidget(
              secondaryColor: Colors.white,
              type: TextInputType.text,
              controller: password,
              icon: Icons.lock,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              hintText: "Your password",


              labelText: "Enter your password",
              onChanged: (val) {},
            )



          ),
          const SizedBox(height: defaultPadding),
          BlocBuilder<LoginResponseCubit, LoginResponseState>(
              builder: (context, state) {
            if (state is LoginResponseLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LoginResponseLoadedState) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainScreen(),
                ),
              );
            } else if (state is LoginResponseErrorState) {
              return Center(
                child: Text(state.error),
              );
            }
            return Container();
          }),
          Hero(
            tag: "login_btn",
            child: ElevatedButton(
              onPressed: () async {
                await PreferencesUtil.saveString('login_save',  true);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChangeNotifierProvider<DrawController>(
                      create: (context) => DrawController(),
                      child: const MainScreen(),
                    ),
                  ),
                );
                //  BlocProvider.of<LoginResponseCubit>(context).submitlogin(username.text, password.text);
              },
              child: Text(
                "Login".toUpperCase(),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
        ],
      ),
    );
  }
}
