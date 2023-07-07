import 'dart:developer';

import 'package:adminpannelgrocery/repositories/Modal/AllProducts.dart';
import 'package:adminpannelgrocery/repositories/Modal/product_category_modal.dart';
import 'package:adminpannelgrocery/repositories/cubit/DeleteCategoryCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/ProductCategoryCubit.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:adminpannelgrocery/models/RecentOrder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import '../../../repositories/cubit/AllProductCubit.dart';
import '../../../repositories/cubit/DeleteProductCubit.dart';
import '../../../state/delete_product_state.dart';

class CategoryItems extends StatelessWidget {
  final List<ItemDataCategory>? itemData;
  final Function(String) deleteCategory;

  CategoryItems(
    this.itemData,this.deleteCategory, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteCategoryCubit, DeleteProductState>(
        listener: (context1, state) {
      if (state is DeleteProductLoadedState) {
        SnackBar snackBar = const SnackBar(
          content: Text("Deleted Successfully"),
          backgroundColor: Colors.green,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        deleteCategory("deleted");


      }
    }, builder: (context, state) {
      if (state is DeleteProductLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Total Products",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            ListView.builder(
              shrinkWrap:true ,
              itemCount: itemData!.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var data = itemData![index];
                return productItemRow(data, context);
              },
            )
          ],
        ),
      );
    });
  }
}

Widget productItemRow(ItemDataCategory data, BuildContext context) {
  bool isSnackBarShown = false;
  return Padding(
    key: UniqueKey(),
    padding: const EdgeInsets.only(left: 10.0, top: 20.0),
    child: Container(
      // padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SvgPicture.asset(
          //   fileInfo.icon!,
          //   height: 30,
          //   width: 30,
          // ),

          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
              child: Text(data.category.toString(),
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            ),
            IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                BlocProvider.of<DeleteCategoryCubit>(context)
                    .deleteCategory(data.category!);
                // Perform delete operation
              },
            )
          ]),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Image.network(
              data.imageUrl.toString(),
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
          ListView.builder(
            itemCount: data.subCategoryList!.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final item = data.subCategoryList![index];
              return Text(
                item.name ?? "null",
                style: TextStyle(
                    // Add your desired text style properties here
                    ),
              );
            },
          )
        ],
      ),
    ),
  );
}
