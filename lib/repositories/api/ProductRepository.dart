import 'dart:developer';


import 'package:dio/dio.dart';

import '../Modal/AddedItemResponse.dart';
import '../Modal/AllProducts.dart';
import '../Modal/HomeProduct.dart';
import 'api.dart';

class ProductRepository {

  Api api = Api();


  Future<List<ItemData>> fetchPosts() async {
    try {
      Response response = await api.sendRequest.post("/Admin/allProducts");
      AllProducts postMaps = AllProducts.fromJson(response.data);
      return postMaps.itemData!;
    }
    catch(ex) {
      rethrow;
    }
  }


}