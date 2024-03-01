import 'package:cart_app/models/products_model.dart';
import 'package:cart_app/utilities/enums.dart';

class CatalogueModel {
  final ScreenStatus status;
  final List<Product>? productList;

  CatalogueModel({
    this.status = ScreenStatus.loading,
    this.productList,
  });

  CatalogueModel copyWith({ScreenStatus? status, List<Product>? productList}) {
    return CatalogueModel(
      productList: productList ?? this.productList,
      status: status ?? this.status,
    );
  }
}
