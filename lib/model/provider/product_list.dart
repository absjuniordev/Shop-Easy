import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/model/provider/product.dart';

class ProductList with ChangeNotifier {
  final _baseUrl = "https://shop-app-3837f-default-rtdb.firebaseio.com";
  final List<Product> _items = dummyProducts;

  List<Product> get items => [..._items];

  List<Product> get favoriteItems =>
      _items.where((product) => product.isFavorite).toList();

  void saveProduct(Map<String, Object> data) {
    final hasId = data['id'] != null;

    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    if (hasId) {
      updateProduct(product);
    } else {
      addProduct(product);
    }
  }

  void updateProduct(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  void addProduct(Product product) {
    final resonse = http.post(
      Uri.parse("$_baseUrl/products.json"),
      body: jsonEncode(
        {
          'name': product.name,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'isFavorite': product.isFavorite,
        },
      ),
    );
    resonse.then((resp) {
      final id = jsonDecode(resp.body)['name'];

      _items.add(Product(
        id: id,
        name: product.name,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      ));
      notifyListeners();
    });
  }

  void removeProduct(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      _items.removeWhere((p) => p.id == product.id);
      notifyListeners();
    }
  }

  int get itemsCount {
    return _items.length;
  }
}
