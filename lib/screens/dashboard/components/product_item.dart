import 'dart:developer';

import 'package:adminpannelgrocery/repositories/Modal/AllProducts.dart';
import 'package:adminpannelgrocery/repositories/cubit/best_selling_checkbox_cubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/exclusive_selling_checkbox_cubit.dart';
import 'package:adminpannelgrocery/state/best_selling_checkbox.dart';
import 'package:adminpannelgrocery/state/exclusive_selling_checkbox.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:adminpannelgrocery/models/RecentOrder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../commonWidget/CommonCheckbox.dart';
import '../../../constants.dart';
import '../../../repositories/cubit/AllProductCubit.dart';
import '../../../repositories/cubit/DeleteProductCubit.dart';
import '../../../state/delete_product_state.dart';

class ProductItems extends StatelessWidget {
  final List<ItemData>? itemData;
  final DeleteProductCubit Cubit;
  final BestSellingCheckBoxCubit bestCubit;
  final ExclusiveCheckBoxCubit exclusiveCheckBoxCubit;
  final  Function(ItemData) editClick;
   ProductItems( this.itemData,this.Cubit,this.bestCubit,this.exclusiveCheckBoxCubit,this.editClick ,{
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      // decoration: const BoxDecoration(
      //   color: secondaryColor,
      //   borderRadius: BorderRadius.all(Radius.circular(10)),
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Total Products",
            style: Theme.of(context).textTheme.subtitle1,
          ),
    BlocConsumer<BestSellingCheckBoxCubit, BestSellingCheckBoxState>(
    listener: (context, state) {
    if (state is BestSellingCheckBoxErrorState) {
    SnackBar snackBar = SnackBar(
    content: Text(state.error),
    backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    else if (state is BestSellingCheckBoxLoadedState) {
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
      if (state is BestSellingCheckBoxErrorState) {
        return Center(
          child: Text(state.error),
        );
      }
      else if(state is BestSellingCheckBoxLoadingState){
        return  Center(child: CircularProgressIndicator());
      }
    else if (state is BestSellingCheckBoxLoadedState) {
    return Container();
    // Perform delete operation
    }
    return Container();


    }

    ),
          BlocConsumer<ExclusiveCheckBoxCubit, ExclusiveCheckBoxState>(
              listener: (context, state) {
                if (state is ExclusiveCheckBoxErrorState) {
                  SnackBar snackBar = SnackBar(
                    content: Text(state.error),
                    backgroundColor: Colors.red,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }

                else if (state is ExclusiveCheckBoxLoadedState) {
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
                if (state is ExclusiveCheckBoxErrorState) {
                  return Center(
                    child: Text(state.error),
                  );
                }
                else if(state is ExclusiveCheckBoxLoadingState){
                  return  Center(child: CircularProgressIndicator());
                }
                else if (state is ExclusiveCheckBoxLoadedState) {
                  return Container();
                  // Perform delete operation
                }
                return Container();


              }

          ),
          SizedBox(
            width: double.infinity,
            height:  1200,
            child: DataTable2(
              dividerThickness: 2.0,
              columnSpacing: 25.0,
              minWidth: 900,
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
                  label: Text("Best Selling"),
                ),
                DataColumn(
                  label: Text("Exclusive"),
                ),
                DataColumn(
                  label: Text("Delete"),
                ),

              ],

              rows: List.generate(
                itemData!.length,
                (index) => productItemRow(itemData![index],Cubit,bestCubit,exclusiveCheckBoxCubit,editClick),

              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow productItemRow(ItemData data, DeleteProductCubit cubit, BestSellingCheckBoxCubit bestCubit,ExclusiveCheckBoxCubit excubit, Function(ItemData) editClick,) {
  Function(ItemData) fnData;
  bool isChecked = false;
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
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: Image.network(
                    data.productImage1.toString(),
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill,
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
              ),
            ],
          ),
        ),
        DataCell(Text(data.productName!,overflow: TextOverflow.clip,),),
        DataCell(Text(data.quantity!)),

        DataCell(
StatefulBuilder(
builder: (context, setState) {
  return CommonCheckbox(
  value: data.bestSellingCheckBox==true,
  onChanged: (newValue) {

  if(newValue==true) {
    data.bestSellingCheckBox=true;
    data.exclusiveSellingCheckBox=false;
  } else{
    data.bestSellingCheckBox = false;
    data.exclusiveSellingCheckBox = false;
  }


  bestCubit.updateBestSelling(data);
  setState(() {
  isChecked = newValue ?? false;
  });
  },
  );
  })),
        DataCell(
  StatefulBuilder(

                    builder: (context, setState) {
                      return CommonCheckbox(
                        value: data.exclusiveSellingCheckBox==true,
                        onChanged: (newValue) {
                          if(newValue==true) {
            data.bestSellingCheckBox = false;
            data.exclusiveSellingCheckBox = true;
          } else{
                            data.bestSellingCheckBox = false;
                            data.exclusiveSellingCheckBox = false;
                          }
                          excubit.updateExclusiveSelling(data);
                          setState(() {
                            isChecked = newValue ?? false;
                          });
                        },
                      );
                    }
                )),



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
                //   if (state is DeleteProductErrorState) {
                //   return Center(
                //     child: Text(state.error),
                //   );
                // }
                //   else if (state is DeleteProductLoadedState) {
                //     return IconButton(
                //       icon: Icon(Icons.delete,color: Colors.black,),
                //       onPressed: () {
                //         cubit.deleteProduct(data.productId.toString());
                //         // Perform delete operation
                //       },
                //     );
                //   }

                    return Row(
                      children: [
                    IconButton(
                    icon: Icon(Icons.edit,color: Colors.black,),
                onPressed: () {
                  editClick(data);


                // Perform delete operation
                },
                ),
                        IconButton(
                          icon: Icon(Icons.delete,color: Colors.black,),
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