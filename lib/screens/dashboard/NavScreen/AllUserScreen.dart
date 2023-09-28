import 'dart:developer';

import 'package:adminpannelgrocery/repositories/Modal/AllProducts.dart';
import 'package:adminpannelgrocery/repositories/cubit/AddProductCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/AllProductCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/UserResponseCubit.dart';
import 'package:adminpannelgrocery/state/all_product_state.dart';
import 'package:adminpannelgrocery/state/all_user_state.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:adminpannelgrocery/repositories/Modal/UserResponse.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants.dart';
import 'package:adminpannelgrocery/repositories/Modal/AllProducts.dart'
    hide ItemData;
import 'package:adminpannelgrocery/repositories/Modal/UserResponse.dart';

import '../../../responsive.dart';
import '../../main/components/side_menu.dart';
import '../components/user_item.dart';

class AllUserScreen extends StatefulWidget {
  const AllUserScreen({Key? key}) : super(key: key);

  @override
  State<AllUserScreen> createState() => ProductScreenState();
}

class ProductScreenState extends State<AllUserScreen> {
  late UserResponseCubit Cubit;

  @override
  void initState() {
    super.initState();
    Cubit = BlocProvider.of<UserResponseCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const SideMenu(false),
        body: Row(
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                child: SideMenu(true),
              ),
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 26.0),
                    Text(
                      "Total Users",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 5,
                          child: SafeArea(
                            child:
                                BlocConsumer<UserResponseCubit, AllUserState>(
                              listener: (context, state) {
                                if (state is AllUserErrorState) {
                                  SnackBar snackBar = SnackBar(
                                    content: Text(state.error),
                                    backgroundColor: Colors.red,
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              },
                              builder: (context, state) {
                                if (state is AllUserLoadingState) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is AllUserLoadedState) {
                                  log(state.products.runtimeType.toString());
                                  var obj = state.products;
                                  return Container(
                                    // Replace 300 with your desired width

                                    child: UserItem(obj.userData),
                                  );
                                  //   return Text("${obj.message}");
                                } else if (state is AllUserErrorState) {
                                  return Center(
                                    child: Text(state.error),
                                  );
                                }

                                return Container();
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

enum State1 { yes, no }
