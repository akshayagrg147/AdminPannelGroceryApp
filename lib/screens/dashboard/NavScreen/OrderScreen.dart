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
import '../../../repositories/cubit/UpdateOrderStatusCubit.dart';
import '../../../state/add_order_state.dart';
import '../components/header.dart';
import '../components/headerDashboard.dart';
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
  final scrollController = ScrollController();
  List<OrderData>?  listProducts=[];

  void setupScrollController(context) {
    scrollController.addListener(() {
      print('scroll listenre');
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          print('scroll listenre');
          BlocProvider.of<AllOrderCubit>(context).loadOrders();
        }
      }

    });
  }


  @override
  void initState() {
    super.initState();
    Cubit = BlocProvider.of<AllOrderCubit>(context);
   // Cubit.resetState();
  //  setupScrollController(context);
    Cubit.loadOrders();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        drawer: const SideMenu(false),

        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                child: SideMenu(true),
              ),
            Expanded(
              flex: 5,
              child: SingleChildScrollView(

                child: Column(
                  children: [
                    DashboardHeader(
                      imageUrl:  "",
                      name:  "null", title: "Orders",),
                    BlocConsumer<UpdateOrderStatusCubit, AddOrderState>(
                      listener: (context, state) {
                        if (state is AddOrderLoadedState) {
                          if(state.products.statusCode==200){
                            SnackBar snackBar = const SnackBar(
                              content: Text('status updated'),
                              backgroundColor: Colors.green,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                          else{
                            SnackBar snackBar = const SnackBar(
                              content: Text('something went wrong'),
                              backgroundColor: Colors.redAccent,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }


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
                    BlocConsumer<AllOrderCubit, AllOrderState>(
                      listener: (context, state) {
                        if (state is AllOrderErrorState) {
                          SnackBar snackBar = SnackBar(
                            content: Text(state.error),
                            backgroundColor: Colors.red,
                          );
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackBar);
                          Cubit.resetState();

                        }

                      },
                      builder: (context, state) {
                        List<OrderData> orders = [];
                        bool isLoading = false;
                        if (state is AllLoadingMoreState && state.isFirstFetch) {
                          return const Center(child: CircularProgressIndicator());
                        }
                       else if (state is AllOrderLoadingState) {
                         //  return const Center(
                         //    child: CircularProgressIndicator(),
                         // );
                        }
                       else if (state is AllLoadingMoreState) {
                          orders = state.oldPosts;
                          isLoading = true;
                          //   return Text("${obj.message}");
                        }
                        else if (state is AllOrderLoadedState) {
                          listProducts=state.itemData;
                          return OrderItems(state.itemData, scrollController: scrollController,);
                          //   return Text("${obj.message}");
                        }
                        else if (state is AllOrderErrorState) {
                          return Center(
                            child: Text(state.error),
                          );
                        }

                        return Container();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}










