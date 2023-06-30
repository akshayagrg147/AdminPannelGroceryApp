import 'dart:developer';

import 'package:adminpannelgrocery/models/AddProductResponse.dart';
import 'package:adminpannelgrocery/models/AllOrders.dart';
import 'package:adminpannelgrocery/models/login_response.dart';
import 'package:adminpannelgrocery/repositories/Modal/RecentOrderCountResponse.dart';
import 'package:adminpannelgrocery/repositories/Modal/UserResponse.dart';
import 'package:adminpannelgrocery/repositories/Modal/add_item_category_response.dart';
import 'package:adminpannelgrocery/repositories/api/dio-utils.dart';
import 'package:dio/dio.dart';

import '../../models/productScreenModal.dart';
import '../Modal/AddedItemResponse.dart';
import '../Modal/AllProducts.dart';
import '../Modal/HomeProduct.dart';
import '../Modal/product_category_modal.dart';
import 'api.dart';

class ProductRepository {
  Api api = Api();
   final _dio = DioUtil().getInstance();
  Future<AddProductResponse> addCategory(String category) async {
    try {
      final Map<String, String> mp = {
        'category': category,
      };
      final response = await _dio?.post("/Admin/AddItemCategory",data: mp);
      if (response?.statusCode == 200) {
        AddProductResponse postMaps = AddProductResponse.fromJson(response?.data);
        return postMaps;
      } else {
        print(response?.statusCode);
      }
    } catch (ex) {
      rethrow;
    }
    return AddProductResponse();
  }
  Future<LoginResponse> login(String email,String password) async {
    try {
      final Map<String, String> mp = {
        'email': email,
        'password': password,
      };
      final response = await _dio?.post("/Admin/Login",data: mp);
      if (response?.statusCode == 200) {
        LoginResponse postMaps = LoginResponse.fromJson(response?.data);
        return postMaps;
      } else {
        print(response?.statusCode);
      }
    } catch (ex) {
      rethrow;
    }
    return LoginResponse();
  }

  Future<AddProductResponse> addProduct(ProductScreenModal object) async {
    try {
      final response = await _dio?.post("/Admin/AddProduct",data: object);
      if (response?.statusCode == 200) {
        AddProductResponse postMaps =
            AddProductResponse.fromJson(response?.data);
        return postMaps;
      } else {
        print(response?.statusCode);
      }
    } catch (ex) {
      rethrow;
    }
    return AddProductResponse();
  }
  Future<AddProductResponse> deleteProduct(String projectId) async {
    try {
      final response = await _dio?.get("/Admin/deleteProduct", queryParameters: {"projectId": projectId});
      if (response?.statusCode == 200) {
        AddProductResponse postMaps =
        AddProductResponse.fromJson(response?.data);
        return postMaps;
      } else {
        print(response?.statusCode);
      }
    } catch (ex) {
      rethrow;
    }
    return AddProductResponse();
  }
  Future<AddProductResponse> deleteCategory(String categoryName) async {
    try {
      final response = await _dio?.get("/Admin/deleteCategory", queryParameters: {"categoryName": categoryName});
      if (response?.statusCode == 200) {
        AddProductResponse postMaps =
        AddProductResponse.fromJson(response?.data);
        return postMaps;
      } else {
        print(response?.statusCode);
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
    return AllProducts(itemData: <ItemData>[],statusCode: 200,message: "true");
  }
  Future<ProductCategoryModal> fetchCategory() async {
    try {
      final response = await _dio?.get("/Admin/getProductCategory");
      print("sucess error");
      print(response?.statusMessage);

      if (response?.statusCode == 200) {
        ProductCategoryModal res = ProductCategoryModal.fromJson(response?.data);
        return res;
      } else {
        print("DioError status code${response?.statusCode}");
      }
    } catch (ex) {
      print("catch error");
      print(ex.toString());
      rethrow;
    }
    return ProductCategoryModal();
  }
  Future<AllOrders> fetchOrders(int page,int limit) async {
    try {
      final response = await _dio?.get("/Admin/AllOrdersByPages", queryParameters: {"skip": page,"limit": limit});
      print("sucess order");
      print(response?.statusMessage);

      if (response?.statusCode == 200) {
        AllOrders products = AllOrders.fromJson(response?.data);
        return products;
      } else {
        print("DioError status code${response?.statusCode}");
      }
    } catch (ex) {
      print("catch error");
      print(ex.toString());
      rethrow;
    }
    return AllOrders();
  }
  Future<RecentOrderCountResponse> fetchRecentOrderCount() async {
    try {
      final response = await _dio?.get("/Admin/RecentOrderCount");
      print("sucess print");
      print(response?.statusMessage);

      if (response?.statusCode == 200) {
        RecentOrderCountResponse products = RecentOrderCountResponse.fromJson(response?.data);
        return products;
      } else {
        print("DioError status code${response?.statusCode}");
      }
    } catch (ex) {
      print("catch error");
      print(ex.toString());
      rethrow;
    }
    return RecentOrderCountResponse();
  }
  Future<UserResponse> userResponse() async {
    try {
      final response = await _dio?.get("/Admin/AllUsers");
      print("sucess error");
      print(response?.statusMessage);

      if (response?.statusCode == 200) {
        UserResponse products = UserResponse.fromJson(response?.data);
        return products;
      } else {
        print("DioError status code${response?.statusCode}");
      }
    } catch (ex) {
      print("catch error");
      print(ex.toString());
      rethrow;
    }
    return UserResponse();
  }
}
