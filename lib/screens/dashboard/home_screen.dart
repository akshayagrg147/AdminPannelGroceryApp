import 'package:adminpannelgrocery/repositories/cubit/RecentOrderCountCubit.dart';
import 'package:adminpannelgrocery/responsive.dart';
import 'package:adminpannelgrocery/screens/dashboard/components/my_fields.dart';
import 'package:adminpannelgrocery/state/recent_order_count_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants.dart';
import '../../sharedpreference/PreferencesUtil.dart';
import '../main/components/side_menu.dart';
import 'components/header.dart';

import 'components/headerDashboard.dart';
import 'components/recent_files.dart';
import 'components/storage_details.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}




class _HomeScreenState extends State<HomeScreen> {
  late RecentOrderCubit cubit;
  String? name;
  String? pincode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(false),
      body: SafeArea(
        child: Row(
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

                    SafeArea(
                      child: BlocConsumer<
                          RecentOrderCubit,
                          RecentOrderCountState>(
                        listener: (context, state) {
                          if (state is RecentOrderCountErrorState) {
                            SnackBar snackBar = SnackBar(
                              content: Text(state.error),
                              backgroundColor: Colors.red,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        builder: (context, state) {
                          if (state is RecentOrderCountLoadingState) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is RecentOrderCountLoadedState) {
                            var obj = state.response;
                            print('print my fields1 ${obj.countResponse
                                ?.length}');
                            return Column(

                              children: [

                                DashboardHeader(
                                  imageUrl: state.response.image ?? "",
                                  name:" $name\n$pincode"?? "null", title: "Dashboard",),
                                SizedBox(height: defaultPadding),
                                CardViewCount(obj.countResponse),
                                const SizedBox(height: defaultPadding),
                                RecentOrders(obj.recentOrders),
                                if (Responsive.isMobile(context))
                                  const SizedBox(height: defaultPadding),
                                if (Responsive.isMobile(context))
                                  const StarageDetails()
                              ],

                            );
                          } else if (state is RecentOrderCountErrorState) {
                            return Center(
                              child: Text(state.error),
                            );
                          }

                          return Container();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // if (!Responsive.isMobile(context))
            //   const SizedBox(width: defaultPadding),
            // if (!Responsive.isMobile(context))
            //   const Expanded(flex: 2, child: StarageDetails(),
            //   ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    cubit = BlocProvider.of<RecentOrderCubit>(context);
    cubit.fetchAllOrderCount();


  }
  Future<void> fetchData() async {
    name = await PreferencesUtil.getString('name');
    pincode= await PreferencesUtil.getString('pincode');
    // After fetching the value, trigger a rebuild
    setState(() {});
  }
}