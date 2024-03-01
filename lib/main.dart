import 'package:cart_app/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';

late String tempPath;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tempPath = (await getTemporaryDirectory()).path;
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routesProvider).router;
    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(
        textTheme: GoogleFonts.muktaMalarTextTheme(),
        primaryColor: Colors.pink.shade50,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.pink.shade50,
          elevation: 0,
        ),
      ),
      title: '63Carts',
    );
  }
}
