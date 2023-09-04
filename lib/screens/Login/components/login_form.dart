import 'package:adminpannelgrocery/models/login_response.dart';
import 'package:adminpannelgrocery/repositories/cubit/login_response_cubit.dart';
import 'package:adminpannelgrocery/state/login_response_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

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
          TextFormField(
            controller: username,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: password,
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
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
