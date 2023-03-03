import 'package:flutter/foundation.dart';

import 'models/product_model.dart';

class CartProvider with ChangeNotifier, DiagnosticableTreeMixin {
  List<ProductModel> _cart = [];

  List<ProductModel> get cart => _cart;

  void addToCart(ProductModel product) {
    _cart.add(product);
    notifyListeners();
  }

  void removeProduct(ProductModel product) {
    ProductModel removedProduct = _cart.firstWhere((element) => element.id == product.id);
    _cart.remove(removedProduct);
    notifyListeners();
  }

  void addProduct(ProductModel product) {
    _cart.add(product);
    notifyListeners();
  }
}