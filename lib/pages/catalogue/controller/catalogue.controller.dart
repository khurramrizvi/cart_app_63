import 'package:cart_app/http/services/products.service.dart';
import 'package:cart_app/models/products_model.dart';
import 'package:cart_app/pages/catalogue/model/catalogue.model.dart';
import 'package:cart_app/utilities/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final catalogueControllerProvider =
    StateNotifierProvider<CatalogueController, CatalogueModel>(
  (ref) => CatalogueController(
    ref.read(productServiceProvider),
    providerRef: ref,
  ),
);

class CatalogueController extends StateNotifier<CatalogueModel> {
  final ProductService service;
  final StateNotifierProviderRef providerRef;
  CatalogueController(
    this.service, {
    required this.providerRef,
  }) : super(CatalogueModel());

  int skip = 0;
  int total = 0;

  Future<void> fetchCatalogues() async {
    try {
      state = CatalogueModel(
        status: ScreenStatus.loading,
        productList: null,
      );
      Products? productsList = await service.getProductList();

      if (productsList != null) {
        total = productsList.total!;
        state = CatalogueModel(
          status: ScreenStatus.ready,
          productList: productsList.products,
        );
      } else {
        state = CatalogueModel(
          status: ScreenStatus.error,
          productList: null,
        );
      }
    } catch (e) {
      state = CatalogueModel(
        status: ScreenStatus.error,
        productList: null,
      );
      debugPrint(e.toString());
    }
  }

  Future<void> fetchMoreProduct() async {
    try {
      if (skip == total) {
        state = CatalogueModel(
          status: ScreenStatus.ready,
          productList: state.productList!,
        );
        return;
      }
      skip += 20;
      state = CatalogueModel(
        status: ScreenStatus.fetchingMore,
        productList: state.productList!,
      );

      Products? productsList = await service.getProductList(
        skip: skip,
      );
      if (productsList != null) {
        state = CatalogueModel(
          status: ScreenStatus.ready,
          productList: [
            ...state.productList!,
            ...productsList.products!,
          ],
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
