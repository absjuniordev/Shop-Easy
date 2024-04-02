import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shop/exceptions/http_exception.dart';
import 'package:shop/model/provider/product.dart';

class ProductList with ChangeNotifier {
  final _baseUrl =
      "https://shop-app-3837f-default-rtdb.firebaseio.com/products";
  final List<Product> _items = [];

  List<Product> get items => [..._items];

  List<Product> get favoriteItems =>
      _items.where((product) => product.isFavorite).toList();

  Future<void> saveProduct(Map<String, Object> data) {
    final hasId = data['id'] != null;

    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    if (hasId) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }

  Future<void> updateProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      await http.patch(
        Uri.parse("$_baseUrl/${product.id}.json"),
        body: jsonEncode(
          {
            'name': product.name,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
          },
        ),
      );
      _items[index] = product;
      notifyListeners();
    }
  }

  Future<void> loadProducts() async {
    _items.clear();
    final response = await http.get(Uri.parse("$_baseUrl.json"));

    if (response.body == 'null') return; //caso BD vazio

    final Map<String, dynamic> data = jsonDecode(response.body);

    data.forEach(
      //chave        valor
      (productId, prodcutData) {
        _items.add(
          Product(
            id: productId,
            name: prodcutData['name'],
            description: prodcutData['description'],
            price: prodcutData['price'],
            imageUrl: prodcutData['imageUrl'],
            isFavorite: prodcutData['isFavorite'],
          ),
        );
      },
    );
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    final response = await http.post(
      Uri.parse("$_baseUrl.json"),
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
    final id = jsonDecode(response.body)['name'];
    _items.add(Product(
      id: id,
      name: product.name,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    ));
    notifyListeners();
  }

  Future<void> removeProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      final product = _items[index];
      _items.remove(product);
      notifyListeners();

      final response = await http.delete(
        Uri.parse("$_baseUrl/${product.id}.json"),
      );
      if (response.statusCode >= 400) {
        _items.insert(index, product);
        notifyListeners();
        throw HttpException(
          msg: "Não foi possivel excluir o produto",
          statusCode: response.statusCode,
        );
      }
    }
  }

  int get itemsCount {
    return _items.length;
  }
}
