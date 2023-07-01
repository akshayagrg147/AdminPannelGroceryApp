import 'dart:developer';

import 'package:adminpannelgrocery/repositories/Modal/AllProducts.dart';
import 'package:adminpannelgrocery/repositories/cubit/AddProductCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/AllProductCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/DeleteProductCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/ProductCategoryCubit.dart';
import 'package:adminpannelgrocery/responsive.dart';
import 'package:adminpannelgrocery/screens/dashboard/components/header.dart';
import 'package:adminpannelgrocery/screens/main/components/side_menu.dart';
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
import '../../../state/add_category_state.dart';
import '../../../state/add_product_state.dart';
import '../components/product_item.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => ProductScreenState();
}

class ProductScreenState extends State<ProductScreen> {
  late AllProductCubit Cubit;
  late AddProductCubit CubitAddNewProuct;
  late DeleteProductCubit CubitdeleteNewProuct;
  List<ItemData>? listProducts = [];

  @override
  void initState() {
    super.initState();
    Cubit = BlocProvider.of<AllProductCubit>(context);
    CubitAddNewProuct = BlocProvider.of<AddProductCubit>(context);
    CubitdeleteNewProuct = BlocProvider.of<DeleteProductCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: SingleChildScrollView(
          child: Column(
            children: [
// if(listProducts?.isNotEmpty ?? true)
            SizedBox(height: 40,),
              ProductHeader(
                CubitAddNewProuct,
                onValueUpdate: (val) {
                  if (val.isNotEmpty) {
                    print('value get after search ${val}');
                    List<ItemData>? items = listProducts
                        ?.where((item) => item.productName!.contains(val))
                        .toList();
                    print('value get after search ${items?.length}');
                    if (val.isEmpty) {
                      Cubit.passFilterData(listProducts ?? <ItemData>[]);
                    } else {
                      Cubit.passFilterData(items ?? <ItemData>[]);
                    }
                  }
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Expanded(
                    flex: 5,
                    child: SafeArea(
                      child: BlocConsumer<AllProductCubit, AllProductState>(
                        listener: (context, state) {
                          if (state is AllProductErrorState) {
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
                          if (state is AllProductLoadingState) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is AllProductLoadedState) {
                            log(state.products.runtimeType.toString());
                            var obj = state.products;
                            listProducts = obj.itemData;
                            return ProductItems(
                                listProducts, CubitdeleteNewProuct, (val) {
                              openAlert(context, CubitAddNewProuct, true, val);
                            });
                            //   return Text("${obj.message}");
                          } else if (state is AllProductErrorState) {
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

class ProductItem extends StatelessWidget {
  final ItemData itemData;
  final DeleteProductCubit cubit;

  const ProductItem({required this.itemData, required this.cubit, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.network(
            itemData.productImage1.toString(),
            width: 200,
            height: 200,
            fit: BoxFit.cover,
            errorBuilder: (ctx, obj, stack) {
              return Image.asset(
                'assets/images/logo.png',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              );
              ;
            },
          ),
          const SizedBox(width: 10),
          Expanded(
            child: LayoutBuilder(builder: (context, constraints) {
              print(constraints.maxWidth);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemData.productName.toString(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    itemData.price.toString(),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    itemData.quantity.toString(),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    itemData.productDescription.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              );
            }),
          ),
          BlocConsumer<DeleteProductCubit, DeleteProductState>(
            listener: (context, state) {
              if (state is DeleteProductErrorState) {
                SnackBar snackBar = SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.red,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            builder: (context, state) {
              if (state is DeleteProductLoadingState) {
                return Container();
              } else if (state is DeleteProductLoadedState) {
                log(state.products.runtimeType.toString());
                var obj = state.products;
                SnackBar snackBar = const SnackBar(
                  content: Text('success'),
                  backgroundColor: Colors.green,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);

                //   return Text("${obj.message}");
              } else if (state is DeleteProductErrorState) {
                return Center(
                  child: Text(state.error),
                );
              }

              return IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  cubit.deleteProduct(itemData.productId.toString());

                  // Perform delete operation
                },
              );
            },
          ),
        ],
      ),
    );
    ;
  }
}

class ProductHeader extends StatefulWidget {
  AddProductCubit addNewProductCubit;
  final Function(String) onValueUpdate;

  ProductHeader(this.addNewProductCubit,
      {Key? key, required this.onValueUpdate})
      : super(key: key);

  @override
  State<ProductHeader> createState() => _ProductHeaderState();
}

class _ProductHeaderState extends State<ProductHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(child: SearchField(textChanged: (value) {
                  print('ProductScreen  ${value}  ');
                  //  setState((){
                  // listProducts = items;
                 widget.onValueUpdate(value!);

//                  });
                })),
                AddCard(onTap: (tap) {
                  if (tap) {
                    openAlert(context, widget.addNewProductCubit, false, ItemData());
                  }
                })
              ],
            )),
      ],
    );
  }
}

void openAlert(BuildContext context, AddProductCubit cubit, bool editButton,
    ItemData data) {
  int? dashboardDisplay = 2;
  TextEditingController productname = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController deliveryInstructionController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController regularPriceController = TextEditingController();
  TextEditingController mrpController = TextEditingController();

  String selectedValue = "";
  List<String?>? categoryList;
  if (editButton) {
    productname.text = data.productName ?? '';
    productDescriptionController.text = data.productDescription ?? '';
    deliveryInstructionController.text = '';
    pincodeController.text = '';
    quantityController.text = data.quantity ?? '';
    regularPriceController.text = data.price ?? '';
  }

  var dialog = Dialog(
    insetPadding: const EdgeInsets.all(32.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    //this right here
    child: StatefulBuilder(
      builder: (context, setState) {
        return ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(15.0),
            children: [
              const SizedBox(
                  width: double.infinity,
                  child: Text("ADD PRODUCT",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ))),

              const SizedBox(height: 20),
              commonTextFieldWidget(
                type: TextInputType.text,
                controller: productname,
                hintText: "Bottle",
                secondaryColor: secondaryColor,
                labelText: "Enter Product Name",
                onChanged: (val) {},
              ),

              const SizedBox(height: 20),

              commonTextFieldWidget(
                type: TextInputType.text,
                controller: productDescriptionController,
                hintText: "desc",
                secondaryColor: secondaryColor,
                labelText: "Enter Poduct Description",
                onChanged: (val) {},
              ),
              const SizedBox(height: 20),
              commonTextFieldWidget(
                type: TextInputType.text,
                controller: deliveryInstructionController,
                hintText: "desc",
                secondaryColor: secondaryColor,
                labelText: "Enter Product Delivery Instruction",
                onChanged: (val) {},
              ),

              const SizedBox(height: 20),
              //AddProductTextField(image: "assets/icons/Search.svg",hint:"Enter Pin code", ),
              commonTextFieldWidget(
                type: TextInputType.number,
                controller: pincodeController,
                hintText: "123456",
                secondaryColor: secondaryColor,
                labelText: "Enter Pin code",
                onChanged: (val) {},
              ),

              Text(
                "Please fill all the pincode if it is supported on specific pincode and if it is supported on all pincode the leave it empty",
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 20),
              commonTextFieldWidget(
                type: TextInputType.number,
                controller: quantityController,
                hintText: "e.g. 16",
                secondaryColor: secondaryColor,
                labelText: "Enter Quantity",
                onChanged: (val) {},
              ),

              commonTextFieldWidget(
                type: TextInputType.number,
                controller: regularPriceController,
                hintText: "Rs.250",
                secondaryColor: secondaryColor,
                labelText: "Enter regular Price",
                onChanged: (val) {},
              ),

              const SizedBox(height: 20),
              commonTextFieldWidget(
                type: TextInputType.number,
                controller: mrpController,
                hintText: "Rs.300",
                secondaryColor: secondaryColor,
                labelText: "Enter Mrp Price",
                onChanged: (val) {},
              ),

              const SizedBox(height: 20),
              Container(
                width: 242.0,
                height: 42.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.0),
                  color: const Color(0xff2c2c2c),
                ),
                child: const Center(
                  child: Text(
                    'Upload Image1',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 18,
                      color: Colors.white,
                      height: 1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 242.0,
                height: 42.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.0),
                  color: const Color(0xff2c2c2c),
                ),
                child: const Center(
                  child: Text(
                    'Upload Image2',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 18,
                      color: Colors.white,
                      height: 1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Text(
                "Dashboard Display",
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 20),
              Column(children: [
                ListTile(
                  title: const Text('Yes'),
                  leading: Radio(
                    value: 1,
                    groupValue: dashboardDisplay,
                    onChanged: (value) {
                      setState(() {
                        dashboardDisplay = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('No'),
                  leading: Radio(
                    value: 2,
                    groupValue: dashboardDisplay,
                    onChanged: (value) {
                      setState(() {
                        dashboardDisplay = value;
                      });
                    },
                  ),
                ),

              ]),
              Text(
                "Select Category",
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.start,
              ),
              BlocConsumer<ProductCategoryCubit, AllCategoryState>(builder: (context, state) {

                if (state is AllCategoryLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return SpinnerWidget(
                  items: categoryList!.cast<String>(),
                  onChanged: (value) {
                    BlocProvider.of<ProductCategoryCubit>(context).selectCatgory(value);
                  },
                  selectedValue: selectedValue,
                );
              },
                listener: (context, state) {
                if(state is AllCategoryLoadedState) {
                  categoryList = state.category.category
                      ?.map((category) => category.category)
                      .toList();
                  categoryList
                      ?.removeWhere((item) => item == null || item.isEmpty);
                  selectedValue = categoryList?.first ?? '';
                }
               else if (state is SelectedCategoryValue) {
                  selectedValue = state.value;
                }
              },),

SizedBox(height: 20,),

              BlocConsumer<AddProductCubit, AddProductState>(
                  listener: (context, state) {
                    if (state is AddProductErrorState) {
                      SnackBar snackBar = SnackBar(
                        content: Text(state.error),
                        backgroundColor: Colors.red,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else if (state is AddProductLoadedState) {
                      SnackBar snackBar = const SnackBar(
                        content: Text('success'),
                        backgroundColor: Colors.green,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  }, builder: (context, state) {
                if (state is AddProductLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is AddProductLoadedState) {
                  var response = state.products;
                  if (response.statusCode == 200) {
                    Navigator.of(context).pop();
                  }
                }
                return ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                      padding:
                      MaterialStateProperty.all(const EdgeInsets.all(15)),
                      textStyle: MaterialStateProperty.all(
                          const TextStyle(fontSize: 15))),
                  onPressed: () {
                    cubit.addProduct(ProductScreenModal(
                        productName: productname.text.toString(),
                        price: regularPriceController.text.toString(),
                        quantity: quantityController.text,
                        actualPrice: mrpController.text,
                        productId: "1",
                        productDescription: productDescriptionController.text,
                        dashboardDisplay: false,
                        itemCategoryId: "1",
                        categoryType: 1));
                  },
                  child: const Text('Save!'),
                );
              }),
              const SizedBox(height: 20),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                      padding:
                      MaterialStateProperty.all(const EdgeInsets.all(15)),
                      textStyle: MaterialStateProperty.all(
                          const TextStyle(fontSize: 15))),
                  onPressed: () {},
                  child: const Text('Cancel!'))
            ]);
      },
    ),
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
