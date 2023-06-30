import 'dart:developer';

import 'package:adminpannelgrocery/repositories/Modal/AllProducts.dart';
import 'package:adminpannelgrocery/repositories/Modal/product_category_modal.dart';
import 'package:adminpannelgrocery/repositories/cubit/AddProductCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/AllProductCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/DeleteProductCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/ProductCategoryCubit.dart';
import 'package:adminpannelgrocery/responsive.dart';
import 'package:adminpannelgrocery/screens/dashboard/components/header.dart';
import 'package:adminpannelgrocery/screens/main/components/side_menu.dart';
import 'package:adminpannelgrocery/state/add_category_state.dart';
import 'package:adminpannelgrocery/state/all_category_state.dart';
import 'package:adminpannelgrocery/state/all_product_state.dart';
import 'package:adminpannelgrocery/state/delete_product_state.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../commonWidget/common_text_field_widget.dart';
import '../../../commonWidget/sppiner.dart';
import '../../../constants.dart';
import '../../../models/AddProductResponse.dart';
import '../../../models/productScreenModal.dart';
import '../../../repositories/cubit/AddCategoryCubit.dart';
import '../../../state/add_product_state.dart';
import '../components/category_item.dart';
import '../components/product_item.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => CategoryScreenState();
}

class CategoryScreenState extends State<CategoryScreen> {
  late ProductCategoryCubit Cubit;
  late DeleteProductCubit cubitdeleteNewProuct;
  List<Category>? listProducts = [];


  @override
  void initState() {
    super.initState();
    Cubit = BlocProvider.of<ProductCategoryCubit>(context);
    cubitdeleteNewProuct = BlocProvider.of<DeleteProductCubit>(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        drawer: const SideMenu(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30,),
// if(listProducts?.isNotEmpty ?? true)
              Align(
                alignment: Alignment.topRight,
                child: AddCard(onTap: (tap) {
                  if (tap) {
                    openAlert(context, false, ItemData());
                  }
                }),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (Responsive.isDesktop(context))
                    const Expanded(
                      child: SideMenu(),
                    ),
                  Expanded(
                    flex: 5,
                    child: SafeArea(
                      child: BlocConsumer<ProductCategoryCubit, AllCategoryState>(
                        listener: (context, state) {
                          if (state is AllCategoryErrorState) {
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
                          if (state is AllCategoryLoadingState) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is AllCategoryLoadedState) {
                            print('category Items ${state.category.category?.length.toString()}');
                            log(state.category.runtimeType.toString());
                            var obj = state.category;
                              listProducts = obj.category??[];
                              return CategoryItems(
                                listProducts);
                            //   return Text("${obj.message}");
                          } else if (state is AllCategoryErrorState) {
                            return Center(
                              child: Text(state.error),
                            );
                          }

                          return Container();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}





void openAlert(BuildContext context, bool editButton,
    ItemData data) {

  TextEditingController categoryName = TextEditingController();



  var dialog = Dialog(
    insetPadding: const EdgeInsets.all(32.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    //this right here
    child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(15.0),
        children: [
          const SizedBox(
              width: double.infinity,
              child: Text("ADD CATEGORY",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ))),

          const SizedBox(height: 20),
          commonTextFieldWidget(
            type: TextInputType.text,
            controller: categoryName,
            hintText: "Bottle",
            secondaryColor: secondaryColor,
            labelText: "Enter Product Name",
            onChanged: (val) {},
          ),



          BlocConsumer<AddCategoryCubit, AddCategoryState>(
              listener: (context, state) {
            if (state is AddCategoryErrorState) {
              SnackBar snackBar = SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else if (state is AddCategoryLoadedState) {
              SnackBar snackBar = const SnackBar(
                content: Text('success'),
                backgroundColor: Colors.green,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          }, builder: (context, state) {
            if (state is AddCategoryLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AddCategoryLoadedState) {
              var response = state.products;
              if (response.statusCode == 200) {
                CategoryScreen();
                Navigator.of(context).pop();
              }
            }
            return ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
                  textStyle:
                      MaterialStateProperty.all(const TextStyle(fontSize: 15))),
              onPressed: () {
                BlocProvider.of<AddCategoryCubit>(context).addCategory(categoryName.text);
              },
              child: const Text('Save!'),
            );
          }),
          const SizedBox(height: 20),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
                  textStyle:
                      MaterialStateProperty.all(const TextStyle(fontSize: 15))),
              onPressed: () {},
              child: const Text('Cancel!'))
        ]),
  );
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.center,
          child: FractionallySizedBox(
            widthFactor: 0.8,
            child: dialog,
          ),
        );
      });
}

void setState(Null Function() param0) {}

enum State1 { yes, no }
