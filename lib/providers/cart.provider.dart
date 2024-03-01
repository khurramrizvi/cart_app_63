//will be used to manage cart
import 'package:cart_app/models/cart_model.dart';
import 'package:cart_app/models/products_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartProvider = StateNotifierProvider<CartProvider, CartModel>((ref) {
  return CartProvider(CartModel());
});

class CartProvider extends StateNotifier<CartModel> {
  CartProvider(super.state);

  //add item in cart
  void addItem(Product product) {
    List<Product> list = [];
    if (state.productList == null) {
      list.add(product);
      state = CartModel(
        productList: list,
        totalCost: _getTotalPrice(list),
        totalQuantity: _getTotalQuantity(list),
      );
    } else {
      list = state.productList!;
      if (list.any((element) => element.id == product.id)) {
        list[list.indexWhere((element) => element.id == product.id)] = product;
      } else {
        list.add(product);
      }
      state = CartModel(
        productList: list,
        totalCost: _getTotalPrice(list),
        totalQuantity: _getTotalQuantity(list),
      );
    }
  }

  //remove item from cart
  void removeItem(Product product) {
    List<Product> list = [];
    if (state.productList != null) {
      list = state.productList!;
      if (list.any((element) => element.id == product.id)) {
        list[list.indexWhere((element) => element.id == product.id)] = product;
      } else {
        list.remove(product);
      }
      state = CartModel(
        productList: list,
        totalCost: _getTotalPrice(list),
        totalQuantity: _getTotalQuantity(list),
      );
    }
  }

  num _getTotalPrice(List<Product> list) {
    num totalPrice = 0.0;
    list.forEach((element) {
      totalPrice += element.price!;
    });
    return totalPrice;
  }

  int _getTotalQuantity(List<Product> list) {
    int totalQuantity = 0;
    list.forEach((element) {
      totalQuantity += element.quantity;
    });
    return totalQuantity;
  }
}
