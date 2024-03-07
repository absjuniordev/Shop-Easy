import 'package:flutter/material.dart';
import 'package:shop/model/product.dart';

class ProductDatailPage extends StatelessWidget {
  const ProductDatailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Container(),
    );
  }
}
