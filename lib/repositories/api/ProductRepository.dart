import 'dart:developer';

import 'package:adminpannelgrocery/models/AddProductResponse.dart';
import 'package:adminpannelgrocery/repositories/api/dio-utils.dart';
import 'package:dio/dio.dart';

import '../../models/productScreenModal.dart';
import '../Modal/AddedItemResponse.dart';
import '../Modal/AllProducts.dart';
import '../Modal/HomeProduct.dart';
import 'api.dart';

class ProductRepository {
  Api api = Api();
   final _dio = DioUtil().getInstance();

  Future<AddProductResponse> addProduct(ProductScreenModal object) async {
    try {
      Response response = await api.sendRequest.post("/Admin/AddProduct",data: object);
      if (response.statusCode == 200) {
        AddProductResponse postMaps =
            AddProductResponse.fromJson(response.data);
        return postMaps;
      } else {
        print(response.statusCode);
      }
    } catch (ex) {
      rethrow;
    }
    return AddProductResponse();
  }

  Future<AllProducts> fetchPosts() async {
    try {
      final response = await _dio?.get("/Admin/allProducts");
      print("sucess error");
      print(response?.statusMessage);

      if (response?.statusCode == 200) {
        AllProducts products = AllProducts.fromJson(response?.data);
        return products;
      } else {
        print("DioError status code${response?.statusCode}");
      }
    } catch (ex) {
      print("catch error");
      print(ex.toString());
      rethrow;
    }
    return AllProducts();
  }
}
