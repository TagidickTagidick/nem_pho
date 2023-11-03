import 'package:flutter/foundation.dart';
import 'models/product_model.dart';
import 'models/topping_model.dart';

class CartProvider with ChangeNotifier, DiagnosticableTreeMixin {
  final List<ProductModel> _products = [];

  List<ProductModel> get products => _products;

  final List<ToppingModel> _toppings = [];

  List<ToppingModel> get toppings => _toppings;

  void addProduct(ProductModel product) {
    _products.add(product);
    notifyListeners();
  }

  void addTopping(ToppingModel topping) {
    _toppings.add(topping);
    notifyListeners();
  }

  void removeProduct(ProductModel product) {
    ProductModel removedProduct =
        _products.firstWhere((element) => element.title == product.title);
    _products.remove(removedProduct);
    notifyListeners();
  }

  void removeTopping(ToppingModel topping) {
    ToppingModel removedTopping =
        _toppings.firstWhere((element) => element.title == topping.title);
    _toppings.remove(removedTopping);
    notifyListeners();
  }
}
