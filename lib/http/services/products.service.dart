import 'package:cart_app/http/http.dart';
import 'package:cart_app/models/products_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productServiceProvider = Provider<ProductService>((ref) {
  return ProductService();
});

class ProductService {
  Future<Products?> getProductList({
    int limit = 20,
    int skip = 0,
  }) async {
    try {
      Response res = await Http.productsEndpoint.get(
        'https://dummyjson.com/products?limit=$limit&skip=$skip',
      );
      return Products.fromJson(res.data);
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
