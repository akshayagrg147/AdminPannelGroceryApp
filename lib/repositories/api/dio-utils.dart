import 'dart:convert';
import 'dart:developer';

// import 'package:chefkart/core/constants/app-text-style.dart';
// import 'package:chefkart/core/constants/color_pallete.dart';
// import 'package:chefkart/core/constants/tts-text.dart';
// import 'package:chefkart/core/image-path/image-paths.dart';
// import 'package:chefkart/core/responsive/size_config.dart';
// import 'package:chefkart/feature/log-in-flow/services/remote_services.dart';
// import 'package:chefkart/src/presentation/widgets/onboarded-user-widgets/alertBoxSpeakerOff.dart';
// import 'package:chefkart/src/presentation/widgets/onboarded-user-widgets/alertBoxSpeakerOn.dart';
// import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DioUtil {
  Dio? _instance;
//method for getting dio instance
  Dio? getInstance() {
    if (_instance == null) {
      _instance = createDioInstance();
    }
    return _instance;
  }

  Dio createDioInstance() {
    var dio = Dio();
    dio.options.baseUrl = "https://cced-2401-4900-1c55-6017-4579-7e39-7cf9-52c7.ngrok-free.app";
    dio.interceptors.clear();
    return dio
      ..interceptors
          .add(InterceptorsWrapper(onRequest: (options, handler) async {
            log(options.toString());
        // options.headers["Authorization"] = "Bearer " + accessToken;
        //     'Content-type': 'application/json'
        options.headers["Content-type"] = "application/json";
        // options.headers["X-APP-CODE"] = "COOK";
        return handler.next(options); //modify your request
      }, onResponse: (response, handler) {
        // ignore: unnecessary_null_comparison
        if (response != null) {
          //on success it is getting called here
          print(response);
          return handler.next(response);
        } else {
          return handler.next(response);
        }
      }, onError: (DioError e, handler) async {
        log(e.error.toString());
        // if (e.response != null) {
        //   if (e.response!.statusCode == 403 || e.response!.statusCode == 401) {
        //     //catch the 401 here
        //     dio.interceptors.requestLock.lock();
        //     dio.interceptors.responseLock.lock();
        //     RequestOptions requestOptions = e.requestOptions;
        //     // await initOauthDependencies();
        //     try {
        //       final loginController = Get.find<LoginController>();
        //       await loginController.updateAccessToken();
        //       var accessToken = await OTPRemoteServices.getAccessToken();
        //       if (accessToken != null) {
        //         final opts = new Options(method: requestOptions.method);
        //         dio.options.headers["Authorization"] = "Bearer " + accessToken;
        //         dio.options.headers["Accept"] = "*/*";
        //         dio.interceptors.requestLock.unlock();
        //         dio.interceptors.responseLock.unlock();
        //         log(requestOptions.queryParameters.toString());
        //
        //         final response = await dio.request(requestOptions.path,
        //             options: opts,
        //             cancelToken: requestOptions.cancelToken,
        //             onReceiveProgress: requestOptions.onReceiveProgress,
        //             data: requestOptions.data,
        //             queryParameters: requestOptions.queryParameters);
        //         // ignore: unnecessary_null_comparison
        //         if (response != null) {
        //           handler.resolve(response);
        //         } else {
        //           return null;
        //         }
        //       }
        //     } catch (err) {
        //       handler.resolve(e.response!);
        //     }
        //   }
        //   if (e.response!.statusCode == 452) {
        //     final SnackBar snackBar = SnackBar(
        //         backgroundColor: Colors.transparent,
        //         elevation: 0.0,
        //         content: Container(
        //             decoration: BoxDecoration(
        //                 color: errorBarColor,
        //                 borderRadius: BorderRadius.circular(7)),
        //             child: Padding(
        //               padding: EdgeInsets.symmetric(
        //                   horizontal: 16 * SizeConfig.widthMultiplier!,
        //                   vertical: 15 * SizeConfig.heightMultiplier!),
        //               child: Text(
        //                 tr('leaveError'),
        //                 style: AppTextStyle.whiteSemiBoldText.copyWith(
        //                     fontSize: 13 * SizeConfig.textMultiplier!),
        //               ),
        //             )));
        //     snackbarKey.currentState?.showSnackBar(snackBar);
        //   }
        //   if (e.response!.statusCode == 411) {
        //     final SnackBar snackBar = SnackBar(
        //         backgroundColor: Colors.transparent,
        //         elevation: 0.0,
        //         content: Container(
        //             decoration: BoxDecoration(
        //                 color: errorBarColor,
        //                 borderRadius: BorderRadius.circular(7)),
        //             child: Padding(
        //               padding: EdgeInsets.symmetric(
        //                   horizontal: 16 * SizeConfig.widthMultiplier!,
        //                   vertical: 15 * SizeConfig.heightMultiplier!),
        //               child: Text(
        //                 tr('checkinError'),
        //                 style: AppTextStyle.whiteSemiBoldText.copyWith(
        //                     fontSize: 13 * SizeConfig.textMultiplier!),
        //               ),
        //             )));
        //     snackbarKey.currentState?.showSnackBar(snackBar);
        //   }
        //   if (e.response!.statusCode == 410) {
        //     return showDialog(
        //         barrierColor: kLightBlack.withOpacity(0.8),
        //         context: Get.context!,
        //         builder: (context) {
        //           return Dialog(
        //             backgroundColor: Colors.transparent,
        //             insetAnimationDuration: const Duration(milliseconds: 100),
        //             shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.circular(8)),
        //             child: Column(
        //               mainAxisSize: MainAxisSize.min,
        //               children: [
        //                 GestureDetector(
        //                   onTap: () {
        //                     TTSText.instance.dispose();
        //                     Navigator.pop(context);
        //                   },
        //                   child: Container(
        //                     height: 48 * SizeConfig.heightMultiplier!,
        //                     width: 48 * SizeConfig.heightMultiplier!,
        //                     decoration: BoxDecoration(
        //                         color: kPureWhite,
        //                         borderRadius: BorderRadius.all(Radius.circular(
        //                             24 * SizeConfig.heightMultiplier!))),
        //                     child: Padding(
        //                       padding: EdgeInsets.all(
        //                           14 * SizeConfig.heightMultiplier!),
        //                       child: SvgPicture.asset(
        //                         ImagePath.crossIcon,
        //                         fit: BoxFit.contain,
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //                 SizedBox(
        //                   height: 12 * SizeConfig.heightMultiplier!,
        //                 ),
        //                 Container(
        //                   height: 382 * SizeConfig.heightMultiplier!,
        //                   width: Get.width,
        //                   decoration: BoxDecoration(
        //                       color: kPureWhite,
        //                       borderRadius: BorderRadius.all(Radius.circular(
        //                           8 * SizeConfig.heightMultiplier!))),
        //                   child: Stack(
        //                     children: [
        //                       Row(
        //                         mainAxisAlignment: MainAxisAlignment.end,
        //                         children: [
        //                           Obx(
        //                             () => TTSText.instance.ttsPlayStatus[
        //                                         "leavecheckinTTS"] ==
        //                                     true
        //                                 ? GestureDetector(
        //                                     onTap: () {
        //                                       TTSText.instance.dispose();
        //                                     },
        //                                     child: AlertBoxSpeakerOn())
        //                                 : GestureDetector(
        //                                     onTap: () {
        //                                       TTSText.instance.playTts(
        //                                           tr('leavecheckinerrorTTS'),
        //                                           "leavecheckinTTS");
        //                                     },
        //                                     child: AlertBoxSpeakerOff(),
        //                                   ),
        //                           )
        //                         ],
        //                       ),
        //                       Center(
        //                         child: Column(
        //                           mainAxisSize: MainAxisSize.min,
        //                           crossAxisAlignment: CrossAxisAlignment.center,
        //                           children: [
        //                             SizedBox(
        //                               height: 10 * SizeConfig.heightMultiplier!,
        //                             ),
        //                             SvgPicture.asset(
        //                               ImagePath.exclamation,
        //                               height: 60 * SizeConfig.heightMultiplier!,
        //                               width: 60 * SizeConfig.heightMultiplier!,
        //                               fit: BoxFit.contain,
        //                             ),
        //                             SizedBox(
        //                               height: 16 * SizeConfig.heightMultiplier!,
        //                             ),
        //                             Padding(
        //                               padding: EdgeInsets.symmetric(
        //                                   horizontal:
        //                                       15 * SizeConfig.widthMultiplier!),
        //                               child: Text(
        //                                 tr('LeavecheckinHeading'),
        //                                 textAlign: TextAlign.center,
        //                                 style: AppTextStyle.blackSemiBoldHeader
        //                                     .copyWith(
        //                                         color: Color.fromRGBO(
        //                                             166, 49, 42, 1),
        //                                         fontSize: 16 *
        //                                             SizeConfig.textMultiplier!),
        //                               ),
        //                             ),
        //                             SizedBox(
        //                               height: 4 * SizeConfig.heightMultiplier!,
        //                             ),
        //                             Padding(
        //                               padding: EdgeInsets.symmetric(
        //                                   horizontal:
        //                                       15 * SizeConfig.widthMultiplier!),
        //                               child: Text(
        //                                 tr('LeavecheckinSubHeading'),
        //                                 textAlign: TextAlign.center,
        //                                 style: AppTextStyle.blackRegularText
        //                                     .copyWith(
        //                                         fontSize: 15 *
        //                                             SizeConfig.textMultiplier!),
        //                               ),
        //                             ),
        //                             SizedBox(
        //                               height: 16 * SizeConfig.heightMultiplier!,
        //                             ),
        //                             Container(
        //                               height: 40 * SizeConfig.heightMultiplier!,
        //                               width: 270 * SizeConfig.widthMultiplier!,
        //                               child: ElevatedButton(
        //                                   child: Text(
        //                                     tr('agree'),
        //                                     style: AppTextStyle.whiteBoldHeader
        //                                         .copyWith(
        //                                             fontSize: 14 *
        //                                                 SizeConfig
        //                                                     .textMultiplier!),
        //                                   ),
        //                                   style: ElevatedButton.styleFrom(
        //                                     shape: RoundedRectangleBorder(
        //                                       borderRadius:
        //                                           BorderRadius.circular(12),
        //                                     ),
        //                                     backgroundColor:
        //                                         Color.fromRGBO(36, 36, 36, 1),
        //                                     textStyle: const TextStyle(
        //                                         color: Colors.white,
        //                                         fontSize: 10,
        //                                         fontStyle: FontStyle.normal),
        //                                   ),
        //                                   onPressed: () {
        //                                     Navigator.pop(context);
        //                                   }),
        //                             ),
        //                           ],
        //                         ),
        //                       )
        //                     ],
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           );
        //         });
        //   }
        //   if (e.response!.statusCode == 500 || e.response!.statusCode == 400) {
        //     try {
        //       var responseData = jsonDecode(e.response.toString());
        //       final SnackBar snackBar = SnackBar(
        //           backgroundColor: Colors.transparent,
        //           elevation: 0.0,
        //           content: Container(
        //               decoration: BoxDecoration(
        //                   color: errorBarColor,
        //                   borderRadius: BorderRadius.circular(7)),
        //               child: Padding(
        //                 padding: EdgeInsets.symmetric(
        //                     horizontal: 16 * SizeConfig.widthMultiplier!,
        //                     vertical: 15 * SizeConfig.heightMultiplier!),
        //                 child: Text(
        //                   responseData['error'] ?? "invalid request",
        //                   style: AppTextStyle.whiteSemiBoldText.copyWith(
        //                       fontSize: 13 * SizeConfig.textMultiplier!),
        //                 ),
        //               )));
        //       snackbarKey.currentState?.showSnackBar(snackBar);
        //     } catch (e) {
        //       final SnackBar snackBar = SnackBar(
        //           backgroundColor: Colors.transparent,
        //           elevation: 0.0,
        //           content: Container(
        //               decoration: BoxDecoration(
        //                   color: errorBarColor,
        //                   borderRadius: BorderRadius.circular(7)),
        //               child: Padding(
        //                 padding: EdgeInsets.symmetric(
        //                     horizontal: 16 * SizeConfig.widthMultiplier!,
        //                     vertical: 15 * SizeConfig.heightMultiplier!),
        //                 child: Text(
        //                   "invalid request",
        //                   style: AppTextStyle.whiteSemiBoldText.copyWith(
        //                       fontSize: 13 * SizeConfig.textMultiplier!),
        //                 ),
        //               )));
        //       snackbarKey.currentState?.showSnackBar(snackBar);
        //     }
        //
        //     handler.resolve(e.response!);
        //   } else {
        //     handler.resolve(e.response!);
        //   }
        // }
      }));
  }
}

// class AuthInterceptor extends Interceptor {
//   static bool isRetryCall = false;
//
//   @override
//   void onRequest(
//       RequestOptions options, RequestInterceptorHandler handler) async {
//     bool _token = isTokenExpired(token);
//     bool _refresh = isTokenExpired(refresh);
//     bool _refreshed = true;
//
//     if (_refresh) {
//       appAuth.logout();
//       EasyLoading.showInfo('Expired session');
//       DioError _err;
//       handler.reject(_err);
//     } else if (_token) {
//       _refreshed = await appAuth.refreshToken();
//     }
//     if (_refreshed) {
//       options.headers["Authorization"] = "Bearer " + token;
//       options.headers["Accept"] = "application/json";
//
//       handler.next(options);
//     }
//   }
//
//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) async {
//     handler.next(response);
//   }
//
//   @override
//   void onError(DioError err, ErrorInterceptorHandler handler) async {
//     handler.next(err);
//   }
// }
