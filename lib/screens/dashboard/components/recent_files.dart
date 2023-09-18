import 'package:adminpannelgrocery/repositories/Modal/RecentOrderCountResponse.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:adminpannelgrocery/models/RecentOrder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../commonWidget/sppiner.dart';
import '../../../constants.dart';
import '../../../repositories/cubit/SelectionCubit.dart';




class RecentOrders extends StatefulWidget {
  final List<RecentOrders1>? itemData;


  const RecentOrders(this.itemData, {Key? key,})
      : super(key: key);

  @override
  State<RecentOrders> createState() => _RecentOrdersState();
}

class _RecentOrdersState extends State<RecentOrders> {
  late SelectionCubit cubit;
  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<SelectionCubit>(context);

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      // decoration: const BoxDecoration(
      //   color: secondaryColor,
      //   borderRadius: BorderRadius.all(Radius.circular(10)),
      // ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Recent Orders",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(
              width: double.infinity,
              height: 600,
              child: DataTable2(
                columnSpacing: defaultPadding,
                minWidth: 1300,

                columns: const [
                  DataColumn(label: Text("Product Image")),
                  DataColumn(
                    label: Text("Order Id"),
                  ),
                  DataColumn(
                    label: Text("Product"),
                  ),

                  DataColumn(
                    label: Text("Mobile Number"),
                  ),
                  DataColumn(
                    label: Text("Address"),
                  ),
                  DataColumn(
                    label: Text("Payment Mode"),
                  ),
                  DataColumn(
                    label: Text("Payment in Rs"),
                  ),
                  DataColumn(
                    label: Text("Status"),
                  ),
                ],
                rows: List.generate(
                  widget.itemData?.length??0,
                      (index) => productItemRow(widget.itemData![index],cubit),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

DataRow productItemRow(RecentOrders1 data,SelectionCubit cubit) {

  String selectedSpinnerValue = 'Ordered';
  return DataRow(cells: [
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
              data.mobilenumber.toString(),
              width: 100,
              height: 100,
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
    DataCell(Text(data.orderId!)),
    DataCell(ListView.builder(
      itemCount: data.orderList!.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(data.orderList![index].productId.toString()),
        );
      },
    )),

    DataCell(Text(data.mobilenumber.toString())),
    DataCell(Text(data.address.toString())),
    DataCell(Text(data.paymentmode.toString())),
    DataCell(Text("₹${data.totalOrderValue.toString()}")),
    DataCell(StatefulBuilder(
      builder: (context, setState) {
        return SpinnerWidget(

          items: const ['Ordered', 'Delivered', 'Cancelled'],
          onChanged: (value, index) {
            setState((){
              selectedSpinnerValue=value;
            });
            print("value changed $value");
          //  cubit.selectItem(value, data);


            // Handle the selected value
          },
          selectedValue:
          selectedSpinnerValue, // Provide the initial selected value
        );
      },
    ))
  ]);
}

