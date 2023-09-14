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
        body: Row(
            children:[
              if (Responsive.isDesktop(context))
                Expanded(
                  child: SideMenu(true),
                ),

              Expanded(
                flex: 5,
                child: SingleChildScrollView(
                  child:Column(

                  children: [
                    DashboardHeader(
                      imageUrl:  "",
                      name:  "null", title: "Banner Screen",),
                    BlocConsumer<BannerCategoryCubit, AllBannerState>(
                      listener: (context, state) {
                        if (state is AllBannerErrorState) {
                          SnackBar snackBar = SnackBar(
                            content: Text(state.error),
                            backgroundColor: Colors.red,
                          );
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackBar);
                        }
                      },
                      builder: (context, state) {
                        print(state);
                        if (state is AllBannerLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        else if (state is AllBannerLoadedState) {
                          print(
                              'category Items ${state.category.itemData?.length.toString()}');
                          log(state.category.runtimeType.toString());
                          var obj = state.category;
                          listProducts = obj.itemData ?? [];
                          return BannerItems(Cubit,listProducts, (delete) {
                            Cubit.fetchBannerCategory();
                          });
                          //   return Text("${obj.message}");
                        }
                        else if (state is AllBannerErrorState) {
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
                  )
                  ,
                ),
              ),]
        ));
  }
}





class ImageKitRequest {
  String ?imageUrl;
  String ?imageId;
  ImageKitRequest(this.imageUrl,this.imageId);
}



Future<void> deleteImage(String publicKey, String privateKey, String imageId) async {
  final authString = '$publicKey:$privateKey';
  final encodedAuth = base64.encode(utf8.encode(authString));

  final dio = Dio();
  dio.options.headers['Authorization'] = 'Basic $encodedAuth';

  final url = 'https://api.imagekit.io/v1/files/$imageId';

  try {
    final response = await dio.delete(url);

    if (response.statusCode == 204) {
      // Image deleted successfully
      print('Image deleted successfully');
    } else {
      // Error deleting image
      print('Error deleting image: ${response.data}');
    }
  } catch (error) {
    // Error handling
    print('Error deleting image: $error');
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
