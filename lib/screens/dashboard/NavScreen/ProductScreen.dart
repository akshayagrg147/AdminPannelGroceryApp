import 'dart:developer';

import 'package:adminpannelgrocery/repositories/Modal/AllProducts.dart';
import 'package:adminpannelgrocery/repositories/Modal/product_category_modal.dart';
import 'package:adminpannelgrocery/repositories/cubit/AddProductCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/AllProductCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/BannerCategoryCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/DeleteProductCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/ProductCategoryCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/best_selling_checkbox_cubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/exclusive_selling_checkbox_cubit.dart';
import 'package:adminpannelgrocery/responsive.dart';
import 'package:adminpannelgrocery/screens/dashboard/NavScreen/BannerScreen.dart';
import 'package:adminpannelgrocery/screens/dashboard/components/header.dart';
import 'package:adminpannelgrocery/state/all_category_state.dart';
import 'package:adminpannelgrocery/state/all_product_state.dart';
import 'package:adminpannelgrocery/state/delete_product_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../commonWidget/common_elevted_Button.dart';
import '../../../commonWidget/common_text_field_widget.dart';
import '../../../commonWidget/sppiner.dart';
import '../../../constants.dart';
import '../../../models/productScreenModal.dart';
import '../../../repositories/Modal/banner_category_modal.dart';
import '../../../state/add_product_state.dart';
import '../../../state/all_banner_state.dart';
import '../../main/components/side_menu.dart';
import '../components/headerDashboard.dart';
import '../components/product_item.dart';
import 'CategoryScreen.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => ProductScreenState();
}

class ProductScreenState extends State<ProductScreen> {
  late AllProductCubit Cubit;
  late AddProductCubit CubitAddNewProuct;
  late ProductCategoryCubit cubitCategory;
  late DeleteProductCubit CubitdeleteNewProuct;
  late BestSellingCheckBoxCubit checkBoxCubit;
  late ExclusiveCheckBoxCubit exclusiveCheckBoxCubit;
  late ProductCategoryCubit pCubit;

  List<ItemData>? listProducts = [];
  List<ItemData>? listProductsIfEmpty = [];

  @override
  void initState() {
    super.initState();
    Cubit = BlocProvider.of<AllProductCubit>(context);
    CubitAddNewProuct = BlocProvider.of<AddProductCubit>(context);
    pCubit = BlocProvider.of<ProductCategoryCubit>(context);
    CubitdeleteNewProuct = BlocProvider.of<DeleteProductCubit>(context);
    checkBoxCubit = BlocProvider.of<BestSellingCheckBoxCubit>(context);
    exclusiveCheckBoxCubit = BlocProvider.of<ExclusiveCheckBoxCubit>(context);
    Cubit.fetchProducts();
    // pCubit.clearCategory();
  }

  @override
  void dispose() {
    super.dispose();
    CubitAddNewProuct.clearProducts();
    Cubit.clearProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SideMenu(false),
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
                    DashboardHeader(
                      imageUrl: "",
                      name: "null",
                      title: "Dashboard",
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    // DashboardHeader(
                    //   imageUrl:  "",
                    //   name: "Products",title: "Products",),
                    ProductHeader(
                      Cubit,
                      CubitAddNewProuct,
                      pCubit,
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
                        } else {
                          setState(() {
                            listProducts = listProductsIfEmpty;
                          });

                          print(
                              'value get after empty ${listProducts}  ${listProductsIfEmpty?.length.toString()}');
                        }
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 5,
                          child: SafeArea(
                            child:
                                BlocConsumer<AllProductCubit, AllProductState>(
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
                                  listProductsIfEmpty = obj.itemData;
                                  return ProductItems(
                                      listProducts,
                                      CubitdeleteNewProuct,
                                      checkBoxCubit,
                                      exclusiveCheckBoxCubit, (val) {
                                    openAlert(context, CubitAddNewProuct,
                                        pCubit, true, val, (String data) {
                                      if (data == "added")
                                        Cubit.fetchProducts();
                                    });
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
              ),
            ),
          ],
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
                    itemData.orignal_price.toString(),
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
                icon: const Icon(
                  Icons.delete,
                  color: Colors.black,
                ),
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
  }
}

class ProductHeader extends StatefulWidget {
  AddProductCubit addNewProductCubit;
  ProductCategoryCubit cubit1;
  AllProductCubit allProductCubit;
  final Function(String) onValueUpdate;

  ProductHeader(this.allProductCubit, this.addNewProductCubit, this.cubit1,
      {Key? key, required this.onValueUpdate})
      : super(key: key);

  @override
  State<ProductHeader> createState() => _ProductHeaderState();
}

class _ProductHeaderState extends State<ProductHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Row(
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
                  AddCard(" Add new Product", onTap: (tap) {
                    if (tap) {
                      openAlert(context, widget.addNewProductCubit,
                          widget.cubit1, false, ItemData(), (String data) {
                        if (data == "added") {
                          widget.allProductCubit.fetchProducts();
                        }
                      });
                    }
                  })
                ],
              )),
        ],
      ),
    );
  }
}

