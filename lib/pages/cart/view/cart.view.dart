import 'package:cart_app/providers/cart.provider.dart';
import 'package:cart_app/utilities/extensions.dart';
import 'package:cart_app/widgets/product_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Cart extends ConsumerStatefulWidget {
  static const String name = 'cart';
  const Cart({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartState();
}

//todo: update cart page, counter not working correctly

class _CartState extends ConsumerState<Cart> {
  @override
  Widget build(BuildContext context) {
    final cartRef = ref.watch(cartProvider);
    return Scaffold(
      backgroundColor: Colors.red.shade50,
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () {},
              child: const Icon(
                Icons.delete_outline_rounded,
                size: 30,
              ),
            ),
          )
        ],
      ),
      body: ListView.separated(
        itemCount: ref.read(cartProvider).productList!.length,
        itemBuilder: (context, index) {
          return ProductTileWidget(
            product: ref.read(cartProvider).productList![index],
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 8,
          );
        },
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Amount Price",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 0.7,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      cartRef.totalCost.inRupees,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 30,
                        letterSpacing: 0.7,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    elevation: const MaterialStatePropertyAll(0),
                    backgroundColor: MaterialStatePropertyAll(
                      Colors.pink.shade500,
                    ),
                    padding: const MaterialStatePropertyAll(
                      EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 20,
                      ),
                    ),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Text(
                        "Check Out",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          letterSpacing: 0.7,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          cartRef.totalQuantity.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.pink,
                            fontSize: 16,
                            letterSpacing: 0.7,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
