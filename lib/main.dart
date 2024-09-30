import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/presentation/cart_page.dart';
import 'package:provider_app/presentation/product_view_page.dart';
import 'package:provider_app/application/cart_provieder.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => const ProductViewPage(),
        "/cart": (context) => const CartPage(),
      },
    );
  }
}
