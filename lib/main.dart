import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/model/cart.dart';
import 'package:shop/model/order_list.dart';
import 'package:shop/model/product_list.dart';
import 'package:shop/pages/cart_page.dart';
import 'package:shop/pages/order_page.dart';
// import 'package:shop/pages/counter_page.dart';
import 'package:shop/pages/product_datail_page.dart';
import 'package:shop/pages/product_form_page.dart';
import 'package:shop/pages/products_overview_page.dart';
import 'package:shop/pages/products_page.dart';
import 'package:shop/utils/app_routes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    //    return CounterProvider(

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductList(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderList(),
        ),
      ],
      child: MaterialApp(
        title: "Meu Shop",
        debugShowCheckedModeBanner: false,
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
        // home: const ProductsOverviewPage(),
        routes: {
          AppRoutes.HOME: (context) => const ProductsOverviewPage(),
          AppRoutes.PRODUCT_DETAIL: (context) => const ProductDatailPage(),
          AppRoutes.CART: (context) => const CartPage(),
          AppRoutes.ORDERS: (context) => const OrderPage(),
          AppRoutes.PRODUCTS_PAGE: (context) => const ProductsPage(),
          AppRoutes.PRODUCTS_FORM_PAGE: (context) => const ProductFormPage(),
        },
      ),
    );
  }
}
