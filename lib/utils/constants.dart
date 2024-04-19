import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static String get baseUrl => dotenv.env['BASE_URL']!;
  static final userFavoriteUrl = "$baseUrl/userFavorites";
  static final productBaseUrl = "$baseUrl/products";
  static final orderBaseUrl = "$baseUrl/orders";
}
