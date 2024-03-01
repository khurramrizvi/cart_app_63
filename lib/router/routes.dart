import 'package:cart_app/pages/cart/view/cart.view.dart';
import 'package:cart_app/pages/catalogue/view/catalogue.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routesProvider = Provider((ref) => Routes());
GlobalKey<NavigatorState> parentKey = GlobalKey<NavigatorState>();

class Routes {
  final router = GoRouter(
    initialLocation: CatalogueView.name,
    routes: <RouteBase>[
      GoRoute(
        path: CatalogueView.name,
        builder: (context, state) => const CatalogueView(),
        routes: [
          GoRoute(
            path: Cart.name,
            builder: (context, state) => const Cart(),
          )
        ],
      ),
    ],
  );
}
