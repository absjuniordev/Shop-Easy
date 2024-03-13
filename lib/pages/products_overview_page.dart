import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/badgee.dart';
import 'package:shop/components/product_grid.dart';
import 'package:shop/model/cart.dart';

enum FilterOptions {
  favorite,
  all,
}

class ProductsOverviewPage extends StatefulWidget {
  const ProductsOverviewPage({super.key});

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  bool _showFavoriteOnly = false;
  @override
  Widget build(BuildContext context) {
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
            onSelected: (FilterOptions filter) {
              setState(() {
                if (filter == FilterOptions.favorite) {
                  _showFavoriteOnly = true;
                } else {
                  _showFavoriteOnly = false;
                }
              });
            },
          ),
          Consumer<Cart>(
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
            ),
            builder: (context, cart, child) => Badgee(
              value: cart.itemsCount.toString(),
              child: child!,
            ),
          )
        ],
        title: const Text('Minha Loja'),
        centerTitle: true,
      ),
      body: ProductGrid(
        showFavoriteOnly: _showFavoriteOnly,
      ),
    );
  }
}
