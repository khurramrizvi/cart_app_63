import 'package:cart_app/models/products_model.dart';

class CartModel {
  final List<Product>? productList;
  final num totalCost;
  final int totalQuantity;

  CartModel({
    this.productList,
    this.totalCost = 0,
    this.totalQuantity = 0,
  });
}
