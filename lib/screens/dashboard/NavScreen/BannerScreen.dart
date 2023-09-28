import 'dart:convert';
import 'dart:developer';

import 'package:adminpannelgrocery/repositories/Modal/AllProducts.dart';
import 'package:adminpannelgrocery/repositories/Modal/product_category_modal.dart';
import 'package:adminpannelgrocery/repositories/cubit/BannerCategoryCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/DeleteProductCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/ProductCategoryCubit.dart';
import 'package:adminpannelgrocery/responsive.dart';
import 'package:adminpannelgrocery/screens/dashboard/components/header.dart';
import 'package:adminpannelgrocery/screens/main/components/side_menu.dart';
import 'package:adminpannelgrocery/state/add_category_state.dart';
import 'package:adminpannelgrocery/state/all_banner_state.dart';
import 'package:adminpannelgrocery/state/all_category_state.dart';
import 'package:adminpannelgrocery/state/delete_banner_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../../commonWidget/common_elevted_Button.dart';
import '../../../commonWidget/common_text_field_widget.dart';
import '../../../constants.dart';
import '../../../repositories/Modal/add_category_modal.dart';
import '../../../repositories/Modal/banner_category_modal.dart';
import '../../../repositories/cubit/AddCategoryCubit.dart';
import '../../../repositories/cubit/DeleteBannerCubit.dart';
import '../components/banner_item.dart';
import '../components/category_item.dart';
import 'package:image_picker/image_picker.dart';

import '../components/headerDashboard.dart';

class BannerScreen extends StatefulWidget {
  const BannerScreen({Key? key}) : super(key: key);

  @override
  State<BannerScreen> createState() => BannerScreenState();
}

class BannerScreenState extends State<BannerScreen> {
  late BannerCategoryCubit Cubit;
  late DeleteBannerCubit deletecubit;
  List<ItemBannerCategory>? listProducts = [];

  @override
  void initState() {
    super.initState();
    Cubit = BlocProvider.of<BannerCategoryCubit>(context);
    deletecubit = BlocProvider.of<DeleteBannerCubit>(context);
    Cubit.fetchBannerCategory();
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
                      title: "Banner Screen",
                    ),
                    BlocConsumer<BannerCategoryCubit, AllBannerState>(
                      listener: (context, state) {
                        if (state is AllBannerErrorState) {
                          SnackBar snackBar = SnackBar(
                            content: Text(state.error),
                            backgroundColor: Colors.red,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      builder: (context, state) {
                        if (state is AllBannerLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is AllBannerLoadedState) {
                          log(state.category.runtimeType.toString());
                          var obj = state.category;
                          listProducts = obj.itemData ?? [];
                          return BannerItems(Cubit, listProducts, (delete) {
                            Cubit.fetchBannerCategory();
                          });
                          //   return Text("${obj.message}");
                        } else if (state is AllBannerErrorState) {
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

List<SubCategoryListData> getDataFromControllers(
    List<TextEditingController> controllers) {
  List<SubCategoryListData> data = [];
  for (var controller in controllers) {
    data.add(SubCategoryListData(name: controller.text));
  }
  return data;
}

enum State1 { yes, no }
