import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/product_grid.dart';
import 'package:shop/model/product_list.dart';

enum FilterOptions {
  favorite,
  all,
}

class ProductsOverviewPage extends StatelessWidget {
  const ProductsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductList>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.favorite,
                child: Text('Somente Favaritos'),
              ),
              const PopupMenuItem(
                value: FilterOptions.all,
                child: Text('Todos'),
              ),
            ],
            onSelected: (value) {
              if (value == FilterOptions.favorite) {
                product.showFavoriteOnly();
              } else {
                product.showAll();
              }
            },
          )
        ],
        title: const Text('Minha Loja'),
        centerTitle: true,
      ),
      body: const ProductGrid(),
    );
  }
}
