import 'package:json_annotation/json_annotation.dart';
part 'products_model.g.dart';

@JsonSerializable()
class Products {
  List<Product>? products;
  int? total;
  int? skip;
  int? limit;

  Products({
    this.products,
    this.total,
    this.skip,
    this.limit,
  });

  factory Products.fromJson(Map<String, dynamic> json) =>
      _$ProductsFromJson(json);
}

@JsonSerializable()
class Product {
  int? id;
  String? title;
  String? description;
  int? price;
  double? discountPercentage;
  double? rating;
  int? stock;
  String? brand;
  String? category;
  String? thumbnail;
  List<String>? images;

  Product({
    this.id,
    this.title,
    this.description,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.brand,
    this.category,
    this.thumbnail,
    this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}