import 'package:cached_network_image/cached_network_image.dart';
import 'package:cart_app/models/products_model.dart';
import 'package:cart_app/providers/cart.provider.dart';
import 'package:cart_app/utilities/extensions.dart';
import 'package:cart_app/widgets/counter/counter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductCardWidget extends ConsumerWidget {
  final Product product;
  const ProductCardWidget({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 0.1,
          color: Colors.grey.shade500,
        ),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  border: Border.all(
                    width: 0.1,
                    color: Colors.grey.shade500,
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                      product.thumbnail!,
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      product.title!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        letterSpacing: 0.7,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      product.brand!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        letterSpacing: 0.7,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: product.price!.inRupees,
                                    style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 9,
                                      letterSpacing: 0.7,
                                      fontWeight: FontWeight.w200,
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor: Colors.grey,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: ' ',
                                  ),
                                  TextSpan(
                                    text: (product.price! -
                                            product.price! *
                                                product.discountPercentage! /
                                                100)
                                        .inRupees,
                                    style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 12,
                                      letterSpacing: 0.7,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Text(
                              '${product.discountPercentage}% OFF',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                letterSpacing: 0.7,
                                fontWeight: FontWeight.w500,
                                color: Colors.pink.shade300,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          Positioned(
            top: 160,
            right: 8,
            child: CounterWidget(
              productId: product.id!,
              onIncrement: (val) {
                ref.read(cartProvider.notifier).addItem(
                      product.copyWith(
                        Product(
                          quantity: val,
                        ),
                      ),
                    );
              },
              onDecrement: (val) {
                ref.read(cartProvider.notifier).removeItem(
                      product.copyWith(
                        Product(
                          quantity: val,
                        ),
                      ),
                    );
              },
            ),
          ),
        ],
      ),
    );
  }
}
