class Product {
  final String id;
  final String titile;
  final String description;
  final String price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.titile,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  void toggleFavorite() {
    isFavorite = !isFavorite;
  }
}
