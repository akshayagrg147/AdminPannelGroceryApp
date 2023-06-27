import 'dart:developer';

import 'package:adminpannelgrocery/repositories/Modal/AllProducts.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:adminpannelgrocery/models/RecentOrder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import '../../../repositories/cubit/AllProductCubit.dart';
import '../../../repositories/cubit/DeleteProductCubit.dart';
import '../../../state/delete_product_state.dart';

class ProductItems extends StatelessWidget {
  final List<ItemData>? itemData;
  final DeleteProductCubit Cubit;
  final  Function(ItemData) editClick;
  const ProductItems( this.itemData,this.Cubit,this.editClick ,{
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
            "Total Products",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            width: double.infinity,
            height:  1200,
            child: DataTable2(
              dividerThickness: 2.0,
              columnSpacing: defaultPadding,
              minWidth: 600,
              columns: const [
                DataColumn(
                  label: Text("Product Image")                ),
                DataColumn(
                  label: Text("Product name"),
                ),
                DataColumn(
                  label: Text("Quantity"),
                ),
                DataColumn(
                  label: Text("Delete"),
                ),

              ],
              rows: List.generate(
                itemData!.length,
                (index) => productItemRow(itemData![index],Cubit,editClick),

              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow productItemRow(ItemData data, DeleteProductCubit cubit,  Function(ItemData) editClick) {
  Function(ItemData) fnData;
  return DataRow(
      cells: [

        DataCell(
          Row(
            children: [
              // SvgPicture.asset(
              //   fileInfo.icon!,
              //   height: 30,
              //   width: 30,
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Image.network(
                  data.productImage1.toString(),
                  width: 100,
                  height: 40,
                  fit: BoxFit.cover,
                  errorBuilder: (ctx, obj, stack) {
                    return Image.asset(
                      'assets/images/logo.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    );
                    ;
                  },
                ),
              ),
            ],
          ),
        ),
        DataCell(Text(data.productName!)),
        DataCell(Text(data.quantity!)),
        DataCell(
            BlocConsumer<DeleteProductCubit, DeleteProductState>(
              listener: (context, state) {
                if (state is DeleteProductErrorState) {
                  SnackBar snackBar = SnackBar(
                    content: Text(state.error),
                    backgroundColor: Colors.red,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                else if (state is DeleteProductLoadedState) {
                  log(state.products.runtimeType.toString());
                  var obj = state.products;
                  SnackBar snackBar = const SnackBar(
                    content: Text('Success'),
                    backgroundColor: Colors.green,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              builder: (context, state) {
                  if (state is DeleteProductErrorState) {
                  return Center(
                    child: Text(state.error),
                  );
                }
                  else if (state is DeleteProductLoadedState) {
                    return IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        cubit.deleteProduct(data.productId.toString());
                        // Perform delete operation
                      },
                    );
                  }

                    return Row(
                      children: [
                    IconButton(
                    icon: Icon(Icons.edit),
                onPressed: () {
                  editClick(data);


                // Perform delete operation
                },
                ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            cubit.deleteProduct(data.productId.toString());
                            // Perform delete operation
                          },
                        )
                      ],
                    );

              },


            ))
      ]);
}