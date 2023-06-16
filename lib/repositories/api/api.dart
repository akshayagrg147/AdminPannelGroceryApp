import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
class Api{
  final Dio _dio=Dio();
      Api(){
        _dio.options.baseUrl = "https://e543-45-64-93-64.ngrok-free.app";
        _dio.interceptors.add(PrettyDioLogger());
        _dio.options.headers['content-Type'] = 'application/json';
        _dio.interceptors.add(PrettyDioLogger());

      }
  Dio get sendRequest => _dio;
}