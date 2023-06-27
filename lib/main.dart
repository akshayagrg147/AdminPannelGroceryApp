import 'package:adminpannelgrocery/constants.dart';
import 'package:adminpannelgrocery/controllers/MenuController.dart';
import 'package:adminpannelgrocery/repositories/api/ProductRepository.dart';
import 'package:adminpannelgrocery/repositories/cubit/AddProductCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/AllOrderCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/AllProductCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/DeleteProductCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/RecentOrderCountCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/UserResponseCubit.dart';
import 'package:adminpannelgrocery/screens/dashboard/NavScreen/NavigationBloc.dart';
import 'package:adminpannelgrocery/screens/main/main_screen.dart';
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
          BlocProvider<NavigationBloc>(create: (context) => NavigationBloc(context)),

          BlocProvider<AddProductCubit>(
              create: (context) => AddProductCubit()),

          BlocProvider<AllProductCubit>(
              create: (context) => AllProductCubit()),
          BlocProvider<UserResponseCubit>(
              create: (context) => UserResponseCubit()),
          BlocProvider<DeleteProductCubit>(
              create: (context) => DeleteProductCubit()),
          BlocProvider<AllOrderCubit>(
              create: (context) => AllOrderCubit(context.read<ProductRepository>())..loadOrders()),
          BlocProvider<RecentOrderCubit>(
              create: (context) => RecentOrderCubit())

        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Admin Panel',
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: bgColor,
            textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
                .apply(bodyColor: Colors.white),
            canvasColor: secondaryColor,
          ),
          home: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => MenuController1(),
              ),
            ],
            child: MainPage(),
          ),
        ),
      ),
    );
  }
}
