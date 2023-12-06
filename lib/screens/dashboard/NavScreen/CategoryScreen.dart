import 'dart:developer';

import 'package:adminpannelgrocery/repositories/Modal/product_category_modal.dart';
import 'package:adminpannelgrocery/repositories/cubit/DeleteProductCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/ProductCategoryCubit.dart';
import 'package:adminpannelgrocery/responsive.dart';
import 'package:adminpannelgrocery/screens/main/components/side_menu.dart';
import 'package:adminpannelgrocery/state/all_category_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repositories/Modal/add_category_modal.dart';
import '../components/category_item.dart';

import '../components/headerDashboard.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => CategoryScreenState();
}

class CategoryScreenState extends State<CategoryScreen> {
  late ProductCategoryCubit Cubit;
  late DeleteProductCubit cubitdeleteNewProuct;
  List<ItemDataCategory>? listProducts = [];

  @override
  void initState() {
    super.initState();
    Cubit = BlocProvider.of<ProductCategoryCubit>(context);
    cubitdeleteNewProuct = BlocProvider.of<DeleteProductCubit>(context);
    Cubit.fetchCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const SideMenu(false),
        body: Row(children: [
          if (Responsive.isDesktop(context))
            Expanded(
              child: SideMenu(true),
            ),
          Expanded(
            flex: 5,
            child: Align(
              alignment: Alignment.topLeft,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    DashboardHeader(
                      imageUrl: "",
                      name: "null",
                      title: "Category Screen",
                    ),
                    BlocConsumer<ProductCategoryCubit, AllCategoryState>(
                      listener: (context, state) {
                        if (state is AllCategoryErrorState) {
                          SnackBar snackBar = SnackBar(
                            content: Text(state.error),
                            backgroundColor: Colors.red,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      builder: (context, state) {
                        print(state);
                        if (state is AllCategoryLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is AllCategoryLoadedState) {
                          print(
                              'category Items ${state.category.itemData?.length.toString()}');
                          log(state.category.runtimeType.toString());
                          var obj = state.category;
                          listProducts = obj.itemData ?? [];

                          if (listProducts?.isNotEmpty == true)
                            return CategoryItems(Cubit, listProducts, (delete) {
                              Cubit.fetchCategory();
                            });
                          else
                            return Center(
                              child: Image.asset(
                                  'assets/images/empty_orders.png'), // Replace with your image asset
                            );

                          //   return Text("${obj.message}");
                        } else if (state is AllCategoryErrorState) {
                          print(
                              'category fetch error ${state.error.toString()}');
                          return Center(
                            child: Text(state.error),
                          );
                        }

                        return Container();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]));
  }
}

class ImageKitRequest {
  String? imageUrl;
  String? imageId;

  ImageKitRequest(this.imageUrl, this.imageId);
}

List<SubCategoryListData> getDataFromControllers(
    List<TextEditingController> controllers) {
  List<SubCategoryListData> data = [];
  for (var controller in controllers) {
    data.add(SubCategoryListData(name: controller.text));
  }
  return data;
}

enum State1 { yes, no }
