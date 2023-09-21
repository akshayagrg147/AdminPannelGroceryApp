import 'package:data_table_2/data_table_2.dart' hide SelectionState;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

import '../../../commonWidget/sppiner.dart';
import '../../../constants.dart';
import '../../../models/AllOrders.dart';
import '../../../repositories/cubit/AllOrderCubit.dart';
import '../../../repositories/cubit/SelectionCubit.dart';
import '../../../repositories/cubit/UpdateOrderStatusCubit.dart';
import '../../../state/SelectionState.dart';
import '../../../state/add_order_state.dart';

class OrderItems extends StatefulWidget {
    List<OrderData>? itemData;
  final ScrollController scrollController;

  OrderItems(this.itemData, {Key? key, required this.scrollController})
      : super(key: key);

  @override
  State<OrderItems> createState() => _OrderItemsState();
}

class _OrderItemsState extends State<OrderItems> {
  late SelectionCubit cubit;
  late UpdateOrderStatusCubit orderStatus;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<SelectionCubit>(context);
    orderStatus=BlocProvider.of<UpdateOrderStatusCubit>(context);
  }
@override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<SelectionCubit, SelectionState>(
              builder: (context, state) {
                print("updated_value 1 ${state}");
                if (state is SelectionUpdated) {
                  print("updated_value 2 ${state.selectedItem} ${state.data} ${state.data.orderStatus}");
                  state.data.orderStatus = state.selectedItem;
                  orderStatus.updateOrderStatus(state.data);
                  return Container();
                }
                return Container();
              },
            ),
            BlocConsumer<UpdateOrderStatusCubit, AddOrderState>(
              listener: (context, state) {
                if (state is AddOrderLoadedState) {
                  SnackBar snackBar = const SnackBar(
                    content: Text('status updated'),
                    backgroundColor: Colors.green,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else if (state is AddOrderErrorState) {
                  SnackBar snackBar = SnackBar(
                    content: Text("${state.error.toString()}"),
                    backgroundColor: Colors.green,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              builder: (context, state) {
                print("updated_value ${state}");
                return Container();
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Orders",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                GestureDetector(
                  onTap: () {
                    // Handle the click action here
                    _selectDate(context);
                  },
                  child: Text(
                    'Filter',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              height: 800,
              child: DataTable2(
                scrollController: widget.scrollController,
                columnSpacing: defaultPadding,
                dataRowHeight: 60.0,
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
                    label: Text("Date"),
                  ),
                  DataColumn(
                    label: Text("Payment in Rs"),
                  ),
                  DataColumn(
                    label: Text("Status"),
                  ),
                ],
                rows: List.generate(
                  widget.itemData?.length ?? 0,
                      (index) {
                   print("productitemlist ${ widget.itemData?.length} ");
                    return productItemRow(widget.itemData![index], cubit);
                  },
                ),
              ),
            ),

            GestureDetector(
              onTap: (){
                BlocProvider.of<AllOrderCubit>(context).loadOrders();
              },
              child:  const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("next page>>",textAlign: TextAlign.right,),
                ],
              )  ,
            )

          ],
        ),
      ),
    );
  }


  DateTime selectedDate = DateTime.now(); // Initialize with the current date

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;

        print("${selectedDate.day}/${selectedDate.month}/${selectedDate.year}");
        widget.itemData=[];
      });
    }
  }
}

DataRow productItemRow(OrderData data, SelectionCubit cubit) {
  // Function(OrderData) fnData;
  String selectedSpinnerValue = data.orderStatus??"Ordered";
  // SizedBox(height: 16.0);
  return DataRow(cells: [
    DataCell(
  Row(
  children: [
  Expanded(
      child: Padding(
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
  },
  ),
  ),
  ),
    ])),
    DataCell(Text(data.orderId!)),
    DataCell(ListView.builder(
      shrinkWrap: true,
      itemCount: data.orderList!.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(data.orderList![index].productName.toString()),
        );
      },
    )),
    DataCell(Text(data.mobilenumber.toString())),
    DataCell(Text(data.address.toString())),
    DataCell(Text(data.paymentmode.toString())),
    DataCell(Text(data.createdDate.toString())),
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
       cubit.selectItem(value, data);
        sendEmail();

        // Handle the selected value
      },
      selectedValue:
          selectedSpinnerValue, // Provide the initial selected value
    );
  },
    ))
  ]);
}


sendEmail() async {

  String username = 'akshaygarg147@gmail.com';
  String password = '7973434833';

  final smtpServer = gmail(username, password);

  // Create our message.
  final message = Message()
    ..from = Address(username, 'Akshay')
    ..recipients.add('grgakshay@gmail.com')
    // ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
    // ..bccRecipients.add(Address('bccAddress@example.com'))
    ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
    ..text = 'This is the plain text.\nThis is line 2 of the text part.'
    ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }
  // DONE

}
