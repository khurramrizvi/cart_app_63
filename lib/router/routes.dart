import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routesProvider = Provider((ref) => Routes());
GlobalKey<NavigatorState> parentKey = GlobalKey<NavigatorState>();

class Routes {
  final router = GoRouter(
    routes: <RouteBase>[],
  );
}