void openAlert(
    BuildContext context,
    AddProductCubit cubit,
    ProductCategoryCubit cubit1,
    bool editButton,
    ItemData data,
    Function(String) dataCalled) {
  //BlocProvider.of<BannerCategoryCubit>(context).fetchBannerCategory();

  int? dashboardDisplay = 1;
  cubit1.fetchCategory();
  BlocProvider.of<BannerCategoryCubit>(context).fetchBannerCategory();
  if (dashboardDisplay == 1) {
    //cubit1.clearCategory();
  } else if (dashboardDisplay == 2) {
    BlocProvider.of<BannerCategoryCubit>(context).clearCategory();
  }
  ImageKitRequest uploadImage1 = ImageKitRequest("null", null);
  ImageKitRequest uploadImage2 = ImageKitRequest("null", null);
  ImageKitRequest uploadImage3 = ImageKitRequest("null", null);
  double dialogWidth = Responsive.isMobile(context)
      ? MediaQuery.of(context).size.width * 0.8
      : 600.0;

  TextEditingController productname = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController quantityInstructionController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController sellingPriceController = TextEditingController();
  TextEditingController orignalPriceController = TextEditingController();

  String selectedValue = "";
  String radioSelectValue = "";
  int indexValue = 0;
  List<String?>? categoryList;
  List<ItemDataCategory?>? spinnerData;
  List<ItemBannerCategory?>? spinnerBannerData;
  if (editButton) {
    productname.text = data.productName ?? '';
    productDescriptionController.text = data.productDescription ?? '';
    quantityInstructionController.text = '';
    pincodeController.text = '';
    quantityController.text = data.quantity ?? '';
    sellingPriceController.text = data.selling_price ?? '';
    orignalPriceController.text = data.orignal_price ?? '';
    uploadImage1.imageUrl = data.productImage1;
    uploadImage2.imageUrl = data.productImage2;
    uploadImage3.imageUrl = data.productImage3;
  }

  var dialog = Dialog(
    insetPadding: const EdgeInsets.all(32.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    //this right here
    child: Container(
      color: Colors.white,
      width: dialogWidth,
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
                Text(
                  "Which Banner you want to add?",
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 20),
                Column(children: [
                  ListTile(
                    title: const Text('Festival Banner'),
                    leading: Radio(
                      activeColor: Colors.red,
                      fillColor: MaterialStateProperty.all(Colors.red),
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
                    title: const Text('Non Festival Banner'),
                    leading: Radio(
                      activeColor: Colors.red,
                      fillColor: MaterialStateProperty.all(Colors.red),
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
                const SizedBox(height: 20),
                commonTextFieldWidget(
                  type: TextInputType.text,
                  controller: productname,
                  hintText: "",
                  secondaryColor: Colors.white,
                  labelText: "Enter Product Name",
                  onChanged: (val) {},
                ),

                const SizedBox(height: 20),

                commonTextFieldWidget(
                  type: TextInputType.multiline,
                  controller: productDescriptionController,
                  hintText: "",
                  secondaryColor: Colors.white,
                  labelText: "Enter Product Description",
                  onChanged: (val) {},
                ),
                const SizedBox(height: 20),
                commonTextFieldWidget(
                  type: TextInputType.text,
                  controller: quantityInstructionController,
                  hintText: "",
                  secondaryColor: Colors.white,
                  labelText: "Enter Product quantity Instruction",
                  onChanged: (val) {},
                ),

                const SizedBox(height: 20),
                //AddProductTextField(image: "assets/icons/Search.svg",hint:"Enter Pin code", ),
                commonTextFieldWidget(
                  type: TextInputType.number,
                  controller: pincodeController,
                  hintText: "",
                  secondaryColor: Colors.white,
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
                  hintText: "",
                  secondaryColor: Colors.white,
                  labelText: "Enter Quantity",
                  onChanged: (val) {},
                ),

                commonTextFieldWidget(
                  type: TextInputType.number,
                  controller: sellingPriceController,
                  hintText: "",
                  secondaryColor: Colors.white,
                  labelText: "Enter selling Price",
                  onChanged: (val) {},
                ),

                const SizedBox(height: 20),
                commonTextFieldWidget(
                  type: TextInputType.number,
                  controller: orignalPriceController,
                  hintText: "",
                  secondaryColor: Colors.white,
                  labelText: "Enter actual Price",
                  onChanged: (val) {},
                ),

                const SizedBox(height: 20),
                Text(
                  "Upload image 1",
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.start,
                ),
                CommonImageButton(
                  onPressed: () {
                    _uploadImage((imageFile, imageId) {
                      setState(() {
                        uploadImage1 = (ImageKitRequest(imageFile, imageId));
                      });
                    });
                  },
                  buttonText: "Upload sub category",
                  selectedImagePath: uploadImage1.imageUrl!.contains("null")
                      ? ImageKitRequest(null, null)
                      : uploadImage1,
                  deleteImage: (obj) {
                    setState(() {
                      uploadImage1 = ImageKitRequest("null", null);
                    });
                  },
                ),

                const SizedBox(height: 20),
                Text(
                  "Upload image 2",
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.start,
                ),
                CommonImageButton(
                  onPressed: () {
                    _uploadImage((imageFile, imageId) {
                      print('Image uploaded! ${imageFile}');
                      setState(() {
                        uploadImage2 = (ImageKitRequest(imageFile, imageId));
                      });
                    });
                  },
                  buttonText: "Upload sub category",
                  selectedImagePath: uploadImage2.imageUrl!.contains("null")
                      ? ImageKitRequest(null, null)
                      : uploadImage2,
                  deleteImage: (obj) {
                    setState(() {
                      uploadImage2 = ImageKitRequest("null", null);
                    });
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  "Upload image 3",
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.start,
                ),
                CommonImageButton(
                  onPressed: () {
                    _uploadImage((imageFile, imageId) {
                      print('Image uploaded! ${imageFile}');
                      setState(() {
                        uploadImage3 = (ImageKitRequest(imageFile, imageId));
                      });
                    });
                  },
                  buttonText: "Upload sub category",
                  selectedImagePath: uploadImage3.imageUrl!.contains("null")
                      ? ImageKitRequest(null, null)
                      : uploadImage3,
                  deleteImage: (obj) {
                    setState(() {
                      uploadImage3 = ImageKitRequest("null", null);
                    });
                  },
                ),
                const SizedBox(height: 20),

                Text(
                  "Select Category",
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.start,
                ),
                if (dashboardDisplay == 2)
                  BlocConsumer<ProductCategoryCubit, AllCategoryState>(
                    builder: (context, state) {
                      print("stateis ${state.runtimeType}");
                      if (state is AllCategoryLoadingState) {
                        print("stateis loading");
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is AllCategoryLoadedState) {
                        print("stateis loaded");
                        spinnerData = state.category.itemData;
                        categoryList = state.category.itemData
                            ?.map((category) => category.category)
                            .toList();
                        categoryList?.removeWhere(
                            (item) => item == null || item.isEmpty);
                        selectedValue = categoryList?.first ?? '';
                      }
                      if (categoryList?.isNotEmpty == true) {
                        return Column(
                          children: [
                            SpinnerWidget(
                              items: categoryList!.cast<String>(),
                              onChanged: (value, index) {
                                BlocProvider.of<ProductCategoryCubit>(context)
                                    .selectCatgory(value, index);
                              },
                              selectedValue: selectedValue,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            if (spinnerData != null)
                              Column(
                                children: spinnerData![indexValue]!
                                    .subCategoryList!
                                    .map((value) {
                                  return RadioListTile(
                                    title: Text(value.name!),
                                    value: value.name,
                                    activeColor: Colors.red,
                                    fillColor: MaterialStateProperty.all(Colors.red),
                                    groupValue: radioSelectValue,
                                    onChanged: (newValue) {
                                      setState(() {
                                        radioSelectValue = newValue as String;
                                      });
                                    },
                                  );
                                }).toList(),
                              ),
                          ],
                        );
                      }

                      return Container();
                    },
                    listener: (context, state) {
                      print("category state is ${state.runtimeType}");

                      if (state is AllCategoryLoadedState) {
                        spinnerData = state.category.itemData;
                        categoryList = state.category.itemData
                            ?.map((category) => category.category)
                            .toList();
                        categoryList?.removeWhere(
                            (item) => item == null || item.isEmpty);
                        selectedValue = categoryList?.first ?? '';
                      } else if (state is SelectedCategoryValue) {
                        print("stateis loaded SelectedCategoryValue");
                        selectedValue = state.value;
                        indexValue = state.index;
                      }
                    },
                  ),
                if (dashboardDisplay == 1)
                  BlocConsumer<BannerCategoryCubit, AllBannerState>(
                    builder: (context, state) {
                      print("banner_stateis ${state.runtimeType}");
                      if (state is AllCategoryLoadingState) {
                        print("stateis loading");
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is AllBannerLoadedState) {
                        print("stateis loaded");
                        categoryList = state
                            .category.itemData?.first.subCategoryList
                            ?.map((category) => category.name)
                            .toList();

                        if (categoryList?.isNotEmpty == true) {
                          return Column(
                            children: [
                              Text(
                                "Festival Type ${state.category.itemData?.first.bannercategory1}",
                                style: Theme.of(context).textTheme.titleMedium,
                                textAlign: TextAlign.start,
                              ),
                              Column(
                                children: categoryList!.map((value) {
                                  return RadioListTile(
                                    title: Text(value!),
                                    activeColor: Colors.red,
                                    fillColor: MaterialStateProperty.all(Colors.red),
                                    value: value,
                                    groupValue: radioSelectValue,
                                    onChanged: (newValue) {
                                      setState(() {
                                        radioSelectValue = newValue as String;
                                      });
                                    },
                                  );
                                }).toList(),
                              ),
                            ],
                          );
                        }
                      }

                      return Container();
                    },
                    listener: (context, state) {
                      if (state is AllBannerLoadedState) {
                        print("stateis loaded");
                        spinnerBannerData = state.category.itemData;
                        categoryList = state
                            .category.itemData?.first.subCategoryList
                            ?.map((category) => category.name)
                            .toList();
                        categoryList?.removeWhere(
                            (item) => item == null || item.isEmpty);
                        selectedValue = categoryList?.first ?? '';
                      } else if (state is SelectCategoryValue) {
                        print("stateis loaded SelectedCategoryValue");
                        selectedValue = state.value;
                        indexValue = state.index;
                      }
                    },
                  ),

                BlocConsumer<AddProductCubit, AddProductState>(
                    listener: (context, state) {
                  if (state is AddProductErrorState) {
                    print("stateis loaded AddProductErrorState");
                    SnackBar snackBar = SnackBar(
                      content: Text(state.error),
                      backgroundColor: Colors.red,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else if (state is AddProductLoadedState) {
                    print("stateis loaded AddProductLoadedState");
                    if (state.products.status == true) {
                      SnackBar snackBar = const SnackBar(
                        content: Text('success'),
                        backgroundColor: Colors.green,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      SnackBar snackBar = SnackBar(
                        content: Text("${state.products.message}"),
                        backgroundColor: Colors.green,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  }
                }, builder: (context, state) {
                  if (state is AddProductLoadingState) {
                    print("stateis loaded AddProductLoadingState");
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is AddProductLoadedState) {
                    print("stateis loaded AddProductLoadedState");
                    var response = state.products;
                    if (response.statusCode == 200) {
                      Navigator.of(context).pop();
                      cubit.clearProducts();
                      dataCalled("added");
                    }
                  }
                  return ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green),
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(15)),
                        textStyle: MaterialStateProperty.all(
                            const TextStyle(fontSize: 15))),
                    onPressed: () {
                      if (productname.text.toString().isEmpty ||
                          orignalPriceController.text.toString().isEmpty ||
                          sellingPriceController.text.toString().isEmpty ||
                          quantityInstructionController.text
                              .toString()
                              .isEmpty ||
                          quantityController.text.isEmpty ||
                          productDescriptionController.text.isEmpty ||
                          selectedValue.isEmpty ||
                          uploadImage1.imageUrl?.contains("null") == true ||
                          uploadImage2.imageUrl?.contains("null") == true ||
                          uploadImage3.imageUrl?.contains("null") == true) {
                        print("${productname.text.toString().isEmpty}"
                            "${orignalPriceController.text.toString().isEmpty}"
                            "${sellingPriceController.text.toString().isEmpty}"
                            "${quantityController.text.toString().isEmpty}"
                            "${productDescriptionController.text.toString().isEmpty}"
                            "${selectedValue.isEmpty}"
                            "${uploadImage1.imageUrl?.contains("null") == true}"
                            "${uploadImage2.imageUrl?.contains("null") == true}"
                            "${uploadImage3.imageUrl?.contains("null") == true}");
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill all informations'),
                          ),
                        );
                        return;
                      }
                      editButton
                          ? cubit.update(ProductScreenModal(
                              productName: productname.text.toString(),
                              orignalPrice:
                                  orignalPriceController.text.toString(),
                              sellingPrice:
                                  sellingPriceController.text.toString(),
                              quantity: quantityController.text,
                              productDescription:
                                  productDescriptionController.text.toString(),
                              dashboardDisplay: false,
                              itemCategoryName: selectedValue,
                              itemSubcategoryName: radioSelectValue,
                              quantityInstructionController:
                                  quantityInstructionController.text,
                              image1: uploadImage1.imageUrl,
                              image2: uploadImage2.imageUrl,
                              image3: uploadImage3.imageUrl,
                              productId: data.productId))
                          : cubit.addProduct(ProductScreenModal(
                              productName: productname.text.toString(),
                              orignalPrice:
                                  orignalPriceController.text.toString(),
                              sellingPrice:
                                  sellingPriceController.text.toString(),
                              quantity: quantityController.text,
                              productDescription:
                                  productDescriptionController.text,
                              dashboardDisplay: false,
                              itemCategoryName: selectedValue,
                              itemSubcategoryName: radioSelectValue,
                              quantityInstructionController:
                                  quantityInstructionController.text,
                              image1: uploadImage1.imageUrl,
                              image2: uploadImage2.imageUrl,
                              image3: uploadImage3.imageUrl));
                    },
                    child: editButton ? Text('Update!') : Text('Save!'),
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

Future<void> _uploadImage(Function(String, String) fn) async {
  var headers = {
    'Authorization':
        'Basic cHJpdmF0ZV9tdHVMdjFGa0YrVE9YbFV5SC9ZbEIvQkpndVE9Og=='
  };

  var url = 'https://upload.imagekit.io/api/v1/files/upload';

  // Select an image using ImagePicker
  final picker = ImagePicker();
  final pickedImage = await picker.pickImage(source: ImageSource.gallery);

  if (pickedImage != null) {
    var imageFile = await pickedImage.readAsBytes();

    try {
      var dio = Dio();
      var timestamp = DateTime.now().millisecondsSinceEpoch;

      var formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(
          imageFile,
          filename: pickedImage.path.split('/').last,
        ),
        'fileName': 'image_$timestamp.png',
        'folder': 'Products',
      });

      var response = await dio.post(
        url,
        data: formData,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = response.data;
        var responseData = jsonResponse["url"].toString();
        fn(responseData, jsonResponse["fileId"].toString());
        print('Image uploaded! ${responseData}');
      } else {
        print('Failed to upload image: ${response.statusMessage}');
      }
    } catch (error) {
      print('Error uploading image: $error');
    }
  } else {
    print('No image selected.');
  }
}

enum State1 { yes, no }
