import 'package:adminpannelgrocery/constants.dart';
import 'package:adminpannelgrocery/repositories/api/ProductRepository.dart';
import 'package:adminpannelgrocery/repositories/cubit/AddBannerCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/AddCategoryCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/AddCouponsCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/AddProductCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/AllCouponsCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/AllOrderCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/AllProductCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/BannerCategoryCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/DeleteBannerCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/DeleteCategoryCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/DeleteCouponCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/DeleteProductCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/ProductCategoryCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/RecentOrderCountCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/SelectionCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/UpdateDeliveryCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/UpdateOrderStatusCubit.dart';

import 'package:adminpannelgrocery/repositories/cubit/UserResponseCubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/best_selling_checkbox_cubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/exclusive_selling_checkbox_cubit.dart';
import 'package:adminpannelgrocery/repositories/cubit/login_response_cubit.dart';
import 'package:adminpannelgrocery/screens/Login/login_screen.dart';
import 'package:adminpannelgrocery/screens/dashboard/NavScreen/NavigationBloc.dart';
import 'package:adminpannelgrocery/state/delete_product_state.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyCeE21bDpuy89r-XmSCm-Ke-brkuDvPXQo',
        appId:'1:558459610565:web:14ffdb29a7fe0efa9097ac',
        messagingSenderId: '558459610565',
        projectId: 'mandixpress-d67a9',
        storageBucket: "mandixpress-d67a9.appspot.com",
      ),
    );
    runApp(MyApp());
  } catch (e) {
    print("Error initializing Firebase: $e");
  }
}


class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  void showFlutterNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    playSampleSound();
  }

  void playSampleSound() async {
    final player = AudioPlayer();
    await player.play(UrlSource('https://ik.imagekit.io/00itvcwwk/shopeefood_sound.mp3?updatedAt=1696573541986'));
    // AudioService().playSound(AssetSource('sound/beep.mp3'));
    setState(() {

    });
  }

  @override
  void initState() {
    FirebaseMessaging.onMessage.listen(showFlutterNotification);
    super.initState();

  } // This widget is the root of your application.
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
                  create: (context) => UpdateOrderStatusCubit()),
              BlocProvider<BestSellingCheckBoxCubit>(
                  create: (context) => BestSellingCheckBoxCubit()),
              BlocProvider<ExclusiveCheckBoxCubit>(
                  create: (context) => ExclusiveCheckBoxCubit()),
              BlocProvider<BannerCategoryCubit>(
                  create: (context) => BannerCategoryCubit()),
              BlocProvider<DeleteBannerCubit>(
                  create: (context) => DeleteBannerCubit()),
              BlocProvider<AddBannerCubit>(
                  create: (context) => AddBannerCubit()),
              BlocProvider<UpdateDeliveryCubit>(
                  create: (context) => UpdateDeliveryCubit()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Admin Panel',
              theme: ThemeData.dark().copyWith(
                scaffoldBackgroundColor: Colors.white,
                textTheme:
                    GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
                        .apply(bodyColor: Colors.black),
                canvasColor: secondaryColor,
              ),
              home: FutureBuilder<bool?>(
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // While waiting for the data, you can show a loading indicator or placeholder
                    return CircularProgressIndicator();
                  }
                  else {
                    false; // Use a default value if data is null
                    //if (!loginSave) {
                    return LoginScreen();
                    // } else {
                    //   return HomeScreen();
                    // }
                  }
                }, future: null,
              ),
            )));
  }

}

class AudioService {

  AudioService._();

  static final AudioService _instance = AudioService._();

  factory AudioService() {
    return _instance;
  }

  void playSound(AssetSource assetSource) async{
    AudioPlayer().play(assetSource, mode: PlayerMode.lowLatency); // faster play low latency eg for a game...
  }
}
