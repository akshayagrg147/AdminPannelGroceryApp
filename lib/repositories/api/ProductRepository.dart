import 'dart:developer';


import 'package:adminpannelgrocery/models/AddProductResponse.dart';
import 'package:dio/dio.dart';

import '../Modal/AddedItemResponse.dart';
import '../Modal/AllProducts.dart';
import '../Modal/HomeProduct.dart';
import 'api.dart';

class ProductRepository {

  Api api = Api();

  Future<AddProductResponse> addProduct() async {
    try {
      Response response = await api.sendRequest.post("/Admin/AddProduct");
      if(response.statusCode==200){
        AddProductResponse postMaps = AddProductResponse.fromJson(response.data);
        return postMaps;
      }
      else{
        print(response.statusCode);
      }


    }
    catch(ex) {
      rethrow;
    }
    return AddProductResponse();
  }
    Future<AllProducts> fetchPosts() async {
      try {
        Response response = await api.sendRequest.post("/Admin/allProducts");
        if(response.statusCode==200){
          AllProducts postMaps = AllProducts.fromJson(response.data);
          return postMaps;
        }
        else{
          print(response.statusCode);
        }


      }
      catch(ex) {
        rethrow;
      }
      return AllProducts();
    }


}