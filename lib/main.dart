import 'package:adminpannelgrocery/constants.dart';
import 'package:adminpannelgrocery/controllers/DrawerController.dart';
import 'package:adminpannelgrocery/repositories/api/ProductRepository.dart';
import 'package:adminpannelgrocery/repositories/cubit/AddCategoryCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/AddCouponsCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/AddProductCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/AllCouponsCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/AllOrderCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/AllProductCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/DeleteCategoryCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/DeleteCouponCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/DeleteProductCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/ProductCategoryCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/RecentOrderCountCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/SelectionCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/UpdateOrderStatusCubit.dart';

import 'package:adminpannelgrocery/repositories/cubit/UserResponseCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/login_response_cubit.dart';
import 'package:adminpannelgrocery/screens/Login/login_screen.dart';
import 'package:adminpannelgrocery/screens/dashboard/NavScreen/CouponScreen.dart';
import 'package:adminpannelgrocery/screens/dashboard/NavScreen/NavigationBloc.dart';
import 'package:adminpannelgrocery/screens/dashboard/home_screen.dart';
import 'package:adminpannelgrocery/screens/main/main_screen.dart';
import 'package:adminpannelgrocery/sharedpreference/PreferencesUtil.dart';
import 'package:adminpannelgrocery/state/delete_product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => ProductRepository(),
        child: MultiBlocProvider(
            providers: [
              BlocProvider<NavigationBloc>(
                  create: (context) => NavigationBloc(context)),
              BlocProvider<AddProductCubit>(
                  create: (context) => AddProductCubit()),
              BlocProvider<AllProductCubit>(
                  create: (context) => AllProductCubit()),
              BlocProvider<UserResponseCubit>(
                  create: (context) => UserResponseCubit()),
              BlocProvider<DeleteProductCubit>(
                  create: (context) => DeleteProductCubit()),
              BlocProvider<AllOrderCubit>(
                  create: (context) =>
                      AllOrderCubit(context.read<ProductRepository>())),
              BlocProvider<RecentOrderCubit>(
                  create: (context) => RecentOrderCubit()),
              BlocProvider<ProductCategoryCubit>(
                  create: (context) => ProductCategoryCubit()),
              BlocProvider<AddCategoryCubit>(
                  create: (context) => AddCategoryCubit()),
              BlocProvider<DeleteCategoryCubit>(
                  create: (context) =>
                      DeleteCategoryCubit(DeleteProductInitialState())),
              BlocProvider<LoginResponseCubit>(
                  create: (context) => LoginResponseCubit()),
              BlocProvider<AddCouponsCubit>(
                  create: (context) => AddCouponsCubit()),
              BlocProvider<AllCouponsCubit>(
                  create: (context) => AllCouponsCubit()),
              BlocProvider<DeleteCouponCubit>(
                  create: (context) => DeleteCouponCubit()),
              BlocProvider<SelectionCubit>(
                  create: (context) => SelectionCubit()),
              BlocProvider<UpdateOrderStatusCubit>(
                  create: (context) => UpdateOrderStatusCubit())
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Admin Panel',
              theme: ThemeData.dark().copyWith(
                scaffoldBackgroundColor: bgColor,
                textTheme:
                    GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
                        .apply(bodyColor: Colors.white),
                canvasColor: secondaryColor,
              ),
              home: FutureBuilder<bool?>(
                // Use FutureBuilder to wait for the shared preferences value
                future: PreferencesUtil.getString("login_save"),
                // Make sure the method name matches
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // While waiting for the data, you can show a loading indicator or placeholder
                    return CircularProgressIndicator();
                  } else {
                    final bool loginSave = snapshot.data ??
                        false; // Use a default value if data is null
                    //if (!loginSave) {
                      return LoginScreen();
                    // } else {
                    //   return HomeScreen();
                    // }
                  }
                },
              ),
            )));
  }
}
