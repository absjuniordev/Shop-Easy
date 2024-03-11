import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/model/product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = dummyProducts;

  List<Product> get items => [..._items];
  //Retorno do clone para evitar manipulação da lista original

  void addItem(Product product) {
    _items.add(product);
    notifyListeners();
  }
}
