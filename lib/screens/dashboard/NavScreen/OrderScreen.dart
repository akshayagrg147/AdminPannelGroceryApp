import 'package:adminpannelgrocery/models/OrderScreenModal.dart';
import 'package:adminpannelgrocery/repositories/cubit/AllOrderCubit.dart';
import 'package:adminpannelgrocery/responsive.dart';
import 'package:adminpannelgrocery/screens/main/components/side_menu.dart';
import 'package:adminpannelgrocery/state/all_orders_state.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants.dart';
import '../../../models/AllOrders.dart';
import '../components/header.dart';
import '../components/my_fields.dart';
import '../components/order_item.dart';
import '../components/product_item.dart';
import '../components/recent_files.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => OrderScreenState();
}

class OrderScreenState extends State<OrderScreen> {
  late AllOrderCubit Cubit;

  List<ItemData>?  listProducts=[];


  @override
  void initState() {
    super.initState();
    Cubit = BlocProvider.of<AllOrderCubit>(context);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        drawer: const SideMenu(),
        body: SingleChildScrollView(
          child: Column(
            children: [
// if(listProducts?.isNotEmpty ?? true)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (Responsive.isDesktop(context))
                    const Expanded(
                      child: SideMenu(),
                    ),
                  Expanded(
                    flex: 5,
                    child: SafeArea(
                      child: BlocConsumer<AllOrderCubit, AllOrderState>(
                        listener: (context, state) {
                          if (state is AllOrderErrorState) {
                            SnackBar snackBar = SnackBar(
                              content: Text(state.error),
                              backgroundColor: Colors.red,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        builder: (context, state) {
                          if (state is AllOrderLoadingState) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is AllOrderLoadedState) {
                            var obj = state.orders;
                            listProducts=obj.itemData;
                            return OrderItems(obj.itemData);
                            //   return Text("${obj.message}");
                          } else if (state is AllOrderErrorState) {
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










