import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/model/provider/auth.dart';
import 'package:shop/model/provider/cart.dart';
import 'package:shop/model/provider/order_list.dart';
import 'package:shop/model/provider/product_list.dart';
import 'package:shop/pages/auth_or_home_page.dart';
import 'package:shop/pages/cart_page.dart';
import 'package:shop/pages/order_page.dart';
import 'package:shop/pages/product_datail_page.dart';
import 'package:shop/pages/product_form_page.dart';
import 'package:shop/pages/products_page.dart';
import 'package:shop/pages/splash_page.dart';
import 'package:shop/utils/app_routes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductList>(
          create: (_) => ProductList(),
          update: (context, auth, previous) {
            return ProductList(
              auth.token ?? '',
              auth.userId ?? '',
              previous?.items ?? [],
            );
          },
        ),
        ChangeNotifierProxyProvider<Auth, OrderList>(
            create: (_) => OrderList(),
            update: (context, auth, previous) {
              return OrderList(
                auth.token ?? '',
                auth.userId ?? '',
                previous?.items ?? [],
              );
            }),
        ChangeNotifierProvider(
          create: (_) => Cart(),
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
        routes: {
          AppRoutes.SPLASH_PAGE: (context) => const SplashPage(),
          AppRoutes.AUTH_OR_HOME_PAGE: (context) => const AuthOrHomePage(),
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
