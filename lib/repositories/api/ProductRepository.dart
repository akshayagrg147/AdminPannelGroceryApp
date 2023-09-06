

import 'package:adminpannelgrocery/models/AddProductResponse.dart';
import 'package:adminpannelgrocery/models/AllOrders.dart';
import 'package:adminpannelgrocery/models/login_response.dart';
import 'package:adminpannelgrocery/repositories/Modal/RecentOrderCountResponse.dart';
import 'package:adminpannelgrocery/repositories/Modal/UserResponse.dart';
import 'package:adminpannelgrocery/repositories/Modal/add_item_category_response.dart';
import 'package:adminpannelgrocery/repositories/api/dio-utils.dart';
import 'package:dio/dio.dart';
import '../Modal/CouponFormData.dart';
import '../Modal/AllProducts.dart';
import '../Modal/add_category_modal.dart';

import '../../models/productScreenModal.dart';
import '../Modal/AddedItemResponse.dart';
import '../Modal/AllProducts.dart';
import '../Modal/HomeProduct.dart';
import '../Modal/add_category_modal.dart';
import '../Modal/allCouponsResponse.dart';
import '../Modal/product_category_modal.dart';
import 'api.dart';

class ProductRepository {
  Api api = Api();
   final _dio = DioUtil().getInstance();
  Future<AddProductResponse>  addCategory(String category,String image, List<SubCategoryListData> list) async {
    try {
      // final Map<String, dynamic> mp = {
      //   'category': category,
      //   'imageUrl':image,
      //  ' subCategoryList':list
      // };
      final response = await _dio?.post("/Admin/AddItemCategory",data: AddCategoryModal(category: category,imageUrl: image, subCategoryList:list ));
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
  Future<AddProductResponse> deleteProduct(String productId) async {
    try {
      final response = await _dio?.delete("/Admin/deleteProduct/$productId", );
     print("deleted data $response");
      if (response?.statusCode == 200) {
        AddProductResponse postMaps =
        AddProductResponse.fromJson(response?.data);
        return postMaps;
      } else {
        print(response?.statusCode);
      }
    } catch (ex) {
      print("deleted data ${ex}");
      rethrow;
    }
    return AddProductResponse();
  }
  Future<AddProductResponse> deleteCoupon(String couponName) async {
    try {

      final response = await _dio?.delete("/Admin/deleteCoupon/$couponName", );

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
      final response = await _dio?.delete("/Admin/deleteCategory/$categoryName", );
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
  Future<AddProductResponse> updateSellingCheckBox(ItemData data) async {
    try {

        final response = await _dio?.post("/Admin/updateProduct",data: data);
      print("sucess error");
      print(response?.statusMessage);

      if (response?.statusCode == 200 ) {
        AddProductResponse products = AddProductResponse.fromJson(response?.data);
        return products;
      } else {
        print("DioError status code${response?.statusCode}");
      }
    } catch (ex) {
      print("catch error");
      print(ex.toString());
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
    return AllProducts(itemData: [],statusCode: 200,message: "true");
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
  Future<allCouponsResponse> fetchAllCoupons() async {
    try {
      final response = await _dio?.post("/Admin/allCoupons");
      print("sucess error");
      print(response?.statusMessage);

      if (response?.statusCode == 200) {
        allCouponsResponse res = allCouponsResponse.fromJson(response?.data);
        return res;
      } else {
        print("DioError status code${response?.statusCode}");
      }
    } catch (ex) {
      print("catch error");
      print(ex.toString());
      rethrow;
    }
    return allCouponsResponse();
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
        print("catch error ${response?.statusCode}");
        UserResponse products = UserResponse.fromJson(response?.data);
        return products;
      } else {
        print("DioError status code${response?.statusCode}");
      }
    } catch (ex) {
      print("catch error ${ex}");
      print(ex.toString());
      rethrow;
    }
    return UserResponse();
  }
  Future<AddProductResponse> updateProduct( ProductScreenModal obj) async {
    try {

      final response = await _dio?.post("/Admin/updateProduct",data: obj);
      print("sucess error");
      print(response?.statusMessage);

      if (response?.statusCode == 200 ) {
        AddProductResponse products = AddProductResponse.fromJson(response?.data);
        return products;
      } else {
        print("DioError status code${response?.statusCode}");
      }
    } catch (ex) {
      print("catch error");
      print(ex.toString());
      rethrow;
    }
    return AddProductResponse();
  }

  Future<AddProductResponse> addCoupons( CouponFormData obj) async {
    try {

      final response = await _dio?.post("/Admin/AddCoupon",data: obj.toJson());
      print("sucess error");
      print(response?.statusMessage);

      if (response?.statusCode == 200 ) {
        AddProductResponse products = AddProductResponse.fromJson(response?.data);
        return products;
      } else {
        print("DioError status code${response?.statusCode}");
      }
    } catch (ex) {
      print("catch error");
      print(ex.toString());
      rethrow;
    }
    return AddProductResponse();
  }
  Future<AddProductResponse> updateStatus( OrderData obj) async {
    try {

      print("jsonRequest ${obj.toJson()}");
      final response = await _dio?.post("/Admin/OrderStatus",data: obj.toJson());

      print(response?.statusMessage);

      if (response?.statusCode == 200 ) {
        AddProductResponse products = AddProductResponse.fromJson(response?.data);
        return products;
      } else {
        print("DioError status code${response?.statusCode}");
      }
    } catch (ex) {
      print("catch error");
      print(ex.toString());
      rethrow;
    }
    return AddProductResponse();
  }
}
