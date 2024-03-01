import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailsView extends ConsumerStatefulWidget {
  static const String name = '/details';
  const ProductDetailsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductDetailsViewState();
}

class _ProductDetailsViewState extends ConsumerState<ProductDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
