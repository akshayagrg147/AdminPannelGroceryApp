import 'dart:developer';

import 'package:adminpannelgrocery/repositories/Modal/AllProducts.dart';
import 'package:adminpannelgrocery/repositories/cubit/AddProductCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/AllProductCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/DeleteProductCubit.dart';
import 'package:adminpannelgrocery/responsive.dart';
import 'package:adminpannelgrocery/screens/dashboard/components/header.dart';
import 'package:adminpannelgrocery/screens/main/components/side_menu.dart';
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
import '../../../state/add_product_state.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => ProductScreenState();
}

class ProductScreenState extends State<ProductScreen> {
  late AllProductCubit Cubit;
  late AddProductCubit CubitAddNewProuct;
  late DeleteProductCubit CubitdeleteNewProuct;


  @override
  void initState() {
    super.initState();
    Cubit = BlocProvider.of<AllProductCubit>(context);
    CubitAddNewProuct = BlocProvider.of<AddProductCubit>(context);
    CubitdeleteNewProuct= BlocProvider.of<DeleteProductCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        drawer: const SideMenu(),
        body: SingleChildScrollView(
          child: Column(
            children: [

              ProductHeader(CubitAddNewProuct),
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
                          if (state is AllProductLoadingState) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is AllProductLoadedState) {
                            log(state.products.runtimeType.toString());
                            var obj = state.products;
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: obj.itemData?.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                ItemData item = obj.itemData![index];
                                return ProductItem(itemData: item,cubit: CubitdeleteNewProuct,);
                              },
                            );
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
  const ProductItem({required this.itemData,required this.cubit, Key? key}) : super(key: key);

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
                ScaffoldMessenger.of(context)
                    .showSnackBar(snackBar);
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

class ProductList extends StatelessWidget {
  const ProductList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Files",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            width: double.infinity,
            height: 400,
            child: DataTable2(
              columnSpacing: defaultPadding,
              minWidth: 600,
              columns: const [
                DataColumn(
                  label: Text("Id"),
                ),
                DataColumn(
                  label: Text("Images"),
                ),
                DataColumn(
                  label: Text("Name"),
                ),
                DataColumn(
                  label: Text("Cash on delevery"),
                ),
                DataColumn(
                  label: Text("Product Delivery In"),
                ),
                DataColumn(
                  label: Text("Free Shipping"),
                ),
                DataColumn(
                  label: Text("Quantity"),
                ),
                DataColumn(
                  label: Text("RegularPrice"),
                ),
                DataColumn(
                  label: Text("Offer"),
                ),
                DataColumn(
                  label: Text("Description"),
                ),
              ],
              rows: [],
              // rows: List.generate(
              //   demoRecentFiles.length,
              //       (index) => recentFileDataRow(demoRecentFiles[index]),
              // ),
            ),
          ),
        ],
      ),
    );
  }
}

// DataRow recentFileDataRow(ProductScreenModal fileInfo) {
//   return DataRow(
//     cells: [
//       DataCell(Text(fileInfo.id!)),
//       DataCell(
//         Row(
//           children: [
//             SvgPicture.asset(
//               fileInfo.images!,
//               height: 30,
//               width: 30,
//             ),
//           ],
//         ),
//       ),
//       DataCell(Text(fileInfo.Name!)),
//       DataCell(Text(fileInfo.cashondelevery!)),
//       DataCell(Text(fileInfo.productdeliveryin!)),
//       DataCell(Text(fileInfo.freeshipping!)),
//       DataCell(Text(fileInfo.quantity!)),
//       DataCell(Text(fileInfo.regularprice!)),
//       DataCell(Text(fileInfo.offer!)),
//       DataCell(Text(fileInfo.description!)),
//     ],
//   );
// }

class ProductHeader extends StatelessWidget {
  final AddProductCubit addNewProductCubit;

  const ProductHeader(this.addNewProductCubit, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        Expanded(
          flex: 2,
          child: Row(
            children: [
              if (!Responsive.isDesktop(context))
                IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: (){
                      ScaffoldState? scaffoldState = Scaffold.of(context);
                      if (!scaffoldState.isDrawerOpen) {
                        scaffoldState.openDrawer();
                      }
                    }
                ),
              if (!Responsive.isMobile(context))
                Text(
                  "Dashboard",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              if (!Responsive.isMobile(context))
                Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
              Expanded(child: SearchField()),
              AddCard(onTap: (tap) {
                if (tap) {
                  openAlert(context, addNewProductCubit);
                }
              })
            ],
          )
        ),
      ],
    );
  }

  void openAlert(BuildContext context, AddProductCubit cubit) {
    int? dashboardDisplay = 0;
    TextEditingController productname = TextEditingController();
    TextEditingController productDescriptionController =
        TextEditingController();
    TextEditingController deliveryInstructionController =
        TextEditingController();
    TextEditingController pincodeController = TextEditingController();
    TextEditingController quantityController = TextEditingController();
    TextEditingController regularPriceController = TextEditingController();
    TextEditingController mrpController = TextEditingController();
    bool selectedSpinnerItem = false;

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
            SpinnerWidget(
              items: [
                'Exclusive',
                'Best Selling',
                'Home Products',
                'ItemCategory'
              ],
              onChanged: (value) {
                if (value.contains('ItemCategory')) {
                  setState(() {
                    selectedSpinnerItem = true;
                  });
                } else {
                  setState(() {
                    selectedSpinnerItem = false;
                  });
                }
              },
              selectedValue: 'Exclusive',
            ),
            if (selectedSpinnerItem) SizedBox(height: 20),
            SpinnerWidget(
              items: [
                '1001',
                '1002',
                '1003',
                '1004'
              ],
              onChanged: (value) {

              },
              selectedValue: '1001',
            ),
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
              if (state is AddProductLoadedState) {
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
}

void setState(Null Function() param0) {}

enum State1 { yes, no }
