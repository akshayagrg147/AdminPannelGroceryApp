import 'dart:developer';

import 'package:adminpannelgrocery/repositories/Modal/allCouponsResponse.dart';
import 'package:adminpannelgrocery/repositories/Modal/product_category_modal.dart';
import 'package:adminpannelgrocery/repositories/cubit/AddProductCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/AllCouponsCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/AllProductCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/DeleteCouponCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/DeleteProductCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/ProductCategoryCubit.dart';
import 'package:adminpannelgrocery/state/allCouponsState.dart';
import 'package:adminpannelgrocery/state/delete_product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../../controllers/DrawerController.dart';
import '../../../state/delete_coupon_state.dart';
import '../../main/main_screen.dart';
import '../components/coupon_item.dart';
import '../components/product_item.dart';

class AllCouponsScreen extends StatefulWidget {
  const AllCouponsScreen({Key? key}) : super(key: key);

  @override
  State<AllCouponsScreen> createState() => AllCouponsScreenState();
}

class AllCouponsScreenState extends State<AllCouponsScreen> {
  late AllCouponsCubit Cubit;

  late DeleteCouponCubit CubitdeleteNewProuct;

  List<ItemDataa> listProducts = [];

  @override
  void initState() {
    super.initState();
    Cubit = BlocProvider.of<AllCouponsCubit>(context);
    CubitdeleteNewProuct = BlocProvider.of<DeleteCouponCubit>(context);

    // pCubit.clearCategory();
  }

  @override
  void dispose() {
    super.dispose();

    Cubit.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'All Coupons',
            style: TextStyle(
              color: Colors.black, // Change this to your desired text color
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChangeNotifierProvider<DrawController>(
                    create: (context) => DrawController(),
                    child: const MainScreen(),
                  ),
                ),
              ); // Navigate back when the back arrow is pressed
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocConsumer<DeleteCouponCubit, DeleteCouponState>(
                  listener: (context, state) {
                if (state is DeleteCouponErrorState) {
                  SnackBar snackBar = SnackBar(
                    content: Text(state.error),
                    backgroundColor: Colors.red,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else if (state is DeleteCouponLoadedState) {
                  log(state.products.runtimeType.toString());
                  var obj = state.products;
                  if (obj.statusCode == 200) {
                    Cubit.fetchAllCoupons();
                    SnackBar snackBar = const SnackBar(
                      content: Text('Success'),
                      backgroundColor: Colors.green,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    SnackBar snackBar = const SnackBar(
                      content: Text('Failure'),
                      backgroundColor: Colors.redAccent,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                }
              }, builder: (context, state) {
                return Container();
              }),
              SizedBox(
                height: 40,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: SafeArea(
                      child: BlocConsumer<AllCouponsCubit, AllCouponsState>(
                        listener: (context, state) {
                          if (state is AllCouponsErrorState) {
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
                          if (state is AllCouponsLoadingState) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is AllCouponsLoadedState) {
                            log(state.products.runtimeType.toString());
                            var obj = state.products;
                            listProducts = obj.itemData ?? [];
                            log("AllCouponsLoadedState is ${listProducts.length.toString()}");
                            return CouponsItems(
                                listProducts, (deleted) {
                              if (deleted) {

                              }
                            }, (val) {});
                            //   return Text("${obj.message}");
                          } else if (state is AllCouponsErrorState) {
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

// class CouponItem extends StatelessWidget {
//   final ItemData itemData;
//   final DeleteProductCubit cubit;
//
//   const CouponItem({required this.itemData, required this.cubit, Key? key})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Image.network(
//             itemData.productImage1.toString(),
//             width: 200,
//             height: 200,
//             fit: BoxFit.cover,
//             errorBuilder: (ctx, obj, stack) {
//               return Image.asset(
//                 'assets/images/logo.png',
//                 width: 200,
//                 height: 200,
//                 fit: BoxFit.cover,
//               );
//             },
//           ),
//           const SizedBox(width: 10),
//           Expanded(
//             child: LayoutBuilder(builder: (context, constraints) {
//               print(constraints.maxWidth);
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     itemData.productName.toString(),
//                     style: const TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 16.0),
//                   Text(
//                     itemData.orignal_price.toString(),
//                     style: const TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 16.0),
//                   Text(
//                     itemData.quantity.toString(),
//                     style: const TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 16.0),
//                   Text(
//                     itemData.productDescription.toString(),
//                     style: const TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               );
//             }),
//           ),
//           BlocConsumer<DeleteProductCubit, DeleteProductState>(
//             listener: (context, state) {
//               if (state is DeleteProductErrorState) {
//                 SnackBar snackBar = SnackBar(
//                   content: Text(state.error),
//                   backgroundColor: Colors.red,
//                 );
//                 ScaffoldMessenger.of(context).showSnackBar(snackBar);
//               }
//             },
//             builder: (context, state) {
//               if (state is DeleteProductLoadingState) {
//                 return Container();
//               } else if (state is DeleteProductLoadedState) {
//                 log(state.products.runtimeType.toString());
//                 SnackBar snackBar = const SnackBar(
//                   content: Text('success'),
//                   backgroundColor: Colors.green,
//                 );
//                 ScaffoldMessenger.of(context).showSnackBar(snackBar);
//
//                 //   return Text("${obj.message}");
//               } else if (state is DeleteProductErrorState) {
//                 return Center(
//                   child: Text(state.error),
//                 );
//               }
//
//               return IconButton(
//                 icon: const Icon(Icons.delete),
//                 onPressed: () {
//                   cubit.deleteProduct(itemData.productId.toString());
//
//                   // Perform delete operation
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
