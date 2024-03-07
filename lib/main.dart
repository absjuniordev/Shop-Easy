import 'package:flutter/material.dart';
// import 'package:shop/pages/counter_page.dart';
import 'package:shop/pages/product_datail_page.dart';
import 'package:shop/pages/products_overview_page.dart';
// import 'package:shop/providers/counter.dart';
import 'package:shop/utils/app_routes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    //    return CounterProvider(

    return MaterialApp(
      title: "Meu Shop",
      debugShowCheckedModeBanner: false,
      home: ProductsOverviewPage(),
      theme: ThemeData(
        fontFamily: 'Lato',
        primarySwatch: Colors.purple,
        hintColor: Colors.deepOrange,
        appBarTheme: const AppBarTheme(
          color: Colors.purple,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      routes: {
        AppRoutes.PRODUCT_DETAIL: (context) => const ProductDatailPage(),
      },
    );
  }
}
