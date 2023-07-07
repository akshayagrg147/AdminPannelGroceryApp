import 'dart:developer';

import 'package:adminpannelgrocery/repositories/Modal/AllProducts.dart';
import 'package:adminpannelgrocery/repositories/Modal/product_category_modal.dart';
import 'package:adminpannelgrocery/repositories/cubit/DeleteCategoryCubit.dart';
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

   CategoryItems( this.itemData ,{
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
                  label: Text("Category Image")                ),
                DataColumn(
                  label: Text("Category name"),
                ),
                DataColumn(
                  label: Text("Action"),
                ),
              ],
              rows: List.generate(
                itemData!.length,
                (index) => productItemRow(itemData![index],context),

              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow productItemRow(ItemDataCategory data,BuildContext context) {

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
                  data.category.toString(),
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
        DataCell(Text(data.category!)),
        DataCell(
          BlocBuilder<DeleteCategoryCubit,DeleteProductState>(
  builder: (context,state){
    if(state is DeleteProductLoadingState){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    else if(state is DeleteProductLoadedState){
      SnackBar snackBar = const SnackBar(
        content: Text("Deleted Successfully"),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    return IconButton(
      icon: const Icon(
        Icons.delete,
        color: Colors.red,
      ),
      onPressed: () {
        BlocProvider.of<DeleteCategoryCubit>(context).deleteCategory(data.category!);
        // Perform delete operation
      },
    );










  },
  )
            ),

      ]);
}