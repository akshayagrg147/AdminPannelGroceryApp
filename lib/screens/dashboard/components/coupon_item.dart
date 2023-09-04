import 'dart:developer';

import 'package:adminpannelgrocery/repositories/Modal/allCouponsResponse.dart';
import 'package:adminpannelgrocery/repositories/cubit/DeleteCouponCubit.dart';
import 'package:adminpannelgrocery/state/delete_coupon_state.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:adminpannelgrocery/models/RecentOrder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import '../../../repositories/cubit/AllProductCubit.dart';
import '../../../repositories/cubit/DeleteProductCubit.dart';
import '../../../state/delete_product_state.dart';

class CouponsItems extends StatelessWidget {
  final List<ItemData>? itemData;
  final DeleteCouponCubit Cubit;
  final  Function(ItemData) editClick;
  const CouponsItems( this.itemData,this.Cubit,this.editClick ,{
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteCouponCubit, DeleteCouponState>(
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
            SnackBar snackBar = const SnackBar(
              content: Text('Success'),
              backgroundColor: Colors.green,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: const BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   "Total Coupons",
                //   style: Theme.of(context).textTheme.subtitle1,
                // ),
                SizedBox(
                  width: double.infinity,
                  height:  1200,
                  child: DataTable2(
                    dividerThickness: 2.0,
                    columnSpacing: defaultPadding,
                    minWidth: 900,
                    columns: const [
                      DataColumn(
                        label: Text("Coupon name"),
                      ),
                      DataColumn(
                        label: Text("Start Date"),
                      ),
                      DataColumn(
                        label: Text("Expiry Date"),
                      ),
                      DataColumn(
                        label: Text("Delete"),
                      ),
                    ],
                    rows: List.generate(
                      itemData!.length,
                          (index) {
                        return productItemRow(itemData![index], Cubit); // Replace 'Cubit' with the actual instance of your Cubit class
                      },
                    ),
                  ),
                ),
              ],
            ),
          );


    });
  }
}

DataRow productItemRow(ItemData data, DeleteCouponCubit cubit) {

  return DataRow(
      cells: [

        DataCell(Text(data.couponCode!)),
        DataCell(Text(data.startDate!)),
        DataCell(Text(data.expireDate!)),
        DataCell(
            Row(
              children: [

                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {

                    // cubit.deleteCoupon(data.couponCode!);
                     cubit.deleteCoupon(data.couponCode.toString());
                    // Perform delete operation
                  },
                )
              ],
            )



            )
      ]);
}