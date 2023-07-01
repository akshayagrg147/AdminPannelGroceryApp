import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/AllOrders.dart';

class OrderItems extends StatelessWidget {
  final List<OrderData>? itemData;
  final ScrollController scrollController;

  const OrderItems(this.itemData, {Key? key, required this.scrollController})
      : super(key: key);

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
            "Total Orders",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            width: double.infinity,
            height: 600,
            child: DataTable2(
              scrollController: scrollController,
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
                  label: Text("Status"),
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
              ],
              rows: List.generate(
                itemData?.length??0,
                    (index) => productItemRow(itemData![index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow productItemRow(OrderData data) {
  Function(OrderData) fnData;
  SizedBox(height: 16.0);
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
          title: Text(data.orderList![index].productName.toString()),
        );
      },
    )),
    DataCell(Row(
      children: [
        IconButton(
          icon: Icon(Icons.check),
          onPressed: () {
            // Perform delete operation
          },
        ),
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            // Perform delete operation
          },
        )
      ],
    )),
    DataCell(Text(data.mobilenumber.toString())),
    DataCell(Text(data.address.toString())),
    DataCell(Text(data.paymentmode.toString())),
    DataCell(Text("₹${data.totalOrderValue.toString()}")),
  ]);
}
