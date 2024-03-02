import 'package:cached_network_image/cached_network_image.dart';
import 'package:cart_app/models/products_model.dart';
import 'package:cart_app/providers/cart.provider.dart';
import 'package:cart_app/utilities/extensions.dart';
import 'package:cart_app/widgets/counter/counter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductTileWidget extends ConsumerStatefulWidget {
  final Product product;
  const ProductTileWidget({
    required this.product,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductTileWidgetState();
}

class _ProductTileWidgetState extends ConsumerState<ProductTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 0.1,
          color: Colors.grey.shade300,
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 160,
            width: 120,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              border: Border.all(
                width: 0.1,
                color: Colors.grey.shade500,
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(
                  widget.product.thumbnail!,
                  maxHeight: 200,
                  maxWidth: 200,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.only(top: 8, bottom: 8, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 200,
                    child: Text(
                      widget.product.title!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 16,
                        letterSpacing: 0.7,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Text(
                    widget.product.brand!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      letterSpacing: 0.7,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: widget.product.price!.inRupees,
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
                          text: (widget.product.price! -
                                  widget.product.price! *
                                      widget.product.discountPercentage! /
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
                    '${widget.product.discountPercentage}% OFF',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      letterSpacing: 0.7,
                      fontWeight: FontWeight.w500,
                      color: Colors.pink.shade300,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: CounterWidget(
                      productId: widget.product.id!,
                      onIncrement: (val) {
                        ref.read(cartProvider.notifier).addItem(
                              widget.product.copyWith(
                                Product(
                                  quantity: val,
                                ),
                              ),
                            );
                      },
                      onDecrement: (val) {
                        ref.read(cartProvider.notifier).removeItem(
                              widget.product.copyWith(
                                Product(
                                  quantity: val,
                                ),
                              ),
                            );
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
