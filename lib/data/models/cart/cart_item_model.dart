import '../product_detail/product_model.dart';

class CartItem {
  final ProductModel product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });

  String get id => product.id;
  String get name => product.name;
  String get image => product.image;
  String get price => product.price;
  String? get description => product.description;
}
