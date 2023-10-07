import 'package:adminpannelgrocery/models/AddProductResponse.dart';
import 'package:adminpannelgrocery/models/AllOrders.dart';
import 'package:adminpannelgrocery/models/login_response.dart';
import 'package:adminpannelgrocery/repositories/Modal/RecentOrderCountResponse.dart';
import 'package:adminpannelgrocery/repositories/Modal/UserResponse.dart';
import 'package:adminpannelgrocery/repositories/Modal/add_bannercategory_modal.dart';
import 'package:adminpannelgrocery/repositories/api/dio-utils.dart';
import 'package:dio/dio.dart';
import '../../models/request_modal.dart';
import '../../sharedpreference/PreferencesUtil.dart';
import '../Modal/CouponFormData.dart';
import '../Modal/AllProducts.dart';
import '../Modal/add_category_modal.dart';

import '../../models/productScreenModal.dart';
import '../Modal/allCouponsResponse.dart';
import '../Modal/banner_category_modal.dart';
import '../Modal/product_category_modal.dart';
import 'api.dart';

class ProductRepository {
  Api api = Api();
  final _dio = DioUtil().getInstance();

  Future<AddProductResponse> addCategory(
      String category, String image, List<SubCategoryListData> list) async {
    try {
      // final Map<String, dynamic> mp = {
      //   'category': category,
      //   'imageUrl':image,
      //  ' subCategoryList':list
      // };
      String? pincode = await PreferencesUtil.getString('pincode');
      final response = await _dio?.post("/Admin/AddItemCategory",
          data: AddCategoryModal(
              category: category,
              imageUrl: image,
              subCategoryList: list,
              pincode: pincode));
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

  Future<AddProductResponse> addBannerCategory(
      String banner1,
      String image1,
      String banner2,
      String imag2,
      String banner3,
      String imag3,
      List<SubBannerCategoryList> list) async {
    try {
      // final Map<String, dynamic> mp = {
      //   'category': category,
      //   'imageUrl':image,
      //  ' subCategoryList':list
      // };
      String? pincode = await PreferencesUtil.getString('pincode');

      final response = await _dio?.post("/Admin/AddBannerCategory",
          data: AddBannerCategoryModal(
              banner1: banner1,
              imageUrl1: image1,
              banner2: banner2,
              imageUrl2: imag2,
              banner3: banner3,
              imageUrl3: imag3,
              subCategoryList: list,
              pincode: pincode));
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

  Future<AddProductResponse> updateBannerCategory(
      String banner1,
      String image1,
      String banner2,
      String imag2,
      String banner3,
      String imag3,
      List<SubBannerCategoryList> list) async {
    try {
      // final Map<String, dynamic> mp = {
      //   'category': category,
      //   'imageUrl':image,
      //  ' subCategoryList':list
      // };
      String? pincode = await PreferencesUtil.getString('pincode');

      final response = await _dio?.post("/Admin/UpdateBannerCategory",
          data: AddBannerCategoryModal(
              banner1: banner1,
              imageUrl1: image1,
              banner2: banner2,
              imageUrl2: imag2,
              banner3: banner3,
              imageUrl3: imag3,
              subCategoryList: list,
              pincode: pincode));
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

  Future<LoginResponse> login(RequestLoginBody request) async {
    try {
      final response = await _dio?.post("/Admin/Login", data: request);
      if (response?.statusCode == 200) {
        LoginResponse postMaps = LoginResponse.fromJson(response?.data);
        return postMaps;
      } else {
        throw DioError(
          requestOptions: RequestOptions(path: "/Admin/Login"),
          response: response,
        );
      }
    } catch (ex) {
      print("Exception during login request: $ex");
      rethrow;
    }

  }

  Future<AddProductResponse> addProduct(ProductScreenModal object) async {
    try {
      String? pincode = await PreferencesUtil.getString('pincode');
      object.pincode = pincode;
      final response = await _dio?.post("/Admin/AddProduct", data: object);
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
      final response = await _dio?.delete(
        "/Admin/deleteProduct/$productId",
      );
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

  Future<AddProductResponse> deleteCoupon(String couponName) async {
    try {
      final response = await _dio?.delete(
        "/Admin/deleteCoupon/$couponName",
      );

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
      final response = await _dio?.delete(
        "/Admin/deleteCategory/$categoryName",
      );
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

  Future<AddProductResponse> deleteBannerCategory(String bannerName) async {
    try {
      final response = await _dio?.delete(
        "/Admin/deleteBanner/$bannerName",
      );
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
      final response = await _dio?.post("/Admin/updateProduct", data: data);
      print("sucess error");
      print(response?.statusMessage);

      if (response?.statusCode == 200) {
        AddProductResponse products =
            AddProductResponse.fromJson(response?.data);
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

  Future<AllProducts> fetchProducts(int page, int limit) async {
    try {
      String? pincode = await PreferencesUtil.getString('pincode');
      final response = await _dio?.get("/Admin/allProducts",
          queryParameters: {"skip": page, "limit": limit, "pincode": pincode});

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
    return AllProducts(itemData: [], statusCode: 200, message: "true");
  }

  Future<AllProducts> fetchSearchProductWise(String query) async {
    try {
      String? pincode = await PreferencesUtil.getString('pincode');

      final response = await _dio?.get("/Admin/SearchAllProducts",
          queryParameters: {"pincode": pincode, "query": query});
      print("sucess error");
      print(response?.statusMessage);

      if (response?.statusCode == 200) {
        AllProducts res = AllProducts.fromJson(response?.data);
        return res;
      } else {
        print("DioError status code${response?.statusCode}");
      }
    } catch (ex) {
      print("catch error");
      print(ex.toString());
      rethrow;
    }
    return AllProducts(
        itemData: [], statusCode: 400, message: 'something went wrong');
  }

  Future<ProductCategoryModal> fetchCategory() async {
    try {
      String? pincode = await PreferencesUtil.getString('pincode');
      final response = await _dio?.get("/Admin/getProductCategory",
          queryParameters: {"pincode": pincode});
      print("sucess error");
      print(response?.statusMessage);

      if (response?.statusCode == 200) {
        ProductCategoryModal res =
            ProductCategoryModal.fromJson(response?.data);
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

  Future<BannerCategoryModal> fetchBannerCategory() async {
    try {
      String? pincode = await PreferencesUtil.getString('pincode');
      final response = await _dio?.get("/Admin/getBannerCategory",
          queryParameters: {"pincode": pincode});

      print("sucess error");
      print(response?.statusMessage);

      if (response?.statusCode == 200) {
        BannerCategoryModal res = BannerCategoryModal.fromJson(response?.data);
        return res;
      } else {
        print("DioError status code${response?.statusCode}");
      }
    } catch (ex) {
      print("catch error");
      print(ex.toString());
      rethrow;
    }
    return BannerCategoryModal();
  }

  Future<BannerCategoryModal> deleteImageKit(String fileId) async {
    try {
      final response = await _dio?.get("/Admin/deleteImageIoFile",
          queryParameters: {"fileId": fileId});

      print("sucess error");
      print(response?.statusMessage);

      if (response?.statusCode == 200) {
        BannerCategoryModal res = BannerCategoryModal.fromJson(response?.data);
        return res;
      } else {
        print("DioError status code${response?.statusCode}");
      }
    } catch (ex) {
      print("catch error");
      print(ex.toString());
      rethrow;
    }
    return BannerCategoryModal();
  }

  Future<allCouponsResponse> fetchAllCoupons() async {
    try {
      String? pincode = await PreferencesUtil.getString('pincode');

      final response = await _dio
          ?.get("/Admin/allCoupons", queryParameters: {"pincode": pincode});
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

  Future<AllOrders> fetchOrders(int page, int limit) async {
    try {
      print("skip_order ${page}  $limit");
      String? pincode = await PreferencesUtil.getString('pincode');

      final response = await _dio?.get("/Admin/AllOrdersByPages",
          queryParameters: {"skip": page, "limit": limit, "pincode": pincode});

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

  Future<RecentOrderCountResponse>  fetchRecentOrderCount() async {
    try {
      String? pincode = await PreferencesUtil.getString('pincode');
      final response = await _dio?.get("/Admin/RecentOrderCount",
          queryParameters: {"pincode": pincode});
      print("request_print $pincode");
      print(response?.statusMessage);

      if (response?.statusCode == 200) {
        RecentOrderCountResponse products =
            RecentOrderCountResponse.fromJson(response?.data);
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

  Future<AddProductResponse> updateProduct(ProductScreenModal obj) async {
    try {
      String? pincode = await PreferencesUtil.getString('pincode');
      obj.pincode = pincode ?? "";
      final response = await _dio?.post("/Admin/updateProduct", data: obj);
      print("sucess error");
      print(response?.statusMessage);

      if (response?.statusCode == 200) {
        AddProductResponse products =
            AddProductResponse.fromJson(response?.data);
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

  Future<AddProductResponse> updateDeliveryAmount(String amount) async {
    try {
      String? pincode = await PreferencesUtil.getString('pincode');
      String? name = await PreferencesUtil.getString('name');
      String? email = await PreferencesUtil.getString('email');
      String? password = await PreferencesUtil.getString('password');
      String?  city  = await PreferencesUtil.getString('city');
      String?  deliveryContactNumber = await PreferencesUtil.getString('deliveryContactNumber');
      String?  fcm_token  = await PreferencesUtil.getString('fcm_token');

      final response = await _dio?.post("/Admin/freeDelivery",
          data: ResponseLogin(
              email: email,
              password: password,
              pincode: pincode,
              name: name,
              price: amount,
          city: city,
          deliveryContactNumber: deliveryContactNumber,
          fcm_token: fcm_token,

          ));
      print("sucess error");
      print(response?.statusMessage);

      if (response?.statusCode == 200) {
        AddProductResponse products =
            AddProductResponse.fromJson(response?.data);
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

  Future<AddProductResponse> addCoupons(CouponFormData obj) async {
    try {
      String? pincode = await PreferencesUtil.getString('pincode');
      obj.pincode = pincode ?? "";
      final response = await _dio?.post("/Admin/AddCoupon", data: obj.toJson());
      print("sucess error");
      print(response?.statusMessage);

      if (response?.statusCode == 200) {
        AddProductResponse products =
            AddProductResponse.fromJson(response?.data);
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

  Future<AddProductResponse> updateStatus(OrderData obj) async {
    try {
      print("jsonRequest ${obj.toJson()}");
      final response =
          await _dio?.post("/Admin/OrderStatus", data: obj.toJson());

      print(response?.statusMessage);

      if (response?.statusCode == 200) {
        AddProductResponse products =
            AddProductResponse.fromJson(response?.data);
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

  updatefcmtokenRepo(String? name, String? pincode, String? email, String? password, String? city, String? deliveryContactNumber, String? fcm_token, String? price)  {
    ResponseLogin obj= ResponseLogin(name: name,pincode: pincode,email: email,password: password,city: city,deliveryContactNumber: deliveryContactNumber,fcm_token: fcm_token,price: price);
     _dio?.post("/Admin/freeDelivery", data: obj.toJson());
  }
}
