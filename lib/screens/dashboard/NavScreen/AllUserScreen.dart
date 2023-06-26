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
import 'package:adminpannelgrocery/repositories/Modal/AllProducts.dart' hide ItemData;
import 'package:adminpannelgrocery/repositories/Modal/UserResponse.dart';

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
        body: SingleChildScrollView(

          child: Column(
            
            children: [
              const SizedBox(height: 26.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                 child: SafeArea(
                    child: BlocConsumer<UserResponseCubit, AllUserState>(
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

                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: obj.userData?.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return UserItem(obj.userData);
                              },
                            ),
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
        ));
  }
}

class UsersData extends StatelessWidget {
  final UserData user;
  const UsersData({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.network(
            user.profileImage.toString(),
            width: 200,
            height: 200,
            fit: BoxFit.cover,
            errorBuilder: (ctx,obj,stack){
              return  Image.asset(
                'assets/images/logo.png',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              );;
            },
          ),

          const SizedBox(width: 10),
          Expanded(
            child: LayoutBuilder(
              builder: (context,constraints) {
                print(constraints.maxWidth);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name.toString(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                   
                    const SizedBox(height: 16.0),
                    Text(
                      user.email.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),


                  ],
                );
              }
            ),
          ),
        ],
      ),
    );;
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



void setState(Null Function() param0) {}

enum State1 { yes, no }
