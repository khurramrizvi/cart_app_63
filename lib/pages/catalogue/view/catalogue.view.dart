import 'package:cart_app/pages/cart/view/cart.view.dart';
import 'package:cart_app/pages/catalogue/controller/catalogue.controller.dart';
import 'package:cart_app/providers/cart.provider.dart';
import 'package:cart_app/utilities/enums.dart';
import 'package:cart_app/widgets/product_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CatalogueView extends ConsumerStatefulWidget {
  static const String name = '/';
  const CatalogueView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CatalogueViewState();
}

class _CatalogueViewState extends ConsumerState<CatalogueView> {
  ScrollController controller = ScrollController();
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(catalogueControllerProvider.notifier).fetchCatalogues();
      controller.addListener(() async {
        if (ref.read(catalogueControllerProvider).status ==
            ScreenStatus.ready) {
          if (controller.offset >= controller.position.maxScrollExtent) {
            await ref
                .read(catalogueControllerProvider.notifier)
                .fetchMoreProduct();
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final catalogueRef = ref.watch(catalogueControllerProvider);

    return Scaffold(
      backgroundColor: Colors.red.shade50,
      appBar: AppBar(
        title: const Text('Catalogue'),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 24),
            child: GestureDetector(
              onTap: () {
                context.go('/${Cart.name}');
              },
              child: Badge(
                backgroundColor: Colors.pink.shade500,
                label: Text(
                  ref.watch(cartProvider).totalQuantity < 10
                      ? '0${ref.watch(cartProvider).totalQuantity.toString()}'
                      : ref.watch(cartProvider).totalQuantity.toString(),
                ),
                smallSize: 18,
                largeSize: 18,
                child: const Icon(
                  Icons.shopping_cart_outlined,
                  size: 30,
                ),
              ),
            ),
          )
        ],
      ),
      body: Visibility(
        visible: catalogueRef.status == ScreenStatus.ready ||
            catalogueRef.status == ScreenStatus.fetchingMore,
        replacement: Visibility(
          visible: catalogueRef.status == ScreenStatus.loading,
          replacement: const Center(
            child: Text('Error Fetching Data'),
          ),
          child: Center(
            child: CircularProgressIndicator(
              color: Colors.pink.shade400,
            ),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(4),
          child: GridView.builder(
            controller: controller,
            //  physics: AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4,
              mainAxisSpacing: 8,
              mainAxisExtent: 300,
            ),
            itemCount: catalogueRef.productList?.length,
            itemBuilder: (context, index) => ProductCardWidget(
              product: catalogueRef.productList![index],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Visibility(
        visible: catalogueRef.status == ScreenStatus.fetchingMore,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: CircularProgressIndicator(
                color: Colors.pink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
